import Foundation
import Alamofire

class MainViewModel: ObservableObject {
    
    init(){
        print("VM init")
    }
}

extension MainViewModel {
    
    // MARK: - BIOM
    func BIOM(completion: @escaping (Int)->()) {
        let url = "http://biomdev-env.ap-northeast-2.elasticbeanstalk.com/api/v1/biom/biom"
        let query = ["regionCode": code]
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer "+servertoken, forHTTPHeaderField: "Authorization")
        request.setValue("en", forHTTPHeaderField: "Accept-Language")
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: query, options: [])
        } catch {
            print("http Body Error")
        }
        AF.request(request).responseString { response in
            do {
                let data = try JSONDecoder().decode(message.self, from: response.value!.data(using: .utf8)!)
                if String(data.message) == "successfully marked biom." {
                    completion(1)
                }
                else {
                    print("조금만 기다리세요")
                    completion(0)
                }
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: - ANOM
    func ANOM(completion: @escaping (Int)->()) {
        let url = "http://biomdev-env.ap-northeast-2.elasticbeanstalk.com/api/v1/biom/anom"
        let query = ["regionCode": code]
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer "+servertoken, forHTTPHeaderField: "Authorization")
        request.setValue("en", forHTTPHeaderField: "Accept-Language")
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: query, options: [])
        } catch {
            print("http Body Error")
        }
        AF.request(request).responseString { response in
            do {
                let data = try JSONDecoder().decode(message.self, from: response.value!.data(using: .utf8)!)
                if String(data.message) == "successfully marked anom." {
                    completion(1)
                }
                else {
                    print("조금만 기다리세요")
                    completion(0)
                }
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: - get percent
    func getpercent(completion: @escaping (Double)->()) {
        let url = "http://biomdev-env.ap-northeast-2.elasticbeanstalk.com/api/v1/biom/proportion"
        let query = ["regionCode" : code]
        var components = URLComponents()
        components.queryItems = query.map { URLQueryItem(name: $0, value: $1) }
        AF.request(url, parameters: query, headers: ["Authorization" : "Bearer "+servertoken]).responseString { response in
            do {
                let data = try JSONDecoder().decode(percent.self, from: response.value!.data(using: .utf8)!)
                completion(data.data.biomProportion)
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: - get regioncode
    func getregioncode() {
        let url = "http://biomdev-env.ap-northeast-2.elasticbeanstalk.com/api/v1/region/region-code"
        let sido = place[0]
        let sigungu = place[1]
        let eupmyeongdong = place[2]
        let query = ["sido": sido, "sigungu" : sigungu, "eupmyeondong" : eupmyeongdong]
        var components = URLComponents()
        components.queryItems = query.map { URLQueryItem(name: $0, value: $1) }
        AF.request(url, parameters: query, headers: ["Authorization" : "Bearer "+servertoken, "Accept-Language" : "en"]).validate().responseString { response in
            do {
                let data = try JSONDecoder().decode(regionClass.self, from: response.value!.data(using: .utf8)!)
                code = String(data.data.regionCode)
            } catch {
                print(error)
            }
        }
    }
}
