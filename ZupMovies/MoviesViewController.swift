//
//  MoviesViewController.swift
//  ZupMovies
//
//  Created by Larissa Cavalcante on 17/01/17.
//  Copyright © 2017 Larissa Cavalcante. All rights reserved.
//

import UIKit
import RealmSwift
import Haneke

class MoviesViewController: ViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var noMoviesView: UIView!
    
    @IBOutlet weak var addButton: UIButton!
    
    var movies: Results<Movie>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let predicate = NSPredicate(format: "isFavorite = 1")
        
        movies = Movie.all().filter(predicate)
    }
    
    func settingsLayout() {
        
        addButton.layer.cornerRadius = 5
        
        addButton.layer.borderColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
        
        addButton.layer.borderWidth = 1
    }
    
    //MARK: CollectionView Datasource, Delegate and FlowLayout
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(movies == nil) {
            
            noMoviesView.isHidden = false
            
            return 0
            
        } else {
            
            noMoviesView.isHidden = true
        }
        
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "movie", sender: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat.leastNormalMagnitude
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat.leastNormalMagnitude
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widthScreen = UIScreen.main.bounds.width
        
        let numberOfItens = widthScreen/159
        
        let width = widthScreen/floor(numberOfItens)
        
        return CGSize(width: width, height: 200)
    }
    
    //MARK: Actions
    
    @IBAction func searchTouched(_ sender: Any) {
        
        performSegue(withIdentifier: "addMovie", sender: self)
    }
    
    @IBAction func addTouched(_ sender: Any) {
        
        performSegue(withIdentifier: "addMovie", sender: self)
        
    }

}
