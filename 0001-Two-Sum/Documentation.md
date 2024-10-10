# 0001 Two Sum

This document explains different solutions to the **Two Sum** problem from LeetCode. We’ll go through three approaches and talk about how they work and how fast they are. You can find the original problem [here](https://leetcode.com/problems/two-sum/).

## Overview

The **Two Sum** problem is a common coding challenge. You’re given an array of integers and a target number. The goal is to find two numbers in the array that add up to the target and return their indices. There are multiple ways to solve this, and we’ll look at three different solutions.

## Topics
- Arrays
- Loops
- Hash Maps
- Pointers

## Solutions

### Solution 1: Brute Force (Nested Loops)
```swift
class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        for i in 0..<nums.count {
            for j in i+1..<(nums.count) {
                if ((nums[i] + nums[j]) == target) { return [i, j] }
            }
        }
        return []
    }
}
```

#### How It Works
- We use nested loops to go through the array.
- The outer loop picks an element from the array.
- The inner loop checks the rest of the elements to see if their sum with the first element equals the target.
- If we find two numbers that match the target, we return their indices.
- If no match is found, we return an empty array.

#### Performance
- **Time Complexity:** `O(n^2)` because we have two loops that go through the array.
- **Space Complexity:** `O(1)` because we don’t use any extra memory aside from the input array.
- **LeetCode Run Time:** `54` ms

#### Advantages
- It’s super simple and easy to understand.
- You don’t need any fancy data structures.

#### Disadvantages
- This solution is slow for large arrays since it has to check every possible pair.

### Solution 2: Two Pointer
```swift
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
```

#### How It Works
- We start by creating an array of tuples that pairs each element with its corresponding index using `enumerated()`. 
- Next, we sort this array based on the values of the elements.

### What’s the `map`?
- **`map`** is a higher-order function that allows you to transform each element of an array into a new form. It takes a closure (a function) as its argument, which defines how each element should be transformed.
- In this code, `map` is used to create an array of tuples. Each tuple contains the value of the element and its original index. For example, if we have an array `[10, 20, 30]`, using `map` with `enumerated()` will give us `[(0, 10), (1, 20), (2, 30)]`, and then we transform it to `[(10, 0), (20, 1), (30, 2)]` to keep the element and its index together.

We define a recursive function `findTwoSum` that takes two indices: `left` (starting from the beginning) and `right` (starting from the end) of the sorted array. Inside the function, we check if the sum of the elements at the `left` and `right` indices equals the target:
- If it does, we return the original indices of these elements from the `numsWithIndex` array.
- If the sum is less than the target, we move the `left` pointer one step to the right to increase the sum.
- If the sum is greater than the target, we move the `right` pointer one step to the left to decrease the sum.
- This process continues until a valid pair is found or the pointers cross each other.
- Finally, if no matching pair is found, we return an empty array.

#### Performance
- **Time Complexity:** `O(n log n)` due to the sorting step.
- **Space Complexity:** `O(n)` for storing the tuples with indices.
- **LeetCode Run Time:** `21` ms

#### Advantages
- More efficient than the brute-force approach, especially for larger inputs.
- Easy to understand and implement using the two-pointer technique.

#### Disadvantages
- Requires sorting the array, which can be an extra overhead.
- If the input array is already sorted, the benefit of sorting is lost, but the two-pointer technique still works well.

Okay, now let’s dive deeper into this algorithm. It might look complicated, but don’t be scared; it’s really simple once you get the hang of it. 

I used a method similar to `Binary Search` in this algorithm, but it’s not literally `Binary Search`. I won’t go into detail about Binary Search because it could take a long time. If you’re not familiar with this search algorithm, I suggest checking out some videos or articles to understand it better. Here are some resources you might want to check out:
- [DSA Binary Search](https://www.w3schools.com/dsa/dsa_algo_binarysearch.php)
- [iOS Interview - Binary Search Algorithms in Swift](https://antran.app/2024/leetcode_binary_search/#:~:text=Binary%20Search%20in%20Swift&text=The%20binarySearch%20function%20takes%20a,than%20or%20equal%20to%20high%20.)
- [Swift: Binary Search Algorithm (iOS Interview Prep) 2022](https://www.youtube.com/watch?v=GNNzTWedUrs)

After going through these resources, I believe you’ll have a clearer understanding of Binary Search. Now, let’s get back to discussing our algorithm for solving this problem.

The beauty of this approach lies in its efficiency. By sorting the array first, we can quickly narrow down our search space using two pointers. The left pointer moves right to find larger values, and the right pointer moves left to find smaller values. This way, we avoid unnecessary comparisons and reach our solution faster compared to a brute-force approach.

### Solution 3: Hash Map

```swift
class Solution {
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
```

#### How It Works
- We start by initializing an empty dictionary called `hashMap`, which will store numbers as keys and their corresponding indices as values. This is a key part of using a hash map because it allows us to quickly look up indices based on the numbers we've seen so far.

### What’s a Hash Map?
- A **hash map** (or dictionary in Swift) is a data structure that allows us to store key-value pairs. In our case, the key is the number from the array, and the value is its index. This makes it easy to check if we've seen a number before and to retrieve its index quickly.
- The time complexity for lookups in a hash map is `O(1)` on average, making it very efficient for our needs.

### What’s `enumerated()`?
- The **`enumerated()`** function is a method that returns a sequence of pairs (tuples), where each pair contains an index and the value from the original array. For example, if we have an array `[10, 20, 30]`, using `enumerated()` will give us `[(0, 10), (1, 20), (2, 30)]`.
- In this code, we use it to loop through the array with both the index and the value of each element. This way, we can easily access both the number and its position in the array while checking for the required pair.

The algorithm works as follows:
1. For each number in the input array, we calculate its **complement**, which is the difference between the `target` and the current number.
2. We check if this complement exists in our `hashMap`:
   - If it does, we have found our pair! We return the indices of the complement (from the hash map) and the current index.
   - If it doesn't exist, we store the current number and its index in the `hashMap` for future reference.
3. This process continues until we find a matching pair or finish iterating through the array. If no pair is found, we return an empty array.

#### Performance
- **Time Complexity:** `O(n)`, as we only pass through the array once.
- **Space Complexity:** `O(n)`, since we store up to `n` elements in the hash map.
- **LeetCode Run Time:** `21` ms

#### Advantages
- Very efficient for large inputs due to linear time complexity.
- Easy to implement and understand with a single loop.

#### Disadvantages
- Uses extra memory for the hash map, which might be a concern for very large datasets.

## Conclusion

This document presented three different solutions to the **Two Sum** problem. Each approach has its strengths and weaknesses:

### 1. Brute Force
- **Advantages:** Simple to understand and implement; no additional data structures are required.
- **Disadvantages:** Slow for large arrays due to its quadratic time complexity, making it inefficient for larger datasets.

### 2. Two Pointer Technique
- **Advantages:** More efficient than the brute-force approach, especially for sorted inputs; utilizes a clear and logical method of narrowing down the search space.
- **Disadvantages:** Requires sorting the array, which adds an extra time overhead; not as straightforward for unsorted inputs.

### 3. Hash Map
- **Advantages:** Highly efficient with linear time complexity, making it the best choice for large inputs; easy to implement using a single pass through the array.
- **Disadvantages:** Uses additional memory for the hash map, which can be a downside for very large datasets.

Each of these solutions serves a specific purpose and can be applied based on the context of the problem. Developers should remember that not every algorithm is the best fit for every scenario. Testing different algorithms in a sandbox environment is crucial for finding the most effective solution for each situation. This approach allows you to evaluate which method works best and how well it performs under varying conditions.

In short, being open to trying different methods in coding can lead to better and more efficient solutions.

## Contact

If you have any questions about this documentation or would like to provide feedback or suggest better solutions for this problem, please feel free to reach out to me. You can contact me at:

- LinkedIn: [www.linkedin.com/in/metehan-belli](https://www.linkedin.com/in/metehan-belli)
- Email: [metehanbelli8@gmail.com](mailto:metehanbelli8@gmail.com)

I would be happy to assist you with any issues you may have!
