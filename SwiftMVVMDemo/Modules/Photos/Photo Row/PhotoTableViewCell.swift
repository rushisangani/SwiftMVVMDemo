//
//  PhotoTableViewCell.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 08/12/2023.
//

import UIKit
import Combine

class PhotoTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var viewModel: PhotoRowViewModelHandler = PhotoRowViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    
    static let identifier = "PhotoTableViewCellId"
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .none
        setupViewComponents()
        addObserver()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    func showPhoto(forUrl url: String) {
        viewModel.getImage(url: url)
    }
}

extension PhotoTableViewCell {
    
    func setupViewComponents() {
        contentView.addSubview(photoImageView)
        photoImageView.autoPinEdgesToSuperViewEdges()
        
        let heightConstraint = photoImageView.heightAnchor.constraint(equalToConstant: 300)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
    }
    
    func addObserver() {
        viewModel
            .imagePublisher
            .sink { [weak self] image in
                guard let self = self else { return }
                self.photoImageView.image = image
            }
            .store(in: &cancellables)
    }
}
