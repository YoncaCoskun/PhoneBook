//
//  ViewController.swift
//  PhoneBook
//
//  Created by Yonca Coskun on 20.01.2017.
//  Copyright © 2017 PoncikApps. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift
import Realm
import Alamofire_Synchronous
import Firebase

class ViewController: UIViewController{
    var id: String = ""
    var idIMDB: String = ""
    var imdbId: String = ""
    var pageNumMovie: Int = 7 //1225
    var pageNumTv: Int = 7 //14
    var page: String = ""
    var m: Int = 0
    var request1: String = ""
    var requestMovie: String = ""
    var requestMovie2: String = ""
    var requestMovie3: String = ""
    var requestTv: String = ""
    var requestTv2: String = ""
    var requestTv3: String = ""
    var request2:String = ""
    var request3:String = ""
    var pageId: String = ""
    var idArray : [String] = []
    var idArrayMovie : [String] = []
    var idArrayTv : [String] = []
    var idImdb : [String] = []
    var idImdbMovie : [String] = []
    var idImdbTv : [String] = []
    var refMovie : FIRDatabaseReference!
    var refTv : FIRDatabaseReference!
    var items: [Movie] = []
    var itemsMovie: [Movie] = []
    var itemsTv: [Movie] = []
    var itemsTvNonImdb: [Tv] = []
    

   
    @IBAction func actionRealm(_ sender: Any) {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        reloadTheTable()
        getDataRealm()
    }

    @IBAction func actionFirebaseMovie(_ sender: Any) {
        refMovie =  FIRDatabase.database().reference()
        getDataMovie()
    }
    @IBAction func actionFirebaseTv(_ sender: Any) {
        refTv =  FIRDatabase.database().reference()
        getDataTv()
    }
   /* @IBAction func actionFirebase(_ sender: Any) {
        refMovie =  FIRDatabase.database().reference()
        refTv =  FIRDatabase.database().reference()
        
        getDataFirebase()
    }*/
    
    @IBOutlet weak var tableview: UITableView!
    
    //dataların tutuldugu yer
    var datasource:Results<Films>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadTheTable()
        //var timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.viewDidLoad), userInfo: nil, repeats: true);
    }
    
     var myGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func reloadTheTable() {
        do{
            let realm = try Realm()
            datasource = realm.objects(Films.self)
            //datasource = realm.objects(Films.self).filter("id == '\(films.Title)'")
            tableview?.reloadData()
            
        }
        catch{
        }
        
    }
    
    func getDataRealm(){
        
        //1130 pages
        for i in 1..<pageNumTv {
            idArray = []
            idImdb = []
            myGroup.enter()
           
            page = String(i)

            
            request1 = "https://api.themoviedb.org/3/discover/movie?api_key=60ec9d5fa8ff0c39143aa6049c37291e&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page="+page+"&vote_count.gte=100&vote_average.gte=6.5"
            
            let response1 = Alamofire.request(request1, method: .get).responseJSON()
            if let json = response1.result.value {
                //print(json)
                let jsonParse = JSON(json)
                let arrayIds =  jsonParse["results"].arrayValue.map({$0["id"].stringValue})
                self.idArray = arrayIds
                //print(idArray)
                
                
            }
            
            //---------------------------Alamofire 1-------------------------------------------------------------------------
            
            //------------------------Alamofire 2----------------------------------------------------------------------------
            //print(self.idArray)
            for i in 0..<idArray.count {
                self.id = idArray[i]
                //print(self.id)
                self.request2 = "https://api.themoviedb.org/3/movie/"+self.id+"?api_key=60ec9d5fa8ff0c39143aa6049c37291e&language=en-US"
                
                let response2 = Alamofire.request(request2, method: .get).responseJSON()
                if let jsonMovie = response2.result.value {
                    //print(json)
                    let jsonParseMovie = JSON(jsonMovie)
                    let imdbId =  jsonParseMovie["imdb_id"].stringValue
                    //print(imdbId)
                    idImdb.append(imdbId)
                    
                }
            }
            print("-----------------------"+page+"-------------------------------")
            //print(idImdb)
            //------------------------Alamofire 2----------------------------------------------------------------------------
            
            //---------------Alamofire 3------------------------------------------------------------------------------------
            
            for j in 0..<idImdb.count {
                self.idIMDB = idImdb[j]
                request3 = "https://www.omdbapi.com/?i="+self.idIMDB+"&plot=short&r=json&tomatoes=true"
                
                let response3 = Alamofire.request(request3, method: .get).responseJSON()
                if let jsonImdb = response3.result.value {
                    //print("JSON: \(jsonImdb)")
                    let jsonParseImdb = JSON(jsonImdb)
                    //print(jsonParseImdb)
                    
                    //l-----------realm e atma islemi--------------
                    
                    let title = jsonParseImdb["Title"].stringValue
                    let year = jsonParseImdb["Year"].stringValue
                    let released = jsonParseImdb["Released"].stringValue
                    let runtime = jsonParseImdb["Runtime"].stringValue
                    let genre = jsonParseImdb["Genre"].stringValue
                    let language = jsonParseImdb["Language"].stringValue
                    let country = jsonParseImdb["Country"].stringValue
                    let poster = jsonParseImdb["Poster"].stringValue
                    let metascore = jsonParseImdb["Metascore"].stringValue
                    let imdbRating = jsonParseImdb["imdbRating"].stringValue
                    let imdbVotes = jsonParseImdb["imdbVotes"].stringValue
                    let type = jsonParseImdb["Type"].stringValue
                    let tomatoMeter = jsonParseImdb["tomatoMeter"].stringValue
                    let tomatoRating = jsonParseImdb["tomatoRating"].stringValue
                    let tomatoReviews = jsonParseImdb["tomatoReviews"].stringValue
                    let tomatoFresh = jsonParseImdb["tomatoFresh"].stringValue
                    let tomatoRotten = jsonParseImdb["tomatoRotten"].stringValue
                    let tomatoConsensus = jsonParseImdb["tomatoConsensus"].stringValue
                    let tomatoUserMeter = jsonParseImdb["tomatoUserMeter"].stringValue
                    let tomatoUserRating = jsonParseImdb["tomatoUserRating"].stringValue
                    
                    
                    let newContact = Films()
                    // newContact.Name = txtContactName.text!
                    // newContact.PhoneNumber = txtContactTelephoneNumber.text!
                    
                    newContact.Title = title
                    newContact.Year = year
                    newContact.Released = released
                    newContact.Runtime = runtime
                    newContact.Genre = genre
                    newContact.Language = language
                    newContact.Country = country
                    newContact.Poster = poster
                    newContact.Metascore = metascore
                    newContact.ImdbRating = imdbRating
                    newContact.ImdbVotes = imdbVotes
                    newContact.Typee = type
                    newContact.TomatoMeter = tomatoMeter
                    newContact.TomatoRating = tomatoRating
                    newContact.TomatoReviews = tomatoReviews
                    newContact.TomatoFresh = tomatoFresh
                    newContact.TomatoRotten = tomatoRotten
                    newContact.TomatoConsensus = tomatoConsensus
                    newContact.TomatoUserMeter = tomatoUserMeter
                    newContact.TomatoUserRating = tomatoUserRating
                    
                    do{
                        let realm = try Realm()
                        try realm.write { ()->Void in
                            realm.add(newContact)
                        }
                        
                    }
                    catch{
                        
                    }
                    
                }
            }
            //------------Alamofire 3--------------------------------------------------
            print("Finished request \(i)")
            self.myGroup.leave()
        }
        //-------------------------------Alamofire 3----------------------------------------------------------
        
        myGroup.notify(queue: DispatchQueue.main, execute: {
            print("Finished all requests.")
        })
    
    }
    func getDataMovie(){
    
        //--------------------------------------------------------------------------------------------------------------------
        for i in 1..<pageNumMovie {
            idArrayMovie = []
            idImdb = []
            idImdbMovie = []
            
            page = String(i)
            
            //---------------------------Alamofire 1-------------------------------------------------------------------------
            
            requestMovie = "https://api.themoviedb.org/3/discover/movie?api_key=60ec9d5fa8ff0c39143aa6049c37291e&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page="+page+"&vote_average.gte=7.0&append_to_response=external_ids"
            
            let responseMovie = Alamofire.request(requestMovie, method: .get).responseJSON()
            if let json = responseMovie.result.value {
                let jsonParseMovie = JSON(json)
                let arrayIdsMovie =  jsonParseMovie["results"].arrayValue.map({$0["id"].stringValue})
                self.idArrayMovie = arrayIdsMovie
                
            }
            
            //---------------------------Alamofire 1-------------------------------------------------------------------------
            
            //------------------------Alamofire 2----------------------------------------------------------------------------
            //print(self.idArray)
            for i in 0..<idArrayMovie.count {
                self.id = idArrayMovie[i]
                // print(self.id)
                self.requestMovie2 = "https://api.themoviedb.org/3/movie/"+self.id+"?api_key=60ec9d5fa8ff0c39143aa6049c37291e&language=en-US"
                
                let responseMovie2 = Alamofire.request(requestMovie2, method: .get).responseJSON()
                if let jsonMovie = responseMovie2.result.value {
                    //print(json)
                    let jsonParseMovie = JSON(jsonMovie)
                    let imdbIdMovie =  jsonParseMovie["imdb_id"].stringValue
                    //print(imdbId)
                    idImdbMovie.append(imdbIdMovie)
                    
                }
            }
            //print("-----------------------"+page+"-------------------------------")
            //print(idImdbMovie)

            //------------------------Alamofire 2----------------------------------------------------------------------------
            
            //---------------Alamofire 3------------------------------------------------------------------------------------
            
            for j in 0..<idImdbMovie.count {
                self.idIMDB = idImdbMovie[j]
                requestMovie3 = "https://www.omdbapi.com/?i="+self.idIMDB+"&plot=short&r=json&tomatoes=true"
                
                let responseMovie3 = Alamofire.request(requestMovie3, method: .get).responseJSON()
                if let jsonImdbMovie = responseMovie3.result.value {
                    //print("JSON: \(jsonImdb)")
                    let jsonParseImdbMovie = JSON(jsonImdbMovie)
                    //print(jsonParseImdb)
                    
                    //l-----------firebase e atma islemi--------------
                    
                    let title = jsonParseImdbMovie["Title"].stringValue
                    let year = jsonParseImdbMovie["Year"].stringValue
                    let released = jsonParseImdbMovie["Released"].stringValue
                    let runtime = jsonParseImdbMovie["Runtime"].stringValue
                    let genre = jsonParseImdbMovie["Genre"].stringValue
                    let language = jsonParseImdbMovie["Language"].stringValue
                    let country = jsonParseImdbMovie["Country"].stringValue
                    let poster = jsonParseImdbMovie["Poster"].stringValue
                    let metascore = jsonParseImdbMovie["Metascore"].stringValue
                    let imdbRating = jsonParseImdbMovie["imdbRating"].stringValue
                    let imdbVotes = jsonParseImdbMovie["imdbVotes"].stringValue
                    let type = jsonParseImdbMovie["Type"].stringValue
                    let tomatoMeter = jsonParseImdbMovie["tomatoMeter"].stringValue
                    let tomatoRating = jsonParseImdbMovie["tomatoRating"].stringValue
                    let tomatoReviews = jsonParseImdbMovie["tomatoReviews"].stringValue
                    let tomatoFresh = jsonParseImdbMovie["tomatoFresh"].stringValue
                    let tomatoRotten = jsonParseImdbMovie["tomatoRotten"].stringValue
                    let tomatoConsensus = jsonParseImdbMovie["tomatoConsensus"].stringValue
                    let tomatoUserMeter = jsonParseImdbMovie["tomatoUserMeter"].stringValue
                    let tomatoUserRating = jsonParseImdbMovie["tomatoUserRating"].stringValue
                    
                    
                    
                    
                    // 2
                    let filmItem = Movie(title: title ,year: year, released: released, runtime: runtime,genre: genre,
                                         language: language, country: country, poster: poster, metascore: metascore,
                                         imdbRating: imdbRating, imdbVotes: imdbVotes, type: type, tomatoMeter: tomatoMeter,
                                         tomatoRating: tomatoRating, tomatoReviews: tomatoReviews, tomatoFresh: tomatoFresh,
                                         tomatoRotten: tomatoRotten, tomatoConsensus: tomatoConsensus, tomatoUserMeter: tomatoUserMeter,
                                         tomatoUserRating: tomatoUserRating)
                    // 3
                    let filmItemRefMovie = self.refMovie.child("ResultsMovie")
                    
                    let pageIdRefMovie = filmItemRefMovie.child("movie")
                    
                    let imdbRefMovie = pageIdRefMovie.child(idIMDB)
                    
                    // 4
                    imdbRefMovie.setValue(filmItem.toAnyObject())
                    
                    self.itemsMovie.append(filmItem)

                    
                   
                    
                }
            }
            
            //------------Alamofire 3--------------------------------------------------
        
        }
    }
    //-----------------------------------------------------------------------------------------------------------------------------------------------
    func getDataTv(){
        //--------------------------------------------------------------------------------------------------------------------
        for i in 1..<pageNumTv {
           
            idArrayTv = []
            idImdb = []
            idImdbTv = []
            
            
            page = String(i)
            
            //---------------------------Alamofire 1-------------------------------------------------------------------------
            
            requestTv = "https://api.themoviedb.org/3/discover/tv?api_key=60ec9d5fa8ff0c39143aa6049c37291e&language=en-US&sort_by=popularity.desc&page="+page+"&vote_average.gte=7&vote_count.gte=15"
            
            let responseTv = Alamofire.request(requestTv, method: .get).responseJSON()
            if let json = responseTv.result.value {
                let jsonParseTv = JSON(json)
                let arrayIdsTv =  jsonParseTv["results"].arrayValue.map({$0["id"].stringValue})
                self.idArrayTv = arrayIdsTv
                //print(idArrayTv)
                
            }
            
            //---------------------------Alamofire 1-------------------------------------------------------------------------
            
            //------------------------Alamofire 2----------------------------------------------------------------------------
            print("---------------------"+page+"--------------------------------")
            print(self.idArrayTv)
            //print("-----------------------"+page+"-------------------------------")
            //print(idImdbMovie)
            
            for i in 0..<idArrayTv.count {
                self.id = idArrayTv[i]
                // print(self.id)
                self.requestTv2 = "https://api.themoviedb.org/3/tv/"+self.id+"?api_key=60ec9d5fa8ff0c39143aa6049c37291e&language=en-US&append_to_response=external_ids"
                
                let responseTv2 = Alamofire.request(requestTv2, method: .get).responseJSON()
                if let jsonTv = responseTv2.result.value {
                    //print(json)
                    let jsonParseTv = JSON(jsonTv)
                    //print(jsonParseMovie)
                    let imdbIdTv =  jsonParseTv["external_ids"]["imdb_id"].stringValue
                    
                    if(imdbIdTv == ""){
                        let original_name = jsonParseTv["original_name"].stringValue
                        let overview = jsonParseTv["overview"].stringValue
                        let poster_path = jsonParseTv["poster_path"].stringValue
                        let original_language = jsonParseTv["original_language"].stringValue
                        let type = jsonParseTv["type"].stringValue
                        let vote_average = jsonParseTv["vote_average"].stringValue
                        let vote_count = jsonParseTv["vote_count"].stringValue
                        let first_air_date = jsonParseTv["first_air_date"].stringValue
                        let last_air_date = jsonParseTv["last_air_date"].stringValue
                        let number_of_episodes = jsonParseTv["number_of_episodes"].stringValue
                        let number_of_seasons = jsonParseTv["number_of_seasons"].stringValue
                        
                        let tvItem = Tv(original_name: original_name, overview:overview,poster_path:poster_path,original_language: original_language, type:type, vote_average:vote_average, vote_count:vote_count, first_air_date:first_air_date, last_air_date :last_air_date , number_of_episodes: number_of_episodes, number_of_seasons:number_of_seasons)
                        
                        // 3
                        let filmItemRefTv = self.refTv.child("ResultsNonImdbTv")
                        let pageIdRefTv = filmItemRefTv.child("tvNonImdb")
                        let imdbRefTv = pageIdRefTv.child(id)
                        imdbRefTv.setValue(tvItem.toAnyObject())
                        self.itemsTvNonImdb.append(tvItem)
                    }
                    //print(imdbIdTv)
                    idImdbTv.append(imdbIdTv)
                    
                }
            }
            //print("-----------------------"+page+"-------------------------------")
            //print(idImdbTv)
            //------------------------Alamofire 2----------------------------------------------------------------------------
            
            //---------------Alamofire 3------------------------------------------------------------------------------------
            
            for j in 0..<idImdbTv.count {
                self.idIMDB = idImdbTv[j]
                self.id = idArrayTv[j]
                requestTv3 = "https://www.omdbapi.com/?i="+self.idIMDB+"&plot=short&r=json&tomatoes=true"
                
                if(idIMDB == ""){
                    print("imdb id bosss"+self.id)
                  
                         }
                else{
                    
                    let responseTv3 = Alamofire.request(self.requestTv3, method: .get).responseJSON()
                    if let jsonImdbTv = responseTv3.result.value {
                        //print("JSON: \(jsonImdb)")
                        let jsonParseImdbTv = JSON(jsonImdbTv)
                        //print(jsonParseImdbTv)
                        
                        //l-----------firebase e atma islemi--------------
                        
                        let title = jsonParseImdbTv["Title"].stringValue
                        let year = jsonParseImdbTv["Year"].stringValue
                        let released = jsonParseImdbTv["Released"].stringValue
                        let runtime = jsonParseImdbTv["Runtime"].stringValue
                        let genre = jsonParseImdbTv["Genre"].stringValue
                        let language = jsonParseImdbTv["Language"].stringValue
                        let country = jsonParseImdbTv["Country"].stringValue
                        let poster = jsonParseImdbTv["Poster"].stringValue
                        let metascore = jsonParseImdbTv["Metascore"].stringValue
                        let imdbRating = jsonParseImdbTv["imdbRating"].stringValue
                        let imdbVotes = jsonParseImdbTv["imdbVotes"].stringValue
                        let type = jsonParseImdbTv["Type"].stringValue
                        let tomatoMeter = jsonParseImdbTv["tomatoMeter"].stringValue
                        let tomatoRating = jsonParseImdbTv["tomatoRating"].stringValue
                        let tomatoReviews = jsonParseImdbTv["tomatoReviews"].stringValue
                        let tomatoFresh = jsonParseImdbTv["tomatoFresh"].stringValue
                        let tomatoRotten = jsonParseImdbTv["tomatoRotten"].stringValue
                        let tomatoConsensus = jsonParseImdbTv["tomatoConsensus"].stringValue
                        let tomatoUserMeter = jsonParseImdbTv["tomatoUserMeter"].stringValue
                        let tomatoUserRating = jsonParseImdbTv["tomatoUserRating"].stringValue
                        
                        
                        
                        
                        // 2
                        let filmItem = Movie(title: title ,year: year, released: released, runtime: runtime,genre: genre,
                                             language: language, country: country, poster: poster, metascore: metascore,
                                             imdbRating: imdbRating, imdbVotes: imdbVotes, type: type, tomatoMeter: tomatoMeter,
                                             tomatoRating: tomatoRating, tomatoReviews: tomatoReviews, tomatoFresh: tomatoFresh,
                                             tomatoRotten: tomatoRotten, tomatoConsensus: tomatoConsensus, tomatoUserMeter: tomatoUserMeter,
                                             tomatoUserRating: tomatoUserRating)
                        // 3
                        let filmItemRefTv = self.refTv.child("ResultsTv")
                        
                        let pageIdRefTv = filmItemRefTv.child("tv")
                        
                        let imdbRefTv = pageIdRefTv.child(idIMDB)
                        
                        // 4
                        imdbRefTv.setValue(filmItem.toAnyObject())
                        
                        self.itemsTv.append(filmItem)
                        
                        
                        
                        
                }
                }
               
            
            //------------Alamofire 3--------------------------------------------------
            
        }
    }
    }
    
}

