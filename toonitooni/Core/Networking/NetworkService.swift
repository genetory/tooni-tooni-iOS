//
//  NetworkService.swift
//  toonitooni
//
//  Created by buzz on 2021/05/10.
//

import Moya
import UIKit

protocol Networkable {
  associatedtype TooniRouter

  func request<T: Decodable>(
    to router: TooniRouter,
    decoder: T.Type,
    completion: @escaping (NetworkDataResponse) -> Void
  )
}

class TooniNetworkService: Networkable {

  private let provider: MoyaProvider<TooniRouter> = {
    let provider = MoyaProvider<TooniRouter>(
      endpointClosure: MoyaProvider.defaultEndpointMapping,
      requestClosure: MoyaProvider<TooniRouter>.defaultRequestMapping,
      stubClosure: MoyaProvider.neverStub,
      callbackQueue: nil,
      session: AlamofireSession.configuration,
      plugins: [],
      trackInflights: false
    )

    return provider
  }()

  func request<T: Decodable>(to router: TooniRouter, decoder: T.Type, completion: @escaping (NetworkDataResponse) -> Void) {

//    provider.request(router) { response in
//      switch response {
//      case let .success(result):
//      case let .failure(error):
//      }
//    }
  }
}
