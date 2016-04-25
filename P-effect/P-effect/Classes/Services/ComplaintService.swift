//
//  ComplaintService.swift
//  P-effect
//
//  Created by Illya on 3/1/16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit

private let complaintSuccessfull = NSLocalizedString("Thank you for complaint", comment: "")
private let nilUserInPost = NSLocalizedString("Nil user in post", comment: "")
private let noObjectsFoundErrorCode = 101

private let selfComplaint = NSLocalizedString("You can't make a complaint on yourself", comment: "")
private let alreadyComplainedPost = NSLocalizedString("You already make a complaint on this post", comment: "")
private let anonymousComlaint = NSLocalizedString("You can't make a complaint without registration", comment: "")

typealias ComplainCompletion = (Bool, NSError?) -> Void

enum ComplaintReason: String {
    case UserAvatar = "User Avatar"
    case PostImage = "Post Image"
    case Username = "Username"
}

class ComplaintService {
        
    func complaintUsername(user: User, post: Post? = nil, completion: ComplainCompletion) {
        if !shouldContinueExecutionWith(user) {
            return
        }
        let complaint = Complaint(user: user, post: post, reason: ComplaintReason.Username)
        sendComplaint(complaint) { result, error in
            completion(result, error)
        }
    }
    
    func complaintUserAvatar(user: User, post: Post? = nil, completion: ComplainCompletion) {
        if !shouldContinueExecutionWith(user) {
            return
        }
        let complaint = Complaint(user: user, post: post, reason: ComplaintReason.UserAvatar)
        sendComplaint(complaint) { result, error in
            completion(result, error)
        }
    }
    
    func complaintPost(post: Post, completion: ComplainCompletion) {
        guard let user = post.user else {
            log.debug(nilUserInPost)
            
            return
        }
        if !shouldContinueExecutionWith(user) {
            return
        }
        let complaint = Complaint(user: user, post: post, reason: ComplaintReason.PostImage)
        performIfComplaintExsist(complaint) { [weak self] existence in
            if !existence {
                self?.sendComplaint(complaint) { result, error in
                    completion(result, error)
                }
            } else {
                AlertManager.sharedInstance.showSimpleAlert(alreadyComplainedPost)
            }
        }
    }
    
    // You should check reachability befor using this method
    func performIfComplaintExsist(complaint: Complaint, existence: Bool -> Void)  {
        complaint.postQuery().getFirstObjectInBackgroundWithBlock { object, error in
            if object != nil {
                existence(true)
                
                return
            }
            guard let error = error where error.code == noObjectsFoundErrorCode else {
                return
            }
            existence(false)
            
            return
        }
    }
    
    //MARK: Private methods
    private func shouldContinueExecutionWith(user:User) -> Bool {
        if user.isCurrentUser {
            AlertManager.sharedInstance.showSimpleAlert(selfComplaint)
            
            return false
        }
        
        if User.notAuthorized {
            AlertManager.sharedInstance.showSimpleAlert(anonymousComlaint)
            
            return false
        }
        
        return ReachabilityHelper.isReachable()
    }
    
    private func sendComplaint(complaint: Complaint, completion: ComplainCompletion) {
        complaint.saveInBackgroundWithBlock { succeeded, error in
            if succeeded {
                AlertManager.sharedInstance.showSimpleAlert(complaintSuccessfull)
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
}
