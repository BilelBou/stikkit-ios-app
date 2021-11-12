import MapKit
import UIKit

import FloatingPanel

class MapViewController: UIViewController, StickersViewControllerDelegate, MKMapViewDelegate {
    fileprivate let locationManager: CLLocationManager = CLLocationManager()
    let fakeData: [fakeLocation] = [fakeLocation(title: "Prototype", loca: GeoModel(latitude: 43.69577319341921, longitude: 7.269619769625674)),
                                    fakeLocation(title: "test1", loca: GeoModel(latitude: 43.69601029076336, longitude: 7.277102691102712)),
                                    fakeLocation(title: "test2", loca: GeoModel(latitude: 43.70159515127883, longitude: 7.265858870982911)),
                                    fakeLocation(title: "test3", loca: GeoModel(latitude: 43.697685803582445, longitude: 7.278819304876558))]
    let stickersPanel = FloatingPanelController()
    let detailsPanel = FloatingPanelController()
    let user: Welcome

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

    init(user: Welcome) {
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
        createAnnotation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        guard let userLatitude = locationManager.location?.coordinate.latitude else { return }
        guard let userLongitude = locationManager.location?.coordinate.longitude else { return }

        let initLocation = CLLocation(latitude: userLatitude, longitude: userLongitude)
        mapView.centerToLocation(initLocation)
        mapView.showsUserLocation = true

        guard let stickers = user.stickers else { return }
        stickersVC.stickersTab = stickers
        stickersPanel.set(contentViewController: stickersVC)
        stickersPanel.addPanel(toParent: self)
        stickersPanel.track(scrollView: stickersVC.stickersTableView)
        stickersPanel.surfaceView.appearance = panelAppearance
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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

    func didTapCell(sticker: stickerModel, pos: GeoModel) {
        ///Waiting for data from BE
        mapView.centerToLocation(CLLocation(latitude: pos.latitude, longitude: pos.longitude), regionRadius: 100)
        stickersPanel.removePanelFromParent(animated: true)
        detailsVC.configure(sticker: sticker)
        detailsPanel.set(contentViewController: detailsVC)
        detailsPanel.surfaceView.appearance = panelAppearance
        detailsPanel.addPanel(toParent: self, animated: true)
    }

    func createAnnotation() {
        for location in fakeData {
            let annotation = MKPointAnnotation()
            annotation.title = location.title
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.loca.latitude, longitude: location.loca.longitude)
            mapView.addAnnotation(annotation)
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
    func didTapDirection() {
        
    }

    func didTapClose() {
        detailsPanel.removePanelFromParent(animated: true)
        stickersPanel.set(contentViewController: stickersVC)
        stickersPanel.addPanel(toParent: self)
        stickersPanel.track(scrollView: stickersVC.stickersTableView)
        stickersPanel.surfaceView.appearance = panelAppearance
    }
}
