import UIKit
import GoogleSignIn
import SwiftJWT
import Alamofire
import CoreLocation


// MARK: - Welcome
struct Welcome: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let region: Region
}

// MARK: - Region
struct Region: Codable {
    let area1: Area
    let area2: Area
    let area3: Area
}

// MARK: - Area
struct Area: Codable {
    let name: String
    
}

struct Google: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let accessToken: String
}

var latitude = 0.0
var longitude = 0.0
var place = [String]()
var token = ""
var servertoken = ""

class ViewController: UIViewController, CLLocationManagerDelegate{

    let config = GIDConfiguration(clientID: "278092451086-e1ks4nnvq6p7bl79bqfnt66rgposucge.apps.googleusercontent.com")
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
   
        if CLLocationManager.locationServicesEnabled() {
            print("ON")
            locationManager.startUpdatingLocation()
        }
        else {
            print("OFF")
        }
        
        // MARK: - login 정보 남아있으면 자동 로그인
//        if GIDSignIn.sharedInstance.currentUser != nil {
//            DispatchQueue.main.async {
//                let newvc = self.storyboard?.instantiateViewController(withIdentifier: "Tabbar")
//                newvc?.modalPresentationStyle = .fullScreen
//                newvc?.modalTransitionStyle = .crossDissolve
//                self.present(newvc!, animated: true, completion: nil)
//            }
//        }
    }

    @IBAction func google(_ sender: UIButton) {
        self.GoogleLogin() { token in
            self.sendToken(token)
            let newvc = self.storyboard?.instantiateViewController(withIdentifier: "Tabbar")
            newvc?.modalPresentationStyle = .fullScreen
            newvc?.modalTransitionStyle = .crossDissolve
            self.present(newvc!, animated: true, completion: nil)
        }
    }
    
    // MARK: - Send authentication token to server
    func sendToken(_ token : String) {
        let url = "http://biom-backend.ap-northeast-2.elasticbeanstalk.com/api/v1/login/google"
        let query = ["accessToken": token]
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
            do {
                let data = try JSONDecoder().decode(Google.self, from: response.value!.data(using: .utf8)!)
                servertoken = data.data.accessToken
                print(place)
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: - Google login
    func GoogleLogin(completion : @escaping (String) -> ()) {
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user else { return }
            user.authentication.do { authentication, error in
                guard error == nil else { return }
                guard let authentication = authentication else { return }
                token = authentication.accessToken
                completion(token)
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            print("위도 ", location.coordinate.latitude)
            print("경도 ", location.coordinate.longitude)
            getplace()
        }
    }
    
    
    func getplace() {
        let url = "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc"
        var querystring = String(longitude)
        querystring += ","
        querystring += String(latitude)
        let query = ["request" : "coordsToaddr","coords" : querystring, "output" : "json"]
        var components = URLComponents()
        components.queryItems = query.map { URLQueryItem(name: $0, value: $1) }
        AF.request(url, parameters: query, headers: ["X-NCP-APIGW-API-KEY-ID" : "ztps04ekoq", "X-NCP-APIGW-API-KEY" : "5vSlPaWyrhiTBAkFWyvuZ6pTg545122hkhmf1C65"]).responseString { response in
            do {
                let data = try JSONDecoder().decode(Welcome.self, from: response.value!.data(using: .utf8)!)
                place.removeAll()
                place.append(data.results[0].region.area1.name)
                place.append(data.results[0].region.area2.name)
                place.append(data.results[0].region.area3.name)
                print(place)
            } catch {
                print(error)
            }
        }
    }
   
    
}

