//
//  SwipeableVC.swift
//  AlbumCollector
//
//  Created by Valter Andre Machado on 1/17/20.
//  Copyright © 2020 Valter Andre Machado. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

var swipeableVCCell = "SwipeableVCCell"

class SwipeableVC: UIViewController {
    
    var selectedCollection: PHAssetCollection?
    private var photos: PHFetchResult<PHAsset>!
//    var photos = [PHAsset]()

//    private var numbeOfItemsInRow = 5
    
    lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        //registering the cells
        cv.register(SwipeableVCCell.self, forCellWithReuseIdentifier: swipeableVCCell)
        return cv
    }()
    
    override func viewDidLoad() {
//        view.backgroundColor = .red
        self.fetchImagesFromGallery(collection: self.selectedCollection)

        setupView()
    }
     private func fetchImagesFromGallery(collection: PHAssetCollection?) {
            DispatchQueue.main.async {
                let fetchOptions = PHFetchOptions()
                fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: false)]
//                let fetchOptions = PHFetchOptions()
//                fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
                if let collection = collection {
                    self.photos = PHAsset.fetchAssets(in: collection, options: fetchOptions)
                } else {
                    self.photos = PHAsset.fetchAssets(with: fetchOptions)
                }
                self.collectionView.reloadData()
            }
        }
    
//    func fetchImagesFromGallery(assets: [PHAsset]) -> [UIImage] {
//        var arrayOfImages = [UIImage]()
//        for asset in assets {
//            let manager = PHImageManager.default()
//            let option = PHImageRequestOptions()
//            var image = UIImage()
//            option.isSynchronous = true
//            manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
//                image = result!
//                arrayOfImages.append(image)
//            })
//        }
//
//        return arrayOfImages
//    }
   
}

extension SwipeableVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func setupView(){
           [collectionView].forEach({view.addSubview($0)})
           collectionView.backgroundColor = .green
           collectionView.delegate = self
           collectionView.dataSource = self
           collectionView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
       }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let photos = photos {
                  return photos.count
              }
              return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: swipeableVCCell, for: indexPath) as? SwipeableVCCell
        cell?.setImage(photos.object(at: indexPath.row))
        
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        let width = (Int(UIScreen.main.bounds.size.width) - (numbeOfItemsInRow - 1) * 6 - 40) / numbeOfItemsInRow
//            return CGSize(width: collectionView.frame.width/3.9, height: collectionView.frame.width/2.5)
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
}
