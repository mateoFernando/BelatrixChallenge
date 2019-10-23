//
//  MovieHttpRouter.swift
//  BelatrixChallenge
//
//  Created by Fer on 20/10/2019.
//  Copyright © 2019 Fer. All rights reserved.
//

import Alamofire

enum MovieHttpRouter {
    case getPopularMovies(page:Int)
    case searchMovies(query: String, page: Int)
    case findDataImage(imageId: Int)
    
    case downloadThumbnail(imageURL:String)
}

extension MovieHttpRouter : HttpRouter {
    
    var baseUrlString: String {
        switch self {
        case .findDataImage:
            return "http://webservice.fanart.tv/v3/movies/"
        case .downloadThumbnail(let imageURL):
            return imageURL
        default:
            return "https://api.trakt.tv/"
        }
    }
    
    var path: String {
        switch (self) {
        case .getPopularMovies:
            return "movies/popular"
        case .searchMovies:
            return "search/movie"
        case .findDataImage(let imageId):
            return "\(imageId)"
        case .downloadThumbnail:
            return ""
        }

    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .findDataImage:
            return [
                "Content-Type" : "application/json; charset=utf-8"
            ]
        default:
            return [
                "Content-Type" : "application/json",
                "trakt-api-version" : "2",
                "trakt-api-key" : "e674d0e14d4c2c5557db80b92120511bdac61bb3bebf228adfb258a7c861d71d"
            ]
        }
        
        
    }
    
    var parameters: Parameters? {
        switch self {
        case .getPopularMovies(let page):
            return ["page" : "\(page)",
                "extended" : "full"]
        case .searchMovies(let query, let page):
            return ["query" : "\(query)",
            "page" : "\(page)",
            "extended" : "full"]
        case .findDataImage:
            return ["api_key":"2da1b719eba388bea4b0a66fff51a429"]
        default:
            return nil
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .getPopularMovies, .searchMovies, .downloadThumbnail, .findDataImage:
            return nil
        }
    }
    
    
}
