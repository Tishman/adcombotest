//
//  MainPresenter.swift
//  AdComboTest
//
//  Created by Роман Тищенко on 01/02/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import Foundation

class MainPresenter: MainPresenterProtocol {

    weak var view: MainViewProtocol!
    var interactor: MainInteractorProtocol!
    var router: MainRouterProtocol!
    
    required init (view: MainViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        
    }
    
    func getLivePhotoData() {
        
    }
}
