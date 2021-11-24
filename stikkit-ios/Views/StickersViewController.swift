//
//  StickersViewController.swift
//  stikkit-ios
//
//  Created by Bilel Bouricha on 13/09/2021.
//

import UIKit

protocol StickersViewControllerDelegate: AnyObject {
    func didTapCell(sticker: Sticker)
    func didReloadData()
}

class StickersViewController: UIViewController {
    weak var delegate: StickersViewControllerDelegate?
    let defaults = UserDefaults.standard

    var stickersTab: [Sticker] = []

    private lazy var refreshControl = UIRefreshControl()..{
        $0.addTarget(self, action: #selector(didRefresh), for: .allEvents)
    }
    
    private lazy var loginButton = UIButton()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 20
        $0.setAttributedTitle("Refresh".typography(.caption), for: .normal)
        $0.addTarget(self, action: #selector(didRefresh), for: .touchUpInside)
    }
    
    private lazy var label = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.attributedText = "My stickers".typography(.title2)
    }

    lazy var stickersTableView = UITableView()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = self
        $0.register(StickerTableViewCell.self)
        $0.rowHeight = 80
        $0.alwaysBounceVertical = false
        $0.backgroundColor = UIColor.clear
        $0.isOpaque = false
        $0.tableFooterView = UIView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        AuthAPI.shared.getStickers { myStickers in
//            self.stickersTab = myStickers
//        }

        AuthAPI.shared.getUserById(id: defaults.string(forKey: "id")!) { user in
            guard let stickers = user.stickers else { return }
            self.stickersTab = stickers
            DispatchQueue.main.async {
                self.stickersTableView.reloadData()
            }
        }
    }

    private func configure() {
        view.addSubview(label)
        view.addSubview(stickersTableView)
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin._20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._12),

            stickersTableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: Margin._20),
            stickersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stickersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stickersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loginButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin._20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin._12),
            loginButton.widthAnchor.constraint(equalToConstant: 150),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

}

extension StickersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stickersTab.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StickerTableViewCell = stickersTableView.dequeue(for: indexPath)
        cell.configure(name: stickersTab[indexPath.row].name, date: stickersTab[indexPath.row].createdAt)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTapCell(sticker: stickersTab[indexPath.row])
    }
    
    @objc private func didRefresh() {
        delegate?.didReloadData()
    }
}
