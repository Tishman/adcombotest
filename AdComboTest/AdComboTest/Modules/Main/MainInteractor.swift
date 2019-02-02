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
    
    func getPreviewImage(with urlString: String) -> UIImage {
        var previewImageData: Data?
        
        PhotoService.getPreviewImageData(completionHandler: { (result) in
            previewImageData = result
        }, previewPhotoUrlString: urlString)
        
        if let previewImageData = previewImageData {
            guard let image = UIImage(data: previewImageData) else { return UIImage(named: "No_image.svg")! }
            return image
        } else { return UIImage(named: "No_image.svg")! }
    }
}
