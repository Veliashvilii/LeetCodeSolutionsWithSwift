class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var numsWithIndex = nums.enumerated().map { ($0.element, $0.offset) }
    numsWithIndex.sort { $0.0 < $1.0 }

    func findTwoSum(left: Int, right: Int) -> [Int] {
        if left >= right { return [] }
        
        let sum = numsWithIndex[left].0 + numsWithIndex[right].0
        
        if sum == target {
            return [numsWithIndex[left].1, numsWithIndex[right].1]
        } else if sum < target {
            return findTwoSum(left: left + 1, right: right)
        } else {
            return findTwoSum(left: left, right: right - 1)
        }
    }
    
    let result = findTwoSum(left: 0, right: numsWithIndex.count - 1)

    return result.isEmpty ? [-1, -1] : result
    }
}
