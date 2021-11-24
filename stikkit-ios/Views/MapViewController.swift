import MapKit
import UIKit

import FloatingPanel

class MapViewController: UIViewController, StickersViewControllerDelegate, MKMapViewDelegate {
    fileprivate let locationManager: CLLocationManager = CLLocationManager()
    let stickersPanel = FloatingPanelController()
    let detailsPanel = FloatingPanelController()
    var user: User
    var timer = Timer()

    private lazy var detailsVC = StickerDetailViewController()..{
        $0.delegate = self
    }

    private lazy var stickersVC = StickersViewController()..{
        $0.delegate = self
    }

    private lazy var panelAppearance = SurfaceAppearance()..{
        //$0.cornerCurve = .continuous
        //$0.cornerRadius = 10.0
        $0.backgroundColor = .clear
    }

    private lazy var mapView = MKMapView()..{
        $0.delegate = self
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        configureStyleAndLayout()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        guard let userLatitude = locationManager.location?.coordinate.latitude else { return }
        guard let userLongitude = locationManager.location?.coordinate.longitude else { return }

        let initLocation = CLLocation(latitude: userLatitude, longitude: userLongitude)
        mapView.centerToLocation(initLocation)
        mapView.showsUserLocation = true
        mapView.delegate = self

        guard let stickers = user.stickers else { return }
        stickersVC.stickersTab = stickers
        stickersPanel.set(contentViewController: stickersVC)
        stickersPanel.addPanel(toParent: self)
        stickersPanel.track(scrollView: stickersVC.stickersTableView)
        stickersPanel.surfaceView.appearance = panelAppearance
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: { _ in
            self.didReloadData()
        })
        createAnnotation()
    }
    
    private func configureStyleAndLayout() {
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    func didTapCell(sticker: Sticker) {
        guard let position = sticker.position, let userLatitude = locationManager.location?.coordinate.latitude, let userLongitude = locationManager.location?.coordinate.longitude else { return }
        mapView.centerToLocation(CLLocation(latitude: position.latitude, longitude: position.longitude), regionRadius: 100)
        let stickerPosition = CLLocationCoordinate2D.init(latitude: position.latitude, longitude: position.longitude)
        let myPosition = CLLocationCoordinate2D.init(latitude: userLatitude, longitude: userLongitude)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: myPosition, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: stickerPosition, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            if let route = unwrappedResponse.routes.first {
                stickersPanel.removePanelFromParent(animated: true)
                detailsVC.configure(sticker: sticker, route: route)
                detailsPanel.set(contentViewController: detailsVC)
                detailsPanel.surfaceView.appearance = panelAppearance
                detailsPanel.addPanel(toParent: self, animated: true)
            }
        }
    }

    func createAnnotation() {
        guard let stickers = user.stickers else { return }
        for sticker in stickers {
            let annotation = MKPointAnnotation()
            annotation.title = sticker.name
            guard let position = sticker.position else { return }
            annotation.coordinate = CLLocationCoordinate2D(latitude: position.latitude, longitude: position.longitude)
            mapView.addAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
         let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .systemBlue
         renderer.lineWidth = 5.0
         return renderer
    }
    
    func didReloadData() {
        AuthAPI.shared.getUserById(id: user.id) { [weak self] user in
            guard let self = self else { return }
            self.user = user
            DispatchQueue.main.async {
                self.mapView.removeAnnotations(self.mapView.annotations)
                self.createAnnotation()
            }
        }
    }
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

extension MapViewController: StickerDetailViewControllerDelegate {
    func didTapDirection(sticker: Sticker, polyline: MKPolyline) {
        self.mapView.addOverlay(polyline)
        self.mapView.setVisibleMapRect(polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80.0, left: 20.0, bottom: 100.0, right: 20.0), animated: true)
    }


    func didTapClose() {
        if !mapView.overlays.isEmpty {
            mapView.removeOverlay(mapView.overlays.first!)
        }
        detailsPanel.removePanelFromParent(animated: true)
        stickersPanel.set(contentViewController: stickersVC)
        stickersPanel.addPanel(toParent: self)
        stickersPanel.track(scrollView: stickersVC.stickersTableView)
        stickersPanel.surfaceView.appearance = panelAppearance
        
        guard let userLatitude = locationManager.location?.coordinate.latitude else { return }
        guard let userLongitude = locationManager.location?.coordinate.longitude else { return }

        let initLocation = CLLocation(latitude: userLatitude, longitude: userLongitude)
        mapView.centerToLocation(initLocation)

    }
}
