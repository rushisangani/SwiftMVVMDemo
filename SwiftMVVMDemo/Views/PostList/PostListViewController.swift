//
//  PostListViewController.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 05/12/2023.
//

import UIKit

class PostListViewController: UIViewController {
    private(set) var viewModel: PostListViewModelHandler
    
    init(viewModel: PostListViewModelHandler) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    private(set) var tableView = UITableView(frame: .zero, style: .plain)
    private(set) var cellIdentifier = "PostListTableViewCell"
    
    // MARK: - Life cycle
    
    override func loadView() {
        super.loadView()
        
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadPosts()
    }
    
    func loadPosts() {
        Task {
            do {
                try await viewModel.loadPosts()
                self.tableView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
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
        cell.accessoryType = .disclosureIndicator
        
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
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
    }
}
