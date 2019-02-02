//
//  PhotoService.swift
//  AdComboTest
//
//  Created by Роман Тищенко on 01/02/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import Foundation

protocol PhotoServiceProtocol {
    static func getLivePhotos(completionHandler: @escaping (([LivePhoto]) -> Void))
    
    static func getPreviewImageData(previewPhotoUrlString: String, completionHandler: @escaping ((Data?) -> Void))
}

class PhotoService: PhotoServiceProtocol {
    
    private static let livePhotoUrlString = "https://m1.kappboom.com/livewallpapers/info?o=0&v=575"
    
    static func getLivePhotos(completionHandler: @escaping (([LivePhoto]) -> Void)) {
        guard let livePhotoUrl = URL(string: livePhotoUrlString) else { return }
        let semaphore = DispatchSemaphore(value: 0)
        
        URLSession.shared.dataTask(with: livePhotoUrl) { (data, response, error) in
            do {
                guard let data = data else { return }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let livePhotos = try decoder.decode([LivePhoto].self, from: data)
                completionHandler(livePhotos)
            } catch {
                completionHandler([])
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
    }
    
    static func getPreviewImageData(previewPhotoUrlString: String, completionHandler: @escaping ((Data?) -> Void)) {
        guard let previewImageUrl = URL(string: previewPhotoUrlString) else { return }
        
        URLSession.shared.dataTask(with: previewImageUrl) { (data, response, error) in
            guard let data = data else { return }
            completionHandler(data)
        }.resume()
    }
    
    
}
