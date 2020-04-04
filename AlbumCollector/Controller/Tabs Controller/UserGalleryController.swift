//
//  PhotosViewController.swift
//  CustomGallery
//
//  Created by Pavle Pesic on 7/14/18.
//  Copyright © 2018 Pavle Pesic. All rights reserved.
//

import UIKit
import Photos

class UserGalleryController: UIViewController {

    // MARK: - Vars & Lets
    
    
    var selectedCollection: PHAssetCollection?
    private var photos: PHFetchResult<PHAsset>!
    private var numbeOfItemsInRow = 5
    
    // MARK: - Outelts
    @IBOutlet weak var cameraBtnTabTwo: UIButton!
    
    @IBOutlet weak var collectionViewUserLibrary: UICollectionView!
    
    // MARK: - Controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        cameraBtnThree.isHidden = true
        view.bringSubviewToFront(cameraBtnTabTwo)
//        collectionViewUserLibrary.backgroundColor = .black
        navigationItem.title = "Gallery"
        navigationItem.largeTitleDisplayMode = .automatic

        self.prepareCollectionView()
        self.fetchImagesFromGallery(collection: self.selectedCollection)
//        navigationItem.backBarButtonItem?.title = "back"
        
    }
    
    // MARK: - Private methods
    
    private func prepareCollectionView() {
        self.collectionViewUserLibrary.dataSource = self
        self.collectionViewUserLibrary.delegate = self
        
        self.collectionViewUserLibrary.register(UINib.init(nibName: "UserGalleryCell", bundle: nil), forCellWithReuseIdentifier: "UserGalleryCell")
    }
    
    private func fetchImagesFromGallery(collection: PHAssetCollection?) {
        DispatchQueue.main.async {
//            let fetchOptions = PHFetchOptions()
//            fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: false)]
//            fetchOptions.fetchLimit = 3

            // Fetch the image assets
//            let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
            if let collection = collection {
                self.photos = PHAsset.fetchAssets(in: collection, options: fetchOptions)
            } else {
                self.photos = PHAsset.fetchAssets(with: fetchOptions)
            }
            self.collectionViewUserLibrary.reloadData()
        }
    }

}

// MARK: - Exteinsions
// MARK: - UICollectionViewDataSource

extension UserGalleryController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let photos = photos {
            return photos.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserGalleryCell", for: indexPath) as? UserGalleryCell
        cell?.setImage(photos.object(at: indexPath.row))
        
        return cell!
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension UserGalleryController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 20, bottom: 20, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (Int(UIScreen.main.bounds.size.width) - (numbeOfItemsInRow - 1) * 6 - 1) / numbeOfItemsInRow
        return CGSize(width: width, height: width)
    }

}


extension UIImageView{
 func fetchImage(asset: PHAsset, contentMode: PHImageContentMode, targetSize: CGSize) {
    let options = PHImageRequestOptions()
    options.version = .original
    PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: options) { image, _ in
        guard let image = image else { return }
        switch contentMode {
        case .aspectFill:
            self.contentMode = .scaleAspectFill
        case .aspectFit:
            self.contentMode = .scaleAspectFit
        }
        self.image = image
    }
   }
}
