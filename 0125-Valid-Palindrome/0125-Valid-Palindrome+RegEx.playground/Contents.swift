class Solution {
    func isPalindrome(_ s: String) -> Bool {
        let filtered = s.lowercased().replacingOccurrences(of: "[^a-z0-9]", with: "", options: .regularExpression)
        return filtered == String(filtered.reversed())
    }
}

let solution = Solution()
let answer = solution.isPalindrome("A man, a plan, a canal: Panama")

print("Question's answer is \(answer)")
