//
//  PostListViewController.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 05/12/2023.
//

import UIKit
import Combine

class PostListViewController: UIViewController {
    private(set) var viewModel: PostListViewModel
    
    init(viewModel: PostListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    private(set) var tableView = UITableView(frame: .zero, style: .plain)
    private var cellIdentifier = "PostListTableViewCell"
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Life cycle
    
    override func loadView() {
        super.loadView()
        
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupObservers()
        getPosts()
    }
    
    func getPosts() {
        Task {
            try await viewModel.loadPosts()
        }
    }
}

// MARK: - Observables

extension PostListViewController {
    
    func setupObservers() {
        viewModel.$posts
            .receive(on: RunLoop.main)
            .sink { [weak self] posts in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

// MARK: - UITableViewDataSource

extension PostListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeCell(withIdentifier: cellIdentifier, style: .subtitle)
        
        let post = viewModel.post(atIndexPath: indexPath)
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body
        cell.textLabel?.numberOfLines = 2
        cell.detailTextLabel?.numberOfLines = 0
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension PostListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - UISetup

extension PostListViewController {
    
    func setupViews() {
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperViewEdges()
        navigationItem.title = "UIKit Posts"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
    }
}
