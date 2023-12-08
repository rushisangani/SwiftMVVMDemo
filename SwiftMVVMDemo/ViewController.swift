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
        let hostViewController = UIHostingController(rootView: PostListView())
        self.navigationController?.pushViewController(hostViewController, animated: true)
    }
    
    @IBAction func photoUIKitTapped(_ sender: Any) {
        let viewModel = PhotosViewModel()
        let viewController = PhotosViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func photosSwiftUIAsyncImageTapped(_ sender: Any) {
        let hostViewController = UIHostingController(rootView: PhotosAsyncImageView())
        self.navigationController?.pushViewController(hostViewController, animated: true)
    }
    
    @IBAction func photosSwiftUIImageLoadingTapped(_ sender: Any) {
        let hostViewController = UIHostingController(rootView: PhotosCustomView())
        self.navigationController?.pushViewController(hostViewController, animated: true)
    }
}

