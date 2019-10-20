//
//  HttpService.swift
//  BelatrixChallenge
//
//  Created by Fer on 20/10/2019.
//  Copyright © 2019 Fer. All rights reserved.
//

import Alamofire

protocol HttpService {
    
    var sessionManager : SessionManager { get set }
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest
}
