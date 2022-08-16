//
//  MainCommentCell.swift
//  Biom
//
//  Created by 오예진 on 2022/08/15.
//

import UIKit

class MainCommentCell: UICollectionViewCell {
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var heartNumber: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!


    func configure(_ comment: MainComments) {
        nickNameLabel.text = "\(comment.nickName)"
        contentsLabel.text = "\(comment.contents)"
        heartNumber.text = "\(comment.heart)"
        timeLabel.text = "\(comment.time)"
        }
    
    override func awakeFromNib() {
            super.awakeFromNib()
        contentView.layer.borderColor = UIColor(named: "grayBorderColor")?.cgColor
        contentView.layer.borderWidth = 1.0
        contentView.layer.cornerRadius = 20
        }
}
