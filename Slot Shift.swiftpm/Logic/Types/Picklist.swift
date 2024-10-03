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

class Picklist<T: Mergable> : ObservableObject {
    typealias EntryType = IntWeightEntry<T>
    typealias Data = [EntryType]
    
    @Published var data: Data
    private var maxWeight: Int = .zero
    
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
