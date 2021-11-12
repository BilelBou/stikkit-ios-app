//
//  StickerActionView.swift
//  stikkit-ios
//
//  Created by Bilel Bouricha on 14/09/2021.
//

import UIKit

class StickerActionView: UIView {

    private lazy var icon = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.attributedText = Icon.App.curvedArrow.typographyIcon(font: Font.Icon._20)
    }

    private lazy var label = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.attributedText = "Itinerary to my sticker".typography(.textStrong)
    }

    private lazy var distanceLabel = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.attributedText = "1,4 km - 10 mn".typography(.caption, color: Color.lightGray)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
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
        addSubview(icon)
        addSubview(label)
        addSubview(distanceLabel)
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: topAnchor, constant: Margin._16),
            icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin._20),

            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin._20),
            label.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: Margin._30),

            distanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin._20),
            distanceLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: Margin._6),
        ])
    }

}
