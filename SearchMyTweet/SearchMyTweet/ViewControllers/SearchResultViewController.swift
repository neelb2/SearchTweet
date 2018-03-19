//
//  SearchResultViewController.swift
//  SearchMyTweet
//
//  Created by Neel Bhasin on 16/03/18.
//  Copyright © 2018 NB. All rights reserved.
//

import UIKit

let tweetCellId = "TweetTableViewCell"

class SearchResultViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    var tweetList = [TweetModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableView.register(UINib.init(nibName: tweetCellId, bundle: nil), forCellReuseIdentifier: tweetCellId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SearchResultViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.tweetList[indexPath.row]
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailedViewController") as? DetailedViewController{
            vc.model = model
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension SearchResultViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweetList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tweetCellId, for: indexPath) as! TweetTableViewCell
        cell.setData(model: self.tweetList[indexPath.row])
        return cell
    }
}
