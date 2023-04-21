# Heaps

## Heap Property

The **(binary) heap** date structure is an array object that we can view as nearly **complete binary tree**.

An array $A$ that represents a heap is an object with two attribute:

1.$A.length$,which (as usual) gives the number of elements in the array.  

2.$A.heap-size$,which represents how many elements in the heap are stored within array $A$.

**PS:** That is, although may $A[1..length]$ contain numbers, only the elements in $A[1..heap-size]$, where $0\le A.heap-size \le A.length$ are valid elements of the heap.

 The root of the tree is $A[1]$ and given the index i of a node, we can easily compute the indices of its parent, left child, and right child:
Father =$\lfloor i/2 \rfloor$  
left-child = $2i$  
right-child = $2i+1$  

![__2VU_CKDOGBMCOO0CH_9RR.png](https://s2.loli.net/2023/04/20/fKIctOQWk46sRNG.png)

## Classification

There are two kinds of binary heaps: **max-heaps** and **min-heaps**
### max-heaps:
In a max-heaps,the max-heaps property is that for every node i other than the root:
$$A[PARENT(i)] \ge A[i]$$
Thus,the largest elements in a max-heap is stored at the root.

### min-heaps:

In a min-heaps,the min-heaps property is that for every node i other than the root:
$$A[PARENT(i)] \le A[i]$$
Thus,the smallest elements in a min-heap is stored at the root.

