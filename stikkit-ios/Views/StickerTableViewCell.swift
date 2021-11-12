//
//  StickerTableViewCell.swift
//  stikkit-ios
//
//  Created by Bilel Bouricha on 13/09/2021.
//

import UIKit

class StickerTableViewCell: UITableViewCell {

    private lazy var image = UIImageView()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "logo")
    }

    private lazy var nameLabel: UILabel = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private lazy var cityLabel: UILabel = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.attributedText = "Nice, Provence-Alpes-Côte d'Azur - il y a 2 min".typography(.caption)
    }

    private lazy var dateLabel: UILabel = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        self.isOpaque = false 
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(cityLabel)
        contentView.addSubview(image)
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin._12),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.widthAnchor.constraint(equalToConstant: 30),
            image.heightAnchor.constraint(equalToConstant: 30),

            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Margin._12),
            nameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: Margin._12),

            cityLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Margin._6),
            cityLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: Margin._12),


        ])
    }

    func configure(name: String, date: String) {
        nameLabel.attributedText = name.typography(.textStrong)
//        let formattedDate: String = configureDate(date: date)
//        self.dateLabel.attributedText = formattedDate.typography(.textStrong, color: Color.white)
    }

//    private func configureDate(date: String) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "fr_FR")
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
//        let dateAfterFormat = dateFormatter.date(from: date)
//        dateFormatter.dateFormat = "dd/MM HH:mm"
//        return dateFormatter.string(from: dateAfterFormat!)
//    }
}
