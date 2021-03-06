//
//  MainPresenter.swift
//  AdComboTest
//
//  Created by Роман Тищенко on 01/02/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import Foundation
import UIKit

class MainPresenter: MainPresenterProtocol {

    weak var view: MainViewProtocol!
    var interactor: MainInteractorProtocol!
    var router: MainRouterProtocol!
    
    required init (view: MainViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        view.getLivePhotoList()
    }
    
    func getLivePhoto(completionHandler: @escaping (([LivePhoto]) -> Void)) {
        interactor.getLivePhoto { (result) in
            completionHandler(result)
        }
    }
    
    func getImageData(urlString: String, completionHandler: @escaping ((UIImage) -> Void)) {
        interactor.getImageData(urlString: urlString) { (result) in
            completionHandler(result)
        }
    }
}
