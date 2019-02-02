//
//  MainInteractor.swift
//  AdComboTest
//
//  Created by Роман Тищенко on 01/02/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import Foundation

class MainInteractor: MainInteractorProtocol {
    
    weak var presenter: MainPresenterProtocol!
    
    required init (presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getAllLivePhotos() {
        
    }
    
    func getPreviewImage() {
        
    }
}
