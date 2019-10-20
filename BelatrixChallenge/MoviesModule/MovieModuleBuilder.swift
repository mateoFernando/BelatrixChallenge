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
        let interactor = MovieInteractor()
        let router = MovieRouter(view:view)
        let presenter = MoviePresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}

