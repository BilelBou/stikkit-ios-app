//
//  StickerDetailViewController.swift
//  stikkit-ios
//
//  Created by Bilel Bouricha on 14/09/2021.
//

import UIKit

protocol StickerDetailViewControllerDelegate: AnyObject {
    func didTapClose()
    func didTapDirection()
}

class StickerDetailViewController: UIViewController {
    weak var delegate: StickerDetailViewControllerDelegate?

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
        $0.attributedText = "50 - 55 Avue de la Californie, 06200, Nice".typography(.caption, color: Color.lightGray)
    }

    private lazy var localize = StickerActionView()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 150).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 200).isActive = true
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDirection)))
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
        NSLayoutConstraint.activate([
            closePanelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin._20),
            closePanelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin._10),

            stickerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._20),
            stickerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin._10),

            stickerAdress.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._20),
            stickerAdress.topAnchor.constraint(equalTo: stickerLabel.bottomAnchor, constant: Margin._4),

            localize.topAnchor.constraint(equalTo: stickerLabel.bottomAnchor, constant: Margin._30),
            localize.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._20),
        ])
    }

    func configure(sticker: stickerModel) {
        stickerLabel.attributedText = sticker.stickerId.typography(.title2)
    }

    @objc func didTapClose() {
        delegate?.didTapClose()
    }

    @objc func didTapDirection() {
        delegate?.didTapDirection()
    }
}
