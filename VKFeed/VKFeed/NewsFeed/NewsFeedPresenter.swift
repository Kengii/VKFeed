//
//  NewsFeedPresenter.swift
//  VKFeed
//
//  Created by Владимир Данилович on 19.07.22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
    func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
    
    weak var viewController: NewsFeedDisplayLogic?
    
    var cellLayoutCalculator: FeedCellLayoutCaculatorProtocol = FeedCellLayoutCaculator()
    
    
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()

    func presentData(response: NewsFeed.Model.Response.ResponseType) {

        switch response {

        case .presentNewsFeed(feed: let feed, let revealPostIds):
            
            let cells = feed.items.map { feedItem in
                cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups, revealPostIds: revealPostIds)
            }
            let feedViewModel = FeedViewModel.init(cells: cells)
            viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
        }
    }

    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group], revealPostIds: [Int]) -> FeedViewModel.Cell {
        
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        
        let photoAttechments = self.photoAttechments(feedItem: feedItem)
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        let isFullSized = revealPostIds.contains { (postId) -> Bool in
            return postId == feedItem.postId
        }
        
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachments: photoAttechments, isFullSizedPost: isFullSized)
        
        return FeedViewModel.Cell.init(postId: feedItem.postId, iconUrlString: profile.photo,
                                       name: profile.name,
                                       date: dateTitle,
                                       text: feedItem.text ?? "",
                                       likes: String(feedItem.likes?.count ?? 0),
                                       comments: String(feedItem.comments?.count ?? 0),
                                       shares: String(feedItem.reposts?.count ?? 0),
                                       views: String(feedItem.views?.count ?? 0),
                                       photoAttachements: photoAttechments,
                                       sizes: sizes)

    }
    
    private func profile( for sourceId: Int, profiles: [Profile], groups: [Group]) -> ProFileRepresentable {
        let profilesOrGroups: [ProFileRepresentable] = sourceId >= 0 ? profiles : groups
        let normalSourceId = sourceId >= 0 ? sourceId : -sourceId
        let profileRepresentable = profilesOrGroups.first { myProfileRepresentable -> Bool in
            myProfileRepresentable.id == normalSourceId
        }
        return profileRepresentable!
    }
    
    private func photoAttechment(feedItem: FeedItem) -> FeedViewModel.FeeCellPhotoAttechment? {
        guard let photos = feedItem.attachments?.compactMap({ attechment in
            attechment.photo
        }), let firstPhoto = photos.first else { return nil}
        return FeedViewModel.FeeCellPhotoAttechment.init(photoURLString:
                                                            firstPhoto.srcBIG,
                                                         width: firstPhoto.width,
                                                         height: firstPhoto.height)
    }
    
    private func photoAttechments(feedItem: FeedItem) -> [FeedViewModel.FeeCellPhotoAttechment] {
        guard let attachments = feedItem.attachments else { return [] }
        
        return attachments.compactMap { attachement -> FeedViewModel.FeeCellPhotoAttechment? in
            guard let photo = attachement.photo else { return nil }
            return FeedViewModel.FeeCellPhotoAttechment.init(photoURLString: photo.srcBIG, width: photo.width, height: photo.height)
        }
    }
}
