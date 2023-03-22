//
//  Requstable.swift
//  PokeApp
//
//  Created by ertugrul.ozvardar on 20.03.2023.
//

import Foundation

protocol Requestable {
    var baseURL: String { get }
    var URLpath: String { get }
    func convertToURLRequest() -> URLRequest
}

extension Requestable {
    
    var baseURL: String {
        return "https://pokeapi.co"
    }
    
    func convertToURLRequest() -> URLRequest {
        var request = URLRequest(url: URL(string: URLpath)!)
        request.httpMethod = getHttpMethod(httpMethod: .get)
        return request
    }
}
