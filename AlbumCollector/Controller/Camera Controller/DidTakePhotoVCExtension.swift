//
//  DidTakePhotoVCExtension.swift
//  AlbumCollector
//
//  Created by Valter Andre Machado on 10/27/19.
//  Copyright © 2019 Valter Andre Machado. All rights reserved.
//

import UIKit
import AVFoundation
import LBTATools
import CoreData
import Photos
import ProgressHUD


//MARK: DidTakePhoto View Controller Extension
extension DidTakePhotoViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    
    
    //MARK: COLLECTION VIEW CONSTRAINT
    func setupCollectionView(){
//        view.addSubview(collectionView)
        [collectionView].forEach({view.addSubview($0)})
        
//        collectionView.backgroundColor =  .gray
        collectionView.contentMode = .scaleAspectFit
        preferredContentSize = photo.image!.size
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize.init(width: 0, height: view.frame.width/2.2))
//        editBtn.anchor(top: collectionView.topAnchor, leading: nil, bottom: nil, trailing: collectionView.trailingAnchor)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3.9, height: collectionView.frame.width/2.5)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // ARRAY 1
        print("ARRAY 1: numberOfItemsInSection = \(albumItem.count)")
        return albumItem.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: albumCellId, for: indexPath) as! AlbumCell
        
        if indexPath.item == 0 {
           let addAlbum = collectionView.dequeueReusableCell(withReuseIdentifier: addNewAlbumCellId, for: indexPath) as! AddNewAlbumCell
//            addAlbum.addAlbumBtn.tag = indexPath.item
            addAlbum.addAlbumBtn.addTarget(self, action: #selector(addNewAlbumPressed), for: UIControl.Event.touchUpInside)
            
            return addAlbum
        }
        else
        {
            cell.data = albumItem[indexPath.item - 1]
            // ARRAY 2
//            print("ARRAY 2: number of AlbumItem = \(self.albumItem[indexPath.count - 1])")

            cell.deleteBtn.tag = indexPath.item
            cell.deleteBtn.addTarget(self, action: #selector(deleteAlbum), for: UIControl.Event.touchUpInside)
            cell.addPhotoBtn.tag = indexPath.item
            cell.addPhotoBtn.addTarget(self, action: #selector(addPhotoToAlbum), for: UIControl.Event.touchUpInside)
            cell.doneBtn.tag = indexPath.item
            cell.doneBtn.addTarget(cell, action: #selector(cell.doneBtnFunc(sender:)), for: UIControl.Event.touchUpInside)
        }
        return cell
    }
    
    
    //MARK: SETUP CONTEXT MENU using collectionView as a default delegate **
//    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
////        let location = point.
//        let index = indexPath.item - 1
//        let album = self.albumItem[indexPath.item - 1]
//
//        if indexPath.item == 0 {
////            self.collectionView.isUserInteractionEnabled = false
//            print("Add Album Button Pressed \(index)")
//        }
//
//           func makeContextMenu(for: Album) -> UIMenu {
//
//                // Create a UIAction for sharing
//                let share = UIAction(title: "Share Album", image: UIImage(systemName: "square.and.arrow.up")) { action in
//                    // Show system share sheet
//                    print("share")
//
//                }
//                let rename = UIAction(title: "Rename Album", image: UIImage(systemName: "square.and.pencil")) { action in
//                    // Show rename UI
//                    print("rename")
//
//                }
//
//
//                // Here we specify the "destructive" attribute to show that it’s destructive in nature
//                let delete = UIAction(title: "Delete Album", image: UIImage(systemName: "trash"), attributes: .destructive) { action in
//                    // Delete this album 😢
//                    print("Delete")
//                    print(index)
//                    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
//                    let context = appDelegate.persistentContainer.viewContext
////                    self.deleteAlbumAsset(albumName: album.title!, index: index, context: context)
//
//                     context.delete(self.albumItem[index] as NSManagedObject)
//                            self.albumItem.remove(at: index)
//                            let _ : NSError! = nil
//                            do {
//                                try context.save()
//                                self.collectionView.reloadData()
//                            } catch {
//                                print("error : \(error)")
//                            }
//
////                    self.deleteAlbumAsset2(albumName: self.albumItem[index - 1].title!)
//
//                    self.collectionView.reloadData()
//                }
//
//                // Create and return a UIMenu with the share action
//                return UIMenu(title: "", children: [share, rename, delete])
//            }
//        let albumInContextMenu = self.albumItem[indexPath.item - 1]
//
////        return UIContextMenuConfiguration(identifier: nil, previewProvider: {
////            // Create a preview view controller and return it
////            return SecondViewController(index: index)
////        }, actionProvider: { suggestedActions in
////            return makeContextMenu(for: index)
////        })
////        func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willCommitWithAnimator animator: UIContextMenuInteractionCommitAnimating) {
////
////               animator.addCompletion {
////
////                self.show(SecondViewController(album: album), sender: self)
////               }
////           }
//        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in
//            // "albumItem" is the array backing the collection view
//            return makeContextMenu(for: albumInContextMenu)
//        })
//
//    }
    ///
//    func collectionView(_ collectionView: UICollectionView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
//
//            let id = configuration.identifier as! String
//
//            animator.addCompletion {
//                self.show(SecondViewController(album: Int(id)), sender: self)
//            }
//    }
   
//
    // **

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //        print(section)
    //        if albumArray.count == 0{
    //            return UIEdgeInsets(top: 0, left: view.frame.width/2, bottom: 0, right: view.frame.width/2)
    //        }
            return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
   
    @objc func deleteAlbum(sender:UIButton, cell: UICollectionViewCell) {
        // FIXING ARRAY OUT OF BOUND ISSUE (ISSUE COMING FROM COLLECTIONVIEW CELL)
        // ARRAY 3
        let index = sender.tag - 1
//        print(index)
        print("ARRAY 3: Index Touched = \(index)")
//        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
////        self.deleteAlbumAsset(albumName: albumItem[index].title!, index: index,context: context)
//
//        context.delete(self.albumItem[index] as NSManagedObject)
//        self.albumItem.remove(at: index)
//        let _ : NSError! = nil
//        do {
//            try context.save()
//            self.collectionView.reloadData()
//        } catch {
//            print("error : \(error)")
//        }
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        /// deletes custom album along with its photos only if the user allow it.
        self.deleteAlbumPhotos(albumName: albumItem[index].title!, index: index, context: context)
        
        /// enabled even if item wasn't deleted
//        self.collectionView.reloadData()

    }

    @objc func addPhotoToAlbum(sender: UIButton){
        // ARRAY 4
            let index = sender.tag - 1
//            print(index)
            print("ARRAY 4: Index Touched = \(index)")
            /// updates the album's thumbnailImage stored into coreData
            updateThumbnailImage(albumName: albumItem[index].title!)
            PHPhotoLibrary.shared().savePhoto(image: self.image, albumName: albumItem[index].title!)
            dismiss(animated: true, completion: nil)
    }
    //MARK: Add New Album function
    @objc func addNewAlbumPressed(sender: UIButton){
        var txtFld = UITextField()
//        var lbl = UILabel()
        
       //MARK: SAVE RECENT PHOTO AS THE ALBUM COVER
        let alert = UIAlertController(title: "New Album", message: "Enter a name for this album.", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in

//      let rotatedImg = self.image.rotate(radians: -180)
//      let data = (rotatedImg).pngData()
        let data = (self.image)!.jpegData(compressionQuality: 0.5)
            
//      accessDate.createdAt = Date()
        let image = self.image!
        let nameToSave = txtFld.text!
        let imageToSave = data
        let dateToSave = Date()
            
     
        PHPhotoLibrary.shared().savePhoto(image: image, albumName: nameToSave)
        self.save(name: nameToSave, image: imageToSave!, createdAt: dateToSave)
        self.collectionView.reloadData()
        self.collectionView.layoutIfNeeded()
    }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField { (addTextField) in
            addTextField.placeholder = "Title"
            txtFld = addTextField
        }
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
//        alert.view.layoutIfNeeded() //avoid Snapshotting error
        present(alert, animated: true)
    }
    
    //MARK: CORE DATA SETTINGS **
    func save(name: String, image: Data, createdAt: Date) {
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
      }

      let managedContext = appDelegate.persistentContainer.viewContext
      let entity = NSEntityDescription.entity(forEntityName: "Album", in: managedContext)!
      let album = NSManagedObject(entity: entity, insertInto: managedContext)
        
      album.setValue(name, forKeyPath: "title")
      album.setValue(image, forKeyPath: "thumbnailImage")
      album.setValue(createdAt, forKey: "createdAt")

      do {
        try managedContext.save()
        albumItem.append(album as! Album)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    //**
}

extension DidTakePhotoViewController{
    
    // MARK: Delete Album Public method
    func deleteAlbumAssetCollection(albumName: String, index: Int, context: NSManagedObjectContext) {
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        let album = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        
        /// check if album is available
        if album.firstObject != nil {
            // request to delete album
        PHPhotoLibrary.shared().performChanges({
            PHAssetCollectionChangeRequest.deleteAssetCollections(album)
        }, completionHandler: { (success, error) in
            if success {
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                  guard let self = self else {
                    return
                  }
                    context.delete(self.albumItem[index] as NSManagedObject)
                    self.albumItem.remove(at: index)

                  // 2
                  DispatchQueue.main.async { [weak self] in
                    // 3
                    let _ : NSError! = nil
                    do {
                        try context.save()
                        self!.collectionView.deleteItems(at: [IndexPath(item: index + 1, section: 0)])
                        self!.collectionView.reloadData()
                    } catch {
                        print("error : \(error)")
                    }
//                    self!.collectionView.reloadData()
                    print("Reload Data")
                  }
                }
                
                print(" \(albumName) removed succesfully")
            } else if error != nil {
                print("request failed. please try again")
            }
            else
            {
                print("album not removed")
            }

        })
        } else {
            print("requested album \(albumName) not found in photos")
        }
//        self.collectionView.reloadData()

    }
    
    /// deletes (album's asset) photos in the album.
    func deleteAlbumPhotos(albumName: String, index: Int, context: NSManagedObjectContext) {
        
          let fetchOptions = PHFetchOptions()
          fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)

          let assetCollections = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
          let album: PHAssetCollection = assetCollections.firstObject!
        let allPhotos = PHAsset.fetchAssets(in: album, options: nil)
//        PHAssetChangeRequest.deleteAssets(allPhotos)
//        let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        if album != nil {
            
          PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.deleteAssets(allPhotos)
          }, completionHandler: { success, error in
                  if success {
                    /// deletes (asset collection) created custom album inside of user gallery.
                    self.deleteAlbumAssetCollection(albumName: albumName, index: index, context: context)
                      print("removed")
                  } else {
                      print("not removed")
                  }
              })
        }
        else
        {
            print("not found")
        }
    }
    
    func updateThumbnailImage(albumName: String){
        let newThumbnailImage = (self.image)!.jpegData(compressionQuality: 0.5)
         //As we know that container is set up in the AppDelegates so we need to refer that container.
         guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
         
         //We need to create a context from this container
         let managedContext = appDelegate.persistentContainer.viewContext
         
         let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Album")
         fetchRequest.predicate = NSPredicate(format: "title = %@", albumName)
         do
         {
             let test = try managedContext.fetch(fetchRequest)
//                    var index2 = index + 2
                 let objectUpdate = test[0] as! NSManagedObject
                 objectUpdate.setValue(newThumbnailImage, forKey: "thumbnailImage")
//                 objectUpdate.setValue("newmail", forKey: "email")
//                 objectUpdate.setValue("newpassword", forKey: "password")
                 do{
                     try managedContext.save()
                    collectionView.reloadData()
                 }
                 catch
                 {
                     print(error)
                 }
             }
         catch
         {
             print(error)
         }
    
     }
}













//import UIKit

/*class SecondViewController : UIViewController{
    
    var imageView : UIImageView!
    var index : Int?
    
    override func loadView() {
        super.loadView()

        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        imageView.contentMode = .scaleToFill
        
        self.imageView = imageView
    }
    
//    override func viewDidLoad() {
//
//        if ((index ?? 0)%2 == 0)
//        {
//            self.imageView.image = UIImage(named: "car")?.addFilter(filter: "CIPhotoEffectProcess")
//            self.view.backgroundColor = .black
//        }else{
//            self.imageView.image = UIImage(named: "bike")?.addFilter(filter: "CIPhotoEffectNoir")
//            self.view.backgroundColor = .white
//        }
//
//    }
    
    init(album: Album) {
        super.init(nibName: nil, bundle: nil)
//        self.index = album
//        album.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
*/
extension UIImage {
func addFilter(filter : String) -> UIImage {
let filter = CIFilter(name: filter)
// convert UIImage to CIImage and set as input
let ciInput = CIImage(image: self)
filter?.setValue(ciInput, forKey: "inputImage")
let ciOutput = filter?.outputImage
let ciContext = CIContext()
let cgImage = ciContext.createCGImage(ciOutput!, from: (ciOutput?.extent)!)
return UIImage(cgImage: cgImage!)
}
}
