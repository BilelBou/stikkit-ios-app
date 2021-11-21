import UIKit

import Kingfisher

final class MyProfileViewController: Controller {
    private var user: User
    let defaults = UserDefaults.standard
    
    private lazy var profilePicture = UIImageView()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        let ressource = ImageResource(downloadURL: URL(string: "https://api.stikkit.fr/" + defaults.string(forKey: "image")!)!)
        $0.kf.setImage(with: ressource)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 60
        $0.contentMode = .scaleAspectFill
    }

    private lazy var createGroupButton = IconButton(icon: Icon.App.plus, title: "Create a new group")..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.backgroundColor = Color.buttonColor
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapNewGroup)))
    }

    private lazy var createStickerLabel = IconButton(icon: Icon.App.plus, title: "Add a new sticker")..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.backgroundColor = Color.buttonColor
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapNewSticker)))
    }

    typealias DataSource = UICollectionViewDiffableDataSource<Int, Sticker>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Sticker>

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Color.backgroundColor
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = true
        $0.register(StickerCell.self)
    }

    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: Margin._20, bottom: 0, trailing: Margin._20)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(StickerCell.height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal

        return UICollectionViewCompositionalLayout(section: section, configuration: configuration)
    }

    private lazy var dataSource: DataSource = {
        return DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, sticker in
            let cell: StickerCell = collectionView.dequeue(for: indexPath)
            cell.configure(sticker: sticker)
            return cell
        }
    }()

    private func configureSnapshot() {
        guard let stickers = self.user.stickers else { return }
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(stickers)
        dataSource.apply(snapshot)
    }

    private lazy var stickerCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()..{
        $0.sectionInset = .zero
        $0.scrollDirection = .horizontal
    }

    lazy var groupsCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: stickerCollectionViewLayout)..{
        $0.dataSource = self
        $0.delegate = self
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Color.backgroundColor
        //$0.contentInset = UIEdgeInsets(top: Margin._8, left: Margin._8, bottom: 0, right: Margin._8)
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = true
        $0.register(StickerCollectionViewCell.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSnapshot()
        view.backgroundColor = Color.backgroundColor
        updateNavigationBar(NavTitleStyle.title(user.firstName), titleColor: Color.white, rightButton: .option, rightColor: Color.white)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AuthAPI.shared.getUserById(id: defaults.string(forKey: "id")!) { user in
            self.user = user
            self.configureSnapshot()
        }
        tabBarController?.tabBar.isHidden = false
    }

    init(user: User) {
        self.user = user
        super.init()
        configureStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didTapOption() {
        let vc = SettingsController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }

    private func configureStyle() {
        view.addSubview(profilePicture)
        //view.addSubview(createGroupeLabel)
        view.addSubview(createStickerLabel)
        view.addSubview(groupsCollectionView)
        view.addSubview(createGroupButton)
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            profilePicture.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePicture.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin._30),
            profilePicture.heightAnchor.constraint(equalToConstant: 120),
            profilePicture.widthAnchor.constraint(equalToConstant: 120),

            groupsCollectionView.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: Margin._30),
            groupsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._20),
            groupsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin._20),
            groupsCollectionView.heightAnchor.constraint(equalToConstant: 100),

            createGroupButton.topAnchor.constraint(equalTo: groupsCollectionView.bottomAnchor, constant: Margin._20),
            createGroupButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._20),
            createGroupButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin._20),
            createGroupButton.heightAnchor.constraint(equalToConstant: 60),

            collectionView.topAnchor.constraint(equalTo: createGroupButton.bottomAnchor, constant: Margin._20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: StickerCell.height),

            createStickerLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: Margin._20),
            createStickerLabel.heightAnchor.constraint(equalToConstant: 60),
            createStickerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin._20),
            createStickerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._20)
        ])
    }

    @objc func didTapNewGroup() {
        let vc = CreateGroupController(type: .group)
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func didTapNewSticker() {
        let vc = CreateGroupController(type: .stickers)
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension MyProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: StickerCollectionViewCell = collectionView.dequeue(for: indexPath)
        guard let group = user.group else { return UICollectionViewCell() }
        cell.configure(name: group.name, users: group.users)
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 100)
    }
}
