# Three step to solve the problem

**Divide:** the problem into a number of **subproblems** that are smaller instances of the same problem.

**Conquer:** the subproblems by solving them **recursively**. If the subproblems sizes are small enough, however, just solve the subproblems in a straightforward manner.

**Combine:** the solutions to the subproblems into the solution for original problem.

## Two case
**recursive base:** the subproblems are large enough to **solve recursively**

**base case:** the subproblems are smaller enough to **solve straightforwardly**

# Recurrences
#### Definition
It's a equation or inequality that describes a function in terms of its value on smaller inputs.
#### Example:Merge sort $\Omicron({n^2})$

$$
T(n)=\begin{cases}\Theta(1)&n = 1\\
2T(n/2)+\Theta(n) & n>1\end{cases}
$$

whose solution we claimed to be $T(n)=\Theta(nlgn)$
#### Technicalities in recurrences
In practice,we neglect certain technical details when we state and solve recurrences.For example ,if we call Merge-sort on n elements when n is odd.

Technically ,the recurrence describing the worst-case running time of Merge-sort is really.

$$
T(n)=\begin{cases}\theta(1)&n = 1\\
T(\lceil n/2 \rceil)+T(\lfloor n/2 \rfloor) + \Theta(n) & n>1\end{cases}
$$

When we state and solve recurrences,we often **omit floors,ceiling,and boundary conditions** .We forge ahead without these details and later determine whether or not they matter.

# Problems
## [The maximum-subarray problem](https://www.acwing.com/problem/content/50/)
#### A brute-force solution $\Omicron(nlgn)$
##### Analyse
A period of n days has $\big( _{2} ^{n} \big)$ such pairs of dates and $\big( _{2} ^{n} \big)$= $\Theta({n^2})$

##### Code
```
#include<iostream>
#include<cstdlib>
using namespace std;

int main()
{
	int n;
	cin>>n;
	int a[n];
	for(int i = 0; i < n; i++)
		cin>>a[i];
	int max_1 = -2147483648;
	for(int i = 0;i < n; i++)
	{
		int max_2 = -2147483648;
		int max_3 = 0;
		for(int j = i;j < n; j++)
		{	
			max_3 += a[j];
			if(max_2 < max_3)
				max_2 =max_3;
		}
		if(max_1 < max_2)
			max_1 = max_2;
	}
	cout<<max_1<<endl;
	return 0;
}
```

### A solution using divide-and-conquer
Suppose we want to find a maximum subarray of the subarray $A[low..high]$ .

As **Figure 4.4(a)** shows,any contiguous subarray $A[i..j]$ of $A[low..high]$ must lie in exactly one of the following place:
>1.entirely in the subarray $A[low..mid]$ ,so that $low \le i \le j \le mid$  
>2.entirely in the subarray $A[mid+1..high]$ ,so that $mid < i \le j \le high$  
>3.crossing the midpoint ,so that $low \le i \le mid < j \le high$

![截图 2023-04-12 17-22-57.png](https://s2.loli.net/2023/04/12/2uDEMPLYpr4otcB.png)


##### Code 
```
#include<iostream>
#include<cstdlib>
#include<climits>

using namespace std;
int findmaxsubarray(int num[],int left,int right);
int findmidmaxsubarry(int num[],int left,int mid,int right); 
int findmaxsubarray(int num[],int left,int right){
        if(left==right)
            return num[left];
        else{
            int mid=(left+right)/2;
            int left_max=findmaxsubarray(num, left,mid);
            int right_max=findmaxsubarray(num, mid+1, right);
            int mid_max=findmidmaxsubarry(num, left, mid, right);
            
            //判断返回三者最大值
            if(left_max>=right_max&&left>=mid_max)
                return left_max;
            else if(right_max>=left_max&&right_max>=mid_max)
                return right_max;
            else
                return mid_max;
        }
}
 
int findmidmaxsubarry(int num[],int left,int mid,int right){
    int  left_max=INT_MIN;
    int sum=0;
    //从中间向左依次加找到最大值
    for(int i=mid;i>=left;i--)
    {
            sum+=num[i];
        //当前值更大就更新左侧最大值
        if(sum>left_max)
            left_max=sum;
    }
    
    int right_max=INT_MIN;
    sum=0;
    //从中间向右依次加找到最大值
    for(int i=mid+1;i<=right;i++){
        sum+=num[i];
        //当前值更大就更新右侧最大值
        if(sum>=right_max)
            right_max=sum;
    }
    
    return left_max+right_max;
} 

int main()
{
	int n;
	cin>>n;
	int a[n];
	for(int i = 0; i < n; i++)
		cin>>a[i];
	int ans = findmaxsubarray(a,0,n-1);
	cout<<ans<<endl;
	return 0;
}

```

### DP $\Omicron(n)$

```
#include<iostream>
#include<cstdlib>
#include<climits>

using namespace std;
int DP(int num[], int n)
{
	int temp = 0;
	int sum = INT_MIN;
	for(int i = 0; i < n; i++)
	{
		if((temp + num[i]) < num[i])
			temp = num[i];
		else 
			temp += num[i];
		if(sum < temp)
			sum = temp;
	}
	return sum;
}

int main()
{
	int n;
	cin>>n;
	int a[n];
	for(int i = 0; i < n; i++)
		cin>>a[i];
	int ans = DP(a,n);
	cout<<ans<<endl;
	return 0;
}

```

## [Strassen’s algorithm for matrix multiplication](https://en.wikipedia.org/wiki/Strassen_algorithm#:~:text=In%20linear%20algebra%2C%20the%20Strassen,often%20better%20for%20smaller%20matrices.)

##### **PS**:It't too hard so I give a link and then you can learn it by wiki.
