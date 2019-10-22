//
//  MoviePresenter.swift
//  BelatrixChallenge
//
//  Created by Fer on 20/10/2019.
//  Copyright © 2019 Fer. All rights reserved.
//
import Foundation

protocol MoviePresentation {
    
    func onFetchMovies(page:Int, completion : @escaping MoviesClosure ) -> Void
    func onFetchThumbnail(imageName:String, completion : @escaping (Data) -> Void ) -> Void
    func onSearchMovies(query:String, completion : @escaping MoviesClosure ) -> Void
}

class MoviePresenter : MoviePresentation {
    
    weak var view: MovieView?
    var interactor: MovieUseCase
    var router: MovieRouting
    typealias UseCase = (
        getPopularMovies :(_ page: Int, _ completion: @escaping MoviesClosure) -> Void,
        fetchThumbnail : (_ imageName:String, _ completion: @escaping ImageClosure) -> Void,
        searchMovie : (_ query:String, _ completion: @escaping MoviesClosure) -> Void
    )
    var useCase: UseCase?
    
    init(view: MovieView, interactor: MovieUseCase, router: MovieRouting, useCase: MoviePresenter.UseCase) {
        self.interactor = interactor
        self.router = router
        self.view = view
        self.useCase = useCase
    }
}

extension MoviePresenter {
    
    func onSearchMovies(query: String, completion: @escaping MoviesClosure) {
        
        DispatchQueue.main.async {
            self.useCase?.searchMovie(query){ movies in
                print("Load 10 movies: \(movies)")
                completion(movies)
            }
        }
    }
    
    func onFetchMovies(page: Int, completion: @escaping (MoviesClosure) ) {
        
        DispatchQueue.main.async {
            self.useCase?.getPopularMovies(page){ movies in
                print("Load 10 movies: \(movies)")
//                self.view?.updateMovies(movies:movies)
                completion(movies)
            }
        }
    }
    
    
    func onFetchThumbnail(imageName: String, completion : @escaping (Data) -> Void ) {
        
        DispatchQueue.global(qos: .background).async {
            
            self.useCase?.fetchThumbnail(imageName){ data in
                guard let data = data else { return }
                completion(data)
            }
        }
    }
}
