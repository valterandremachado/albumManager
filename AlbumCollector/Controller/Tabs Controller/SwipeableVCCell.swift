//
//  SwipeableVCCell.swift
//  AlbumCollector
//
//  Created by Valter Andre Machado on 1/17/20.
//  Copyright © 2020 Valter Andre Machado. All rights reserved.
//

import UIKit
import Photos

class SwipeableVCCell: UICollectionViewCell {
    lazy var image: UIImageView = {
           let iv = UIImageView()
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.sizeToFit()
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
    //        iv.layer.borderWidth = 2
//            iv.layer.cornerRadius = 14
            return iv
        }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    func setupView(){
        [image].forEach({addSubview($0)})
        contentView.backgroundColor = .red
        image.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10))
    }
    func setImage(_ asset: PHAsset) {
        self.image.image = asset.getAssetThumbnail(size: CGSize(width: contentView.frame.width, height: contentView.frame.height))
//        self.image.image = asset.get(size: CGSize(width: contentView.frame.width, height: contentView.frame.height))
//        self.image.image = asset.getImageFromPHAsset()
    }
    
//    func setImageTwo(_ image: UIImage) {
//        self.image.image = image
//    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
