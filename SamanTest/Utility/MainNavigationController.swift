//
//  MainNavigationController.swift
//  SamanTest
//
//  Created by Ashkan Ghaderi on 2022-02-16.
//

import UIKit

class MainNavigationController: UINavigationController {
  //MARK: - Initialization
  
  init() {
    super.init(rootViewController: UIViewController())
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  override init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)
  }
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setNavigationBarHidden(false, animated: false)
  }
}

