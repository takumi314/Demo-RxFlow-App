//
//  TableViewController.swift
//  Demo-RxFlow-App
//
//  Created by NishiokaKohei on 29/11/2018.
//  Copyright © 2018 Takumi. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Reusable

final class TableViewController: UIViewController, ViewModelBased, StoryboardBased {

    @IBOutlet weak var tableView: UITableView!

    var viewModel: TableViewViewModel!

    var addButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)

    private let cellIdentifier = "Cell"
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Demo App"
        // Do any additional setup after loading the view.
//        setupViewModel()
        setupAddButton()
        setupTableView()
        setupTableViewBinding()
    }

    private func setupViewModel() {
        self.viewModel = TableViewViewModel(addItemTap: addButton.rx.tap.asDriver())
    }

    private func setupAddButton() {
        navigationItem.setRightBarButton(addButton, animated: true)
    }

    private func setupTableView() {
        //This is necessary since the UITableViewController automatically set his tableview delegate and dataSource to self
        tableView.delegate = nil
        tableView.dataSource = nil

        tableView.tableFooterView = UIView() // Prevent empty rows
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    private func setupTableViewBinding() {

        viewModel.dataSource
            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier, cellType: UITableViewCell.self)) {  row, element, cell in
                cell.textLabel?.text = "\(element) \(row)"
            }
            .disposed(by: disposeBag)
    }

}
