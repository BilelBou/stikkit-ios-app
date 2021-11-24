//
//  StickerDetailViewController.swift
//  stikkit-ios
//
//  Created by Bilel Bouricha on 14/09/2021.
//

import UIKit
import MapKit

protocol StickerDetailViewControllerDelegate: AnyObject {
    func didTapClose()
    func didTapDirection(sticker: Sticker, polyline: MKPolyline)
}

class StickerDetailViewController: UIViewController {
    weak var delegate: StickerDetailViewControllerDelegate?
    var sticker: Sticker?
    var polyline: MKPolyline?

    private lazy var closePanelButton = UIButton()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setAttributedTitle("Close".typography(.text), for: .normal)
        $0.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
    }

    private lazy var stickerLabel = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private lazy var stickerAdress = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private lazy var localize = StickerActionView(type: .itinerary)..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 150).isActive = true
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDirection)))
    }
    
    private lazy var notification = StickerActionView(type: .notification)..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 150).isActive = true
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        configureStyle()
    }

    private func configureStyle() {
        view.addSubview(closePanelButton)
        view.addSubview(stickerLabel)
        view.addSubview(stickerAdress)
        view.addSubview(localize)
        view.addSubview(notification)
        NSLayoutConstraint.activate([
            closePanelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin._20),
            closePanelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin._10),

            stickerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._20),
            stickerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin._10),

            stickerAdress.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._20),
            stickerAdress.topAnchor.constraint(equalTo: stickerLabel.bottomAnchor, constant: Margin._4),

            localize.topAnchor.constraint(equalTo: stickerLabel.bottomAnchor, constant: Margin._30),
            localize.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._20),
            localize.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin._20),
            
            notification.topAnchor.constraint(equalTo: localize.bottomAnchor, constant: Margin._10),
            notification.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._20),
            notification.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin._20)
        ])
    }

    func configure(sticker: Sticker, route: MKRoute) {
        self.sticker = sticker
        stickerLabel.attributedText = sticker.name.typography(.title2)
        stickerAdress.attributedText = route.name.typography(.caption, color: Color.lightGray)
        localize.configure(distance: route.distance, time: route.expectedTravelTime)
        self.polyline = route.polyline
    }

    @objc func didTapClose() {
        delegate?.didTapClose()
    }

    @objc func didTapDirection() {
        guard let sticker = sticker, let polyline = polyline else { return }
        delegate?.didTapDirection(sticker: sticker, polyline: polyline)
    }
}
