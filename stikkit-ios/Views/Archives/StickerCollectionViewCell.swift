//
//  StickerCollectionViewCell.swift
//  stikkit-ios
//
//  Created by Bilel Bouricha on 22/04/2021.
//

import UIKit
import Kingfisher

class StickerCollectionViewCell: UICollectionViewCell {
    private lazy var nameLabel: UILabel = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private lazy var imagesStackView = UIStackView()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.spacing = -Margin._10
        $0.isHidden = true
    }

    private lazy var emptyGroup = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.attributedText = "OOPS ! this group is empty !".typography(.captionStrong, color: Color.lightGray)
        $0.isHidden = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setup() {
        contentView.backgroundColor = Color.containerColor
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 20
        contentView.addSubview(nameLabel)
        contentView.addSubview(imagesStackView)
        contentView.addSubview(emptyGroup)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margin._10),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margin._10),

            imagesStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Margin._10),
            imagesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margin._10),

            emptyGroup.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Margin._10),
            emptyGroup.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margin._10),

        ])
    }

    func configure(name: String, users: [Welcome]) {
        self.nameLabel.attributedText = name.typography(.title3, color: Color.white)
        if !users.isEmpty {
            for user in users {
                let image = UIImageView()
                let ressource = ImageResource(downloadURL: URL(string: "https://api.stikkit.fr/" + user.image)!)
                image.kf.setImage(with: ressource)
                image.clipsToBounds = true
                image.heightAnchor.constraint(equalToConstant: 30).isActive = true
                image.widthAnchor.constraint(equalToConstant: 30).isActive = true
                image.clipsToBounds = true
                image.layer.cornerRadius = 15
                image.layer.borderWidth = 2
                image.layer.borderColor = Color.containerColor.cgColor
                image.contentMode = .scaleAspectFill
                imagesStackView.addArrangedSubview(image)
                imagesStackView.isHidden = false
                emptyGroup.isHidden = true
            }
        } else {
            emptyGroup.isHidden = false
            imagesStackView.isHidden = true
        }
    }
}
