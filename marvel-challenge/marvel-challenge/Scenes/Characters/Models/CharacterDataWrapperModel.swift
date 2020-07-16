//
//  File.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 11/07/20.
//  Copyright © 2020 danilo. All rights reserved.
//

import Foundation

struct CharacterDataWrapperModel: Decodable {
	let code: Int?
	let status: String?
	let copyright: String?
	let attributionText: String?
	let attributionHTML: String?
	let etag: String?
	let data: CharacterDataContainerModel?
}
