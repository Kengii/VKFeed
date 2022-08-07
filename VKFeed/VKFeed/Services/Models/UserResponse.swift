//
//  UserResponse.swift
//  VKFeed
//
//  Created by Владимир Данилович on 30.07.22.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
