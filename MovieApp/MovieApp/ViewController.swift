//
//  ViewController.swift
//  MovieApp
//
//  Created by Third Eye InfoTech on 03/03/19.
//  Copyright © 2019 Third Eye InfoTech. All rights reserved.
//

import UIKit
import Alamofire

let strBaseUrl = "https://api.themoviedb.org/3/"
let imagebaseURL = "https://image.tmdb.org/t/p/w500"
let API_Key = "14bc774791d9d20b3a138bb6e26e2579"

struct MovieList {
    let title: String!
    let overView: String!
    let ID:String!
    let releaseDate:String!
    let posterPath:String!
}



struct APIName {
    static let DiscoverMovie = "discover/movie"
    static let MovieDetails = "movie/"
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tblMovie: UITableView!
    
    var arrMovies:[MovieList] = []
    
    var currentPage = 1
    var totalPage = 1
    let network: NetworkManager = NetworkManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.isUnreachable { _ in
            //Fetch from DB
            self.GetOfflineMovieList()
           
        }
        
        NetworkManager.isReachable { _ in
            self.GetMovieList { (movieData) in
//                for movieDetail:MovieList in movieData
//                {
//                    
//                }
                
                self.arrMovies = movieData
                self.tblMovie.reloadData()
            }
        }
        
       
        
    }

    func GetOfflineMovieList()
    {
        FMDBAccessor.sharedInstance.methodToSelectData("SELECT * FROM discovermovie", completion: { (aryDB) in
            if(aryDB.count == 0)
            {
                self.network.reachability.whenReachable = { reachability in
                    self.GetMovieList { (movieData) in
                        
                    }
                }
            }
            else{
                var list = [MovieList]()
                
                for child in 0...aryDB.count-1 {
                    let post = aryDB[child] as! [String: AnyObject]
                    
                    let title:String = post["title"] as? String ?? ""
                    let overView:String = post["overview"] as? String ?? ""
                    let ID:String = String(post["id"] as? Int ?? 0)
                    let releaseDate:String = post["release_date"] as? String ?? ""
                    let posterPath:String = post["poster_path"] as? String ?? ""
                    
                    list.append(MovieList(
                        title: title,
                        overView: overView,
                        ID:ID,
                        releaseDate:releaseDate,
                        posterPath:posterPath
                    ))
                }
                
                self.arrMovies = list
                self.tblMovie.reloadData()
            }
        })
    }
    
    func GetMovieList(completion: @escaping (_ posts: [MovieList]) -> Void) -> Void
    {
        let API_LIST = "\(strBaseUrl)\(APIName.DiscoverMovie)?api_key=\(API_Key)&page=\(currentPage)"
        
        Alamofire.request(API_LIST).validate().responseJSON { response in
            switch response.result {
            case .success(let JSON):
                let data = JSON as! [String:AnyObject]
                
                guard let children = data["results"]! as? [AnyObject] else { return }
                self.totalPage = data["total_pages"] as! Int
                var list = [MovieList]()
                
                for child in 0...children.count-1 {
                    let post = children[child] as! [String: AnyObject]
                    
                    let title:String = post["title"] as? String ?? ""
                    let overView:String = post["overview"] as? String ?? ""
                    let ID:String = String(post["id"] as? Int ?? 0)
                    let releaseDate:String = post["release_date"] as? String ?? ""
                    let posterPath:String = post["poster_path"] as? String ?? ""
                    
                    list.append(MovieList(
                        title: title,
                        overView: overView,
                        ID:ID,
                        releaseDate:releaseDate,
                        posterPath:posterPath
                    ))
                    
                    FMDBAccessor.sharedInstance.methodToInsertUpdateDeleteData("INSERT or REPLACE INTO `discovermovie`(`id`,`title`,`poster_path`,`original_title`,`backdrop_path`,`overview`,`release_date`) VALUES ('\(ID)','\(title)','\(posterPath)','\(title)','\(posterPath)','\(overView)','\(releaseDate)')", completion: { (status) in
                    })
                    
                }
            
                
                DispatchQueue.main.async {
                    completion(list)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let movieCell:MovieListCell = (tblMovie.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieListCell)!
        
        movieCell.configureCell(movieInfo: arrMovies[indexPath.row])
        
        return movieCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movieDetail:MovieDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailVC
        
        let movieInfo:MovieList = arrMovies[indexPath.row]
        
        movieDetail.movieID = movieInfo.ID
        
        self.navigationController?.pushViewController(movieDetail, animated: true)
        
    }
}

