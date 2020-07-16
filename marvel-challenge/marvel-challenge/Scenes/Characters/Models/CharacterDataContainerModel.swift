//
//  File.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 11/07/20.
//  Copyright © 2020 danilo. All rights reserved.
//

import Foundation

struct CharacterDataContainerModel: Decodable {
	let offset: Int?
	let limit: Int?
	let total: Int?
	let count: Int?
	let results: [CharacterModel]?
}
