//
//  AvatarManager.swift
//  History
//
//  Created by Zhenyuan Shen on 3/14/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import Foundation
import UIKit
import LeanCloud
import LeanCloudSocial

/**
 *  User avatar manager. Call getMyAvatar, getUserAvatar and getPeopleAvater.
 *
 *  - note: This class use singleton. Call AvatarManager.sharedInstance.
 */
class AvatarManager {
    
    static var sharedInstance : AvatarManager = {
        return AvatarManager()
    }()
    
    private init() {
    }
    
    func getMyAvatear(withBlock block : @escaping (_ image : UIImage?) -> Void) {
        getUserAvatar(user: UserManager.sharedInstance.currentUser(), withBlock: block)
    }
    
    func getUserAvatar(user : LCUser, withBlock block : @escaping (_ image : UIImage?) -> Void) {
        if let avatarFile = UserManager.sharedInstance.getAvatarFile(user: user) {
            avatarFile.getDataInBackground({ (data, error) in
                if error == nil {
                    block(UIImage(data: data!))
                } else {
                    block(UIImage(named: "default"))
                }
            })
        } else {
            block(UIImage(named: "default"))
        }
    }

    func getPeopleAvatar(avatarFile : AVFile, withBlock block : @escaping (_ image : UIImage?) -> Void) {
        avatarFile.getDataInBackground({ (data, error) in
            if error == nil {
                block(UIImage(data: data!))
            } else {
                block(UIImage(named: "default"))
            }
        })
    }
    
    func updateAvatarWithImage(image : UIImage, withBlock block : @escaping (LCBooleanResult) -> Void) {
        let data = UIImageJPEGRepresentation(image.resized(toWidth: 200)!, 1)
        let file = AVFile(data: data!)
        
        file.saveInBackground { (succeed, error) in
            if succeed {
                LCUser.current?.set(LCConstants.UserKey.avatarFile, value: file as! LCValueConvertible)
                LCUser.current?.save(block)
            } else {
                block(error as! LCBooleanResult)
            }
        }
    }
    
    func updateAvatarWithImage(image : UIImage, withBlock block : @escaping AVBooleanResultBlock) {
        let data = UIImageJPEGRepresentation(image.resized(toWidth: 200)!, 1)
        let file = AVFile(data: data!)
        
        file.saveInBackground { (succeed, error) in
            if succeed {
                AVUser.current()?.setObject(file, forKey: LCConstants.UserKey.avatarFile)
                AVUser.current()?.saveInBackground(block)
            } else {
                block(false, error)
            }
        }
    }
    
    func clearAllCache() {
        AVFile.clearAllPersistentCache()
    }
}



//self.user?.avatar?.getDataInBackground { (data: Data?, error: Error?) in
//    if error != nil || data == nil {
//        print(error!.localizedDescription)
//    } else {
//        if let image = UIImage(data: data!) {
//            self.avatarImage = image
//            self.avatarImageButton.imageView?.isHidden = false
//            self.avatarImageButton.imageView?.frame = self.avatarImageButton.bounds
//            self.avatarImageButton.setImage(image, for: UIControlState.normal)
//        }
//    }
//}

