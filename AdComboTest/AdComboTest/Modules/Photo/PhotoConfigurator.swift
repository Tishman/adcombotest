//
//  PhotoConfigurator.swift
//  AdComboTest
//
//  Created by Роман Тищенко on 03/02/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import Foundation

class PhotoConfigurator: PhotoConfiguratorProtocol {
    func configure(with viewController: PhotoViewController) {
        let presenter = PhotoPresenter(view: viewController)
        let interactor = PhotoInteractor(presenter: presenter)
        let router = PhotoRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
