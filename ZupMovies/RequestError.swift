//
//  RequestError.swift
//  ZupMovies
//
//  Created by Larissa Cavalcante on 20/01/17.
//  Copyright © 2017 Larissa Cavalcante. All rights reserved.
//

import Foundation

class RequestError {
    
    init(message: String? = "") {
        
        self.message = message
    }
    
    var message: String!
}
