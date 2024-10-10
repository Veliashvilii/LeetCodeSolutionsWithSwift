class Solution
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var hashMap = [Int: Int]()

    for (index, num) in nums.enumerated() {
        let complement = target - num
        if let complementIndex = hashMap[complement] {
            return [complementIndex, index]
        }
        hashMap[num] = index
    }
    return []
}
}
