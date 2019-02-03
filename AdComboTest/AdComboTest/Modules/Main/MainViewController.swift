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
    let selfToPhotoSegueName = "showImage"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.configureView()
        livePhotoDataList = presenter.getLivePhoto()
    }
    
    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return livePhotoDataList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mainCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MainViewCell
        presenter.getImageData(urlString: livePhotoDataList[indexPath.row].smallUrl) { (result) in
            DispatchQueue.main.async {
                mainCell.photo.image = result
            }
        }        
        return mainCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.router.showLivePhotoScene()
    }
    
    // MARK: - MainViewProtocol Methods
    
    func showAcitvityIndicator() {
        let container: UIView = UIView()
        container.frame = self.view.frame
        container.center = self.view.center
        container.tag = 100
        container.backgroundColor = UIColor.init(red: 255, green: 255, blue: 255, alpha: 0.3)
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = self.view.center
        loadingView.backgroundColor = UIColor.gray
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = .gray
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        self.view.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }else{
            print("No!")
        }
    }
    
    // MARK: - Navigation Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
        presenter.router.prepare(for: segue, sender: sender, imageUrlString: livePhotoDataList[indexPath.row].largeUrl, movieUrlString: livePhotoDataList[indexPath.row].movieUrl)
    }
}
