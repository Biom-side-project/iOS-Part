
import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var topLogo: UILabel!
    @IBOutlet weak var userLogo: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let commentList: [MainComments] = MainComments.list
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self

    }
}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return commentList.count
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCommentCell", for: indexPath) as? MainCommentCell else {
            return UICollectionViewCell()
        }
        
        let comment = commentList[indexPath.item]
        
        cell.configure(comment)
        return cell
       }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 321, height: 69)
    }
    
    
    
}
