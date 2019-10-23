//
//  MovieInteractor.swift
//  BelatrixChallenge
//
//  Created by Fer on 20/10/2019.
//  Copyright © 2019 Fer. All rights reserved.
//

protocol MovieUseCase {
}

class MovieInteractor {
    
    var service : MoviesAPI
    
    init(service: MoviesAPI) {
        self.service = service
    }
    
}

extension MovieInteractor : MovieUseCase {
    
    func getPopularMovies(page: Int, completion: @escaping MoviesClosure) -> (Void) {
        self.service.fetchPopularMoviews(page: page,completion: completion)
    }
    
    func searchMovies(query: String,page: Int, completion: @escaping MoviesClosure) -> (Void) {
        self.service.searchMovies(query: query, page:page, completion: completion)
    }
    
    func searchDetailMovie(imageId: Int, completion: @escaping DataImageClosure ) -> (Void) {
        self.service.fetchMovie(movieId: imageId, completion: completion)
    }
    
}
