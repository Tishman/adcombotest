//
//  MainViewController.swift
//  AdComboTest
//
//  Created by Роман Тищенко on 01/02/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PreviewPhotoCell"

class MainViewController: UICollectionViewController, MainViewProtocol {

    var presenter: MainPresenterProtocol!
    var livePhotoDataList: [LivePhoto] = []
    let configurator: MainConfiguratorProtocol = MainConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAcitvityIndicator()
        configurator.configure(with: self)
        presenter.configureView()
        livePhotoDataList = presenter.getLivePhoto()
        hideActivityIndicator()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return livePhotoDataList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mainCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MainViewCell
        presenter.getPriviewImage(urlString: livePhotoDataList[indexPath.row].smallUrl) { (result) in
            DispatchQueue.main.async {
                mainCell.photo.image = result
            }
        }        
        return mainCell
    }
    
    // MARK: MainViewProtocol Methods
    
    func showAcitvityIndicator() {
        let container: UIView = UIView()
        container.frame = self.view.frame
        container.center = self.view.center
        container.tag = 100
        container.backgroundColor = UIColor.blue
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = self.view.center
        loadingView.backgroundColor = UIColor.darkGray
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        actInd.style = .gray
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        self.view.addSubview(container)
        actInd.startAnimating()
    }
    
    func hideActivityIndicator() {
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }else{
            print("No!")
        }
    }
}
