//
//  UITableView+DiffPlugin.swift
//  HoloTableViewDiffPlugin
//
//  Created by 与佳期 on 2020/11/16.
//

import UIKit
import DeepDiff
import HoloTableView

public extension UITableView {
    
    /// Stored old sections data
    func stored() {
        self.diffOldData = self.holo_proxy.proxyData.sections
    }
    
    /// Animate reload in a batch update
    ///
    /// - Parameters:
    ///   - sectionTag: Tag of the section that all calculated IndexPath belong
    ///   - insertionAnimation: The animation for insert rows
    ///   - deletionAnimation: The animation for delete rows
    ///   - replacementAnimation: The animation for reload rows
    ///   - updateData: Update your data source model
    ///   - completion: Called when operation completes
    func reload (
        sectionTag: String? = nil,
        insertionAnimation: UITableView.RowAnimation = .automatic,
        deletionAnimation: UITableView.RowAnimation = .automatic,
        replacementAnimation: UITableView.RowAnimation = .automatic,
        updateData: (() -> Void)? = nil,
        completion: ((Bool) -> Void)? = nil) {
        
        guard let section = self.holo_proxy.proxyData.section(withTag: sectionTag),
              let index = self.holo_proxy.proxyData.sections.firstIndex(of: section) else {
            debugPrint("[HoloTableViewDiffPlugin] No found a section with the tag: \(sectionTag ?? "nil").")
            return
        }
        
        var oldItems: [HoloTableRow]
        if let diffOldData = self.diffOldData, diffOldData.count > index {
            oldItems = diffOldData[index].rows
        } else {
            oldItems = [HoloTableRow]()
        }
        let newItems = section.rows
        let changes = diff(old: oldItems, new: newItems)
        
        self.reload(changes: changes,
                    section: index,
                    insertionAnimation: insertionAnimation,
                    deletionAnimation: deletionAnimation,
                    replacementAnimation: replacementAnimation,
                    updateData: {
                        self.diffOldData = self.holo_proxy.proxyData.sections
                        updateData?()
                    },
                    completion: completion
        )
    }
    
}

extension UITableView {
    
    static var kHoloTableViewDiffOldDataKey = "kHoloTableViewDiffOldDataKey"
    
    var diffOldData: [HoloTableSection]? {
        set {
            objc_setAssociatedObject(self, &UITableView.kHoloTableViewDiffOldDataKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &UITableView.kHoloTableViewDiffOldDataKey) as? [HoloTableSection]
        }
    }
    
}

