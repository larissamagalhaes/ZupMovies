//
//  MovieViewController.swift
//  ZupMovies
//
//  Created by Larissa Cavalcante on 17/01/17.
//  Copyright © 2017 Larissa Cavalcante. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
    
    var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.titleView = searchBar
        
        searchBar.becomeFirstResponder()
    }

}
