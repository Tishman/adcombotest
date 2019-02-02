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
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        //showAcitvityIndicator()
        configurator.configure(with: self)
        presenter.configureView()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }
    
    // MARK: MainViewProtocol Methods
    
    func showAcitvityIndicator() {
        let container: UIView = UIView()
        container.frame = self.view.frame
        container.center = self.view.center
        container.backgroundColor = UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 0.3)
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = self.view.center
        loadingView.backgroundColor = UIColor.white
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        actInd.style = .gray
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        self.collectionView.addSubview(container)
        actInd.startAnimating()
    }
}
