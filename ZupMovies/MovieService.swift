//
//  MovieService.swift
//  ZupMovies
//
//  Created by Larissa Cavalcante on 19/01/17.
//  Copyright © 2017 Larissa Cavalcante. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire
import AlamofireObjectMapper

protocol MovieServiceDelegate {
    
    func movieSuccessful()
    func movieFailed(data: Data?)
}

extension MovieServiceDelegate {
    
    func movieSuccessful() {
        
        fatalError("O método movieSuccessful precisa ser implementado")
    }
    
    func movieFailed(data: Data?) {
        
        fatalError("O método movieFailed precisa ser implementado")
    }
}

class MovieService {
    
    let delegate: MovieServiceDelegate
    
    init(delegate: MovieServiceDelegate) {
        
        self.delegate = delegate
    }
    
    func requestMovie(name: String) {
        
        let url = baseURL
        
        let parameters: [String: AnyObject] = ["t": name as AnyObject, "y": "" as AnyObject, "plot": "full" as AnyObject, "r": "json" as AnyObject]
                
        Alamofire.request(url, method: .get, parameters: parameters).validate().responseObject { (response: DataResponse<Movie>) in
            
            switch response.result {
                
            case .success:
                
                let movies = Movie.all()
                                
                if let movie = response.result.value, response.result.value?.response == "True" {
                    
                    if let movieDB = movies.filter({$0.id == movie.id}).first {
                        
                        try! uiRealm.write {
                            
                            movie.isFavorite = movieDB.isFavorite
                        }
                    }
                    
                    Movie.save(object: movie)
                }
                
                self.delegate.movieSuccessful()

            case .failure:
                
                self.delegate.movieFailed(data: response.data)
            }
        }
    }
}
