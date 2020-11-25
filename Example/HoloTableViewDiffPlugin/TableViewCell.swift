//
//  TableViewCell.swift
//  HoloTableViewDiffPlugin_Example
//
//  Created by 与佳期 on 2020/11/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.label.frame = CGRect(x: 0, y: 0, width: 320, height: 60)
        self.contentView.addSubview(self.label)
    }
    
    func configTitle(_ title: String) {
        self.label.text = title
        self.label.center = self.contentView.center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var label: UILabel = {
        let _label = UILabel()
        _label.backgroundColor = UIColor.systemBlue
        _label.textColor = .white
        _label.layer.cornerRadius = 5
        _label.layer.masksToBounds = true
        _label.textAlignment = .center
        return _label
    }()
}
