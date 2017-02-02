//
//  Tv.swift
//  PhoneBook
//
//  Created by Yonca Coskun on 1.02.2017.
//  Copyright © 2017 PoncikApps. All rights reserved.
//


import Foundation
import Firebase

struct Tv {
    
    
    let key: String
    let original_name: String
    let overview: String
    let poster_path: String
    let original_language: String
    let type: String
    let vote_average: String
    let vote_count: String
    let first_air_date: String
    let last_air_date: String
    let number_of_episodes: String
    let number_of_seasons: String
  
    
    let ref: FIRDatabaseReference?
    
    
    init(original_name: String, overview: String, poster_path: String, original_language: String, type: String, vote_average: String, vote_count: String, first_air_date: String, last_air_date: String, number_of_episodes: String, number_of_seasons: String,key: String = "") {
        self.key = key
        self.original_name = original_name
        self.overview = overview
        self.poster_path = poster_path
        self.original_language = original_language
        self.type = type
        self.vote_average = vote_average
        self.vote_count = vote_count
        self.first_air_date = first_air_date
        self.last_air_date = last_air_date
        self.number_of_episodes = number_of_episodes
        self.number_of_seasons = number_of_seasons
        
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        original_name = snapshotValue["original_name"] as! String
        overview = snapshotValue["overview"] as! String
        poster_path = snapshotValue["poster_path"] as! String
        original_language = snapshotValue["original_language"] as! String
        type = snapshotValue["type"] as! String
        vote_average = snapshotValue["vote_average"] as! String
        vote_count = snapshotValue["vote_count"] as! String
        first_air_date = snapshotValue["first_air_date"] as! String
        last_air_date = snapshotValue["last_air_date"] as! String
        number_of_episodes = snapshotValue["number_of_episodes"] as! String
        number_of_seasons = snapshotValue["number_of_seasons"] as! String
    
        
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "original_name": original_name,
            "overview": overview,
            "poster_path": poster_path,
            "original_languagee": original_language,
            "type": type,
            "vote_average": vote_average,
            "vote_count": vote_count,
            "first_air_date": first_air_date,
            "last_air_date": last_air_date,
            "number_of_episodes": number_of_episodes,
            "number_of_seasons": number_of_seasons,
      
            
        ]
    }
    
    
    
    
}

