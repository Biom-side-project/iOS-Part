import UIKit
import GoogleSignIn
import Alamofire

var code = ""

class MainViewController: UIViewController {

    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var topLogo: UILabel!
    @IBOutlet weak var userLogo: UIImageView!
    @IBOutlet var region: UILabel!
    @IBOutlet var percentView: UIStackView!
    @IBOutlet var buttonView: UIStackView!
    @IBOutlet var biompercent: UILabel!
    var VM = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VM.getregioncode()
        // 초기값이 DB에 없는 듯!!!!
//        VM.getpercent() { per in
//            print("d")
//            print(per)
//            DispatchQueue.main.async {
//                self.biompercent.text = String(per*100) + "%"
//            }
//        }
        region.text = place[0] + place[1] + place[2]
        percentView.layer.cornerRadius = 15
        percentView.layer.borderWidth = 1
        percentView.layer.masksToBounds = true
        buttonView.layer.cornerRadius = 15
        buttonView.layer.borderWidth = 1
        buttonView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }

    @IBAction func Biom(_ sender: UIButton) {
        VM.BIOM() { result in
            if result == 1 {
                self.VM.getpercent() { per in
                    DispatchQueue.main.async {
                        self.biompercent.text = String(per*100) + "%"
                    }
                }
            }
        }
    }
    
    @IBAction func Anom(_ sender: UIButton) {
        VM.BIOM() { result in
            if result == 1 {
                self.VM.getpercent() { per in
                    DispatchQueue.main.async {
                        self.biompercent.text = String(per*100) + "%"
                    }
                }
            }
        }
    }
    
}
