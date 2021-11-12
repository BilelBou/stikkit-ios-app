//
//  HomeViewController.swift
//  stikkit-ios
//
//  Created by Bilel Bouricha on 22/04/2021.
//

import UIKit
import Hero

class HomeViewController: Controller {
    let defaults = UserDefaults.standard
    let APICalls = AuthAPI()
    var codeSticker: String = ""
    var popUp = AddStickerView()
    
    var stickersTab: [stickerModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.stickerCollectionView.reloadData()
            }
        }
    }
    
    private lazy var welcomeLabel: UILabel = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        guard let firstName = defaults.string(forKey: "firstName") else { return }
        $0.attributedText = ("Welcome " + firstName).typography(.title2, color: Color.buttonColor)
    }
    
    private lazy var addSticker: UIButton = UIButton()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setAttributedTitle(Icon.App.plus.typographyIcon(font: Font.Icon._24), for: .normal)
        $0.backgroundColor = Color.buttonColor
        $0.setTitleColor(Color.white, for: .normal)
        $0.widthAnchor.constraint(equalToConstant: 40).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
    }
    
    private lazy var stickerCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()..{
        $0.sectionInset = .zero
        $0.scrollDirection = .vertical
    }
    
    lazy var stickerCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: stickerCollectionViewLayout)..{
        $0.dataSource = self
        $0.delegate = self
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Color.backgroundColor
        $0.contentInset = UIEdgeInsets(top: Margin._8, left: Margin._8, bottom: 0, right: Margin._8)
        $0.showsVerticalScrollIndicator = false
        $0.register(StickerCollectionViewCell.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLogin()
        updateNavigationBar(NavTitleStyle.title("Stickers"), titleColor: Color.white, rightButton: .option, rightColor: Color.white)
        APICalls.getStickers { (stickers) in
            self.stickersTab = stickers
        }
        configureStyleAndLayout()
    }
    
    private func configureStyleAndLayout() {
        view.backgroundColor = Color.backgroundColor
        view.addSubview(welcomeLabel)
        view.addSubview(stickerCollectionView)
        view.addSubview(addSticker)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin._30),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._20),
            
            addSticker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin._24),
            addSticker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Margin._20),
            
            stickerCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stickerCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stickerCollectionView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: Margin._10),
            stickerCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    
    private func checkLogin() {
        if defaults.string(forKey: "firstName") == nil  {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        }
    }


    override func didTapOption() {
        let alert = UIAlertController(title: "Log Out", message: "You want to log out ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Log Out", style: .default, handler: { alertAction in
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
    
    @objc func didTapAdd() {
        let popUp = AddStickerView()
        self.popUp = popUp
        popUp.linkButton.addTarget(self, action: #selector(didTapLink), for: .touchUpInside)
        self.view.addSubview(popUp)
    }
    
    @objc func didTapLink() {
        APICalls.linkSticker(stickerId: self.popUp.textFieldCode.text!) { (statusCode) in
            if statusCode == 201 {
                self.APICalls.getStickers { (stickerModel) in
                    self.stickersTab = stickerModel
                }
                DispatchQueue.main.async {
                    self.popUp.removeFromSuperview()
                }
            } else {
                print("error")
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stickersTab.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: StickerCollectionViewCell = collectionView.dequeue(for: indexPath)
       // cell.configure(name: stickersTab[indexPath.row].stickerId, date: stickersTab[indexPath.row].lastPositionDate)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MapViewController()
        vc.navigationController?.view.backgroundColor = .clear
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        //navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 2.2
        return CGSize(width: width, height: width)
    }
}
