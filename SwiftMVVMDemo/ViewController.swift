//
//  ViewController.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 05/12/2023.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showPostsVCTapped(_ sender: Any) {
        let viewModel = PostListViewModel()
        let viewController = PostListViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func showPostsViewTapped(_ sender: Any) {
        let viewModel = PostListViewModel()
        let hostViewController = UIHostingController(rootView: PostListView(viewModel: viewModel))
        self.navigationController?.pushViewController(hostViewController, animated: true)
    }
}

