class Solution {
    func isPalindrome(_ s: String) -> Bool {
        let chars = Array(s.lowercased())
        var left = 0
        var right = chars.count - 1
        
        while left < right {
            while left < right && !isAlphanumeric(chars[left]) {
                left += 1
            }
            while left < right && !isAlphanumeric(chars[right]) {
                right -= 1
            }
            if chars[left] != chars[right] {
                return false
            }
            left += 1
            right -= 1
        }
        
        return true
    }
    
    private func isAlphanumeric(_ char: Character) -> Bool {
        return char.isNumber || (char >= "a" && char <= "z") || (char >= "A" && char <= "Z")
    }
}

let solution = Solution()
let answer = solution.isPalindrome("A man, a plan, a canal: Panama")

print("Question's answer is \(answer)")

