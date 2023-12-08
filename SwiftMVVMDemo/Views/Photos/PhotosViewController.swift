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

// MARK: - UITableViewDataSource

extension PhotosViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as! PhotoTableViewCell
        
        //let photo = viewModel.photo(atIndexPath: indexPath)
        cell.photoImageView.image = UIImage(named: "sample")
        return cell
    }
}

// MARK: - UITableViewDelegate

extension PhotosViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - UISetup

extension PhotosViewController {
    
    func setupViews() {
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperViewEdges()
        navigationItem.title = "Photos Prefetching"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
    }
}
