//
//  SettingsController.swift
//  stikkit-ios
//
//  Created by Bilel Bouricha on 08/11/2021.
//

import UIKit

import DesignSystem

class SettingsController: Controller {
    let sections: [SettingsSection] = [.preferences, .account]
    let defaults = UserDefaults.standard

    typealias DataSource = UICollectionViewDiffableDataSource<SettingsSection, Setting>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SettingsSection, Setting>

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.backgroundColor = Color.backgroundColor
        $0.register(SettingHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
        $0.register(SettingCell.self)
    }

    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(SettingHeader.height))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        header.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: Margin._16, bottom: 0, trailing: Margin._16)

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: Margin._16, bottom: 0, trailing: Margin._16)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(SettingCell.height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return UICollectionViewCompositionalLayout(section: section)
    }

    private lazy var dataSource: DataSource = {
        dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, setting in
            let cell: SettingCell = collectionView.dequeue(for: indexPath)
            cell.configure(setting)
            return cell
        }

        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let self = self else { return UICollectionViewCell() }
            let header: SettingHeader = collectionView.dequeueSupplementaryView(of: kind, for: indexPath)
            header.configure(self.sections[indexPath.section].title)
            return header
        }

        return dataSource
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSnapshot()
        configureStyleAndLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar(title: "Settings", leftType: .back)
    }

    private func configureSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections(sections)
        sections.forEach {snapshot.appendItems($0.settings, toSection: $0) }
        dataSource.apply(snapshot)
    }

    override func didTapBack() {
        navigationController?.popViewController(animated: true)
    }

    private func configureStyleAndLayout() {
        view.backgroundColor = Color.backgroundColor
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension SettingsController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting: Setting = sections[indexPath.section].settings[indexPath.item]
        switch setting {
        case .language:
            break
        case .editUsername:
            let vc = EditUsernameController(username: defaults.string(forKey: "firstName")!, id: defaults.string(forKey: "id")!)
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        case .logout:
            let alert = UIAlertController(title: "Log Out", message: "You want to log out ?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { alertAction in
                self.defaults.removeObject(forKey: "id")
                self.defaults.removeObject(forKey: "firstName")
                self.defaults.removeObject(forKey: "lastName")
                self.defaults.removeObject(forKey: "email")
                self.defaults.removeObject(forKey: "phone")
                self.defaults.removeObject(forKey: "image")
                let vc = LoginViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false, completion: nil)
            }))
            present(alert, animated: true, completion: nil)
        }
    }
}
