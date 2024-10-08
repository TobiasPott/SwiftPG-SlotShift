import SwiftUI

extension Matrix where T: Equatable {
    func canMerge(_ sRow: Int, _ sCol: Int, _ dRow: Int, _ dCol: Int, condition: MergeCondition) -> Bool {
        let source = self[sRow, sCol]
        let dest = self[dRow, dCol]
        return source.canMergeWith(dest, condition)
    }
    ///->Merge source and destintion and set destination to clearValue
    private func merge(_ sRow: Int, _ sCol: Int, _ dRow: Int, _ dCol: Int, _ clearValue: T) {
        let source = self[sRow, sCol]
        let dest = self[dRow, dCol]
        let nDest = dest.merge(source, source.Mode)
        print("merge: \(sRow),\(sCol) (\(source)) with \(dRow),\(dCol) (\(dest)) \(source.Mode)")
        self[dRow, dCol] = nDest            
        self[sRow, sCol] = clearValue
    }
    ///->Merge source and destination if both not equal clearValue
    private func mergeIfNot(_ sRow: Int, _ sCol: Int, _ dRow: Int, _ dCol: Int, _ clearValue: T) -> Bool {
        let dest = self[dRow, dCol]
        let source = self[sRow, sCol]
        if(dest != clearValue && source != clearValue) {
            self.merge(sRow, sCol, dRow, dCol, clearValue)
            return true
        }
        return false
    }
    ///->Merge source and destination if both equal clearValue 
    // ToDo: re-evaluate if condition both is wanted behaviour or only one needs to equal
    private func mergeIf(_ sRow: Int, _ sCol: Int, _ dRow: Int, _ dCol: Int, _ clearValue: T) -> Bool {
        let dest = self[dRow, dCol]
        let source = self[sRow, sCol]
        if(dest == clearValue && source == clearValue) {
            self.merge(sRow, sCol, dRow, dCol, clearValue)
            return true
        }
        return false
    }
    
    ///->Merges the columns of the given index, using the mergeCondition and clearValue to merge
    func mergeColumns(by: Int, condition: MergeCondition, _ clearWith: T) -> Int {
        if(by == 0) { return 0 }
        var result: Int = 0
        for c in 0..<self.size.columns {
            result += mergeColumn(c, by: by, condition: condition, clearWith)
        }
        return result
    }
    private func mergeColumn(_ c: Int, by: Int, condition: MergeCondition, _ clearWith: T) -> Int {
        if(by == 0) { return 0 }
        var result: Int = 0
        // make rows index array (reverse if necessary)
        var rowsArray = Array((size.getStartRow(by)...size.getEndRow(by)))
        if (by > 0) { rowsArray.reverse() }
        
        //        let revEnd = size.getRevEndRow(by)
        for r in rowsArray {
            // Remark: add iteration over all (to revEnd) to achieve merging all possible per columns/row
            //    change is required on columns AND rows functions 
            if self.canMerge(r, c, r+by, c, condition: condition) {
                // ToDo: validate functionality, the mergeIfNot causes unexpected behaviour in colors mode
                if self.mergeIfNot(r, c, r+by, c, clearWith) {
                    result += 1
                }
            }
        }
        return result
    }
    
    ///->Merges the row of the given index, using the mergeCondition and clearValue to merge
    func mergeRows(by: Int, condition: MergeCondition, _ clearWith: T) -> Int {
        if(by == 0) { return 0 }
        var result: Int = 0
        for r in 0..<self.size.rows {
            result += mergeRow(r, by: by, condition: condition, clearWith)
        }        
        return result
    }
    private func mergeRow(_ r: Int, by: Int, condition: MergeCondition, _ clearWith: T) -> Int {
        if(by == 0) { return 0 }
        var result: Int = 0
        // make rows index array (reverse if necessary)
        var colsArray = Array((size.getStartColumn(by)...size.getEndColumn(by)))
        if (by > 0) { colsArray.reverse() }
        
        //        let revEnd = size.getRevEndColumn(by)
        for c in colsArray {
            // Remark: add iteration over all (to revEnd) to achieve merging all possible per columns/row
            //    change is required on columns AND rows functions
            if self.canMerge(r, c, r, c+by, condition: condition) {
                if self.mergeIfNot(r, c, r, c+by, clearWith) { 
                    result += 1
                }
            }
        }
        return result
    }
}
