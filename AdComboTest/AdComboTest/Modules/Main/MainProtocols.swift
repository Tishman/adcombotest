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
    func getPreviewImage(with urlString: String) -> UIImage
}

protocol MainPresenterProtocol: class {
    var router: MainRouterProtocol! { set get }
    func configureView()
    func getLivePhoto() -> [LivePhoto]
    func getPriviewImage(with urlString: String) -> UIImage
}

protocol MainRouterProtocol: class  {
}

protocol MainViewProtocol: class {
    func showAcitvityIndicator()
    func hideActivityIndicator()
}
