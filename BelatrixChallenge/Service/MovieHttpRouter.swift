//
//  MovieHttpRouter.swift
//  BelatrixChallenge
//
//  Created by Fer on 20/10/2019.
//  Copyright © 2019 Fer. All rights reserved.
//

import Alamofire

enum MovieHttpRouter {
    case getMoviesCategories
    case getMovies(categoryId: String)

    case getFilteredMovies

    case downloadImage(imageName:String)
    case downloadThumbnail(imageName:String)
}

extension MovieHttpRouter : HttpRouter {
    
    var baseUrlString: String {
        return "https://asdasd"
    }
    
    var path: String {
        switch (self) {
        case .getFilteredMovies:
            return "/asd"
        case .getMoviesCategories:
            return "/asd"
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
            "Content-Type" : "application/json; charset=UTF-8"
        ]
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    func body() throws -> Data? {
        switch self {
        case .getFilteredMovies, .getMoviesCategories, .getMovies, .downloadThumbnail, .downloadImage:
            return nil
        }
    }
    
    
}
