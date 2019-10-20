//
//  ViewController.swift
//  BelatrixChallenge
//
//  Created by Fer on 20/10/2019.
//  Copyright © 2019 Fer. All rights reserved.
//

import UIKit

protocol MovieView: class {
    
    func updateTitle(title:String) -> (Void)
}

class MoviesViewController: UIViewController {

    @IBOutlet var testLabel: UILabel!
    
    var presenter: MoviePresentation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.viewDidLoad()
    }


}


extension MoviesViewController : MovieView {
    
    func updateTitle(title: String) {
        testLabel.text = title
    }
}
