//
//  MainInteractor.swift
//  AdComboTest
//
//  Created by Роман Тищенко on 01/02/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import Foundation
import UIKit

class MainInteractor: MainInteractorProtocol {

    weak var presenter: MainPresenterProtocol!
    
    required init (presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getLivePhoto(completionHandler: @escaping (([LivePhoto]) -> Void)) {
        DataService.getLivePhotos { (result) in
            completionHandler(result)
        }
    }
    
    func getImageData(urlString: String, completionHandler: @escaping ((UIImage) -> Void)) {
        DataService.getPreviewImageData(previewPhotoUrlString: urlString,completionHandler: { (result) in
            if let previewImageData = result {
                completionHandler(UIImage(data: previewImageData)!)
            } else {
                completionHandler(UIImage(named: "No_image.svg")!)
            }
        })
    }
}
