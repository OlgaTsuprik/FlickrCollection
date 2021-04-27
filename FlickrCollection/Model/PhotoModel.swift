//
//  PhotoModel.swift
//  FlickrCollection
//
//  Created by Оля on 22.04.2021.
//

import Foundation

//MARK: - Welcome
struct Welcome: Codable {
    let photos: Photos
    let extra: Extra
    let stat: String
    
    enum CodingKeys: String, CodingKey {
        case photos, extra, stat
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        photos = try container.decode(Photos.self, forKey: .photos)
        extra = try container.decode(Extra.self, forKey: .extra)
        stat = try container.decode(String.self, forKey: .stat)
    }
}

// MARK: - Extra
struct Extra: Codable {
    let exploreDate: String
    let nextPreludeInterval: Int
    
    enum CodingKeys: String, CodingKey {
        case exploreDate = "explore_date"
        case nextPreludeInterval = "next_prelude_interval"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        exploreDate = try container.decode(String.self, forKey: .exploreDate)
        nextPreludeInterval = try container.decode(Int.self, forKey: .nextPreludeInterval)
    }
}

// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage, total: Int
    let photo: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case page, pages, perpage, total, photo
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        pages = try container.decode(Int.self, forKey: .pages)
        perpage = try container.decode(Int.self, forKey: .perpage)
        total =  try container.decode(Int.self, forKey: .total)
        photo = try container.decode([Photo].self, forKey: .photo)
    }
}

// MARK: - Photo
struct Photo: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
    let urlQ: String
    let heightQ, widthQ: Int
    let urlZ: String
    let heightZ, widthZ: Int
    
    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title, ispublic, isfriend, isfamily
        case urlQ = "url_q"
        case heightQ = "height_q"
        case widthQ = "width_q"
        case urlZ = "url_z"
        case heightZ = "height_z"
        case widthZ = "width_z"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        owner = try container.decode(String.self, forKey: .owner)
        secret = try container.decode(String.self, forKey: .secret)
        server = try container.decode(String.self, forKey: .server)
        farm = try container.decode(Int.self, forKey: .farm)
        title = try container.decode(String.self, forKey: .title)
        ispublic = try container.decode(Int.self, forKey: .ispublic)
        isfriend = try container.decode(Int.self, forKey: .isfriend)
        isfamily = try container.decode(Int.self, forKey: .isfamily)
        urlQ = try container.decode(String.self, forKey: .urlQ)
        heightQ = try container.decode(Int.self, forKey: .heightQ)
        widthQ = try container.decode(Int.self, forKey: .widthQ)
        urlZ = try container.decode(String.self, forKey: .urlZ)
        heightZ = try container.decode(Int.self, forKey: .heightZ)
        widthZ = try container.decode(Int.self, forKey: .widthZ)
    }
}
