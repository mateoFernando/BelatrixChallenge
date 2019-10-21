//
//  MovieAPI.swift
//  BelatrixChallenge
//
//  Created by Fer on 20/10/2019.
//  Copyright © 2019 Fer. All rights reserved.
//

typealias MoviesClosure = ([MovieModel]) -> (Void)

protocol MoviesAPI {
    
    func fetchPopularMoviews(completion: @escaping MoviesClosure) -> (Void)
}
