//
//  StickerCell.swift
//  stikkit-ios
//
//  Created by Bilel Bouricha on 08/11/2021.
//

import UIKit

class StickerCell: UICollectionViewCell {

    static let height: CGFloat = 214

    private lazy var name = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private lazy var lastSeen = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private lazy var city = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private lazy var image = UIImageView()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "logo")
        $0.contentMode = .scaleAspectFit
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStyleAndLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureStyleAndLayout() {
        backgroundColor = Color.containerColor
        layer.cornerRadius = CornerRadius._12
        contentView.addSubview(name)
        contentView.addSubview(image)
        contentView.addSubview(lastSeen)
        contentView.addSubview(city)

        NSLayoutConstraint.activate([
            name.centerXAnchor.constraint(equalTo: centerXAnchor),
            name.topAnchor.constraint(equalTo: topAnchor, constant: Margin._8),

            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.topAnchor.constraint(equalTo: name.bottomAnchor, constant: Margin._20),
            image.heightAnchor.constraint(equalToConstant: 70),
            image.widthAnchor.constraint(equalToConstant: 70),

            lastSeen.centerXAnchor.constraint(equalTo: centerXAnchor),
            lastSeen.topAnchor.constraint(equalTo: image.bottomAnchor, constant: Margin._20),

            city.centerXAnchor.constraint(equalTo: centerXAnchor),
            city.topAnchor.constraint(equalTo: lastSeen.bottomAnchor, constant: Margin._20),

            heightAnchor.constraint(equalToConstant: StickerCell.height)
        ])
    }

    func configure(sticker: Sticker) {
        name.attributedText = "Vélo".typography(.textStrong)
        lastSeen.attributedText = "2 min ago".typography(.caption)
        city.attributedText = "Nice Alpes Côte d'azur".typography(.caption)
    }
}
