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

class MovieService {
    
    let delegate: MovieServiceDelegate
    
    init(delegate: MovieServiceDelegate) {
        
        self.delegate = delegate
    }
}
