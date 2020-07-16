//
//  File.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 11/07/20.
//  Copyright © 2020 danilo. All rights reserved.
//

import Foundation

struct ComicsModel: Decodable {
	let available: Int?
	let collectionURI: String?
	let items: [ComicSummaryModel]?
	let returned: Int?
}
