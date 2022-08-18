import UIKit
import GoogleSignIn
import SwiftJWT
import Alamofire

class ViewController: UIViewController {

    let config = GIDConfiguration(clientID: "278092451086-e1ks4nnvq6p7bl79bqfnt66rgposucge.apps.googleusercontent.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - login 정보 남아있으면 자동 로그인
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
        // MARK: - Google login
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user else { return }
            user.authentication.do { authentication, error in
                guard error == nil else { return }
                guard let authentication = authentication else { return }
                let token = authentication.accessToken
                
                // MARK: - Send accesToken to server
                let url = "http://logintest02-env.eba-r2vdfqkp.ap-northeast-2.elasticbeanstalk.com/api/v1/token-test"
                let query = ["token": token]
                var components = URLComponents()
                components.queryItems = query.map { URLQueryItem(name: $0, value: $1) }
                AF.request(url, parameters: query, headers:  nil).responseString { response in
                    print(response)
                }
                
                let newvc = self.storyboard?.instantiateViewController(withIdentifier: "Tabbar")
                newvc?.modalPresentationStyle = .fullScreen
                newvc?.modalTransitionStyle = .crossDissolve
                self.present(newvc!, animated: true, completion: nil)
            }
        }
    }
}
