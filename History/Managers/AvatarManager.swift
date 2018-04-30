//
//  AvatarManager.swift
//  History
//
//  Created by Zhenyuan Shen on 3/14/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import Foundation
import UIKit
import AVOSCloud

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

    func getUserAvatar(user : AVUser, withBlock block : @escaping (_ image : UIImage?) -> Void) {
        let avatarFile = UserManager.sharedInstance.getAvatarFile(user: user)
        getAvatar(avatarFile: avatarFile, withBlock: block)
    }

    func getAvatar(avatarFile : AVFile?, withBlock block : @escaping (_ image : UIImage?) -> Void) {
        if avatarFile != nil {
            avatarFile?.download { (url, error) in
                if error == nil && url != nil {
                    do {
                        let imgData = try Data(contentsOf: url!)
                        block(UIImage(data: imgData))
                    } catch {
                        block(UIImage(named: Constants.Default.defaultAvatar))
                    }
                } else {
                    block(UIImage(named: Constants.Default.defaultAvatar))
                }
            }
        } else {
            block(UIImage(named: Constants.Default.defaultAvatar))
        }
    }

    func updateAvatarWithImage(image: UIImage, withBlock block : @escaping AVBooleanResultBlock) {
        let data =  UIImagePNGRepresentation(image.resized(toWidth: 200)!)
        let file = AVFile(data: data!)

        file.upload { (succeed, error) in
            if succeed {
                AVUser.current()?.setObject(file.url(), forKey: LCConstants.UserKey.avatarURL)
//                AVUser.current()?.setObject(file, forKey: LCConstants.UserKey.avatarFile) // LC bug?
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
