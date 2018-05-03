//
//  PostManager.swift
//  History
//
//  Created by Zhenyuan Shen on 5/3/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import Foundation
import AVOSCloud

class PostManager {
    static let sharedInstance: PostManager = {
        return PostManager()
    }()
    
    func getTitle(post: AVObject) -> String? {
        return post.object(forKey: LCConstants.PostKey.title) as? String
    }
    
    func getImage(post: AVObject) -> UIImage? {
        if let urlStr = post.object(forKey: LCConstants.PostKey.imageURL) as? String {
            let url = URL(string: urlStr.convertToHttps())
            if let data = try? Data(contentsOf: url!) {
                return UIImage(data: data)
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func getText(post: AVObject) -> String? {
        if let urlStr = post.object(forKey: LCConstants.PostKey.textURL) as? String {
            let url = URL(string: urlStr.convertToHttps())
            if let data = try? Data(contentsOf: url!) {
                return NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)! as String
            } else {
                return Constants.Default.defaultInfo
            }
        } else {
            return Constants.Default.defaultInfo
        }
    }
    
    func getLikes(post: AVObject) -> Int {
        return post.object(forKey: LCConstants.PostKey.likes) as? Int ?? 0
    }
    
    func getSubscribers(post: AVObject) -> Int {
        return post.object(forKey: LCConstants.PostKey.subscribers) as? Int ?? 0
    }
    
    func getReplies(post: AVObject) -> Int {
        return post.object(forKey: LCConstants.PostKey.replies) as? Int ?? 0
    }
    
    func getReviews(post: AVObject) -> Int {
        return post.object(forKey: LCConstants.PostKey.reviews) as? Int ?? 0
    }
    
    func getAuthor(post: AVObject, withBlock block: @escaping AVArrayResultBlock) {
        if let authorId = post.object(forKey: LCConstants.PostKey.authorId) {
            UserManager.sharedInstance.findUser(key: LCConstants.GeneralKey.objectId, value: authorId as! String, withBlock: block)
        }
    }
    
    func updateCounter(forKey key: String, amount: NSNumber, post: AVObject) {
        post.saveInBackground({ (succeed, error) in
            if succeed {
                post.incrementKey(key, byAmount: amount)
                post.fetchWhenSave = true
                post.saveInBackground()
                
                // send notification to user to increment his/her follower field
                // TODO
            } else {
                print(error?.localizedDescription)
            }
        })
    }
    
    func fetchAllPostsFromLC(withBlock block: @escaping AVArrayResultBlock) {
        let query = AVQuery(className: LCConstants.PostKey.className)
        query.findObjectsInBackground(block)
    }
    
    func fetchPostFromLC(forKey key: String, value: String, withBlock block: @escaping AVArrayResultBlock) {
        let query = AVQuery(className: LCConstants.PostKey.className)
        query.whereKey(key, equalTo: value)
        query.order(byDescending: LCConstants.GeneralKey.createAt)
        query.findObjectsInBackground(block)
    }
    
    func findPosts(forKey key: String, value: String, withBlock block: @escaping AVArrayResultBlock) {
        let query = AVQuery(className: LCConstants.PostKey.className)
        query.whereKey(key, contains: value)
        query.order(byDescending: LCConstants.GeneralKey.createAt)
        query.findObjectsInBackground(block)
    }
}
