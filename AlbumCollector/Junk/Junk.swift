//
//  Junk.swift
//  AlbumCollector
//
//  Created by Valter Andre Machado on 10/27/19.
//  Copyright © 2019 Valter Andre Machado. All rights reserved.
//

import Foundation


//JUNK: CODE TO IMPLEMENT BUTTON IN THE LAST CELL OF A COLLECTION VIEW 
//func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return data.count + 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        let cellID = indexPath.item < data.count ? "CustomCell" : "AddAlbumCell"

//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
//        setupCell(cell: cell, indexPath: indexPath, type: cellID)
//        print(indexPath.item)
//    }
//func setupCell(cell: UICollectionViewCell, indexPath: IndexPath, type: String) {
//    switch(type) {
//    case "CustomCell":
//        setupCustomCell(cell: cell as! CustomCell, indexPath: indexPath)
//    case "AddAlbumCell":
//        setupAddAlbumCell(cell: cell as! AddAlbumCell, indexPath: indexPath)
//    default:
//        break
//    }
//}
//
//func setupCustomCell(cell: CustomCell, indexPath: IndexPath) {
//    cell.data = data[indexPath.item]
//}
//
//func setupAddAlbumCell(cell: AddAlbumCell, indexPath: IndexPath) {
//    cell.addAlbumBtn.addTarget(self, action: #selector(addAlbumPressed), for: UIControl.Event.touchUpInside)
//}



//import Foundation
//import UIKit
//import Photos
//import CoreData
//
//class CustomPhotoAlbum {
//
//    static let albumName = "Flashpod"
//    static let sharedInstance = CustomPhotoAlbum()
//
//    var assetCollection: PHAssetCollection!
//
//    init() {
//
//        func fetchAssetCollectionForAlbum() -> PHAssetCollection! {
//
//            let fetchOptions = PHFetchOptions()
//            fetchOptions.predicate = NSPredicate(format: "title = %@", CustomPhotoAlbum.albumName)
//            let collection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
//
//            if let firstObject: AnyObject = collection.firstObject {
//                return collection.firstObject as? PHAssetCollection
//            }
//
//            return nil
//        }
//
//        if let assetCollection = fetchAssetCollectionForAlbum() {
//            self.assetCollection = assetCollection
//            return
//        }
//
//        PHPhotoLibrary.shared().performChanges({
//            PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: CustomPhotoAlbum.albumName)
//        }) { success, _ in
//            if success {
//                self.assetCollection = fetchAssetCollectionForAlbum()
//            }
//        }
//    }
//
//    func saveImage(image: UIImage) {
//
//        if assetCollection == nil {
//            return   // If there was an error upstream, skip the save.
//        }
//
//        PHPhotoLibrary.shared().performChanges({
//
//            let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
//            guard let assetPlaceholder = assetChangeRequest.placeholderForCreatedAsset,
//                let albumChangeRequest = PHAssetCollectionChangeRequest(for: self.assetCollection) else {
//                    return
//            }
//
//            let enumeration: NSArray = [assetPlaceholder]
//            albumChangeRequest.addAssets(enumeration)
//
//            let request = PHAssetChangeRequest.creationRequestForAsset(from: image)
//            guard let placeholder = request.placeholderForCreatedAsset,
//                let _ = PHAssetCollectionChangeRequest(for: self.assetCollection) else {
//                return
//            }
//
//            let _: NSArray = [placeholder]
//            albumChangeRequest.addAssets(enumeration)
//        }, completionHandler: nil)
//    }
//
//
//}


//extension DidTakePhotoViewController {
//
//    func createAlbum(albumName: String) {
//        //Get PHFetch Options
//        let fetchOptions = PHFetchOptions()
//        fetchOptions.predicate = NSPredicate(format: "title = %@", "Album")
//        let collection : PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
//        //Check return value - If found, then get the first album out
//        if let _: AnyObject = collection.firstObject {
//            self.albumFound = true
//            assetCollection = collection.firstObject
//        } else {
//            //If not found - Then create a new album
//            PHPhotoLibrary.shared().performChanges({
//                let createAlbumRequest : PHAssetCollectionChangeRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: albumName)
//                self.assetCollectionPlaceholder = createAlbumRequest.placeholderForCreatedAssetCollection
//                }, completionHandler: { success, error in
//                    self.albumFound = success
//
//                    if (success) {
//                        let collectionFetchResult = PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [self.assetCollectionPlaceholder.localIdentifier], options: nil)
//                        print(collectionFetchResult)
//                        self.saveImage()
//                        self.assetCollection = collectionFetchResult.firstObject!
//                    }
//            })
//        }
//    }
//
//    func saveImage(){
//        PHPhotoLibrary.shared().performChanges({
//            let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: self.image)
//            guard let assetPlaceholder = assetChangeRequest.placeholderForCreatedAsset,
//                let albumChangeRequest = PHAssetCollectionChangeRequest(for: self.assetCollection) else {
//                    return
//            }
//
//            let enumeration: NSArray = [assetPlaceholder]
//            albumChangeRequest.addAssets(enumeration)
//
//            }, completionHandler: { success, error in
//                print("added image to album")
////                print(error!)
//
//                self.showImages()
//        })
//    }
//
//    func showImages() {
//    //This will fetch all the assets in the collection
//        let assets : PHFetchResult = PHAsset.fetchAssets(in: assetCollection, options: nil)
////        print(assets)
//
//        let imageManager = PHCachingImageManager()
//        //Enumerating objects to get a chached image - This is to save loading time
//        assets.enumerateObjects{(object: AnyObject!, count: Int, stop: UnsafeMutablePointer<ObjCBool>) in
//
//        if object is PHAsset {
//            let asset = object as! PHAsset
//            print(asset)
//
////            let imageSize = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
//
//            let options = PHImageRequestOptions()
//            options.deliveryMode = .highQualityFormat
//            imageManager.requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFill, options: options, resultHandler: {
//                (resultThumbnail: UIImage?, info) in
////                print(resultThumbnail!)
////                print(info)
//                 // Assign your thumbnail which is the *resultThumbnail*
//
////                self.image = resultThumbnail
////                (image: UIImage?, info: [NSObject : AnyObject]?) in
////                print(info)
////                print(image)
//                } )
//
//        }
//    }
//}
//}


//    // MARK: Delete Album Public method
//    func deleteAlbum(albumName: String) {
//        let options = PHFetchOptions()
//        options.predicate = NSPredicate(format: "title = %@", albumName)
//        let album = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: options)
//
//        // check if album is available
//        if album.firstObject != nil {
//
//            // request to delete album
//        PHPhotoLibrary.shared().performChanges({
//            PHAssetCollectionChangeRequest.deleteAssetCollections(album)
//        }, completionHandler: { (success, error) in
//            if success {
//
//
//                print(" \(albumName) removed succesfully")
//            } else if error != nil {
//                print("request failed. please try again")
//            }
//        })
//        } else {
//            print("requested album \(albumName) not found in photos")
//        }
//    }

/// UIContext
//    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
//
//        let configuration = UIContextMenuConfiguration(identifier: "\(indexPath.item)" as NSCopying, previewProvider: {
//            return SecondViewController(index: indexPath.item)
//        }){ action in
//                let viewMenu = UIAction(title: "View", image: UIImage(systemName: "eye.fill"), identifier: UIAction.Identifier(rawValue: "view")) {_ in
//                    print("button clicked..")
//                }
//                let rotate = UIAction(title: "Rotate", image: UIImage(systemName: "arrow.counterclockwise"), identifier: nil, state: .on, handler: {action in
//                    print("rotate clicked.")
//                })
//                let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash.fill"), identifier: nil, discoverabilityTitle: nil, attributes: .destructive, state: .on, handler: {action in
//
//                    print("delete clicked.")
//                })
//                let editMenu = UIMenu(title: "Edit...", children: [rotate, delete])
//
//
//                return UIMenu(title: "Options", image: nil, identifier: nil, children: [viewMenu, editMenu])
//            }
//
//
//            return configuration
//    }
//    func collectionView(_ collectionView: UICollectionView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
//
//        let id = configuration.identifier.self as! String
//
//            animator.addCompletion {
//                self.show(SecondViewController(index: Int(id)), sender: self)
//            }
//    }
