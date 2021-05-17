//
//  FirebaseService+Auth.swift
//  toonitooni
//
//  Created by buzz on 2021/05/15.
//

import Foundation
import FirebaseAuth

extension FirebaseService {

  func signInAnonymously(completion: @escaping (User) -> Void) {
    Auth.auth().signInAnonymously { result, error in
      if let error = error {
        debug(error)
        return
      }

      guard let user = result?.user else { return }
      completion(user)
    }
  }
}
