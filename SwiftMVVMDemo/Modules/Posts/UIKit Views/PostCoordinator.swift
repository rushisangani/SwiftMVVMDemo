//
//  PostCoordinator.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 12/12/2023.
//

import Foundation
import UIKit
import SwiftUI

class PostCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = PostListViewController(viewModel: PostListViewModel())
        viewController.coordinator = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
