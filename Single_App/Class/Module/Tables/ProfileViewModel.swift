//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************
//
//  Single_App
//  ProfileViewModel
//
//  Created by iCocos on 2019/01/06.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class ProfileViewModel.swift
// @abstract MVVM-TableView-ViewModel
// @discussion 实现MVVM-TableView-ViewModel数据
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation
import UIKit

protocol ProfileViewModelItem {
    var rowCount: Int { get }
}

class ProfileViewModel: NSObject {
    var items = [ProfileViewModelItem]()
    
    override init() {
        super.init()
        guard let data = dataFromFile("ServerData"), let profile = Profile(data: data) else {
            return
        }
        
        let friends = profile.friends
        if !profile.friends.isEmpty {
            let friendsItem = ProfileViewModeFriendsItem(friends: friends)
            items.append(friendsItem)
        }        
    }
}

extension ProfileViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        if let item = item as? ProfileViewModeFriendsItem, let cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.identifier, for: indexPath) as? FriendCell {
            let friend = item.friends[indexPath.row]
            cell.item = friend
            return cell
        }
        return UITableViewCell()
    }
}


class ProfileViewModeFriendsItem: ProfileViewModelItem {

    var sectionTitle: String {
        return "Friends"
    }
    
    var rowCount: Int {
        return friends.count
    }
    
    var friends: [Friend]
    
    init(friends: [Friend]) {
        self.friends = friends
    }
}


