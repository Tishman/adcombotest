//
//  PhotoRouter.swift
//  AdComboTest
//
//  Created by Роман Тищенко on 03/02/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import Foundation

class PhotoRouter: PhotoRouterProtocol {
    weak var viewController: PhotoViewController!
    
    init(viewController: PhotoViewController) {
        self.viewController = viewController
    }
    
    func closeCurrentViewController() {
        viewController.dismiss(animated: true, completion: nil)
    }
}
