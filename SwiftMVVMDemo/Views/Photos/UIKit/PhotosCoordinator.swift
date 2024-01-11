//
//  PhotosCoordinator.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 12/12/2023.
//

import UIKit

class PhotosCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = PhotosViewController(viewModel: PhotosViewModel())
        viewController.coordinator = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
