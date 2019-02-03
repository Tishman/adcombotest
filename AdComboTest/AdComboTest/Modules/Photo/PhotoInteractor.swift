//
//  PhotoInteractor.swift
//  AdComboTest
//
//  Created by Роман Тищенко on 03/02/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import Foundation
import UIKit

class PhotoInteractor: PhotoInteractorProtocol {
    weak var presenter: PhotoPresenterProtocol!
    
    required init (presenter: PhotoPresenterProtocol) {
        self.presenter = presenter
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
    
    func downloadImage(downloadUrlString: String, completionHandler: @escaping ((URL) -> Void)) {
        DownloadService.downloadMedia(downloadUrlString: downloadUrlString, fileType: .image) { (url) in
            completionHandler(url)
        }
    }
    
    func downloadVideo(downloadUrlString: String, completionHandler: @escaping ((URL) -> Void)) {
        DownloadService.downloadMedia(downloadUrlString: downloadUrlString, fileType: .video) { (url) in
            completionHandler(url)
        }
    }
}
