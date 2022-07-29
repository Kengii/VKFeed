//
//  NewsFeedModels.swift
//  VKFeed
//
//  Created by Владимир Данилович on 19.07.22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum NewsFeed {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getNewsFeed
          case revealPostIds(postId: Int)
      }
    }
    struct Response {
      enum ResponseType {
          case presentNewsFeed(feed: FeedResponse, revealPostIds: [Int])
      }
    }
    struct ViewModel {
      enum ViewModelData {
          case displayNewsFeed(feedViewModel: FeedViewModel)
      }
    }
  }
  
}

struct FeedViewModel {
    struct Cell: FeedCellViewModel {
        var postId: Int
        var iconUrlString: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
        var photoAttachements: [FeedCellPhotoAttachementViewModel]
        var sizes: FeedCellSizes
    }
    
    struct FeeCellPhotoAttechment: FeedCellPhotoAttachementViewModel {
        var photoURLString: String?
        var width: Int
        var height: Int
    }
    let cells: [Cell]
}
