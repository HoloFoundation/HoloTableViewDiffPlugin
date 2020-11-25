//
//  ViewController.swift
//  HoloTableViewDiffPlugin
//
//  Created by gonghonglou on 11/16/2020.
//  Copyright (c) 2020 gonghonglou. All rights reserved.
//

import UIKit
import HoloTableView
import HoloTableViewDiffPlugin

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.reloadButton.frame = CGRect(x: 100, y: 50, width: self.view.frame.width - 200, height: 40)
        self.tableView.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.height - 100)
        self.view.addSubview(reloadButton)
        self.view.addSubview(self.tableView)
    }
    
    @objc func reloadButtonAction() {
        self.tableView.holo_removeAllSections()
        self.tableView.holo_makeRows { (make) in
            DataSet.generateItems().forEach { (item) in
                _ = make.row(TableViewCell.self).height(80).willDisplayHandler { (cell, model) in
                    guard let cell = cell as? TableViewCell else { return }
                    cell.configTitle("\(item)")
                }.diffId(item)
            }
        }
        self.tableView.reload()
    }
    
    
    lazy var reloadButton: UIButton = {
        let _reloadButton = UIButton.init(type: .system)
        _reloadButton.setTitle("reload", for: .normal)
        _reloadButton.layer.borderColor = UIColor.systemBlue.cgColor
        _reloadButton.layer.borderWidth = 1
        _reloadButton.layer.cornerRadius = 5
        _reloadButton.addTarget(self, action: #selector(ViewController.reloadButtonAction), for: .touchUpInside)
        return _reloadButton
    }()
    
    lazy var tableView: UITableView = {
        let _tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        _tableView.tableFooterView = UIView()
        _tableView.separatorStyle = .none
        return _tableView
    }()
}

struct DataSet {
  static func generateItems() -> [Int] {
    let count = Int(arc4random_uniform(20)) + 10
    let items = Array(0..<count)
    return items.shuffled()
  }
}
