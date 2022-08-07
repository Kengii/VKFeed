//
//  NewsFeedCell.swift
//  VKFeed
//
//  Created by Владимир Данилович on 19.07.22.
//

import Foundation
import UIKit

protocol NewsFeedCellDelegate: AnyObject {
    func revealPost(for cell: NewsFeedCell)
}

protocol FeedCellViewModel {
    
    var iconUrlString: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
    var photoAttachements: [FeedCellPhotoAttachementViewModel] { get }
    var sizes: FeedCellSizes { get }
}

protocol FeedCellSizes {
    var postLableFrame: CGRect { get }
    var attachmentFrame: CGRect { get }
    var bottomView: CGRect { get }
    var totalHeight: CGFloat { get }
    var moreTextButtonFrame: CGRect { get }
}

protocol FeedCellPhotoAttachementViewModel {
    var photoURLString: String? { get }
    var width: Int { get }
    var height: Int { get }
}

class NewsFeedCell: UITableViewCell {
    
    weak var delegate: NewsFeedCellDelegate?
     
    static let reuseId = "NewsFeedCell"
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var iconImageView: WedImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var postImagView: WedImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var postLabel: UITextView!
    
    let moreTextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("Показать полностью...", for: .normal)
        return button
    }()
    
    let galleryCollectionView = GalleryCollectionView()
    
    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
        postImagView.set(imageURL: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.clipsToBounds = true
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        cardView.addSubview(moreTextButton)
        cardView.addSubview(galleryCollectionView)
        
        // moreTextButton constraints
        
        backgroundColor = .clear
        selectionStyle = .none
        
        moreTextButton.addTarget(self, action: #selector(moreTextButtonTouch), for: .touchUpInside)
        setupTextView()
    }
    
    @objc func moreTextButtonTouch() {
        delegate?.revealPost(for: self)
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
        postLabel.frame = viewModel.sizes.postLableFrame
        
        bottomView.frame = viewModel.sizes.bottomView
        moreTextButton.frame = viewModel.sizes.moreTextButtonFrame
        
        if let photoAttachment = viewModel.photoAttachements.first, viewModel.photoAttachements.count == 1 {
            postImagView.isHidden = false
            galleryCollectionView.isHidden = true
            postImagView.set(imageURL: photoAttachment.photoURLString)
            postImagView.frame = viewModel.sizes.attachmentFrame
        } else if viewModel.photoAttachements.count > 1 {
            postImagView.isHidden = true
            galleryCollectionView.isHidden = false
            galleryCollectionView.frame = viewModel.sizes.attachmentFrame
            galleryCollectionView.set(photos: viewModel.photoAttachements)
        }
        else {
            postImagView.isHidden = true
            galleryCollectionView.isHidden = true
        }
    }
    
    func setupTextView() {
        postLabel.font = Constants.postLabelFont
        postLabel.isScrollEnabled = false
        postLabel.isSelectable = true
        postLabel.isUserInteractionEnabled = true
        postLabel.isEditable = false
        let padding = postLabel.textContainer.lineFragmentPadding
        postLabel.textContainerInset = UIEdgeInsets.init(top: 0, left: -padding, bottom: 0, right: -padding)
        
        postLabel.dataDetectorTypes = UIDataDetectorTypes.all
    }
}
