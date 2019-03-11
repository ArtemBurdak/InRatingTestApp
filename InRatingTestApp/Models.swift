//
//  Parse.swift
//  InRatingTestApp
//
//  Created by Artem on 3/6/19.
//  Copyright © 2019 Artem. All rights reserved.
//

import Foundation

struct Post: Codable {
    let id: Int
    let bookmarks_count: Int
    let views_count: Int
    let likes_count: Int
    let reposts_count: Int
    let comments_count: Int
}

struct Person: Codable {
    let id: Int
    let nickname: String
    let avatar_image: AvatarImage
}

struct AvatarImage: Codable {
    let url_small: String
}

struct StatisticData: Codable {
    let data: [Person]
}

struct StatisticTVCell {
    let title: String
    let postUrl: String?
    let postId: Int?

    var personsArray: [Person]

    var manualyCount: Bool = false
}

struct MensionsMeta: Codable {
    var meta: MensionsCount
}

struct MensionsCount: Codable {
    let total: Int
}

