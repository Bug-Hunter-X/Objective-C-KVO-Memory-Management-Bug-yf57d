# Objective-C KVO Memory Management Bug

This repository demonstrates a common, yet subtle, bug in Objective-C related to Key-Value Observing (KVO) and memory management.  Failing to remove KVO observers properly can lead to crashes when the observed object is deallocated. 

The `bug.m` file contains code that showcases the problematic behavior.  The `bugSolution.m` file demonstrates the correct way to handle KVO observer removal to prevent the memory management issues. 

## Bug Description
When an object is deallocated while still registered as a KVO observer, attempting to send KVO notifications to the observer (which now points to deallocated memory) will lead to a crash.  This can be tricky to track down, especially if the timing of events isn't always consistent.

## Solution
Always ensure that you remove KVO observers in the `-dealloc` method of your observer class.  This is crucial for preventing memory-related issues.  Alternatively, consider using a weak reference to the observed object to prevent retain cycles and memory leaks that could contribute to the problem.
