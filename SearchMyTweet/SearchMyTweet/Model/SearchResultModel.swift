//
//  SearchResultModel.swift
//  SearchMyTweet
//
//  Created by Neel Bhasin on 16/03/18.
//  Copyright © 2018 NB. All rights reserved.
//

import UIKit

class TweetModel: NSObject{
    var text: String?
    var name: String?
    var userImg: String?
    var handle: String?
    var userDescription: String?
    
    init(With dictionary:[String:Any]?) {
        super.init()
        if let dict = dictionary{
            if let nodeValue = dict["text"]{
                self.text = nodeValue as? String
            }
            if let user = dict["user"] as? [String:Any]{
                if let name = user["name"]{
                    self.name = name as? String
                }
                if let img = user["profile_background_image_url_https"]{
                    self.userImg = img as? String
                }
                if let screen_name = user["screen_name"]{
                    self.handle = screen_name as? String
                }
                if let des = user["description"]{
                    self.userDescription = des as? String
                }
            }
        }
    }
}

class SearchResultModel: NSObject {
    var tweetList : [TweetModel]?
    init(With dictionary:[String:Any]?) {
        super.init()
        if let dict = dictionary{
            if let nodeValue = dict["statuses"] as? [Any]{
                tweetList = [TweetModel]()
                for node in nodeValue{
                    let model = TweetModel.init(With: node as? [String : Any])
                    tweetList?.append(model)
                }
            }
            
        }
    }
}
