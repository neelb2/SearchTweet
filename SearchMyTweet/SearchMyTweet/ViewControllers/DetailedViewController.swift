//
//  DetailedViewController.swift
//  SearchMyTweet
//
//  Created by Neel Bhasin on 19/03/18.
//  Copyright © 2018 NB. All rights reserved.
//

import UIKit

let userCellID = "TweetUserTableViewCell"
let tweetTextCellID = "TweetTextTableViewCell"

class DetailedViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    var model: TweetModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.mainTableView.dataSource = self
        self.mainTableView.register(UINib.init(nibName: userCellID, bundle: nil), forCellReuseIdentifier: userCellID)
        self.mainTableView.register(UINib.init(nibName: tweetTextCellID, bundle: nil), forCellReuseIdentifier: tweetTextCellID)
        self.title = "Tweet Details"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DetailedViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: userCellID, for: indexPath) as! TweetUserTableViewCell
            cell.setData(model: self.model!)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: tweetTextCellID, for: indexPath) as! TweetTextTableViewCell
            if let text = self.model?.text{
                cell.setText(tweet: text)
            }
            return cell
        }
        
    }
}
