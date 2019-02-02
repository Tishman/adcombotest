//
//  MainRouter.swift
//  AdComboTest
//
//  Created by Роман Тищенко on 01/02/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import Foundation

class MainRouter: MainRouterProtocol {
    
    weak var viewController: MainViewController!
    
    init(viewController: MainViewController) {
        self.viewController = viewController
    }
}
