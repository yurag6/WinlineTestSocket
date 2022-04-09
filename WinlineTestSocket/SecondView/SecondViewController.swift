//
//  SecondViewController.swift
//  WinlineTestSocket
//
//  Created by Garri Avakyan on 01.04.2022.
//  Copyright © 2022 StLiga. All rights reserved.
//

//import Foundation
import UIKit
//import EasyPeasy

class SecondViewController: UIViewController {
    
    var presenter: SecondViewPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
    }
    
    
}

extension SecondViewController: SecondViewProtocol {
    func displayData() {
        
//        guard ((data.data) != nil) else {return}
//        guard(data.data?.count == 1) else {return}
//        guard((data.data?.results) != nil) else {return}
//        guard(data.data?.results?[0].description != nil) else {return}
        
        DispatchQueue.main.async {
//            var description = data.data?.results?[0].description
//            description = description == "" ? "No description" : description
//            self.descriptionHero.text = description // data.data?.results?[0].description ?? "No description"
        }
    }
    
    func endRefreshing() {
        DispatchQueue.main.async {
       //  self.refreshControl.endRefreshing()
        }
    }
}
