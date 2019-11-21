//
//  SearchMoviesViewController.swift
//  ZupMovies
//
//  Created by Larissa Cavalcante on 18/01/17.
//  Copyright © 2017 Larissa Cavalcante. All rights reserved.
//

import UIKit
import RealmSwift
import ReachabilitySwift
import AlamofireImage

class SearchMoviesViewController: ViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, MovieServiceDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies: Results<Movie>!
    
    var timer = Timer()
    
    let reachability = Reachability()
    
    var isConnection = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.becomeFirstResponder()
        
        tableView.rowHeight = 110
        
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    //MARK: Tableview Delegate and Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(movies == nil) || (movies.count == 0) {
            
            let noResultLabel = UILabel(frame: tableView.bounds)
            noResultLabel.textColor = UIColor(white: 220/255.0, alpha: 1)
            noResultLabel.numberOfLines = 0
            noResultLabel.textAlignment = NSTextAlignment.center
            noResultLabel.font = noResultLabel.font.withSize(14)
            noResultLabel.text = "Nenhum filme encontrado"
            noResultLabel.sizeToFit()
            
            tableView.backgroundView = noResultLabel
        
            return 0
        
        } else {
            
            tableView.backgroundView = nil
        }
        
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
            
            let movie = movies[indexPath.row]
            
            let genre = movie.genre.components(separatedBy: ",").first
            
            cell.genreYearLabel.text = genre! + ", " + movie.year
            
            cell.titleLabel.text = movie.title
            
            cell.ratingLabel.text = movie.rating
            
            cell.addButton.indexPath = indexPath
            
            cell.addButton.addTarget(self, action: #selector(SearchMoviesViewController.favoriteMovieTouched(_ :)), for: .touchUpInside)
            
            var image = UIImage(named: "add")
            
            if(movie.isFavorite) {
                
                image = UIImage(named: "remove")
            }
            
            cell.addButton.setImage(image, for: .normal)
            
            if(movie.posterURL != "N/A") {
                
                let url = URL(string: movie.posterURL)
                
                cell.posterImageView.af_setImage(withURL: url!)
                
            } else {
                
                cell.posterImageView.image = UIImage(named: "placeholder_movie")
            }
            
            return cell
    }
    
    //MARK: Actions
    
    func favoriteMovieTouched(_ button: Button) {
        
        let indexPath = button.indexPath
        
        let movie = movies[(indexPath?.row)!]
        
        try! uiRealm.write {
            
            movie.isFavorite = !movie.isFavorite
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Searchbar Delegate
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(SearchMoviesViewController.searchText(_ :)), userInfo: searchBar.text, repeats: false)
    }
    
    func searchText(_ timer: Timer) {
        
        let searchText = timer.userInfo as! String
        
        searchDatabase(searchText: searchText)
        
        if(reachability?.currentReachabilityStatus == Reachability.NetworkStatus.notReachable) && (isConnection){
            
            isConnection = false
            
            showAlertErroConexao(data: nil)
        
        } else if (reachability?.currentReachabilityStatus != Reachability.NetworkStatus.notReachable)  {
            
            isConnection = true
            
            MovieService(delegate: self).requestMovie(name: searchText)
        }
    }
    
    func searchDatabase(searchText: String) {
        
        let predicate = NSPredicate(format: "title contains[c]%@ ", searchText)
        
        movies = Movie.all().filter(predicate)
                
        tableView.reloadData()
    }
    
    //MAKE: Service Delegate

    func movieSuccessful() {
        
        searchDatabase(searchText: searchBar.text!)
    }
    
    func movieFailed(data: Data?) {
        
        showAlertErroConexao(data: data)
    }
}
