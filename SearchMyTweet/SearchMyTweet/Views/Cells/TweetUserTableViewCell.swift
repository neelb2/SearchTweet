//
//  TweetUserTableViewCell.swift
//  SearchMyTweet
//
//  Created by Neel Bhasin on 19/03/18.
//  Copyright © 2018 NB. All rights reserved.
//

import UIKit

class TweetUserTableViewCell: UITableViewCell {

    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var handleLbl: UILabel!
    @IBOutlet weak var desLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(model:TweetModel){
        self.userImgView.layer.cornerRadius = 40.0
        self.userImgView.layer.masksToBounds = true
        
        if let name = model.name{
            self.nameLbl.text = name
        }
        if let handle = model.handle{
            self.handleLbl.text = "@" + handle
        }
        if let des = model.userDescription{
            self.desLbl.text = des
        }
        if let img = model.userImg{
            weak var weakSelf = self
            NetworkManager.sharedInstance.downloadImage(fromURL: img, success: {image in
                weakSelf?.userImgView.image = image
                weakSelf?.reloadInputViews()
            })
        }
    }
    
    override func prepareForReuse() {
        self.userImgView.image = nil
    }
    
}
