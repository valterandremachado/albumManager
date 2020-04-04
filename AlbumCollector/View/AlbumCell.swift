//
//  AlbumCell.swift
//  AlbumCollector
//
//  Created by Valter Andre Machado on 10/27/19.
//  Copyright © 2019 Valter Andre Machado. All rights reserved.
//

import UIKit
import AVFoundation
import LBTATools
import Photos
import AudioToolbox


let doneImage = UIImage(named: "done")
let addImage = UIImage(named: "add2")
let removeImage = UIImage(named: "remove")


// MARK: Existing Album Cell
class AlbumCell: UICollectionViewCell, UIGestureRecognizerDelegate{
   
    
    
    var shakeEnabled: Bool!
    
    var data: Album? {
        didSet {
//            guard let data = data else { return }
//            data.createdAt = Date()
//            albumTitle.text = data.title
            
            //MARK: CONVERTING IMAGE TYPE TO DATA TYPE
//            if let convertedImage = data.thumbnailImage {
//                    self.albumThumbnailimage.image = UIImage(data: convertedImage as Data)
//            }
            
            DispatchQueue.global(qos: .background).async {
                guard let data = self.data else { return }
                let converIG = data.thumbnailImage
                
                DispatchQueue.main.async {
                    self.albumTitle.text = data.title
                    self.albumThumbnailimage.image = UIImage(data: converIG!)
                }

            }
            
        }
    }
    lazy var deleteBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "delete"), for: UIControl.State())
//        btn.setTitle("delete", for: UIControl.State())
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = .red
//        btn.backgroundColor = .darkGray

        return btn
    }()
    
    lazy var addPhotoBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "add2"), for: UIControl.State())
//        btn.setTitle("Add", for: UIControl.State())
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.backgroundColor = .darkGray

        return btn
    }()
    
    lazy var doneBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "done"), for: UIControl.State())
//        btn.setTitle("Done", for: UIControl.State())
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        btn.backgroundColor = .darkGray

        return btn
    }()
    
    fileprivate var albumTitle: UILabel = {
        var lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.sizeToFit()
        lb.lineBreakMode = .byWordWrapping
//        lb.numberOfLines = 0
        lb.textAlignment = .center
        lb.font = .boldSystemFont(ofSize: 18)
        return lb
    }()
    
//    lazy var editBtn: UIButton = {
//        var btn = UIButton()
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.setTitle("Edit", for: UIControl.State())
//        return btn
//    }()
     
    fileprivate var albumThumbnailimage: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.sizeToFit()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
//        iv.layer.borderWidth = 2
        iv.layer.cornerRadius = 14
        return iv
    }()
    lazy var viewToTap: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        return layoutAttributes
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)

        gestureHandler()
        setupViews()
//        contentView.backgroundColor = .red
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func editBtnPressed() {
        print("123")
//        deleteBtn.isHidden = true
//        print("\(deleteBtn.isHidden)")
    }
    
//  func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
//
//      return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in
//
//          return self.makeContextMenu()
//      })
//  }
//    func makeContextMenu() -> UIMenu {
//
//        // Create a UIAction for sharing
//        let share = UIAction(title: "Share Pupper", image: UIImage(systemName: "square.and.arrow.up")) { action in
//            // Show system share sheet
//        }
//
//        // Create and return a UIMenu with the share action
//        return UIMenu(title: "Main Menu", children: [share])
//    }
   
    
//    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willCommitWithAnimator animator: UIContextMenuInteractionCommitAnimating){
//
//    }
    
    
    func gestureHandler(){
//         instatiate longPress feature
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        lpgr.minimumPressDuration = 0.5
        lpgr.delegate = self
        lpgr.delaysTouchesBegan = true
        contentView.addGestureRecognizer(lpgr)
                
        // instatiate tap feature
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
//        tapGesture.numberOfTapsRequired = 1
//        tapGesture.numberOfTouchesRequired = 1
//        contentView.addGestureRecognizer(tapGesture)
    }
    
    func setupViews(){
        [albumThumbnailimage, albumTitle, deleteBtn, doneBtn, addPhotoBtn].forEach({addSubview($0)})
        deleteBtn.isHidden = true
        doneBtn.isHidden = true
//        albumTitle.textAlignment = .center
        albumThumbnailimage.contentMode = .scaleAspectFill
//        albumThumbnailimage.backgroundColor = .green
//        let interaction = UIContextMenuInteraction(delegate: self)
//        albumThumbnailimage.isUserInteractionEnabled = true
//        albumThumbnailimage.addInteraction(interaction)
        
//        contentView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets.init(top: -5, left: -1, bottom: -5, right: -1) )
        albumThumbnailimage.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding:UIEdgeInsets.init(top: 5, left: 1, bottom: 5, right: 1))
        
//        albumTitle.anchor(top: nil, leading: nil, bottom: albumThumbnailimage.bottomAnchor, trailing: nil, padding: UIEdgeInsets.init(top: 0, left: albumThumbnailimage.frame.width - 2, bottom: 15, right: albumThumbnailimage.frame.width - 2))
        
        doneBtn.anchor(top: albumThumbnailimage.topAnchor, leading: nil, bottom: nil, trailing: albumThumbnailimage.trailingAnchor, padding: UIEdgeInsets.init(top: -3, left: 0, bottom: 0, right: -3), size: CGSize.init(width: 34, height: 34))
        
        deleteBtn.anchor(top: albumThumbnailimage.topAnchor, leading: albumThumbnailimage.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets.init(top: -1, left: -1, bottom: 0, right: 0), size: CGSize.init(width: 30, height: 30))
        
        addPhotoBtn.anchor(top: contentView.topAnchor, leading: nil, bottom: nil, trailing: contentView.trailingAnchor,padding: UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize.init(width: 50, height: 50))
        
        albumTitle.widthAnchor.constraint(equalTo: albumThumbnailimage.widthAnchor).isActive = true
        albumTitle.centerXAnchor.constraint(equalTo: albumThumbnailimage.centerXAnchor).isActive = true
        albumTitle.centerYAnchor.constraint(equalTo: albumThumbnailimage.bottomAnchor, constant: -15).isActive = true

    }
    
    //MARK: SHAKING COLLECTIONVIEWCELL **
    func shakeIcons() {
    let shakeAnimation = CABasicAnimation(keyPath: "transform.rotation")
            shakeAnimation.duration = 0.05
            shakeAnimation.repeatCount = 2
            shakeAnimation.autoreverses = true
    let startAngle: Float = (-2) * 3.14159/180
    let stopAngle = -startAngle
            shakeAnimation.fromValue = NSNumber(value: startAngle as Float)
            shakeAnimation.toValue = NSNumber(value: 3 * stopAngle as Float)
            shakeAnimation.autoreverses = true
            shakeAnimation.duration = 0.2
            shakeAnimation.repeatCount = 10000
            shakeAnimation.timeOffset = 290 * drand48()
    let layer: CALayer = self.layer
            layer.add(shakeAnimation, forKey:"shaking")
        shakeEnabled = true
        doneBtn.isHidden = false
        deleteBtn.isHidden = false
        addPhotoBtn.isHidden = true
        }
    
    func stopShakingIcons() {
        let layer: CALayer = self.layer
                layer.removeAnimation(forKey: "shaking")
        self.deleteBtn.isHidden = true
        shakeEnabled = false
        doneBtn.isHidden = true
        deleteBtn.isHidden = true
        addPhotoBtn.isHidden = false
    }
//
//    @objc func cellTapped(tapRecognizer: UITapGestureRecognizer){
//              print("cell tapped")
//   }
    @objc func doneBtnFunc(sender: UIButton){
        
            stopShakingIcons()
    }
 
    
    @objc func handleLongPress(gestureRecognizer : UILongPressGestureRecognizer){
        if (gestureRecognizer.state != UIGestureRecognizer.State.began)
        {
            print("gesture started")
            if shakeEnabled == true{
                /// Vibration enabler
//                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                gestureRecognizer.state = .cancelled
            }else{
                /// enables UIFeedbackGenerator 
                Vibration.medium.vibrate()
                shakeIcons()
            }
        }
//        else if shakeEnabled == false
//        {
//            stopShakingIcons()
//        }
    }
        
        
//
//        let p = gestureRecognizer.location(in: self)
//
//        if let indexPath: NSIndexPath = (self.indexPathForItem(at:p)) as NSIndexPath{
//            //do whatever you need to do
//         shakeIcons()
//
//        }

//    }
    // **

    }

