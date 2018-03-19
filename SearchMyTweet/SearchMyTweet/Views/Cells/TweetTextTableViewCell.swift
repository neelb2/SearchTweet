//
//  TweetTextTableViewCell.swift
//  SearchMyTweet
//
//  Created by Neel Bhasin on 19/03/18.
//  Copyright © 2018 NB. All rights reserved.
//

import UIKit

class TweetTextTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetTxtLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setText(tweet:String){
        self.tweetTxtLbl.text = tweet
    }
}
