//
//  SearchMoviesViewController.swift
//  ZupMovies
//
//  Created by Larissa Cavalcante on 18/01/17.
//  Copyright © 2017 Larissa Cavalcante. All rights reserved.
//

import UIKit

class SearchMoviesViewController: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.becomeFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        
        return cell
    }
}
