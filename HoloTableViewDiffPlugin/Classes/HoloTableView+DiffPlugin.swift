//
//  HoloTableView+DiffPlugin.swift
//  HoloTableViewDiffPlugin
//
//  Created by 与佳期 on 2020/11/16.
//

import Foundation
import DeepDiff
import HoloTableView

public extension HoloTableRowMaker {
    
    /// Diff id
    func diffId(_ diffId: AnyHashable) -> Self {
        let row = self.fetchTableRow()
        row.diffId = diffId
        return self
    }
    
}

extension HoloTableRow: DiffAware {
    
    static var kHoloTableRowDiffIdKey = "kHoloTableRowDiffIdKey"
    
    public var diffId: AnyHashable? {
        set {
            objc_setAssociatedObject(self, &HoloTableRow.kHoloTableRowDiffIdKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &HoloTableRow.kHoloTableRowDiffIdKey) as? AnyHashable
        }
    }
    
    public static func compareContent(_ a: HoloTableRow, _ b: HoloTableRow) -> Bool {
        return a.diffId != nil && b.diffId != nil && a.diffId == b.diffId
    }
    
}
