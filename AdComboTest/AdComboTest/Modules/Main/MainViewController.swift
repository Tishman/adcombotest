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
        mainCell.layer.cornerRadius = 5
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
    
    func getLivePhotoList() {
        presenter.getLivePhoto { (livePhotoList) in
            self.livePhotoDataList = livePhotoList
        }
    }
    // MARK: - Navigation Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
        presenter.router.prepare(for: segue, sender: sender, imageUrlString: livePhotoDataList[indexPath.row].largeUrl, movieUrlString: livePhotoDataList[indexPath.row].movieUrl)
    }
}
