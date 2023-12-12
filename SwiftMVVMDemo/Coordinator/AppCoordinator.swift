//
//  AppCoordinator.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 12/12/2023.
//

import Foundation
import UIKit
import SwiftUI

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
    //func finish()
}

class AppCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = mainStoryboard.createViewController(ViewController.self)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showPostsUIKit() {
        let child = PostCoordinator(navigationController: navigationController)
        child.start()
    }
    
    func showPhotosViewController() {
        let child = PhotosCoordinator(navigationController: navigationController)
        child.start()
    }
    
    func showPostsSwiftUIView() {
        let hostController = UIHostingController(rootView: PostListView())
        self.navigationController.pushViewController(hostController, animated: true)
    }
    
    func showPhotosAsyncImageView() {
        let hostController = UIHostingController(rootView: PhotosAsyncImageView())
        self.navigationController.pushViewController(hostController, animated: true)
    }
    
    func showPhotosImageLoadingView() {
        let hostController = UIHostingController(rootView: PhotosCustomView())
        self.navigationController.pushViewController(hostController, animated: true)
    }
}
