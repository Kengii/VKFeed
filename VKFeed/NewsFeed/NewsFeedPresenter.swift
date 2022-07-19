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

    func presentData(response: NewsFeed.Model.Response.ResponseType) {

        switch response {

        case .presentNewsFeed(feed: let feed):
            
            let cells = feed.items.map { feedItem in
                cellViewModel(from: feedItem)
            }
            let feedViewModel = FeedViewModel.init(cells: cells)
            viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
        }
    }

    private func cellViewModel(from feedItem: FeedItem) -> FeedViewModel.Cell {
        return FeedViewModel.Cell.init(iconUrlString: "",
                                       name: "future name", date: "future date",
                                       text: feedItem.text ?? "",
                                       likes: String(feedItem.likes?.count ?? 0),
                                       comments: String(feedItem.comments?.count ?? 0),
                                       shares: String(feedItem.reposts?.count ?? 0),
                                       views: String(feedItem.views?.count ?? 0))

}
}
