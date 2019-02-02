//
//  MainProtocols.swift
//  AdComboTest
//
//  Created by Роман Тищенко on 01/02/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import Foundation

protocol MainConfiguratorProtocol: class {
    func configure (with viewController: MainViewController)
}

protocol MainInteractorProtocol: class {
    func getAllLivePhotos()
    func getPreviewImage()
}

protocol MainPresenterProtocol: class {
    var router: MainRouterProtocol! { set get }
    func configureView()
    func getLivePhotoData()
}

protocol MainRouterProtocol: class  {
}

protocol MainViewProtocol: class {
    func showAcitvityIndicator()
}
