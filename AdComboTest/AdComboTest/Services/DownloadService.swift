//
//  DwonloadService.swift
//  AdComboTest
//
//  Created by Роман Тищенко on 03/02/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import Foundation

enum FileType: String {
    case video = ".mov"
    case image = ".jpg"
}

protocol DownloadServiceProtocol: class {
    static func downloadMedia(downloadUrlString: String, fileType: FileType, completionHandler: @escaping ((URL) -> Void))
}

class DownloadService: DownloadServiceProtocol {
    
    private init() {}
    
    static func downloadMedia(downloadUrlString: String, fileType: FileType, completionHandler: @escaping ((URL) -> Void)) {
        guard let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let destinationFileUrl = documentsUrl.appendingPathComponent("downloadedFile" + fileType.rawValue)
        let downloadUrl = URL(string: downloadUrlString)!
        URLSession.shared.downloadTask(with: downloadUrl) { (localUrl, response, error) in
            do {
                guard let localUrl = localUrl else { return }
                try FileManager.default.copyItem(at: localUrl, to: destinationFileUrl)
                completionHandler(destinationFileUrl)
                print("Download successfull")
            } catch {
                print("Error creating a file")
            }
        }.resume()
    }
}
