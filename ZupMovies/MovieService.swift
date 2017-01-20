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
        
        let url = baseURL + ""
        
        let parameters: [String: AnyObject] = ["t": name as AnyObject]
        
        Alamofire.request(url, method: .get, parameters: parameters).validate().responseObject { (response: DataResponse<Movie>) in
            
            switch response.result {
                
            case .success:
                                
                if let movie = response.result.value, response.result.value?.response != "True" {
                    
                    Movie.save(object: movie)
                }
                
                self.delegate.movieSuccessful()
                
            case .failure:
                
                self.delegate.movieFailed(data: response.data)
            }
        }
    }
}
