//
//  MovieRouter.swift
//  BelatrixChallenge
//
//  Created by Fer on 20/10/2019.
//  Copyright © 2019 Fer. All rights reserved.
//

import UIKit

protocol MovieRouting {
    
}

class MovieRouter {
    var viewController: UIViewController
    
    init(view: UIViewController) {
        self.viewController = view
    }
}

extension MovieRouter : MovieRouting {
    
}
