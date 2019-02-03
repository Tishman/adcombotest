//
//  PhotoPresenter.swift
//  AdComboTest
//
//  Created by Роман Тищенко on 03/02/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import Foundation
import UIKit

class PhotoPresenter: PhotoPresenterProtocol {
    
    weak var view: PhotoViewProtocol!
    var interactor: PhotoInteractorProtocol!
    var router: PhotoRouterProtocol!
    
    required init (view: PhotoViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        view.clearFileCache()
        view.setUpViewComponents()
        view.openImage()
        view.downloadDataForLivePhoto()
    }
    
    func closeButtonClicked() {
        router.closeCurrentViewController()
    }
    
    func getImageData(urlString: String, completionHandler: @escaping ((UIImage) -> Void)) {
        interactor.getImageData(urlString: urlString) { (result) in
            completionHandler(result)
        }
    }
    
    func downloadImage(downloadUrlString: String, completionHandler: @escaping ((URL) -> Void)) {
        interactor.downloadImage(downloadUrlString: downloadUrlString) { (url) in
            completionHandler(url)
        }
    }
    
    func downloadVideo(downloadUrlString: String, completionHandler: @escaping ((URL) -> Void)) {
        interactor.downloadVideo(downloadUrlString: downloadUrlString) { (url) in
            completionHandler(url)
        }
    }
}
