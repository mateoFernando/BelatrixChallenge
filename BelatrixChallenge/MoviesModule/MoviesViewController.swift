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
    
    var presenter: MoviePresentation!
    var arrayOfMovies : [MovieModel] = []
    var pagination = 1
    
    fileprivate var loadMoreControl: LoadMoreControl!
    let searchController = UISearchController(searchResultsController: nil)
    var filteredMovies: [MovieModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.onFetchMovies(page: pagination) { movies in
            self.arrayOfMovies = movies
            self.movies.reloadData()
        }
        loadMoreControl = LoadMoreControl(scrollView: movies, spacingFromLastCell: 10, indicatorHeight: 60)
        loadMoreControl.delegate = self
        
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Buscar peliculas"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredMovies.count
        }
        return arrayOfMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie:MovieModel
        if isFiltering {
            movie = arrayOfMovies[indexPath.row]
        } else {
            movie = self.arrayOfMovies[indexPath.row]
        }
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
    
    
    
    //Search
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
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

extension MoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredMovies = arrayOfMovies.filter { (movie: MovieModel) -> Bool in
            return movie.title.lowercased().contains(searchText.lowercased())
        }
        movies.reloadData()
    }
}
