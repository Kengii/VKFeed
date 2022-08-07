//
//  GallaryCollectionView.swift
//  VKFeed
//
//  Created by Владимир Данилович on 27.07.22.
//

import Foundation
import UIKit

class GalleryCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {

    var photos = [FeedCellPhotoAttachementViewModel]()

    init() {
        let rowLayout = RowLayout()
        super.init(frame: .zero, collectionViewLayout: rowLayout)

        delegate = self
        dataSource = self

        backgroundColor = UIColor.white

        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false

        register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseId)

        if let rowLayout = collectionViewLayout as? RowLayout {
            rowLayout.delegate = self
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(photos: [FeedCellPhotoAttachementViewModel]) {
        self.photos = photos
        contentOffset = CGPoint.zero
        reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseId, for: indexPath) as! GalleryCollectionViewCell

        cell.set(imageURL: photos[indexPath.row].photoURLString)

        return cell
    }
}

extension GalleryCollectionView: RowLayoutDelegate {

    func colletctionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = photos[indexPath.row].width
        let height = photos[indexPath.row].height
        return CGSize(width: width, height: height)
    }
}
