//
//  ViewController.swift
//  Sorting
//
//  Created by Karthi on 12/06/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var array = [5,2,3,6,4,1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Array before sorting \(array)")
        //bubbleSort(&array)
        //array = insertionSort(&array)
        //array = mergeAndSort(array)
        //quickSort(array: &array)
        selectionSort(array: &array)
        array = quickSort(arrayToSort: array)
        print("Array after sorting \(array)")
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //Remove duplicates in array
        let numbers = [1, 5, 3, 4, 5, 1, 3]
        let unique = numbers.removingDuplicates()
        print(unique)
    }

    //MARK: -Bubble Sort-
    func bubbleSort(_ array: inout [Int]) {
        for _ in 0...array.count {
            for value in 1...array.count - 1 {
                if(array[value - 1] > array[value]) {
                    let largest = array[value - 1]
                    array[value - 1] = array[value]
                    array[value] = largest
                }
            }
        }
    }
    
    //MARK: -Insertion Sort-
    func insertionSort(_ array: inout [Int]) -> [Int] {
        for firstNumberToCompare in 1...array.count - 1 {
            let currentValue = array[firstNumberToCompare]
            var previousIndex = firstNumberToCompare - 1
            while (previousIndex >= 0 && array[previousIndex] > currentValue) {
                array.swapAt(previousIndex, previousIndex + 1)
                previousIndex -= 1;
            }
        }
        return array
    }
    
    //MARK: -Merge Sort-
    func mergeAndSort(_ array: [Int]) -> [Int] {
        if array.count <= 1 {
            return array
        }
        let midValue = array.count/2
        let leftArray = mergeAndSort(Array(array[0..<midValue]))
        let rightArray = mergeAndSort(Array(array[midValue..<array.count]))
        return merge(leftArray: leftArray , rightArray: rightArray)
    }
    
    func merge(leftArray: [Int], rightArray: [Int]) -> [Int] {
        var orderedArray: [Int] = []
        var leftIndex = 0
        var rightIndex = 0
        while (leftIndex < leftArray.count && rightIndex < rightArray.count) {
            if(leftArray[leftIndex] < rightArray[rightIndex]) {
                orderedArray = orderedArray + [leftArray[leftIndex]]
                leftIndex += 1
            } else {
                orderedArray = orderedArray + [rightArray[rightIndex]]
                rightIndex += 1
            }
        }
        orderedArray = orderedArray + Array(leftArray[leftIndex..<leftArray.count]) + Array(rightArray[rightIndex..<rightArray.count])
        return orderedArray
    }

    //MARK: -Selection Sort-
    func selectionSort<T : Comparable>(array : inout [T]) {
        
        for index in 0..<array.count {
            let minimumValueIndex = getMinimumIndex(array: array, startIndex: index)
            if minimumValueIndex != index {
                array.swapAt(minimumValueIndex, index)
            }
        }
    }
    
    func getMinimumIndex<T : Comparable>(array: [T], startIndex: Int) -> Int {
        var minimumIndex = startIndex
        for index in startIndex..<array.count {
            if (array[minimumIndex] > array[index]) {
                minimumIndex = index
            }
        }
        return minimumIndex
    }
    
    //MARK: -Quick Sort-
    func quickSort(arrayToSort: [Int]) -> [Int] {
        if(arrayToSort.count == 1) {
            return arrayToSort
        }
        
        var leftArray = [Int]()
        var rightArray = [Int]()
        let pivotElement = arrayToSort.count - 1
        
        for index in 0..<pivotElement {
            if(arrayToSort[index] < arrayToSort[pivotElement]) {
                leftArray.append(arrayToSort[index])
            } else {
                rightArray.append(arrayToSort[pivotElement])
            }
        }
        
        var leftSortedArray: [Int]
        
        if(leftArray.count > 1) {
           leftSortedArray = quickSort(arrayToSort: leftArray)
        } else {
            leftSortedArray = leftArray
        }
        
        var rightSortedArray: [Int]
        
        if(rightArray.count > 1) {
            rightSortedArray = quickSort(arrayToSort: rightArray)
        } else {
            rightSortedArray = rightArray
        }
        
        let sortedArray = concatArray(leftArray: leftSortedArray, rightArray: rightSortedArray, pivotValue: arrayToSort[pivotElement])
        return sortedArray
    }
    
    func concatArray(leftArray: [Int], rightArray: [Int], pivotValue: Int) -> [Int] {
        var resultArray: [Int] = leftArray
        resultArray.append(pivotValue)
        for value in rightArray {
        resultArray.append(value)
        }
        return resultArray
    }
    
    /*
    
    func quickSort<T : Comparable> (array: inout[T]) {
        quickSort(array: &array, startIndex:0, endIndex: array.count-1)
    }
    
    func quickSort<T: Comparable> (array: inout [T], startIndex: Int, endIndex: Int) {
        if startIndex >= endIndex {
            return
        }
        let placedElement = partition(array: &array, startIndex:startIndex , endIndex: endIndex)
        quickSort(array: &array, startIndex: startIndex, endIndex: placedElement-1)
        quickSort(array: &array, startIndex: placedElement+1, endIndex: endIndex)
    }
    
    func partition<T: Comparable>(array: inout[T], startIndex: Int, endIndex: Int) -> Int {
        var q = startIndex
        for index in startIndex...endIndex {
            if(array[index] < array[endIndex]) {
                self.swap(leftValue: &array[q], rightValue: &array[index])
                q += 1
            }
        }
        self.swap(leftValue: &array[q], rightValue: &array[endIndex])
        return q
    }
    
    func swap<T: Comparable> (leftValue: inout T, rightValue: inout T) {
        (leftValue , rightValue) = (rightValue, leftValue)
    }
    */
}


//MARK: -Remove Duplicate in Array-
extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}


