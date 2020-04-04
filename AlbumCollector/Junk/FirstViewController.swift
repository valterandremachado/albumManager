//
//  FirstViewController.swift
//  CustomTabShapeTest
//
//  Created by Philipp Weiß on 16.11.18.
//  Copyright © 2018 pmw. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    fileprivate var lb: UILabel = {
            var lb = UILabel()
            lb.translatesAutoresizingMaskIntoConstraints = false
            lb.sizeToFit()
            lb.lineBreakMode = .byWordWrapping
    //        lb.numberOfLines = 0
            lb.textAlignment = .center
            lb.text = "No custom album found"
            lb.font = .boldSystemFont(ofSize: 18)
            return lb
        }()
    
//    @IBOutlet weak var cameraBtnTabOne: UIButton!
    

    
	override func viewDidLoad() {
		super.viewDidLoad()
//        cameraBtnTabOne.isHidden = true

//        view.backgroundColor = .white
        setupViews()
	}
    func setupViews(){
        [lb].forEach({view.addSubview($0)})
        navigationItem.title = "My Albums"
        navigationItem.largeTitleDisplayMode = .always
        lb.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
//        navBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
    }
}
