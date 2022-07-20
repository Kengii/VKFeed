//
//  NewsFeedCell.swift
//  VKFeed
//
//  Created by Владимир Данилович on 19.07.22.
//

import Foundation
import UIKit

protocol FeedCellViewModel {
    
    var iconUrlString: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
    var photoAttachement: FeedCellPhotoAttachementViewModel? { get }
}

protocol FeedCellPhotoAttachementViewModel {
    var photoURLString: String? { get }
    var width: Int { get }
    var height: Int { get }
}

class NewsFeedCell: UITableViewCell {
     
    static let reuseId = "NewsFeedCell"
    @IBOutlet weak var iconImageView: WedImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var postImagView: WedImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.clipsToBounds = true
    }
    
    func set(viewModel: FeedCellViewModel) {
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        iconImageView.set(imageURL: viewModel.iconUrlString)
        
        if let photoAttachement = viewModel.photoAttachement {
            postImagView.set(imageURL: photoAttachement.photoURLString)
            postImagView.isHidden = false
        } else {
            postImagView.isHidden = true
        }
    }
}
