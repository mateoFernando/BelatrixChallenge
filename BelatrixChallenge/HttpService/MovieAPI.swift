//
//  MovieAPI.swift
//  BelatrixChallenge
//
//  Created by Fer on 20/10/2019.
//  Copyright © 2019 Fer. All rights reserved.
//

typealias MoviesClosure = ([MovieModel]) -> (Void)
typealias DataImageClosure = (DetailImageModel) -> (Void)

protocol MoviesAPI {
    
    func fetchPopularMoviews(page: Int, completion: @escaping MoviesClosure) -> (Void)
    func searchMovies(query: String, page: Int, completion: @escaping MoviesClosure) -> (Void)
    func fetchMovie(movieId: Int, completion: @escaping DataImageClosure) -> (Void)
}
