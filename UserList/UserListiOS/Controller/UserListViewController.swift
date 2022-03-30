//
//  UserListViewController.swift
//  IVDI
//
//  Created by Rasik on 29/03/22.
//

import UIKit
import UserList

public protocol UserListViewControllerDelegate {
    func didRequestUserRefresh()
}

public class UserListViewController: UITableViewController, UserLoadingView, UserErrorView {
    
    @IBOutlet private(set) public var errorView: ErrorView?

    private var tableModel = [UserCellController]() {
        didSet { tableView.reloadData() }
    }
    
    public var delegate: UserListViewControllerDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.sizeTableHeaderToFit()
    }
    
    @IBAction private func refresh() {
        delegate?.didRequestUserRefresh()
    }
    
    public func display(_ cellControllers: [UserCellController]) {
        tableModel = cellControllers
    }
    
    public func display(_ viewModel: UserLoadingViewModel) {
        refreshControl?.update(isRefreshing: viewModel.isLoading)
    }
    
    public func display(_ viewModel: UserErrorViewModel) {
        errorView?.message = viewModel.message
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellController(forRowAt: indexPath).view(in: tableView)
    }
    
    private func cellController(forRowAt indexPath: IndexPath) -> UserCellController {
        let controller = tableModel[indexPath.row]
        return controller
    }
}
