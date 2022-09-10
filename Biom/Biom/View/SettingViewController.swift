import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var SettingTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SettingTable.delegate = self
        SettingTable.dataSource = self
        SettingTable.sectionHeaderTopPadding = 20
    }
    
    
    let myinfo = ["계정", "닉네임", "횟수", "로그아웃"]
    let setting = ["자동 새로고침", "지도 설정"]
    let more = ["위치서비스", "개인정보", "통계", "버전"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0 :
            return "내 정보"
        case 1 :
            return "설정"
        case 2 :
            return "더 보기"
        default :
            return ""
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return 4
        case 1 :
            return 2
        case 2 :
            return 4
        default :
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingTable.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell
        
        if indexPath.section == 0 {
            cell.label.text = myinfo[indexPath.row]
        }
        else if indexPath.section == 1 {
            cell.label.text = setting[indexPath.row]
        }
        else if indexPath.section == 2 {
            cell.label.text = more[indexPath.row]
        }
        return cell
    }
    
   
    

}
