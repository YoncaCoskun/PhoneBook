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
    var pageNum: Int = 6
    var page: String = ""
    var m: Int = 0
    var request1: String = ""
    var request2:String = ""
    var request3:String = ""
    var pageId: String = ""
    var idArray : [String] = []
    var idImdb : [String] = []
    var ref : FIRDatabaseReference!
    var items: [Movie] = []

   
    @IBAction func actionRealm(_ sender: Any) {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        reloadTheTable()
        getDataRealm()
    }

    @IBAction func actionFirebase(_ sender: Any) {
        ref =  FIRDatabase.database().reference()
        
        getDataFirebase()
    }
    
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
        // Do any additional setup after loading the view, typically from a nib.
        //self.setupUI()
      // print(Realm.Configuration.defaultConfiguration.fileURL!)
        
       // reloadTheTable()
       // getDataRealm()
        
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
        for i in 1..<pageNum {
            idArray = []
            idImdb = []
            myGroup.enter()
            //     page = String(j)
            //     print(page)
            
            page = String(i)
            // print(page)
            
            request1 = "https://api.themoviedb.org/3/discover/movie?api_key=60ec9d5fa8ff0c39143aa6049c37291e&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page="+page+"&vote_average.gte=6&append_to_response=external_ids"
            
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
                // print(self.id)
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
            print(idImdb)
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
    func getDataFirebase(){
    
        //1130 pages
        for i in 1..<pageNum {
            idArray = []
            idImdb = []
            
            //     page = String(j)
            //     print(page)
            
            page = String(i)
            // print(page)
            
            request1 = "https://api.themoviedb.org/3/discover/movie?api_key=60ec9d5fa8ff0c39143aa6049c37291e&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page="+page+"&vote_average.gte=6&append_to_response=external_ids"
            
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
                // print(self.id)
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
            print(idImdb)
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
                    
                    
                    
                    
                    // 2
                    let filmItem = Movie(title: title ,year: year, released: released, runtime: runtime,genre: genre,
                                         language: language, country: country, poster: poster, metascore: metascore,
                                         imdbRating: imdbRating, imdbVotes: imdbVotes, type: type, tomatoMeter: tomatoMeter,
                                         tomatoRating: tomatoRating, tomatoReviews: tomatoReviews, tomatoFresh: tomatoFresh,
                                         tomatoRotten: tomatoRotten, tomatoConsensus: tomatoConsensus, tomatoUserMeter: tomatoUserMeter,
                                         tomatoUserRating: tomatoUserRating)
                    // 3
                    let filmItemRef = self.ref.child("results")
                    
                    let pageIdRef = filmItemRef.child("page"+page+"")
                    
                    let imdbRef = pageIdRef.child(idIMDB)
                    
                    // 4
                    imdbRef.setValue(filmItem.toAnyObject())
                    
                    self.items.append(filmItem)

                    
                   
                    
                }
            }
            //------------Alamofire 3--------------------------------------------------
            
        }
    }
    
    
    
}

