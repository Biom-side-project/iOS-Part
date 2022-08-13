import UIKit
import GoogleSignIn

class ViewController: UIViewController {

    let config = GIDConfiguration(clientID: "278092451086-e1ks4nnvq6p7bl79bqfnt66rgposucge.apps.googleusercontent.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if GIDSignIn.sharedInstance.currentUser != nil {
            DispatchQueue.main.async {
                let newvc = self.storyboard?.instantiateViewController(withIdentifier: "Tabbar")
                newvc?.modalPresentationStyle = .fullScreen
                newvc?.modalTransitionStyle = .crossDissolve
                self.present(newvc!, animated: true, completion: nil)
            }
        }
        
    }

    @IBAction func google(_ sender: UIButton) {
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user else { return }

            user.authentication.do { authentication, error in
                guard error == nil else { return }
                guard let authentication = authentication else { return }

                let idToken = authentication.accessToken
                // Send ID token to backend (example below).
                print("token!!!!")
                print(idToken)
                let newvc = self.storyboard?.instantiateViewController(withIdentifier: "Tabbar")
                newvc?.modalPresentationStyle = .fullScreen
                newvc?.modalTransitionStyle = .crossDissolve
                self.present(newvc!, animated: true, completion: nil)
            }
        }
    }
}

