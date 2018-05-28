//
//  GitHubLoginInteractor.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/10.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation
import RxSwift

protocol GitHubLoginInteractorProtocol {
  func login(withEmailOrUsername: String, password: String)
  func loginViaOAuth()
  func clearLoginInfo()
}

class GitHubLoginInteractor: GitHubLoginInteractorProtocol {
  private let client: RxClient
  private let localStorage: LocalStorage
  private let presenter: GitHubLoginPresenterProtocol
  private let keychainAccessor: KeychainAccessorProtocol
  private let disposeBag: DisposeBag = DisposeBag()
  
  init(client: RxClient, localStorage: LocalStorage, keychainAccessor: KeychainAccessorProtocol, presenter: GitHubLoginPresenterProtocol) {
    self.client = client
    self.localStorage = localStorage
    self.keychainAccessor = keychainAccessor
    self.presenter = presenter
  }
  
  func login(withEmailOrUsername emailOrUsername: String, password: String) {
    guard let request = GitHubLoginRequest(username: emailOrUsername, password: password) else {
      return
    }
    
    client.send(request).observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] response in
        self?.clearLoginInfo()
        self?.presenter.dismissLoginView()
        self?.localStorage.save(object: response, mapper: UserMapper())
        self?.keychainAccessor.savePassword(password, into: emailOrUsername)
      }, onError: { error in
        print("GitHub Login failed: \(error)")
      }).disposed(by: disposeBag)
  }
  
  func clearLoginInfo() {
    localStorage.deleteAllObjects(for: UserMapper().entityName)
    keychainAccessor.clearAccount()
  }
  
  func loginViaOAuth() {
    fatalError("GitHubLoginInteractorProtocol.LoginViaOAuth not implemented yet!")
  }
}
