//
//  PhotoViewController.swift
//  AdComboTest
//
//  Created by Роман Тищенко on 03/02/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import UIKit
import Photos
import PhotosUI

class PhotoViewController: UIViewController, PhotoViewProtocol {
    
    var imageUrlString: String = ""
    var videoUrlString: String = ""
    var imageFileUrl: URL?
    var videoFileUrl: URL?
    var presenter: PhotoPresenterProtocol!
    let configurator: PhotoConfiguratorProtocol = PhotoConfigurator()
    var castedLivePhoto: PHLivePhoto?
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet var closeButton: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Overrided methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.configureView()        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        clearFileCache()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - IBAction methods
    
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        presenter.closeButtonClicked()
    }
    
    @IBAction func startVideo(_ sender: UIButton) {
        guard let imageFileUrl = imageFileUrl else { return }
        guard let videoFileUrl = videoFileUrl else { return }
        guard let previewImage = photo.image else { return }
        makeLivePhoto(imageURL: imageFileUrl, videoURL: videoFileUrl, previewImage: previewImage) { (livePhoto) in
            DispatchQueue.main.async {
                let livePhotoView = PHLivePhotoView(frame: self.view.frame)
                livePhotoView.livePhoto = livePhoto
                self.view.addSubview(livePhotoView)
                livePhotoView.startPlayback(with: .full)
            }
        }
    }
    
    // MARK: - PhotoViewProtocol Methods
    
    func setUpViewComponents() {
        saveButton.layer.cornerRadius = saveButton.bounds.width / 2
        saveButton.isEnabled = false
        activityIndicator.startAnimating()
    }
    
    func clearFileCache() {
        let fileManager = FileManager.default
        let moviePath =  (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("downloadedFile.mov")
        
        let imagePath =  (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("downloadedFile.jpg")
        
        if fileManager.fileExists(atPath: moviePath) {
            try! fileManager.removeItem(atPath: moviePath)
        }
        
        if fileManager.fileExists(atPath: imagePath) {
            try! fileManager.removeItem(atPath: imagePath)
        }
    }
    
    func downloadDataForLivePhoto() {
        presenter.downloadVideo(downloadUrlString: videoUrlString) { (url) in
            self.videoFileUrl = url
        }
        
        presenter.downloadImage(downloadUrlString: imageUrlString) { (url) in
            self.imageFileUrl = url
        }
    }
    
    func openImage() {
        presenter.getImageData(urlString: imageUrlString) { (result) in
            DispatchQueue.main.async {
                self.photo.image = result
                self.activityIndicator.stopAnimating()
                self.saveButton.isEnabled = true
            }
        }
    }
    
    // MARK: - Private methods
    
    private func makeLivePhoto (imageURL: URL, videoURL: URL, previewImage: UIImage, completion: @escaping (_ livePhoto: PHLivePhoto) -> Void) {
        PHLivePhoto.request(withResourceFileURLs: [imageURL, videoURL], placeholderImage: previewImage, targetSize: CGSize.zero, contentMode: .aspectFit) { (livePhoto, infoDictionary) -> Void in
            if let lp = livePhoto {
                completion(lp)
            }
        }
    }
}
