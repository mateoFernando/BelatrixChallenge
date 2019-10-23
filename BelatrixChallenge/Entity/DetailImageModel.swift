//
//  DetailImageClosure.swift
//  BelatrixChallenge
//
//  Created by Fer on 22/10/2019.
//  Copyright © 2019 Fer. All rights reserved.
//

struct DetailImageModel : Codable {
    let id : String?
    let url : String?
    let lang : String?
    let likes : String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case url
        case lang
        case likes
    }
}
