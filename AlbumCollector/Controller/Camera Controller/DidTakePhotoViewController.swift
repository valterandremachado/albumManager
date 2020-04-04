//
//  TakenPhotoViewController.swift
//  AlbumCollector
//
//  Created by Valter Andre Machado on 10/24/19.
//  Copyright © 2019 Valter Andre Machado. All rights reserved.
//

import UIKit
import AVFoundation
import LBTATools
import CoreData
import AssetsLibrary
import Photos
import ProgressHUD

//let vc = AlbumCell()
class DidTakePhotoViewController: UIViewController {
    
//  PREVIEW VIEW BUTTONS
    
   
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var settingsBtn: UIButton!
    
    var albumItem: [Album] = []
    let addNewAlbumCellId = "AddNewAlbumCell"
    let albumCellId = "AlbumCell"
    
    var longPressed = false
    var selectedItem = 0
    var shakeEnabled: Bool!
       
//    var albumArray = [AlbumModel]()
    
    @IBOutlet weak var photo: UIImageView!
    var image: UIImage!
    
    lazy var ttxField: UITextField = {
        var txtFld = UITextField()
        return txtFld
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
//        preferredContentSize = layout.itemSize

        //registering the cells 
        cv.register(AlbumCell.self, forCellWithReuseIdentifier: albumCellId)
        cv.register(AddNewAlbumCell.self, forCellWithReuseIdentifier: addNewAlbumCellId)

        return cv
    }()

    lazy var editBtn: UIButton = {
        var btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Edit", for: UIControl.State())
        btn.setTitleColor(.blue, for: UIControl.State())
//        btn.addTarget(vc, action: #selector(self.vc.editBtnPressed), for: .touchUpInside)
        return btn
    }()
//    override func loadView() {
////        self.vc = AlbumCell()
//        editBtn.addTarget(vc, action: #selector(self.vc.editBtnPressed), for: .touchUpInside)
//
//    }
    //    HIDING THE STATUS BAR
    override var prefersStatusBarHidden: Bool {
        return true
    }

    
//    let pinchRecognizer = UIPinchGestureRecognizer(target: self, action:#selector(pinch(_:)))
    
    //MARK: VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: PASSING THE TAKEN PHOTO TO THIS VC
//        tapToStop()
        buttonTintColor()
        photo.contentMode = .scaleAspectFit
//        didTakePicture(image)
        
        photo.image = self.image
        setupCollectionView()
    }
    
    func didTakePicture(_ picture: UIImage) {
        let flippedImage = UIImage(cgImage: picture.cgImage!, scale: picture.scale, orientation: .leftMirrored)
        // Here you have got flipped image you can pass it wherever you are using image
        photo.image = flippedImage

    }
    
    //MARK: VIEWwillAppear
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
        
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
      }

      let managedContext = appDelegate.persistentContainer.viewContext
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Album")
      let sortAlbum = NSSortDescriptor(key: "title", ascending: true)
      fetchRequest.sortDescriptors = [sortAlbum]
      fetchRequest.returnsObjectsAsFaults = false

      do {
        albumItem = try managedContext.fetch(fetchRequest) as! [Album]
        collectionView.reloadData()
//        collectionView.setContentOffset(CGPoint.zero, animated: true)
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
        collectionView.reloadData()
    }
    
    fileprivate func buttonTintColor(){
        backBtn.tintColor = .white
        saveBtn.tintColor = .white
        settingsBtn.tintColor = .white
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func settingsBtn(_ sender: Any) {
    }
    
}







