# Idnow Platform SDK iOS


## Requirements:
- Xcode 14.0+
- Deployment Target: iOS 11.0 or later Device with Wifi / 3G / LTE




## Installation



## Manually

- drag and drop to your project SDKs provided by IDnow:

        IDnowUnifiedSDK.xcframework
        idnow_vi.xcframework
        idnow_eid.xcframework 
        AuthadaAuthenticationLibrary.xcframework
        IDNowSDKCore.xcframework 
        ReadID_UI.xcframework
        ReadID.xcframework
        XS2AiOSNetService.xcframework
        FaceTecSDK.xcframework:

    make sure they are "embed and sign"


- add to your project info descriptions for:
    Privacy - NFC Scan Usage Description 
    Privacy - Microphone Usage Description
    Privacy - Camera Usage Description


- add Near Field Communication Tag Reading as a capability. In the entitlements file, check if there is an array for the key Near Field Communication Tag Reader Session Format, make sure the array contains the entry NFC tag-specific data protocol

- update the Info.plis file: -- Add an array with the key com.apple.developer.nfc.readersession.iso7816.select-identifiers / ISO7816 application identifiers for NFC Tag Reader Session. Then add 2 items to the array: E80704007F00070302, A0000002471001. 


### implementation example:

```swift

import IDnowUnifiedSDK



    func startIdentification(token: String) {
        sdk = IDNUnifiedSDK()
        IDNUAppearance.shared.storeDefaults()
        IDNUAppearance.shared.brandLogo = UIImage(named: "logo")
        IDNUAppearance.shared.cancelButtonImage = UIImage(named: "icon")
        IDNUAppearance.shared.mode = .light

        IDNUSettings.shared.enableDarkMode = false
        sdk?.startIdentification(controller: self, token: token) {[unowned self] result in
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
```



## Branding

- some customization allowed via customer config(please reach out to your support team)

- for more customization use IDNUAppearance to customise colours and fonts within Unified SDK along with Video Ident and Electronic Ident identifications.



## Settings

- use IDNUSettings to set some available configurations.
