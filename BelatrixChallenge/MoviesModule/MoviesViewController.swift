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

class MoviesViewController: UIViewController , UITableViewDelegate , UITableViewDataSource, LoadMoreControlDelegate {
    
    
    @IBOutlet var movies: UITableView!
    @IBOutlet var searchMovies: UISearchBar!
    
    var presenter: MoviePresentation!
    var arrayOfMovies : [MovieModel] = []
    var pagination = 1
    
    fileprivate var loadMoreControl: LoadMoreControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.onFetchMovies(page: pagination) { movies in
            self.arrayOfMovies = movies
            self.movies.reloadData()
        }
        loadMoreControl = LoadMoreControl(scrollView: movies, spacingFromLastCell: 10, indicatorHeight: 60)
        loadMoreControl.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = self.arrayOfMovies[indexPath.row]
        cell.movieTitle.text = movie.title
        cell.movieYear.text = "\(movie.year)"
        cell.movieOverview.text = "BelatrixChallenge."
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func loadMoreControl(didStartAnimating loadMoreControl: LoadMoreControl) {
        print("didStartAnimating")
        pagination = pagination + 1
        self.presenter.onFetchMovies(page: pagination) { movies in
            self.arrayOfMovies.append(contentsOf: movies)
            self.movies.reloadData()
            loadMoreControl.stop()
        }
        
    }
    
    func loadMoreControl(didStopAnimating loadMoreControl: LoadMoreControl) {
        print("didStopAnimating")
        
    }
    
    
    
}

extension MoviesViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        loadMoreControl.didScroll()
    }
}

extension MoviesViewController : MovieView {
    
    func updateMovies(movies: [MovieModel]) {
        self.arrayOfMovies = movies
    }
}
