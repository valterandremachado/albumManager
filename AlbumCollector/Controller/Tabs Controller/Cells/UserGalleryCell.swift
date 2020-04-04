//
//  UserLibraryCell.swift
//  AlbumCollector
//
//  Created by Valter Andre Machado on 1/7/20.
//  Copyright © 2020 Valter Andre Machado. All rights reserved.
//

import UIKit
import Photos

class UserGalleryCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setImage(_ asset: PHAsset) {
        self.imageView.image = asset.getAssetThumbnail(size: CGSize(width: self.frame.width * 3, height: self.frame.height * 3))
    }
    
    func setImage(_ image: UIImage) {
        self.imageView.image = image
    }
}
