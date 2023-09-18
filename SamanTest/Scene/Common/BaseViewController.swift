//
//  BaseViewController.swift
//  SamanTest
//
//  Created by Ashkan Ghaderi on 2022-02-17.
//

import UIKit
import Domain
import RxSwift

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var errorBinding: Binder<Error> {
        return Binder(self, binding: { (vc, error) in
            if let eError = error as? SamanError{
                self.showAlert(message: eError.localization)
            }
        })
    }
    
    public func showAlert(title: String = "Error", message: String, buttonTitle: String = "Ok") {
        let ac = UIAlertController(title: title,
                                    message: message,
                                    preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        self.present(ac, animated: true, completion: nil)
    }

}
