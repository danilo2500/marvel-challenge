//
//  File.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 11/07/20.
//  Copyright © 2020 danilo. All rights reserved.
//

import Foundation
struct CharacterModel: Decodable {
	let id: Int?
	let name: String?
	let description: String?
	let modified: String?
	let thumbnail: ThumbnailModel?
	let resourceURI: String?
	let comics: ComicsModel?
	let series: SeriesModel?
	let stories: StoriesModel?
	let events: EventsModel?
	let urls: [UrlsModel]?
}
