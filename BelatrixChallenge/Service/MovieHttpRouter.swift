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
    case getMovies(categoryId: String)

    case getFilteredMovies

    case downloadImage(imageName:String)
    case downloadThumbnail(imageName:String)
}

extension MovieHttpRouter : HttpRouter {
    
    var baseUrlString: String {
        return "https://api.trakt.tv/"
    }
    
    var path: String {
        switch (self) {
        case .getFilteredMovies:
            return ""
        case .getPopularMovies:
            return "movies/popular"
        case .getMovies(let categoryId):
            return "/asd/{\(categoryId)}"
        case .downloadImage(let imageName):
            return "/asd/{\(imageName)}"
        case .downloadThumbnail(let imageName):
            return "/asd/{\(imageName)}"
        }

    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders? {
        return [
            "Content-Type" : "application/json",
            "trakt-api-version" : "2",
            "trakt-api-key" : "e674d0e14d4c2c5557db80b92120511bdac61bb3bebf228adfb258a7c861d71d"
        ]
    }
    
    var parameters: Parameters? {
        switch self {
        case .getPopularMovies(let page):
            return ["page" : "\(page)"]
        default:
            return nil
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .getFilteredMovies, .getPopularMovies, .getMovies, .downloadThumbnail, .downloadImage:
            return nil
        }
    }
    
    
}
