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

    private let addButton: UIBarButtonItem!
    private let cellIdentifier = "Cell"
    private let disposeBag = DisposeBag()

    init(addItemTap: UIBarButtonItem) {
        self.addButton = addItemTap
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewModel()
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

        tableView.tableFooterView = UIView() //Prevent empty rows
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
