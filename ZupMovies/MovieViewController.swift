//
//  MovieViewController.swift
//  ZupMovies
//
//  Created by Larissa Cavalcante on 17/01/17.
//  Copyright © 2017 Larissa Cavalcante. All rights reserved.
//

import UIKit
import MXParallaxHeader
import Haneke
import RKParallaxEffect

class MovieViewController: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var posterBackgroundImageView: UIImageView!

    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var parallaxEffect: RKParallaxEffect!
    
    var id = ""
    
    var movie: Movie!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parallaxEffect = RKParallaxEffect(tableView: tableView)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.estimatedRowHeight = 150
        
        movie = Movie.getByID(id: id as AnyObject)
        
        tableView.tableFooterView = UIView(frame: .zero)
        
        let url = URL(string: movie.posterURL)

        posterBackgroundImageView.hnk_setImageFromURL(url!)
        
        posterImageView.hnk_setImageFromURL(url!)
        
        title = movie.title
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        parallaxEffect.isParallaxEffectEnabled = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieDetailTableViewCell
        
        cell.titleLabel.text = movie.title + " (\(movie.year))"
        
        let genre = "Gênero: \(movie.genre)"
        
        cell.genderLabel.attributedText = attributedString(text: genre, rangeString: "Gênero:")
        
        let director = "Diretor: \(movie.director)"
        
        cell.directorLabel.attributedText = attributedString(text: director, rangeString: "Diretor:")
        
        let actors = "Principais Atores: \(movie.actors)"
        
        cell.actorLabel.attributedText = attributedString(text: actors, rangeString: "Principais Atores:")
        
        let plot = "Sinopse: \(movie.plot)"
        
        cell.plotLabel.attributedText = attributedString(text: plot, rangeString: "Sinopse:")
        
        cell.ratingLabel.text = movie.rating
        
        return cell
    }
}
