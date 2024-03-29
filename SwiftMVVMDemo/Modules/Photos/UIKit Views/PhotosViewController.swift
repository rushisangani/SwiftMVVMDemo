//
//  PhotosViewController.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 08/12/2023.
//

import UIKit
import Combine

class PhotosViewController: UIViewController {
    
    private(set) var viewModel: PhotosViewModel
    
    init(viewModel: PhotosViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    weak var coordinator: PhotosCoordinator?
    private(set) var tableView = UITableView(frame: .zero, style: .plain)
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Life cycle
    
    override func loadView() {
        super.loadView()
        
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupObservers()
        getPhotos()
    }
    
    func getPhotos() {
        Task {
            try await viewModel.getPhotos()
        }
    }
}

// MARK: - Observables

extension PhotosViewController {
    
    func setupObservers() {
        viewModel.$photos
            .receive(on: RunLoop.main)
            .sink { [weak self] posts in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension PhotosViewController {
    
    func showImage(_ image: UIImage, atIndexPath indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

// MARK: - UITableViewDataSource

extension PhotosViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as! PhotoTableViewCell
        cell.showPhoto(forUrl: viewModel.photoUrl(at: indexPath))
        return cell
    }
}

//// MARK: - UITableViewDataSourcePrefetching
//
//extension PhotosViewController: UITableViewDataSourcePrefetching {
//    
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        // Perform image downloading for the indexPaths, only if not available in cache
//        for indexPath in indexPaths {
////            if viewModel.image(atIndexPath: indexPath) == nil {
////                viewModel.downloadImage(atIndexPath: indexPath)
////            }
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
//        // TODO: how to cancel prefetch?
//    }
//}

// MARK: - UISetup

extension PhotosViewController {
    
    func setupViews() {
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperViewEdges()
        navigationItem.title = "Photos Prefetching"
        
        tableView.dataSource = self
        //tableView.prefetchDataSource = self
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
    }
}
