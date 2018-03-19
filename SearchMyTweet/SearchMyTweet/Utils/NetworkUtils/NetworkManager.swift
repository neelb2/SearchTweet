//
//  NetworkManager.swift
//  SearchMyTweet
//
//  Created by Neel Bhasin on 16/03/18.
//  Copyright © 2018 NB. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {
    static let sharedInstance = NetworkManager()
    static let authUrl = "https://api.twitter.com/oauth2/token"
    static let searchUrl = "https://api.twitter.com/1.1/search/tweets.json"
    
    static let consumerKey = "Wau2JpjqydnYVZKN2Oh4UbRD7"
    static let consumerSecret = "NN19rUTPs4yJbWktNcBl6dnBdmaoQj4mxYhfy72X6WthRZno2A"
    private var token = ""
    private override init() {
        super.init()
    }
    
    
    class func getAuthToken(){
        let key = consumerKey.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let value = consumerSecret.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        if let k = key, let s = value{
            let combined = k + ":" + s
            let utf = combined.data(using: .utf8)
            if let base64Str = utf?.base64EncodedString(options: .init(rawValue: 0)){
                var header = [String:String]()
                header["Authorization"] = "Basic " + base64Str
                header["Content-Type"] = "application/x-www-form-urlencoded;charset=UTF-8"

                let dr = "client_credentials"
                
                upload(multipartFormData: {data in data.append(dr.data(using: .utf8)!, withName: "grant_type")}, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: NetworkManager.authUrl, method: .post, headers: header, encodingCompletion: {encoding in
                    switch encoding{
                    case .failure:
                        print("Fail")
                    case .success(request: let request, streamingFromDisk: _, streamFileURL: _):
                        request.responseJSON(completionHandler: {response in
                            if response.result.isSuccess{
                                if let object = response.result.value{
                                    if let dict = object as? [String:Any]{
                                        if let val = dict["access_token"] as? String{
                                            self.sharedInstance.token = val
                                        }
                                    }
                                }
                            }else if response.result.isFailure{
                            }
                        })
                    }
                })
            }
        }
    }
    
    //GET Request for Search Tweet
    func getSearchResult(Keywork str:String, success:@escaping (SearchResultModel)->Void, error:@escaping (Error)->Void){
        
        let params : [String:String] = ["q":str]
        
        request(NetworkManager.searchUrl, method: .get, parameters: params, encoding: URLEncoding.default, headers: NetworkManager.headers() as? HTTPHeaders).responseJSON(completionHandler: {response in
            if response.result.isSuccess{
                let object = response.result.value
                if let obj = object{
                    let model = SearchResultModel.init(With: obj as? [String : Any])
                    success(model)
                }
            }else{
                error(response.error!)
            }
        })
    }
    
    /** Download and Cache Image in File Directory */
    func downloadImage(fromURL url:String,success:@escaping (UIImage) -> Void) {
        
        let urlParts = url.components(separatedBy: "/")
        let fileName = urlParts.last
        
        let directoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileUrl = directoryURLs.appendingPathComponent(fileName!).path
        
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: fileUrl){
            let image = UIImage.init(contentsOfFile: fileUrl)
            if let img = image{
                success(img)
            }
        }else{
            let des = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
            download(url, to: des).responseData(completionHandler: {response in
                if let path = response.destinationURL?.path{
                    let image = UIImage.init(contentsOfFile: path)
                    if let img = image{
                        success(img)
                    }
                }
            })
        }
    }
    
    class func headers() -> [String:Any]{
        var header = [String:Any]()
        header["Authorization"] = "Bearer " + self.sharedInstance.token
        return header
    }
}
