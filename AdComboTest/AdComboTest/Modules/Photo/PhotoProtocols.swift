//
//  PhotoProtocols.swift
//  AdComboTest
//
//  Created by Роман Тищенко on 03/02/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoViewProtocol: class {
    func openImage()
    func clearFileCache()
    func setUpViewComponents()
    func getLivePhoto()
    func downloadDataForLivePhoto()
}

protocol PhotoPresenterProtocol: class {
    func configureView()
    func closeButtonClicked()
    func getImageData(urlString: String, completionHandler: @escaping ((UIImage) -> Void))
    func downloadImage(downloadUrlString: String, completionHandler: @escaping ((URL) -> Void))
    func downloadVideo(downloadUrlString: String, completionHandler: @escaping ((URL) -> Void))
}

protocol PhotoInteractorProtocol: class {
    func getImageData(urlString: String, completionHandler: @escaping ((UIImage) -> Void))
    func downloadImage(downloadUrlString: String, completionHandler: @escaping ((URL) -> Void))
    func downloadVideo(downloadUrlString: String, completionHandler: @escaping ((URL) -> Void))
}

protocol PhotoConfiguratorProtocol: class {
    func configure (with viewController: PhotoViewController)
}

protocol PhotoRouterProtocol: class {
    func closeCurrentViewController()
}
