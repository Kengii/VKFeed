//
//  NewsFeedInteractor.swift
//  VKFeed
//
//  Created by Владимир Данилович on 19.07.22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
    func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {

    var presenter: NewsFeedPresentationLogic?
    var service: NewsFeedService?

    private var revealPostIds = [Int]()
    private var feedResponse: FeedResponse?
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())

    func makeRequest(request: NewsFeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsFeedService()
        }

        switch request {

        case .getNewsFeed:
            fetcher.getFeed { [weak self] feedResponse in
                self?.feedResponse = feedResponse
                self?.presentFeed()
            }
            
        case .revealPostIds(postId: let postId):
            revealPostIds.append(postId)
            presentFeed()
        }
    }
    
    private func presentFeed() {
        guard let feedResponse = feedResponse else {  return }
        presenter?.presentData(response: .presentNewsFeed(feed: feedResponse, revealPostIds: revealPostIds))
    }

}
