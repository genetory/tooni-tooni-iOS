//
//  TooniRouter.swift
//  toonitooni
//
//  Created by buzz on 2021/05/10.
//

import UIKit
import Moya
import Alamofire

enum TooniRouter {
  case esports
}

extension TooniRouter: TargetType {
  var baseURL: URL {
    return URL(string: "http://imgenetory.com")!
  }

  var path: String {
    switch self {
    case .esports:
      return "/esports/leagues.json"
    }
  }

  var method: Alamofire.HTTPMethod {
    switch self {
    case .esports:
      return .get
    }
  }

  var sampleData: Data {
    return "".data(using: .utf8)!
  }

  var task: Task {
    switch self {
    case .esports:
//      return .requestParameters(parameters: <#T##[String : Any]#>, encoding: <#T##ParameterEncoding#>)
      return .requestPlain
    }
  }

  var headers: [String : String]? {
    return nil
  }
}
