//
//  MovieModel.swift
//  BelatrixChallenge
//
//  Created by Fer on 20/10/2019.
//  Copyright © 2019 Fer. All rights reserved.
//

struct MovieModel : Codable {
    let title : String?
    let year : Int?
    let ids : MovieDetail?
    let overview : String?
    var imageUrl : String?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case year
        case ids
        case overview
        case imageUrl
    }
}

struct MovieDetail : Codable {
    let trakt : Int?
    let slug : String?
    let imdb : String?
    let tmdb : Int?
    
    private enum CodingKeys : String, CodingKey {
        case trakt
        case slug
        case imdb
        case tmdb
    }
}
