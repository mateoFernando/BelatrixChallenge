//
//  ImageInteractor.swift
//  BelatrixChallenge
//
//  Created by Fer on 21/10/2019.
//  Copyright © 2019 Fer. All rights reserved.
//

final class ImageInteractor  {
    
    let service : ImagesAPI
    
    init(service: ImagesAPI ) {
        self.service = service
    }
}

extension ImageInteractor {
    
    func fetchThumbnail(imageName:String, completion: @escaping ImageClosure) -> Void {
        self.service.fetchThumbnail(imageName: imageName, completion: completion)
    }
    func fetchImage(imageName:String, completion: @escaping ImageClosure) -> Void {
        self.service.fetchImage(imageName: imageName, completion: completion)
    }
}

