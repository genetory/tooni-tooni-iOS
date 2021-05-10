//
//  NetworkDataResponse.swift
//  toonitooni
//
//  Created by buzz on 2021/05/10.
//

import Foundation

enum NetworkResult {
  case success,
  failure
}

struct NetworkDataResponse {
  let json: Decodable?
  let result: NetworkResult
  let error: NetworkError?
}
