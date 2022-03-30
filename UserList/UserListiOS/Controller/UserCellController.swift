//
//  UserCellController.swift
//  IVDI
//
//  Created by Rasik on 29/03/22.
//

import UIKit
import UserList

public final class UserCellController {
    private var cell: UserCell?
    
    private let viewModel: UserViewModel
    
    public init(viewModel: UserViewModel) {
        self.viewModel = viewModel
    }
    
    func view(in tableView: UITableView) -> UITableViewCell {
        cell = tableView.dequeueReusableCell()
        display()
        return cell!
    }
    
    private func display() {
        cell?.nameLabel.text = viewModel.name
        cell?.genderLabel.text = viewModel.gender
        cell?.emailLabel.text = viewModel.email
    }
    
}
