//
//  String + Height.swift
//  VKFeed
//
//  Created by Владимир Данилович on 21.07.22.
//

import Foundation
import UIKit

extension String {
    func height(widht: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: widht, height: .greatestFiniteMagnitude)
        
        let size = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context: nil)
        return ceil(size.height)
    }
}
