//
//  SearchMoviesViewController.swift
//  ZupMovies
//
//  Created by Larissa Cavalcante on 18/01/17.
//  Copyright © 2017 Larissa Cavalcante. All rights reserved.
//

import UIKit
import RealmSwift

class SearchMoviesViewController: ViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, MovieServiceDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies: Results<Movie>!
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let predicate = NSPredicate(format: "isFavorite = 0")
        
        movies = Movie.all().filter(predicate)
        
        searchBar.becomeFirstResponder()
        
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    //MARK: Tableview Delegate and Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(movies == nil) {
            
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
        
        return cell
    }
    
    //MARK: Searchbar Delegate
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer.invalidate()
        
        if(searchText.characters.count >= 3){
            
            timer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: Selector(("searchDataTimer:")), userInfo: searchText, repeats: false)
        }
    
    }
    
    func searchText(timer: Timer) {
        
        let searchText = timer.userInfo as! String
        
        searchDatabase(searchText: searchText)
        
        MovieService(delegate: self).requestMovie(name: searchText)
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
        
        
    }
}
