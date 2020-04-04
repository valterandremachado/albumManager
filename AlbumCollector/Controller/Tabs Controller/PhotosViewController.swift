//
//  PhotosViewController.swift
//  CustomGallery
//
//  Created by Pavle Pesic on 7/14/18.
//  Copyright © 2018 Pavle Pesic. All rights reserved.
//

import UIKit
import Photos

class PhotosViewController: UIViewController {

    // MARK: - Vars & Lets
    public var myImage: UIImage?

    @IBOutlet weak var cameraBtnThree: UIButton!
    var selectedCollection: PHAssetCollection?
    private var photos: PHFetchResult<PHAsset>!
    private var numbeOfItemsInRow = 5
    
    // MARK: - Outelts
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.sendSubviewToBack(collectionView)
        view.bringSubviewToFront(cameraBtnThree)
//        cameraBtnThree.isHidden = true
        collectionView.backgroundColor = .clear
        view.backgroundColor = .black
        self.prepareCollectionView()
        self.fetchImagesFromGallery(collection: self.selectedCollection)
//        navigationItem.backBarButtonItem?.title = "back"
    }
    
    // MARK: - Private methods
    
    private func prepareCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: "PhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotosCollectionViewCell")
    }
    
    private func fetchImagesFromGallery(collection: PHAssetCollection?) {
        DispatchQueue.main.async {
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: false)]
//            let fetchOptions = PHFetchOptions()
//            fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
            if let collection = collection {
                self.photos = PHAsset.fetchAssets(in: collection, options: fetchOptions)
            } else {
                self.photos = PHAsset.fetchAssets(with: fetchOptions)
            }
            self.collectionView.reloadData()
        }
    }

}

// MARK: - Exteinsions
// MARK: - UICollectionViewDataSource

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let photos = photos {
            return photos.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as? PhotosCollectionViewCell
        cell?.setImage(photos.object(at: indexPath.row))
        
        return cell!
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 20, bottom: 20, right: 15)
    }
    
    // PROBLEM TO BE SOLVED
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        let width = (Int(UIScreen.main.bounds.size.width) - (numbeOfItemsInRow - 1) * 6 - 40) / numbeOfItemsInRow
//        return CGSize(width: collectionView.frame.width/3.9, height: collectionView.frame.width/2.5)
//        return CGSize(width: width, height: width)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("send data to swipeableVC")
        
        let swipeableVC = SwipeableVC()
        let selectedCell = collectionView.cellForItem(at: indexPath) as! SwipeableVCCell
        selectedCollection = selectedCell.image.image as? PHAssetCollection
//        let photo = photos[indexPath.item]
//        swipeableVC.photos = photo.getImageFromPHAsset()
            
//                let album = albums[indexPath.item]
//                photosViewController.title = album.localizedTitle
//                photosViewController.selectedCollection = album
//        swipeableVC.selectedCollection = photos
        self.navigationController?.pushViewController(swipeableVC, animated: true)
        //        self.present(photosViewController, animated: true, completion: nil)
        
    }

}
