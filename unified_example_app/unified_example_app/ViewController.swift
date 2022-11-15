//
//  ViewController.swift
//  unified_example_app
//
//  Created by Pavel on 21.10.22.
//  Copyright © 2022 IDnow Gmbh. All rights reserved.
//

import UIKit
import IDnowUnifiedSDK

class ViewController: UIViewController {

    var sdk: IDNUnifiedSDK?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBOutlet weak var textfield: UITextField!
    
    @IBAction func startAction(_ sender: Any) {
        startIdentification(token: textfield.text ?? "")
    }
    
    //    @IBOutlet weak var image: UIImageView!
    
    
    func startIdentification(token: String) {
        sdk = IDNUnifiedSDK()
        IDNUAppearance.shared.storeDefaults()
        IDNUAppearance.shared.brandLogo = UIImage(named: "idn-new-logo")
        IDNUAppearance.shared.cancelButtonImage = UIImage(named: "idn-close-icon")
        IDNUAppearance.shared.mode = .light

        IDNUSettings.shared.enableDarkMode = false
        sdk?.startIdentification(controller: self, token: token) {[unowned self] result in
            IDNUAppearance.shared.dropToDefault()
            IDNUAppearance.shared.brandLogo = UIImage(named: "idn-new-logo")
            IDNUAppearance.shared.cancelButtonImage = UIImage(named: "idn-close-icon")
            IDNUAppearance.shared.mode = .light
            switch result {
            case .success(let bool):
                //handle an identification success
                break
            case .failure(let error):
                //handle the error
                
                //for example show an alerts
                switch error {
                case .canceledByUser: break
                case .unknown(let description), .precheckFailed(let description):
                    self.showAlert(message: description?.localizedDescription ?? error.localizedDescription)
                case .wrongTokenFormat, .identFinished, .returnedDataWrongFormat:
                    self.showAlert(message: error.localizedDescription)
                }
            }
        }
    }
    
    private func showAlert(_ title: String? = nil, message: String) {
        let titleString = title ?? "Error"
        let alertController = UIAlertController(title: titleString, message: message, preferredStyle: .alert)
       
       alertController.addAction(UIAlertAction(title: "Ok",
                                               style: .cancel,
                                               handler: { _ in
       }))

        navigationController?.present(alertController, animated: true, completion: nil)
    }
}
