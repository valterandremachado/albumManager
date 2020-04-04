//
//  MyNavigationController.swift
//  CustomTabShapeTest
//
//  Created by Philipp Weiß on 16.11.18.
//  Copyright © 2018 pmw. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate  {

    lazy var doneBtn: UIButton = {
            let btn = UIButton()
            btn.setImage(UIImage(named: "done"), for: UIControl.State())
    //        btn.setTitle("Done", for: UIControl.State())
            btn.translatesAutoresizingMaskIntoConstraints = false
    //        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    //        btn.backgroundColor = .darkGray

            return btn
        }()
	override func viewDidLoad() {
		super.viewDidLoad()
        tabBar.barTintColor = .red
        doneBtn.anchor(top: nil, leading: tabBar.leadingAnchor, bottom: tabBar.bottomAnchor, trailing: tabBar.trailingAnchor, padding: UIEdgeInsets.init(top: 0, left: 152, bottom: 14, right: 152))
        self.delegate = self
	}
    // UITabBarDelegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        let itemNo = tabBar.selectedItem
        tabBar.tintColor = .red
        print("Selected item")
        tabBar.isUserInteractionEnabled = true
    }

    // UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let viewNo = tabBarController.selectedIndex
        tabBarController.tabBar.tintColor = .red
        print("Selected view controller: \(viewNo)")
    }
}
