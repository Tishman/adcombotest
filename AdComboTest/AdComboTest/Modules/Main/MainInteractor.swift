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
    
    func getLivePhoto() -> [LivePhoto] {
        var livePhotos: [LivePhoto] = []
        
        PhotoService.getLivePhotos { (result) in
            livePhotos = result
        }
        return livePhotos
    }
    
    func getPreviewImage(urlString: String, completionHandler: @escaping ((UIImage) -> Void)) {
        var previewImageData: Data?
        
        PhotoService.getPreviewImageData(previewPhotoUrlString: urlString,completionHandler: { (result) in
            previewImageData = result
            if let previewImageData = previewImageData {
                completionHandler(UIImage(data: previewImageData)!)
            } else {
                completionHandler(UIImage(named: "No_image.svg")!)
            }
        })
    }
}
