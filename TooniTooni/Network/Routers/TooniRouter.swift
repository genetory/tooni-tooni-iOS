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
  case weekWebtoon(String)
}

extension TooniRouter: TargetType {
  var baseURL: URL {
    return URL(string: "https://webtoon.chandol.net")!
  }

  var path: String {
    switch self {
    case let .weekWebtoon(day):
      return "/weekday/\(day)"
    }
  }

  var method: Alamofire.HTTPMethod {
    switch self {
    case .weekWebtoon:
      return .get
    }
  }

  var sampleData: Data {
    return "".data(using: .utf8)!
  }

  var task: Task {
    switch self {
    case .weekWebtoon:
      return .requestPlain
    }
  }

  var headers: [String : String]? {
    return nil
  }
}
