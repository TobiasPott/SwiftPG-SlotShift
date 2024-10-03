import SwiftUI

class CachedPicklist<T: Mergable> : Picklist<T> {
    @Published private var cache: Data = []
    
    init(_ entries: [EntryType], _ cacheSize: Int = 5) {
        super.init(entries)
        for _ in 0..<cacheSize {
            cache.append(self.randomData())
        }
    }
    
    func nextData() -> EntryType {
        let e = cache.first!
        cache.removeFirst()
        cache.append(self.randomData())
        return e
    }
    func nextElement() -> T { return nextData().value }
}
