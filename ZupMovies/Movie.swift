//
//  Movie.swift
//  ZupMovies
//
//  Created by Larissa Cavalcante on 19/01/17.
//  Copyright © 2017 Larissa Cavalcante. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Movie: Object, Mappable {
    
    dynamic var id = ""
    dynamic var title = ""
    dynamic var year = ""
    dynamic var released = ""
    dynamic var genre = ""
    dynamic var director = ""
    dynamic var writter = ""
    dynamic var actors = ""
    dynamic var plot = ""
    dynamic var posterURL = ""
    dynamic var rating = ""
    dynamic var response = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func mapping(map: Map) {
        
        id <- map["imdbID"]
        title <- map["Title"]
        year <- map["Year"]
        released <- map["Released"]
        genre <- map["Genre"]
        director <- map["Director"]
        writter <- map["Writer"]
        actors <- map["Actors"]
        plot <- map["Plot"]
        posterURL <- map["Poster"]
        rating <- map["imdbRating"]
        response <- map["Response"]
    }
    
    
    static func current() -> Movie? {
        
        return uiRealm.objects(Movie.self).first
    }
    
    static func getByID(id: AnyObject) -> Movie? {
        
        let results = uiRealm.objects(Movie.self).filter("id = %@", id)
        
        return results.first
    }
    
    
    static func all() -> List<Movie> {
        
        let list = List<Movie>()
        
        list.append(objectsIn: uiRealm.objects(Movie.self))
        
        return list
    }
    
    static func save(object: Movie) {
        
        do {
            
            try uiRealm.write {
                
                uiRealm.add(object, update: true)
                
            }
            
        } catch  {
            
            assert(false, "Não foi possível persistir o objeto")
        }
    }
    
    static func saveAll(objects: List<Movie>) {
        
        do {
            
            try uiRealm.write {
                
                uiRealm.add(objects, update: true)
            }
            
        } catch  {
            
            assert(false, "Não foi possível persistir o objeto")
        }
        
    }
    
    static func deleteObject(object: Movie) {
        
        do {
            
            try uiRealm.write {
                
                uiRealm.delete(object)
            }
            
        } catch  {
            
            print("Não foi possível persitir os objetos")
        }
    }
    
    static func deleteAll() {
        
        let objects = all()
        
        for object in objects {
            
            deleteObject(object: object)
        }
    }
}
