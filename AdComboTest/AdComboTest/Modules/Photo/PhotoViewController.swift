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
    var createdLivePhoto: PHLivePhoto?
    var imageFileUrl: URL?
    var videoFileUrl: URL?
    var presenter: PhotoPresenterProtocol!
    let configurator: PhotoConfiguratorProtocol = PhotoConfigurator()
    var livePhotoView: PHLivePhotoView?
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet var closeButton: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - View methods
    
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
    
    @IBAction func saveLivePhotoToLibary(_ sender: UIButton) {
        presenter.saveButtonClicked()
    }
    
    // MARK: - PhotoViewProtocol Methods
    
    func saveButtonClicked(){
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized else { return }
            
            PHPhotoLibrary.shared().performChanges({
                guard let imageFileUrl = self.imageFileUrl else { return }
                let creationRequest = PHAssetCreationRequest.forAsset()
                creationRequest.addResource(with: .photo, fileURL: imageFileUrl, options: nil)
                
                let options = PHAssetResourceCreationOptions()
                options.shouldMoveFile = true
                guard let videoFileUrl = self.videoFileUrl else { return }
                creationRequest.addResource(with: .pairedVideo, fileURL: videoFileUrl, options: options)
            })
        }
        let alertController = UIAlertController(title: "Saved", message: "Image saved to Photo library", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func getLivePhoto() {
        DispatchQueue.main.async {
            guard let imageFileUrl = self.imageFileUrl else { return }
            guard let videoFileUrl = self.videoFileUrl else { return }
            guard let previewImage = self.photo.image else { return }
            self.makeLivePhoto(imageURL: imageFileUrl, videoURL: videoFileUrl, previewImage: previewImage) { (livePhoto) in
                self.createdLivePhoto = livePhoto
            }
        }
    }
    
    func setUpViewComponents() {
        if traitCollection.forceTouchCapability != UIForceTouchCapability.unavailable {
            let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
            self.view.addGestureRecognizer(longPressRecognizer)
        }
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
            self.getLivePhoto()
            DispatchQueue.main.async {
                self.saveButton.isEnabled = true
            }
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
    
    // MARK: - Touch methods
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if #available(iOS 9.0, *) {
                if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
                    print("force touch")
                    let viewWithTag = self.view.viewWithTag(100)
                    if viewWithTag == nil {
                        if touch.force == touch.maximumPossibleForce {
                            livePhotoView = PHLivePhotoView(frame: self.view.frame)
                            livePhotoView!.tag = 100
                            livePhotoView!.livePhoto = createdLivePhoto
                            self.view.addSubview(livePhotoView!)
                            livePhotoView!.startPlayback(with: .full)
                        } else {
                            if let viewWithTag = self.view.viewWithTag(100) {
                                viewWithTag.removeFromSuperview()
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for subView in self.view.subviews {
            if subView.tag == 100{
            subView.removeFromSuperview()
            }
        }
    }
    
    @objc private func longPressed(sender: UILongPressGestureRecognizer)
    {
        print("long touch")
        let livePhotoView = PHLivePhotoView(frame: self.view.frame)
        livePhotoView.tag = 100
        livePhotoView.livePhoto = createdLivePhoto
        
        switch sender.state {
        case .began:
            self.view.addSubview(livePhotoView)
            livePhotoView.startPlayback(with: .full)
        case .ended:
            for subView in self.view.subviews {
                if subView.tag == 100{
                    subView.removeFromSuperview()
                }
            }
        default:
            break
        }
    }
}
