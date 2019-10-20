//
//  MovieInteractor.swift
//  BelatrixChallenge
//
//  Created by Fer on 20/10/2019.
//  Copyright © 2019 Fer. All rights reserved.
//

protocol MovieUseCase {
    func getTestTitle() -> MovieModel
}

class MovieInteractor { }

extension MovieInteractor : MovieUseCase {
    
    func getTestTitle() -> MovieModel {
        
        return MovieModel(movieName: "Kill Bill")
    }
}
