//
//  ViewController.swift
//  BelatrixChallenge
//
//  Created by Fer on 20/10/2019.
//  Copyright © 2019 Fer. All rights reserved.
//

import UIKit

protocol MovieView: class {
    
    func updateMovies(movies: [MovieModel]) -> Void
}

class MoviesViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet var movies: UITableView!
    @IBOutlet var searchMovies: UISearchBar!
    
    var presenter: MoviePresentation!
    var arrayOfMovies : [MovieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.movieTitle.text = self.arrayOfMovies[indexPath.row].title
        return cell
    }
}


extension MoviesViewController : MovieView {
    
    func updateMovies(movies: [MovieModel]) {
        self.arrayOfMovies = movies
        self.movies.reloadData()
    }
}
