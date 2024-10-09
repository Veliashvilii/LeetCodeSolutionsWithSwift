class Solution {
    func isPalindrome(_ s: String) -> Bool {
        let filtered = s.lowercased().filter {  $0.isLetter || $0.isNumber }
        let reversed = String(filtered.reversed())
        return filtered == reversed
    }
}

let solution = Solution()
let answer = solution.isPalindrome("A man, a plan, a canal: Panama")

print("Question' s answer is \(answer)")

