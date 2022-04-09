//
//  ViewController.swift
//  WinlineTestSocket
//
//  Created by Garri Avakyan on 01.04.2022.
//

import UIKit

class ViewController: UITabBarController, UITabBarControllerDelegate {

    private let tabControlNames = ["Главная","LIVE"]
    private let tabControlIcons = [("1a.png","1b.png"), ("2a.png","2b.png")]
    
    var images: [(selected: UIImage, normal: UIImage)] = []

    var presenter: ViewPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .black //UIColor(red: 100, green: 100, blue: 50, alpha: 0.5)
        self.delegate = self
        loadAndResizeImageForTabBar()
        createTabBarController()
        
        presenter = ViewPresenter()
        presenter.serverUp()
    }

    func loadAndResizeImageForTabBar(){
        var defaultImage  : UIImage?
        var selectedImage : UIImage?
        
        
        for (nameDefaultIcon, nameSelectedIcons) in tabControlIcons{
            print(nameDefaultIcon)
            print(nameSelectedIcons)
            print("------")
            
            // load and resize icons
            defaultImage  = UIImage(named: nameDefaultIcon)?.scaleImageToFitSize(size: CGSize(width: 20, height: 20))
            selectedImage = UIImage(named: nameSelectedIcons)?.scaleImageToFitSize(size: CGSize(width: 20, height: 20))
            
            guard let def = defaultImage, let sel = selectedImage else { return }
            images.append((def, sel))
        }
    }
    
    func createTabBarController() {
        var index = 0
        var viewControllers: [UIViewController] = []
        
        // 1-ое окно (Главная)
        let firstViewController            = FirstViewController()
        firstViewController.presenter      = FirstViewPresenter()
        firstViewController.presenter.view = firstViewController
        let firstNavController             = UINavigationController(rootViewController: firstViewController)

        // 2-ое окно (LIVE)
        let secondViewController            = SecondViewController()
        secondViewController.presenter      = SecondViewPresenter()
        secondViewController.presenter.view = secondViewController
        let secondNavController             = UINavigationController(rootViewController: secondViewController)
        
        // append to viewControllers
        viewControllers.append(firstNavController)
        viewControllers.append(secondNavController)
        
        for viewController in viewControllers{
            viewController.title      = tabControlNames[index]
            viewController.tabBarItem = UITabBarItem(title: tabControlNames[index], image: images[index].normal, selectedImage: images[index].selected)
            index += 1
        }
        
        self.viewControllers = viewControllers
        selectedViewController = self.viewControllers?.first
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let title = viewController.title else { return }
        print("Selected: \(title)")
     }

    override var selectedViewController: UIViewController? {
        didSet {
            guard let viewControllers = viewControllers else {
                return
            }

            for viewController in viewControllers {

                if viewController == selectedViewController {

                    let selected: [NSAttributedString.Key: AnyObject] =
                    [.font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.heavy)]
                                 
                    viewController.tabBarItem.setTitleTextAttributes(selected, for: .normal)

                } else {

                    let normal: [NSAttributedString.Key: AnyObject] =
                        [.font: UIFont.systemFont(ofSize: 10)]

                    viewController.tabBarItem.setTitleTextAttributes(normal, for: .normal)
                }
            }
        }
    }
}

