//
//  AlbumCollectionViewCell.swift
//  CustomGallery
//
//  Created by Pavle Pesic on 7/14/18.
//  Copyright © 2018 Pavle Pesic. All rights reserved.
//

import UIKit
import Photos

class AlbumCollectionViewCell: UICollectionViewCell {

    // MARK: - Outelts
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    
    // MARK: - Public methods
    
    func setAlbum(_ album: PHAssetCollection) {
        albumNameLabel.text = album.localizedTitle!
        albumImageView.layer.cornerRadius = 10
        albumNameLabel.sizeToFit()
//        albumNameLabel.lineBreakMode = .byWordWrapping
//        albumNameLabel.numberOfLines = 0
//        albumNameLabel.layoutIfNeeded()
        albumImageView.image = album.getCoverImgWithSize(CGSize(width: albumImageView.frame.width, height: albumImageView.frame.height))
    }

}
