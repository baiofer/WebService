//
//  Product.swift
//  FastApp
//
//  Created by Fernando Jarilla on 3/3/18.
//  Copyright © 2018 Henry Bravo. All rights reserved.
//

import Foundation

struct Product: Decodable {
    let identifier: Int64
    let date: String
    let link: String
    let title: Title
    let content: Content
    let _links: Link
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case date
        case link
        case title
        case content
        case _links
    }
}

struct Title: Decodable {
    let rendered: String
    
    private enum CodingKeys: String, CodingKey {
        case rendered
    }
}

struct Content: Decodable {
    let rendered: String
    let protected: Bool
    
    private enum CodingKeys: String, CodingKey {
        case rendered
        case protected
    }
}

struct Link: Decodable {
    let selfLink: [Href]
    let collection: [Href]
    let about: [Href]
    let replies: [Href]
    
    private enum CodingKeys: String, CodingKey {
        case selfLink = "self"
        case collection
        case about
        case replies
    }
}

struct Href: Decodable {
    let href: String
    let embedable: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case href
        case embedable
    }
}









