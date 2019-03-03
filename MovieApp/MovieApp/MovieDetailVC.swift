//
//  MovieDetailVC.swift
//  MovieApp
//
//  Created by Third Eye InfoTech on 03/03/19.
//  Copyright © 2019 Third Eye InfoTech. All rights reserved.
//

import UIKit
import Alamofire

class MovieDetailVC: UIViewController {

    public var movieID = ""
    
    let network: NetworkManager = NetworkManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkManager.isUnreachable { _ in
            //Fetch from DB
            self.GetMovieDetailFromLocal()
        }
        
        NetworkManager.isReachable { _ in
            self.getMovieDetail()
        }
        
    }
    
    func getMovieDetail()
    {
        
        let API_DETAIL = "\(strBaseUrl)\(APIName.MovieDetails)\(movieID)?api_key=\(API_Key)"
        
        Alamofire.request(API_DETAIL).validate().responseJSON { response in
            switch response.result {
            case .success(let JSON):
                let dataa = JSON as! [String:AnyObject]
                var objModelClass:Modal_Movie_Details?
                do {
                    objModelClass = try JSONDecoder().decode(Modal_Movie_Details!.self,from: response.data!)
                    
                }catch let error{ //If model class parsing fail
                    print(error.localizedDescription)
                    
                }
                
                guard let children = dataa["results"]! as? [AnyObject] else { return }
//                self.totalPage = data["total_pages"] as! Int
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
                    
//                    FMDBAccessor.sharedInstance.methodToInsertUpdateDeleteData("INSERT or REPLACE INTO `discovermovie`(`id`,`title`,`poster_path`,`original_title`,`backdrop_path`,`overview`,`release_date`) VALUES ('\(ID)','\(title)','\(posterPath)','\(title)','\(posterPath)','\(overView)','\(releaseDate)')", completion: { (status) in
//                    })
                    
                }
                
                
//                DispatchQueue.main.async {
//                    completion(list)
//                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    

    //mvvm
    //iox swift
//    mvc
    //instruments

    func GetMovieDetailFromLocal()
    {
        FMDBAccessor.sharedInstance.methodToSelectData("SELECT * FROM MovieDetails WHERE id = '\(self.movieID)'", completion: { (aryDataFromDB) in
            if aryDataFromDB.count > 0{
                self.setupDataWithDict(dictInfo: aryDataFromDB.firstObject as! NSDictionary)
                
            }else{
//                self.scrMain.isHidden = true
                self.network.reachability.whenReachable = { reachability in
                       self.getMovieDetail()
                }
            }
        })
    }
    
    func setupData(objModal_Movie_Details : Modal_Movie_Details)  {
        
//        ivBackgroundPoster?.sd_setImage(with: URL(string:  imagebaseURL + (objModal_Movie_Details.backdrop_path ?? "")), completed: nil)
//        ivPoster?.sd_setImage(with: URL(string:  imagebaseURL + (objModal_Movie_Details.poster_path ?? "")), completed: nil)
//        lblMovieTitle.text = objModal_Movie_Details.title
//        lblTagLine.text = objModal_Movie_Details.tagline
//        lblOverview.text = objModal_Movie_Details.overview
//        lblGenres.text = objModal_Movie_Details.genres?.compactMap{$0.name}.joined(separator: ",")
//        lblDuration.text = String(objModal_Movie_Details.runtime ?? 0) + " Minutes"
//        lblReleaseDAte.text = objModal_Movie_Details.release_date
//        lblProductionCompanies.text = objModal_Movie_Details.production_companies?.compactMap{$0.name}.joined(separator: ",")
//        lblProductionBudget.text = String(objModal_Movie_Details.budget ?? 0).StringToCurrency
//        lblRevenue.text = String(objModal_Movie_Details.revenue ?? 0).StringToCurrency
//        lblLanguages.text = objModal_Movie_Details.spoken_languages?.compactMap{$0.name}.joined(separator: ",")
        
        
        let id = "\(objModal_Movie_Details.id!)"
        let title = objModal_Movie_Details.title!
        let poster_path = objModal_Movie_Details.poster_path!
        let backdrop_path = objModal_Movie_Details.backdrop_path!
        let overview = objModal_Movie_Details.overview!
        let release_date = objModal_Movie_Details.release_date!
        let tagline = objModal_Movie_Details.tagline!
        let genres = ""//lblGenres.text!
        let runtime = ""//lblDuration.text!
        let production_companies = ""//lblProductionCompanies.text!
        let budget = ""//lblProductionBudget.text!
        let revenue = ""//lblRevenue.text!
        let spoken_languages = ""//lblLanguages.text!
        
        FMDBAccessor.sharedInstance.methodToInsertUpdateDeleteData("INSERT or REPLACE INTO `MovieDetails`(`id`,`title`,`poster_path`,`backdrop_path`,`overview`,`release_date`,`tagline`,`genres`,`runtime`,`production_companies`,`budget`,`revenue`,`spoken_languages`) VALUES ('\(id)','\(title)','\(poster_path)','\(backdrop_path)','\(overview)','\(release_date)','\(tagline)','\(genres)','\(runtime)','\(production_companies)','\(budget)','\(revenue)','\(spoken_languages)')", completion: { (status) in
        })
    }
    
    func setupDataWithDict(dictInfo : NSDictionary)  {
        
//        ivBackgroundPoster?.sd_setImage(with: URL(string:  imagebaseURL + (dictInfo.value(forKey: "backdrop_path") as? String ?? "")), completed: nil)
//        ivPoster?.sd_setImage(with: URL(string:  imagebaseURL + (dictInfo.value(forKey: "poster_path") as? String ?? "")), completed: nil)
//        lblMovieTitle.text = (dictInfo.value(forKey: "title") as? String ?? "")
//        lblTagLine.text = (dictInfo.value(forKey: "tagline") as? String ?? "")
//        lblOverview.text = (dictInfo.value(forKey: "overview") as? String ?? "")
//        lblGenres.text = (dictInfo.value(forKey: "genres") as? String ?? "")
//        lblDuration.text = dictInfo.value(forKey: "runtime") as? String ?? ""
//        lblReleaseDAte.text = dictInfo.value(forKey: "release_date") as? String ?? ""
//        lblProductionCompanies.text = dictInfo.value(forKey: "production_companies") as? String ?? ""
//        lblProductionBudget.text = dictInfo.value(forKey: "budget") as? String ?? ""
//        lblRevenue.text = dictInfo.value(forKey: "revenue") as? String ?? ""
//        lblLanguages.text = dictInfo.value(forKey: "spoken_languages") as? String ?? ""
    }
    
}
