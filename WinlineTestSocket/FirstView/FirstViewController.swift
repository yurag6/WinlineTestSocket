//
//  FirstViewController.swift
//  WinlineTestSocket
//
//  Created by Garri Avakyan on 01.04.2022.
//  Copyright © 2022 StLiga. All rights reserved.
//

//import Foundation
import UIKit
//import EasyPeasy

class FirstViewController: UIViewController {
 
    var presenter: FirstViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
    }
    
}

//extension
extension FirstViewController: FirstViewProtocol {
    func displayData() {
//        self.data = data
        DispatchQueue.main.async {
//            self.collectionView.reloadData()
        }
    }
    
    func endRefreshing() {
        DispatchQueue.main.async {
//            self.refreshControl.endRefreshing()
        }
    }
}
