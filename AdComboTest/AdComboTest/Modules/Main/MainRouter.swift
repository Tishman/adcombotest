//
//  MainRouter.swift
//  AdComboTest
//
//  Created by Роман Тищенко on 01/02/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import Foundation
import UIKit

class MainRouter: MainRouterProtocol {
    weak var viewController: MainViewController!
    
    init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
    func showLivePhotoScene() {
        viewController.performSegue(withIdentifier: viewController.selfToPhotoSegueName, sender: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?, imageUrlString: String, movieUrlString: String) {
        let photoViewController = segue.destination as! PhotoViewController
        photoViewController.imageUrlString = imageUrlString
        photoViewController.videoUrlString = movieUrlString
    }
    
}
