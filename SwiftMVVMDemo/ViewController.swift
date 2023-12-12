//
//  ViewController.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 05/12/2023.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    weak var coordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showPostsVCTapped(_ sender: Any) {
        coordinator?.showPostsUIKit()
    }
    
    @IBAction func showPostsViewTapped(_ sender: Any) {
        coordinator?.showPostsSwiftUIView()
    }
    
    @IBAction func photoUIKitTapped(_ sender: Any) {
        coordinator?.showPhotosViewController()
    }
    
    @IBAction func photosSwiftUIAsyncImageTapped(_ sender: Any) {
        coordinator?.showPhotosAsyncImageView()
    }
    
    @IBAction func photosSwiftUIImageLoadingTapped(_ sender: Any) {
        coordinator?.showPhotosImageLoadingView()
    }
}

