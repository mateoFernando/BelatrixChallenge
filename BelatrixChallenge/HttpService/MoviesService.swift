//
//  MoviesService.swift
//  BelatrixChallenge
//
//  Created by Fer on 20/10/2019.
//  Copyright © 2019 Fer. All rights reserved.
//

import Alamofire

class MoviesService {
    private lazy var httpService = MovieHttpService()
    static let shared : MoviesService = MoviesService()
}

extension MoviesService : MoviesAPI {
    
    func searchMovies(query: String, page: Int, completion: @escaping MoviesClosure) {
        do {
            try MovieHttpRouter
                .searchMovies(query: query, page : page)
                .request(usingHttpService: httpService)
                .responseJSON { (result) in
                    let movies = MoviesService.parseSearchMovies(result: result)
                    completion(movies)
            }
        } catch  {
            print("Something went grong while fetching popular movies = \(error)")
        }
    }
    
    
    func fetchPopularMoviews(page: Int, completion: @escaping ([MovieModel]) -> (Void)) {
        do {
            try MovieHttpRouter
                .getPopularMovies(page: page)
                .request(usingHttpService: httpService)
                .responseJSON { (result) in
                    let movies = MoviesService.parseMovies(result: result)
                    completion(movies)
            }
        } catch  {
            print("Something went grong while fetching popular movies = \(error)")
        }
    }
    
    
    
}


extension MoviesService {
    
    private static func parseMovies(result: DataResponse<Any>) -> [MovieModel] {
        
        guard [200,201].contains(result.response?.statusCode), let data = result.data else { return [] }
        
        do {
            return try JSONDecoder().decode(Array<MovieModel>.self, from: data)
        } catch  {
            print("Something went grong parsing movies = \(error)")
        }
        return []
    }
    
    private static func parseSearchMovies(result: DataResponse<Any>) -> [MovieModel] {
        
        guard [200,201].contains(result.response?.statusCode), let data = result.data else { return [] }
        
        do {
            let anyResult: Any = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers])
            let array = anyResult as? [[String: Any]]
            var newArray = [[String:Any]]()
            for filteredMovie in array! {
                newArray.append(filteredMovie["movie"]! as! [String : Any])
            }
            let jsonData = try? JSONSerialization.data(withJSONObject:newArray)
            return try JSONDecoder().decode(Array<MovieModel>.self, from: jsonData!)
        } catch  {
            print("Something went grong parsing movies = \(error)")
        }
        return []
    }
}

extension MoviesService : ImagesAPI {

    func fetchThumbnail(imageName: String, completion: @escaping ImageClosure) {
        
        do {
            try MovieHttpRouter
                .downloadThumbnail(imageName: imageName)
                .request(usingHttpService: httpService)
                .responseData(completionHandler: { (result) in
                    completion(result.data)
                })
        } catch  {
            print("Something went grong while fetching image! = \(error)")
        }
    }
    
    func fetchImage(imageName: String, completion: @escaping ImageClosure) {
        
        do {
            try MovieHttpRouter
                .downloadImage(imageName: imageName)
                .request(usingHttpService: httpService)
                .responseData(completionHandler: { (result) in
                    completion(result.data)
                })
        } catch  {
            print("Something went grong while fetching thumbnail! = \(error)")
        }
    }
    
    
}
