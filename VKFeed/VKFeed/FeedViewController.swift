//
//  FeedViewController.swift
//  VKFeed
//
//  Created by Владимир Данилович on 16.07.22.
//

import UIKit

class FeedViewController: UIViewController {

    private var fetcher: DataFetcher = NetwirkDataFetcher(networking: NetworkService())

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        fetcher.getFeed { feedResponse in
            guard let feedResponse = feedResponse else { return }
            feedResponse.items.map { feedItem in
                print(feedItem.date)
            }
        }
    }
}
