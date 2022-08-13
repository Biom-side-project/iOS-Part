import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func google(_ sender: UIButton) {
        let newvc = self.storyboard?.instantiateViewController(withIdentifier: "Tabbar")
        newvc?.modalPresentationStyle = .fullScreen
        newvc?.modalTransitionStyle = .crossDissolve
        self.present(newvc!, animated: true, completion: nil)
    }
    
}

