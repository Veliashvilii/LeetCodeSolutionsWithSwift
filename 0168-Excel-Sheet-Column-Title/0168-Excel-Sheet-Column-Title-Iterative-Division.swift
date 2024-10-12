class Solution {
    func convertToTitle(_ columnNumber: Int) -> String {
        var number = columnNumber
        var result = ""
        
        while number > 0 {
            number -= 1
            let remainder = number % 26
            let letter = self.convertToLetter(remainder)
            result.insert(letter, at: result.startIndex)
            number /= 26
        }
        
        return result
    }
    
    private func convertToLetter(_ digit: Int) -> Character {
        let alphabet = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        return alphabet[digit]
    }
}
