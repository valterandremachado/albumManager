//
//  AlbumsViewController.swift
//  CustomGallery
//
//  Created by Pavle Pesic on 7/14/18.
//  Copyright © 2018 Pavle Pesic. All rights reserved.
//

import UIKit
import Photos
import CoreData

class AlbumsViewController: UIViewController {

    // MARK: - Vars & Lets
    var albumItem: [Album] = []
    let albumCellId = "AlbumCell"

    private var albums: [PHAssetCollection] = []
    private var numbeOfItemsInRow = 3
    
    // MARK: - Outelts
//    @IBOutlet weak var shutterBtn: UIButton!
    @IBOutlet weak var cameraBtnTabOne: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.sendSubviewToBack(collectionView)
        view.bringSubviewToFront(cameraBtnTabOne)
        collectionView.backgroundColor = .clear
        view.backgroundColor = .black
//        cameraBtnTabTwo.isHidden = true
        navigationItem.title = "My Albums"
        navigationItem.largeTitleDisplayMode = .automatic

        self.prepareCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkAutorizationStatus()

//    self.shutterBtn.sendSubviewToBack(collectionView)
//        collectionView.backgroundColor = .clear

    }
    
//     override func viewWillAppear(_ animated: Bool) {
//          super.viewWillAppear(animated)
//
//          guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return
//          }
//
//          let managedContext = appDelegate.persistentContainer.viewContext
//          let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Album")
//          let sortAlbum = NSSortDescriptor(key: "title", ascending: true)
//          fetchRequest.sortDescriptors = [sortAlbum]
//          fetchRequest.returnsObjectsAsFaults = false
//
//          do {
//            albumItem = try managedContext.fetch(fetchRequest) as! [Album]
//            collectionView.reloadData()
//    //        collectionView.setContentOffset(CGPoint.zero, animated: true)
//          } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//          }
//            collectionView.reloadData()
//        }
    
    // MARK: - Private methods
    
    private func checkAutorizationStatus() {
        PHPhotoLibrary.checkAuthorizationStatus {
            if $0 {
                self.fetchAlbums()
            } else {
//                self.showAlertWith(message: AlertMessage(title: "Error", body: "Please authorize gallery access."))
                print("error! Couldn't fetch albums")
            }
        }
    }
    
    private func fetchAlbums() {
        self.albums.removeAll()
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", "Camera Roll")
//        let fetchOptions = PHFetchOptions()
//        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: true)]
        let result = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .smartAlbumRecentlyAdded, options: nil)
//        PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: ["CCS3", "CCS13"], options: nil)

        result.enumerateObjects({ (collection, _, _) in
            if (collection.hasAssets()) {
                self.albums.append(collection)
                self.collectionView.reloadData()
            }
        })
    }
    
    private func prepareCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
//        self.collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: albumCellId)

        self.collectionView.register(UINib.init(nibName: "AlbumCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AlbumCollectionViewCell")
    }
    
}

// MARK: - Exteinsions
// MARK: - UICollectionViewDataSource

extension AlbumsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
//        return albumItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: albumCellId, for: indexPath) as! AlbumCell

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCollectionViewCell", for: indexPath) as? AlbumCollectionViewCell
        cell?.setAlbum(albums[indexPath.row])
//        cell.data = albumItem[indexPath.item]
//        cell.addPhotoBtn.isHidden = true
        return cell!
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension AlbumsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 20, bottom: 20, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (Int(UIScreen.main.bounds.size.width) - (numbeOfItemsInRow - 1) * 10 - 40) / numbeOfItemsInRow
        return CGSize(width:width, height: width + 46)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photosViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotosViewController") as! PhotosViewController
//        albums.removeAll()
//        albums.append(albumItem)
        let album = albums[indexPath.item]
        print(indexPath.item)
//        let album = albumItem[indexPath.item]
        photosViewController.title = album.localizedTitle
        photosViewController.selectedCollection = album
        self.navigationController?.pushViewController(photosViewController, animated: true)
//        self.present(photosViewController, animated: true, completion: nil)
    }
}
