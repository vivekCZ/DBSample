/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Modal_Movie_Details : Codable {
	let adult : Bool?
	let backdrop_path : String?
	let budget : Int?
	let genres : [Genres]?
	let homepage : String?
	let id : Int?
	let imdb_id : String?
	let original_language : String?
	let original_title : String?
	let overview : String?
	let popularity : Double?
	let poster_path : String?
	let production_companies : [Production_companies]?
	let production_countries : [Production_countries]?
	let release_date : String?
	let revenue : Int?
	let runtime : Int?
	let spoken_languages : [Spoken_languages]?
	let status : String?
	let tagline : String?
	let title : String?
	let video : Bool?
	let vote_average : Double?
	let vote_count : Int?

	enum CodingKeys: String, CodingKey {

		case adult = "adult"
		case backdrop_path = "backdrop_path"
		case budget = "budget"
		case genres = "genres"
		case homepage = "homepage"
		case id = "id"
		case imdb_id = "imdb_id"
		case original_language = "original_language"
		case original_title = "original_title"
		case overview = "overview"
		case popularity = "popularity"
		case poster_path = "poster_path"
		case production_companies = "production_companies"
		case production_countries = "production_countries"
		case release_date = "release_date"
		case revenue = "revenue"
		case runtime = "runtime"
		case spoken_languages = "spoken_languages"
		case status = "status"
		case tagline = "tagline"
		case title = "title"
		case video = "video"
		case vote_average = "vote_average"
		case vote_count = "vote_count"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
		backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
		budget = try values.decodeIfPresent(Int.self, forKey: .budget)
		genres = try values.decodeIfPresent([Genres].self, forKey: .genres)
		homepage = try values.decodeIfPresent(String.self, forKey: .homepage)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		imdb_id = try values.decodeIfPresent(String.self, forKey: .imdb_id)
		original_language = try values.decodeIfPresent(String.self, forKey: .original_language)
		original_title = try values.decodeIfPresent(String.self, forKey: .original_title)
		overview = try values.decodeIfPresent(String.self, forKey: .overview)
		popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
		poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
		production_companies = try values.decodeIfPresent([Production_companies].self, forKey: .production_companies)
		production_countries = try values.decodeIfPresent([Production_countries].self, forKey: .production_countries)
		release_date = try values.decodeIfPresent(String.self, forKey: .release_date)
		revenue = try values.decodeIfPresent(Int.self, forKey: .revenue)
		runtime = try values.decodeIfPresent(Int.self, forKey: .runtime)
		spoken_languages = try values.decodeIfPresent([Spoken_languages].self, forKey: .spoken_languages)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		tagline = try values.decodeIfPresent(String.self, forKey: .tagline)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		video = try values.decodeIfPresent(Bool.self, forKey: .video)
		vote_average = try values.decodeIfPresent(Double.self, forKey: .vote_average)
		vote_count = try values.decodeIfPresent(Int.self, forKey: .vote_count)
	}
}
