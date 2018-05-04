//
//  Post.swift
//  History
//
//  Created by Zhenyuan Shen on 5/3/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class Post {
    
    var title: String?
    var image: UIImage? // TODO
    var type: String?
    var text: String?
    var dynasty: String?
    
    init(title: String?, image: UIImage?, type: String?, text: String?, dynasty: String?) {
        self.title = title
        self.image = image
        self.type = type
        self.text = text
        self.dynasty = dynasty
    }
    
    init(person: Person) {
        self.title = person.name
        self.type = person.type
        self.dynasty = person.dynasty
        
        if let image_ = person.avatar {
            let url = URL(string: image_.convertToHttps())
            if let data = try? Data(contentsOf: url!) {
                self.image = UIImage(data: data)
            } else {
                self.image = nil
            }
        } else {
            self.image = nil
        }
        
        if let text_ = person.info {
            let url = URL(string: text_.convertToHttps())
            if let data = try? Data(contentsOf: url!) {
                self.text = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)! as String
            } else {
                self.text = Constants.Default.defaultInfo
            }
        } else {
            self.text = Constants.Default.defaultInfo
        }
    }
    
    init(event: Event) {
        self.title = event.name
        self.type = event.type
        self.dynasty = event.dynasty
        
        if let image_ = event.avatar {
            let url = URL(string: image_.convertToHttps())
            if let data = try? Data(contentsOf: url!) {
                self.image = UIImage(data: data)
            } else {
                self.image = nil
            }
        } else {
            self.image = nil
        }
        
        if let text_ = event.info {
            let url = URL(string: text_.convertToHttps())
            if let data = try? Data(contentsOf: url!) {
                self.text = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)! as String
            } else {
                self.text = Constants.Default.defaultInfo
            }
        } else {
            self.text = Constants.Default.defaultInfo
        }
    }
    
    static func getPosts(events: [Event]) -> [Post] {
        var posts = [Post]()
        for event in events {
            posts.append(Post(event: event))
        }
        return posts
    }
    
    static func getPosts(people: [Person]) -> [Post] {
        var posts = [Post]()
        for person in people {
            posts.append(Post(person: person))
        }
        return posts
    }
}
