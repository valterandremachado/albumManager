//
//  AddAlbumCell.swift
//  AlbumCollector
//
//  Created by Valter Andre Machado on 10/27/19.
//  Copyright © 2019 Valter Andre Machado. All rights reserved.
//

import UIKit
import AVFoundation
import LBTATools

var addimage = UIImage(named: "add-100")

// MARK: Add New Album Cell
class AddNewAlbumCell: UICollectionViewCell {
    
    lazy var addAlbumBtn: UIButton = {
        var btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(addimage, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
//        btn.imageView?.frame = CGRect(x: 0, y: 0 , width: 30, height: 30)
        btn.imageEdgeInsets = .init(top: 15, left: 15, bottom: 15, right: 15)
//        btn.setTitle("Add", for: UIControl.State())
        btn.tintColor = UIColor.white
        btn.backgroundColor = .gray
        btn.layer.cornerRadius = 14
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
//        btn.titleEdgeInsets = .init(top: 150, left: 0, bottom: 0, right: 0)
        return btn
        }()
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        return layoutAttributes
    }
    override init(frame: CGRect) {
           super.init(frame: .zero)
        views()
//        contentView.isUserInteractionEnabled = false
    }
    
    func views(){
        contentView.addSubview(addAlbumBtn)
//        addAlbumBtn.isUserInteractionEnabled = true
        addAlbumBtn.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets.init(top: 5, left: 0, bottom: 5, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
