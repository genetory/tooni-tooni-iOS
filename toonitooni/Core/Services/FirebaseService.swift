//
//  FirebaseService.swift
//  toonitooni
//
//  Created by buzz on 2021/05/15.
//

import Foundation
import Firebase

class FirebaseService {

  static let shared = FirebaseService()

  func configure() {
    FirebaseApp.configure()
  }
}
