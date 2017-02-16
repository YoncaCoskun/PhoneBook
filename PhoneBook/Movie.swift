//
//  Movie.swift
//  PhoneBook
//
//  Created by Yonca Coskun on 1.02.2017.
//  Copyright © 2017 PoncikApps. All rights reserved.
//

import Foundation
import Firebase

struct Movie {
    
    
    let key: String
    let title: String
    let year: String
    let released: String
    let runtime: String
    let genre: String
    let language: String
    let country: String
    let poster: String
    let metascore: String
    let imdbRating: String
    let imdbVotes: String
    let type: String
    let tomatoMeter: String
    let tomatoRating: String
    let tomatoReviews: String
    let tomatoFresh: String
    let tomatoRotten: String
    let tomatoConsensus: String
    let tomatoUserMeter: String
    let tomatoUserRating: String
    let plot: String
    
    let ref: FIRDatabaseReference?
    
    
    init(title: String, year: String, released: String, runtime: String, genre: String, language: String, country: String, poster: String, metascore: String, imdbRating: String, imdbVotes: String, type: String, tomatoMeter: String, tomatoRating: String, tomatoReviews: String, tomatoFresh: String, tomatoRotten: String, tomatoConsensus: String, tomatoUserMeter: String, tomatoUserRating: String,plot:String, key: String = "") {
        self.key = key
        self.title = title
        self.year = year
        self.released = released
        self.runtime = runtime
        self.genre = genre
        self.language = language
        self.country = country
        self.poster = poster
        self.metascore = metascore
        self.imdbRating = imdbRating
        self.imdbVotes = imdbVotes
        self.type = type
        self.tomatoMeter = tomatoMeter
        self.tomatoRating = tomatoRating
        self.tomatoReviews = tomatoReviews
        self.tomatoFresh = tomatoFresh
        self.tomatoRotten = tomatoRotten
        self.tomatoConsensus = tomatoConsensus
        self.tomatoUserMeter = tomatoUserMeter
        self.tomatoUserRating = tomatoUserRating
        self.plot = plot
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        title = snapshotValue["Title"] as! String
        year = snapshotValue["Year"] as! String
        released = snapshotValue["Released"] as! String
        runtime = snapshotValue["Runtime"] as! String
        genre = snapshotValue["Genre"] as! String
        language = snapshotValue["Language"] as! String
        country = snapshotValue["Country"] as! String
        poster = snapshotValue["Poster"] as! String
        metascore = snapshotValue["Metascore"] as! String
        imdbRating = snapshotValue["imdbRating"] as! String
        imdbVotes = snapshotValue["imdbVotes"] as! String
        type = snapshotValue["Type"] as! String
        tomatoMeter = snapshotValue["tomatoMeter"] as! String
        tomatoRating = snapshotValue["tomatoRating"] as! String
        tomatoReviews = snapshotValue["tomatoReviews"] as! String
        tomatoFresh = snapshotValue["tomatoFresh"] as! String
        tomatoRotten = snapshotValue["tomatoRotten"] as! String
        tomatoConsensus = snapshotValue["tomatoConsensus"] as! String
        tomatoUserMeter = snapshotValue["tomatoUserMeter"] as! String
        tomatoUserRating = snapshotValue["tomatoUserRating"] as! String
        plot = snapshotValue["Plot"] as! String
        
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "Title": title,
            "Year": year,
            "Released": released,
            "Runtime": runtime,
            "Genre": genre,
            "Language": language,
            "Country": country,
            "Poster": poster,
            "Metascore": metascore,
            "imdbRating": imdbRating,
            "imdbVotes": imdbVotes,
            "Type": type,
            "tomatoMeter": tomatoMeter,
            "tomatoRating": tomatoRating,
            "tomatoReviews": tomatoReviews,
            "tomatoFresh": tomatoFresh,
            "tomatoRotten": tomatoRotten,
            "tomatoConsensus": tomatoConsensus,
            "tomatoUserMeter": tomatoUserMeter,
            "tomatoUserRating": tomatoUserRating,
            "Plot": plot,
            
        ]
    }
    
    
    
    
}
