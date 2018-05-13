//
//  ViewController.swift
//  StartKit
//
//  Created by XueliangZhu on 9/24/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let viewController = HomeViewController()
    viewController.willMove(toParentViewController: self)
    addChildViewController(viewController)
    view.addSubview(viewController.view)
    viewController.didMove(toParentViewController: self)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    showLoginViewController()
  }
  
  func showLoginViewController() {
    guard let viewController = UIStoryboard(name: "GitHubLogin", bundle: nil).instantiateViewController(withIdentifier: "GitHubLoginViewController") as? GitHubLoginViewController else {
      return
    }
    GitHubLoginConfiguration.configure(viewController: viewController)
    
    present(viewController, animated: false, completion: nil)
  }
}
