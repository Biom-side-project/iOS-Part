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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        region.text = place[0] + place[1] + place[2]
        percentView.layer.cornerRadius = 15
        percentView.layer.borderWidth = 1
        percentView.layer.masksToBounds = true
        buttonView.layer.cornerRadius = 15
        buttonView.layer.borderWidth = 1
        buttonView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    // MARK: - BIOM
    func BIOM() {
        let url = "http://biom-backend.ap-northeast-2.elasticbeanstalk.com/api/v1/biom/biom"
        let query = ["regionCode": "4111113200"]
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer "+servertoken, forHTTPHeaderField: "Authorization")
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: query, options: [])
        } catch {
            print("http Body Error")
        }
        AF.request(request).responseString { response in
            print("test")
            print(response)
            do {
                print("check")
            } catch {
                print(error)
            }
        }
    }
    //4111113200
    @IBAction func Biom(_ sender: UIButton) {
        BIOM()
    }
    
    func getregion() {
        let url = "http://biom-backend.ap-northeast-2.elasticbeanstalk.com/api/v1/region/region-code"
        let query = ["sido": place[0], "sigungu" : place[1], "eupmyeondong" : place[2]]
        var components = URLComponents()
        components.queryItems = query.map { URLQueryItem(name: $0, value: $1) }
        AF.request(url, parameters: query, headers: ["Authorization" : "Bearer "+servertoken]).responseJSON { response in
            do {
                let value =  String(data: response.data!, encoding: .utf8)
                code = value!
            } catch {
                print(error)
            }
        }
    }
    
    @IBAction func Anom(_ sender: UIButton) {
        let url = "http://biom-backend.ap-northeast-2.elasticbeanstalk.com/api/v1/login/naver"
        let query = ["location": place]
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: query, options: [])
        } catch {
            print("http Body Error")
        }
        AF.request(request).responseString { response in
            let value =  String(data: response.data!, encoding: .utf8)
            print(value)
        }
    }
    
   
}
