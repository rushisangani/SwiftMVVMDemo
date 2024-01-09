//
//  PhotoTableViewCell.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 08/12/2023.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    static let identifier = "PhotoTableViewCellId"
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .none
        setupViewComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension PhotoTableViewCell {
    
    func setupViewComponents() {
        contentView.addSubview(photoImageView)
        photoImageView.autoPinEdgesToSuperViewEdges()
        
        let heightConstraint = photoImageView.heightAnchor.constraint(equalToConstant: 200)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
    }
}
