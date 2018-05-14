//
//  GitHubBasicLoginRequest.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/11.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation

struct GitHubLoginRequest: Request {
  typealias Response = UserProfile
  
  let path: String = "/user"
  let method: HTTPMethod = .post
  let parameter: [String : Any] = [:]
  var headers: [String : String]? = [:]
  let encoding: ParameterEncoding? = .json
}

extension GitHubLoginRequest {
  init?(username: String, password: String) {
    guard let encodedAuthentication = base64Encode(emailOrUsername: username, password: password) else {
      return nil
    }
    
    headers?["Authorization"] = "Basic \(encodedAuthentication)"
  }
}
