//
//  MovieModuleBuilder.swift
//  BelatrixChallenge
//
//  Created by Fer on 20/10/2019.
//  Copyright © 2019 Fer. All rights reserved.
//

import UIKit

class MoviewModuleBuilder {
    
    static func build() -> UIViewController {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as! MoviesViewController
        let interactor = MovieInteractor(service: MoviesService.shared)
        let imageInteractor = ImageInteractor(service: MoviesService.shared)
        let router = MovieRouter(view:view)
        let presenter = MoviePresenter(view: view, interactor: interactor, router: router,useCase:(
            getPopularMovies: interactor.getPopularMovies,
            fetchThumbnail: imageInteractor.fetchThumbnail,
            searchMovie : interactor.searchMovies)  )
        view.presenter = presenter
        return view
    }
}

