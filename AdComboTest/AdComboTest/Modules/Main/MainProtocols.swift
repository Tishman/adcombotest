//
//  MainProtocols.swift
//  AdComboTest
//
//  Created by Роман Тищенко on 01/02/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import Foundation
import UIKit

protocol MainConfiguratorProtocol: class {
    func configure (with viewController: MainViewController)
}

protocol MainInteractorProtocol: class {
    func getLivePhoto() -> [LivePhoto]
    func getPreviewImage(urlString: String, completionHandler: @escaping ((UIImage) -> Void))
}

protocol MainPresenterProtocol: class {
    var router: MainRouterProtocol! { set get }
    func configureView()
    func getLivePhoto() -> [LivePhoto]
    func getPriviewImage(urlString: String, completionHandler: @escaping ((UIImage) -> Void))
}

protocol MainRouterProtocol: class  {
}

protocol MainViewProtocol: class {
    func showAcitvityIndicator()
    func hideActivityIndicator()
}
