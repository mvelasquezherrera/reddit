//
//  PostRequest.swift
//  Data
//
//  Created by Marcelo Stefano Velasquez Herrera on 14/04/22.
//

import Foundation
import Alamofire

var headerDefault: HTTPHeaders = [
    "Content-Type" : "application/json",
    "Accept" : "application/json"
]

internal struct ListPostRequestObject: RequestObject {
    var path: String = "new/.json?limit=100&link_flair_text=Shitposting&post_hint=image"
    var method: HTTPMethod = .get
    var headers: HTTPHeaders
    var encoding: JSONEncoding = .default
    var parameters: Parameters = [:]

    init() {
        headers = headerDefault
    }
}

internal struct FilterListPostRequestObject: RequestObject {
    var path: String = "search.json?q="
    var method: HTTPMethod = .get
    var headers: HTTPHeaders
    var encoding: JSONEncoding = .default
    var parameters: Parameters = [:]

    init(searchText: String) {
        path.append("\(searchText)&limit=100")
        headers = headerDefault
    }
}
