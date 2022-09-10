import UIKit
import GoogleSignIn

class MapViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logout(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signOut()
        self.dismiss(animated: true, completion: nil)
    }
}
