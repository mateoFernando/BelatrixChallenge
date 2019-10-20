//
//  MoviePresenter.swift
//  BelatrixChallenge
//
//  Created by Fer on 20/10/2019.
//  Copyright © 2019 Fer. All rights reserved.
//
import Foundation

protocol MoviePresentation {
    
    func viewDidLoad() -> Void
}

class MoviePresenter {
    
    weak var view: MovieView?
    var interactor: MovieUseCase
    var router: MovieRouting
    
    init(view: MovieView, interactor: MovieUseCase, router: MovieRouting) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}

extension MoviePresenter : MoviePresentation {
    
    func viewDidLoad() {
        let movieModel = self.interactor.getTestTitle()
        print("Test viper data \(movieModel.movieName)")
        DispatchQueue.main.async {
            self.view?.updateTitle(title: movieModel.movieName)
        }
    }
}
