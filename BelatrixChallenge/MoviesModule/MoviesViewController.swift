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

class MoviesViewController: UIViewController , UITableViewDelegate , UITableViewDataSource, LoadMoreControlDelegate , UISearchControllerDelegate {
    
    
    @IBOutlet var movies: UITableView!
    
    var presenter: MoviePresentation!
    var arrayOfMovies : [MovieModel] = []
    var pagination = 1
    var paginationForFilter = 1
    
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
        
        
        searchController.delegate = self
        
        searchController.searchResultsUpdater = self
        
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.placeholder = "Buscar peliculas"
        
        navigationItem.searchController = searchController
        
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
            movie = filteredMovies[indexPath.row]
        } else {
            movie = self.arrayOfMovies[indexPath.row]
        }
        cell.movieTitle.text = movie.title == nil ? "" : movie.title!
        cell.movieYear.text = "\(movie.year == nil ? 0 : movie.year!)"
        cell.movieOverview.text = movie.overview == nil ? "" : movie.overview!
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
        if isFiltering {
            paginationForFilter = paginationForFilter + 1
            self.presenter.onSearchMovies(query: searchController.searchBar.text!, page: paginationForFilter) { searchedMovies in
                self.filteredMovies.append(contentsOf: searchedMovies)
                self.movies.reloadData()
                loadMoreControl.stop()
            }
        }
        else {
            pagination = pagination + 1
            self.presenter.onFetchMovies(page: pagination) { movies in
                self.arrayOfMovies.append(contentsOf: movies)
                self.movies.reloadData()
                loadMoreControl.stop()
            }
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
        
        self.presenter.onSearchMovies(query: searchText.lowercased(), page: paginationForFilter) { searchedMovies in
            self.filteredMovies = searchedMovies
            self.movies.reloadData()
        }
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        paginationForFilter = 1
        pagination = 1
        self.presenter.onFetchMovies(page: pagination) { movies in
            self.arrayOfMovies = [MovieModel]()
            self.filteredMovies = [MovieModel]()
            self.arrayOfMovies = movies
            self.movies.reloadData()
        }
    }
}
