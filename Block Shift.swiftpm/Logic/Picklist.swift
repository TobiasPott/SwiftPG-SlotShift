import SwiftUI

struct IntWeightEntry<T> {
    typealias WeightType = Int
    let value: T
    let weight: WeightType
    
    init(_ value: T, _ weight: WeightType) {
        self.value = value
        self.weight = weight
    }
}
class CachedPicklist<T: Mergable> : Picklist<T> {
    @Published var cache: Data = []
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
class Picklist<T: Mergable> : ObservableObject {
    typealias EntryType = IntWeightEntry<T>
    typealias Data = [EntryType]
    
    @Published var data: Data
    var maxWeight: Int = .zero
    
    init(_ entries: [EntryType]) {
        data = entries
        for e in entries {
            maxWeight += e.weight
        }
    }
    internal func randomData() -> EntryType {
        var roll: Int = Int.random(in: 0..<maxWeight)
        for e in data {
            roll -= e.weight
            if roll <= 0 {
                return e
            }
        }
        return data.first!
    }
    func randomElement() -> T { return randomData().value }
}
