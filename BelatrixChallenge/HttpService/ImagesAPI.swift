//
//  ImagesAPI.swift
//  BelatrixChallenge
//
//  Created by Fer on 21/10/2019.
//  Copyright © 2019 Fer. All rights reserved.
//

import Foundation

typealias ImageClosure = (Data?) -> Void

protocol ImagesAPI {
    
    func fetchThumbnail(imageName:String, completion: @escaping ImageClosure) -> Void
    func fetchImage(imageName:String, completion: @escaping ImageClosure) -> Void
}
