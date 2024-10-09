# 0125 Valid Palindrome

This documentation outlines the solutions for the Valid Palindrome problem from LeetCode. Three solutions are provided, highlighting their approaches and performance characteristics.
[Valid Palindrome](https://leetcode.com/problems/valid-palindrome/)

## Overview

A phrase is considered a palindrome if it reads the same forwards and backwards after filtering out non-alphanumeric characters and converting all uppercase letters to lowercase. The task is to determine whether a given string satisfies this condition.

## Topics
Strings

## Solutions

### Solution 1: Using Filter and Reverse

```swift
class Solution {
    func isPalindrome(_ s: String) -> Bool {
        let filtered = s.lowercased().filter { $0.isLetter || $0.isNumber }
        let reversed = String(filtered.reversed())
        return filtered == reversed
    }
}
```

#### Approach

- Convert the entire string to lowercase.
- Filter out non-alphanumeric characters.
- Reverse the filtered string.
- Compare the filtered string with its reversed version.

#### How Does the Filter Method Work?

The filter method in Swift selects elements from a collection (like an array or string) that meet a specific condition. This method examines the elements of the original collection and creates a new collection consisting of the elements that satisfy the given condition.

##### Condition Structure:
        
```swift
{ $0.isLetter || $0.isNumber }
```

This expression is a closure passed to the filter method. It runs for each element the filter method processes.

##### Closure:
A block of code defined as `{ ... }`. The code inside runs for each character in the string.

The `$0` expression represents the first parameter of the closure. In other words, the filter method calls this closure for each character in the string.

##### Condition:

- `isLetter`: Checks if a character is a letter. If it is, it returns true.
- `isNumber`: Checks if a character is a digit. If it is, it returns true.
- Logical OR (`||`):
    - The `||` operator returns true if at least one of the two conditions is true. So, if a character is either a letter or a digit, this expression evaluates to true, and the character is added to the new array.

#### Performance

* Time Complexity: `O(n)`, where `n` is the length of the input string.
* Space Complexity: `O(n)`, as it creates new strings for both the filtered and reversed versions.

#### Advantages

* Simple and easy to understand.
* Utilizes Swift's built-in string methods effectively.

#### Disadvantages

* Requires extra memory for the filtered and reversed strings.
* May perform slower for large inputs due to additional operations.
* When I submitted to LeetCode, the system returned a runtime of 25-29 ms.

### Solution 2: Two Pointer Technique

```swift
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
```

#### Approach

- Convert the entire string to lowercase and change it to an array.
- Initialize two pointers at the start and end of the array.
- Move the left pointer to the right until it finds an alphanumeric character.
- Move the right pointer to the left until it finds an alphanumeric character.
- Compare the characters at the left and right pointers.
- If they are not equal, return `false`; otherwise, update the pointers.

#### Performance

* Time Complexity: `O(n)`, where `n` is the length of the input string. Each character is checked only once.
* Space Complexity: `O(1)`, as it uses a fixed number of variables and does not create any additional arrays or strings.

#### Advantages

* No extra memory usage; works directly on the characters.
* Faster performance for large inputs; no unnecessary array or string creation.
* When I submitted to LeetCode, the system returned a runtime of 11-13 ms.

#### Disadvantages

* The code may be less readable than the first solution, especially with the addition of the `isAlphanumeric` function.

### Bonus Solution: Using Regular Expressions (RegEx)

Okay, we know RegEx can be a good opportunity sometimes for coding. This solution is really simple for this question, but we can be scared of the RegEx topic as developers. It’s normal because when we look at a RegEx string, it can seem really strange, and we often forget how to write it. For example:
`"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}"` (This is for email format)

Anyway, when I saw the question, I thought about this topic. I asked myself how can I solve this problem with Swift, because I know a simple way with RegEx. Let's check the solution with RegEx:

```swift
class Solution {
    func isPalindrome(_ s: String) -> Bool {
        let filtered = s.lowercased().replacingOccurrences(of: "[^a-z0-9]", with: "", options: .regularExpression)
        return filtered == String(filtered.reversed())
    }
}

let solution = Solution()
let answer = solution.isPalindrome("A man, a plan, a canal: Panama")

print("Question's answer is \(answer)")
```

#### Approach

- The input string `s` is converted to lowercase. This makes the check case-insensitive.
- Filter out non-alphanumeric characters.
- Check for palindrome.

#### Performance

* Time Complexity: `O(n)`, where `n` is the length of the input string. The regex operation and string reversal both iterate over the characters.
* Space Complexity: `O(n)`, as a new filtered string is created.

#### Advantages

* Conciseness: The code is shorter and arguably more readable due to the use of regex.
* Flexibility: Regex can be easily adjusted to modify filtering criteria if needed.

#### Disadvantages

* Regex Overhead: While regex can simplify filtering, it may introduce overhead compared to the two-pointer approach for very large strings.
* Less Explicit: Some might find regex less intuitive than straightforward character comparisons.
* When I submitted to LeetCode, the system returned a runtime of 46-48 ms. 
    * This is a big difference, so let's dive deeper into this performance issue.

Okay, first I think we should understand how RegEx works in the code. After that, we can clearly see why RegEx might perform poorly.

#### How Does RegEx Work?

1. **Pattern Matching**:
    - At its core, regex (regular expressions) is used for pattern matching in strings. It allows developers to define a search pattern using characters that specify the criteria for matching.

2. **Compilation**:
    - When a regex pattern is used, the regex engine first compiles the pattern into an internal representation. This can consume resources, as it involves parsing the pattern and creating a finite state machine (FSM) or similar structure.

3. **Execution**:
    - The compiled regex is then executed against the input string. The regex engine scans the string to find matches based on the defined pattern. This process may involve checking each character in the string against the pattern.

4. **Memory Allocation**:
    - During execution, memory may be allocated for various purposes:
        - **Match Storage**: If the regex captures groups (using parentheses), memory is allocated to store these matches.
        - **Temporary Objects**: The regex engine might create temporary objects or structures to help with matching.
        - If the regex is used to filter or replace parts of the string, new strings must be created, consuming more memory.

5. **Backtracking**:
    - In some cases, the regex engine may need to backtrack to find alternative matches, especially with complex patterns. This can lead to increased memory usage and slower performance.

#### Performance Considerations:
- **Complexity**: More complex regex patterns can lead to increased time and memory overhead as the engine has to evaluate more possibilities.
- **Garbage Collection**: Once the regex execution is complete, memory used for matches or temporary objects is usually released, but there might be a slight delay in garbage collection depending on the language and environment.

#### Why Does RegEx Have Bad Performance?

1. **Regex Overhead**:
    - Regex engines often involve additional overhead due to the complexity of parsing and matching patterns, which can add latency, especially for larger input strings.

2. **Multiple Passes**:
    - The regex operation generally requires one pass over the string to match and replace characters, and then another pass for reversing the string. In contrast, the two-pointer approach processes the string in a single pass.

3. **Memory Allocation**:
    - Creating new strings during the regex operation (filtered string) adds to memory allocation overhead, which can slow down performance for large strings.

Okay, I think everything is now clear. **The main

 reason for the performance difference is due to overhead in regex processing and extra passes through the input.** If the input is large, regex can be significantly slower.

## Contact

If you have any questions about this documentation or would like to provide feedback or suggest better solutions for this problem, please feel free to reach out to me. You can contact me at:

- LinkedIn: [www.linkedin.com/in/metehan-belli](https://www.linkedin.com/in/metehan-belli)
- Email: [metehanbelli8@gmail.com](mailto:metehanbelli8@gmail.com)

I would be happy to assist you with any issues you may have!
