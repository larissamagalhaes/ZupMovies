//
//  SearchMoviesViewController.swift
//  ZupMovies
//
//  Created by Larissa Cavalcante on 18/01/17.
//  Copyright © 2017 Larissa Cavalcante. All rights reserved.
//

import UIKit
import RealmSwift

class SearchMoviesViewController: ViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies: Results<Movie>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}
