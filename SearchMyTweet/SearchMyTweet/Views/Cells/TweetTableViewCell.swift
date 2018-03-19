//
//  TweetTableViewCell.swift
//  SearchMyTweet
//
//  Created by Neel Bhasin on 16/03/18.
//  Copyright © 2018 NB. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var handleLbl: UILabel!
    @IBOutlet weak var tweetLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setData(model:TweetModel){
        self.userImgView.layer.cornerRadius = 20.0
        self.userImgView.layer.masksToBounds = true

        if let name = model.name{
            self.nameLbl.text = name
        }
        if let handle = model.handle{
            self.handleLbl.text = "@" + handle
        }
        if let tweet = model.text{
            self.tweetLbl.text = tweet
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
