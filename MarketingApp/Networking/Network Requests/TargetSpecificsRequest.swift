//
//  TargetSpecificsRequest.swift
//  MovieApp
//
//  Created by George Stratulat on 19.05.2024.
//

struct TargetSpecificsRequest: NetworkRequest {
    typealias ResponseModel = TargetSpecificsResponse
    
    var path: String {
        "/b/664a688fad19ca34f86c0cc4"
    }
        
    var method: HTTPMethod {
        .get
    }
    
    var httpHeaders: HTTPHeaders {
       return [
           "X-Master-Key": Constants.apiKey,
           "X-Access-Key": Constants.accessKey
       ]
   }
}

struct TargetSpecificsResponse: Codable {
    let record: [TargetingSpecifics]
}
