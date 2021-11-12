//
//  LoginCollectionViewCell.swift
//  stikkit-ios
//
//  Created by Bilel Bouricha on 20/04/2021.
//

import UIKit

class LoginCollectionViewCell: UICollectionViewCell {
    private lazy var label: UILabel = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
    }
    private lazy var selectionIndicator: UILabel = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isHidden = true
        $0.backgroundColor = Color.white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStyleAndLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureStyleAndLayout() {
        contentView.addSubview(label)
        contentView.addSubview(selectionIndicator)

        NSLayoutConstraint.activate([            
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            selectionIndicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            selectionIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            selectionIndicator.heightAnchor.constraint(equalToConstant: 3),
            selectionIndicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(labelString: String, isSelected: Bool) {
        let color = isSelected ? Color.white : Color.white.withAlphaComponent(0.5)
        label.attributedText = labelString.typography(.text, color: color)
        selectionIndicator.isHidden = !isSelected

    }
}
