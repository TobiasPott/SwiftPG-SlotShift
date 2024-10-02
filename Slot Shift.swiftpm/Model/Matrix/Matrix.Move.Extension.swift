import SwiftUI

extension Matrix where T: Equatable {
    func move(_ sRow: Int, _ sCol: Int, _ dRow: Int, _ dCol: Int, _ clearValue: T) {
        self[dRow, dCol] = self[sRow, sCol]        
        self[sRow, sCol] = clearValue
    }
    func moveIf(_ sRow: Int, _ sCol: Int, _ dRow: Int, _ dCol: Int, _ clearValue: T) -> Bool  {
        let dest  = self[dRow, dCol]
        if(dest == clearValue) {
            self.move(sRow, sCol, dRow, dCol, clearValue)
            return true
        }
        return false
    }
    func moveIfNot(_ sRow: Int, _ sCol: Int, _ dRow: Int, _ dCol: Int, _ clearValue: T) -> Bool  {
        let dest  = self[dRow, dCol]
        if(dest == clearValue) {
            self.move(sRow, sCol, dRow, dCol, clearValue)
            return true
        }
        return false
    }
    
    func moveColumns(by: Int, _ clearWith: T) {
        for c in 0..<self.size.columns {
            moveColumn(c, by: by, clearWith)
        }        
    }
    func moveColumn(_ c: Int, by: Int, _ clearWith: T) {
        if(by == 0) { return }
        // make rows index array (reverse if necessary)
        var rowsArray = Array((size.getStartRow(by)...size.getEndRow(by)))
        if (by > 0) { rowsArray.reverse() }
        
        let revEnd = size.getRevEndRow(by)
        for r in rowsArray {
            var rCur = r;
            while(rCur != revEnd)
            {
                _ = self.moveIf(rCur, c, rCur+by, c, clearWith)
                // change current row by 'by' value (includes sign)
                rCur += by;
            }
        }
    }
    
    
    func moveRows(by: Int, _ clearWith: T) {
        for r in 0..<self.size.rows {
            moveRow(r, by: by, clearWith)
        }        
    }
    func moveRow(_ r: Int, by: Int, _ clearWith: T) {
        if(by == 0) { return }
        
        // make rows index array (reverse if necessary)
        var colsArray = Array((size.getStartColumn(by)...size.getEndColumn(by)))
        if (by > 0) { colsArray.reverse() }
        
        let revEnd = size.getRevEndColumn(by)
        for newC in colsArray {
            var cCur = newC;
            while(cCur != revEnd)
            {
                _ = self.moveIf(r, cCur, r, cCur+by, clearWith)
                // change current row by 'by' value (includes sign)
                cCur += by;
            }
        }
        
    }
}
