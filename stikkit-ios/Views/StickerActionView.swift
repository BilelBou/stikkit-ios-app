//
//  StickerActionView.swift
//  stikkit-ios
//
//  Created by Bilel Bouricha on 14/09/2021.
//

import UIKit
import CoreLocation
import SwiftUI

enum actionType {
    case itinerary, notification
    
    var title: String {
        switch self {
        case .itinerary:
            return "Itinerary to my sticker"
        case .notification:
            return "Notification"
        }
    }
}

class StickerActionView: UIView {
    let type: actionType

    private lazy var label = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.attributedText = type.title.typography(.title3)
    }

    private lazy var distanceLabel = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.attributedText = "Notify me if forget my sticker".typography(.text, color: Color.white)
    }
    
    private lazy var toggle = UISwitch()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isOn = true
        $0.isHidden = type == .itinerary
    }
    
    private lazy var timeLabel = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isHidden = type == .notification
    }

    init(type: actionType) {
        self.type = type
        super.init(frame: .zero)
        backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
        configureStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureStyle() {
        addSubview(label)
        addSubview(distanceLabel)
        addSubview(timeLabel)
        addSubview(toggle)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin._20),
            label.topAnchor.constraint(equalTo: topAnchor, constant: Margin._20),

            distanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin._20),
            distanceLabel.centerYAnchor.constraint(equalTo: toggle.centerYAnchor),
            
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin._20),
            timeLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: Margin._6),
            
            toggle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Margin._20),
            toggle.topAnchor.constraint(equalTo: label.bottomAnchor, constant: Margin._20),
        ])
    }
    
    func configure(distance: CLLocationDistance, time: TimeInterval) {
        let kmDisance = distance/1000
        let formatter = DateComponentsFormatter()

        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        let timeString = formatter.string(from: time)
        if type == .itinerary {
            distanceLabel.attributedText = "\(kmDisance) Km".typography(.text, color: Color.white)
            timeLabel.attributedText = timeString?.typography(.text, color: Color.white)
        }

    }

}
