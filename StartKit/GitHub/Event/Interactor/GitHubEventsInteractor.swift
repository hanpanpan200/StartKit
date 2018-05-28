//
//  GitHubEventsInteractor.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/14.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation
import RxSwift

protocol GitHubEventsInteractorProtocol {
  func loadEvents()
}

class GitHubEventsInteractor: GitHubEventsInteractorProtocol {
  private let presenter: GitHubEventsPresenterProtocol
  private let localStorage: LocalStorage
  private let keychainAccessor: KeychainAccessor
  private let client: RxClient
  private let disposeBag: DisposeBag = DisposeBag()
  
  init(presenter: GitHubEventsPresenterProtocol, client: RxClient, localStorage: LocalStorage, keychainAccessor: KeychainAccessor) {
    self.presenter = presenter
    self.localStorage = localStorage
    self.client = client
    self.keychainAccessor = keychainAccessor
  }
  
  func loadEvents() {
    localStorage.queryOne(withMapper: UserMapper())
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] userProfile in
        
        guard let strongSelf = self,
          let username = userProfile?.login,
          let password = strongSelf.keychainAccessor.currentAccount()?.password else {
            self?.presenter.configureEventList(with: [])
            return
        }

        let request = GitHubEventsRequest(username: username, password: password)
        strongSelf.client.send(request).observeOn(MainScheduler.instance)
          .subscribe(onNext: { [weak self] events in
            self?.presenter.configureEventList(with: events)
            }, onError: { error in
              print("RxClient fetching events failed: \(error)")
          }).disposed(by: strongSelf.disposeBag)

        }, onError: { error in
          print("CoreData fetch userProfile failed: \(error)")
      }).disposed(by: disposeBag)
  }
}
