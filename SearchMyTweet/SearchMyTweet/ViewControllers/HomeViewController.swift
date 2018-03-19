//
//  ViewController.swift
//  SearchMyTweet
//
//  Created by Neel Bhasin on 16/03/18.
//  Copyright © 2018 NB. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func searchBtnTap(_ sender: Any) {
        if let text = self.searchTxtField.text{
            weak var weakSelf = self
            NetworkManager.sharedInstance.getSearchResult(Keywork: text, success: {model in
                weakSelf?.goToTweetList(model: model)
            }, error: {error in
                print(error.localizedDescription)
            })
        }
    }
    
    func goToTweetList(model:SearchResultModel){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchResultViewController") as? SearchResultViewController{
            if let tweets = model.tweetList{
                vc.tweetList = tweets
            }
            vc.title = self.searchTxtField.text
            self.searchTxtField.text = ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

