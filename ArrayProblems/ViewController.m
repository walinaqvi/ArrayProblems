//
//  ViewController.m
//  ArrayProblems
//
//  Created by Haider, Wali (Contractor) on 4/3/17.
//  Copyright © 2017 AliCo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //**********************Duplicate elements***********************************************//
    NSArray *repeatedArray = [NSArray arrayWithObjects:@"Ram",@"Sham",@"hham",@"Wali",@"Ram",@"Wali", nil];
    [self printRepeatingElemntAndTimesInArray:repeatedArray];
    
    //**********************Missing number ***********************************************//
    NSArray *arrayWithMissingNumber = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:2],[NSNumber numberWithInt:5],[NSNumber numberWithInt:6],[NSNumber numberWithInt:7],[NSNumber numberWithInt:8],[NSNumber numberWithInt:9],[NSNumber numberWithInt:10], nil];
    [self printMissingNumberFromArray:arrayWithMissingNumber andRangeOfNumbers:10];
    
    //**********************Finding Largest,Smallest,Second largest,Second smallest ***********************************************//
    NSArray *arrayWithLargestNumber = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:2],[NSNumber numberWithInt:5],[NSNumber numberWithInt:6],[NSNumber numberWithInt:7],[NSNumber numberWithInt:8],[NSNumber numberWithInt:9],[NSNumber numberWithInt:10], nil];
    [self printLargetsAndSmallestFromArray:arrayWithLargestNumber];
    //**********************Buuble Sort ***********************************************//
    [self bubbleSortTheArray:[arrayWithLargestNumber mutableCopy]];
    //**********************QUICK Sort ***********************************************//
    [self quickSortTheArray:[arrayWithLargestNumber mutableCopy] startPoint:0 EndPoint:(int)arrayWithLargestNumber.count-1];



   
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 Mathod to print elements which are duplicate or repeated

 @param array array with duplicate elements
 */
- (void)printRepeatingElemntAndTimesInArray:(NSArray*)array
{
    NSMutableDictionary *arrayTempDictionary = [NSMutableDictionary new];
    for (int i=0; i<array.count;i++) {
        if ([arrayTempDictionary valueForKey:[array objectAtIndex:i]]) {
            NSLog(@"Repeated number:%@",[array objectAtIndex:i]);
        }else
        {
            [arrayTempDictionary setObject:@"not repeated" forKey:[array objectAtIndex:i]];
        }
    }
}

/**
 Mathod to print missing number from a series

 @param numbersArray array with all elements
 @param range range of series
 */
-(void)printMissingNumberFromArray:(NSArray*)numbersArray andRangeOfNumbers:(int)range
{
    int expectedSumOfRange = range*(range+1)/2;
    int actualSum = 0;
    for (NSNumber *values in numbersArray) {
        actualSum = actualSum+[values intValue];
    }
    int diffrence =expectedSumOfRange-actualSum;
    NSLog(@"Missing Number is:%d",diffrence);
}

/**
 Mathod to print largest,second largest,smallest,second smallest number from a array

 @param numbersArray array with numbers
 */
-(void)printLargetsAndSmallestFromArray:(NSArray*)numbersArray
{
    int largest = 0;
    int smallest =  (numbersArray.count>0)?[[numbersArray objectAtIndex:0] intValue]:0;//Initiate with any value which present in array
    int secondLargest = 0;
    int secondSmallest = 0;
    
    for (NSNumber *value in numbersArray) {
        if ([value intValue]>largest) {
            secondLargest = largest;
            largest = [value intValue];
        }
        if ([value intValue]<smallest) {
            secondSmallest = smallest;
            smallest = [value intValue];
        }
    }
    
    NSLog(@"Largest:%d Smallest:%d Second Largest:%d second Smallest:%d",largest,smallest,secondLargest,secondSmallest);
    
    
}


/**
 mathod to sort a array in ascending order using quick sort
 Concept: https://www.youtube.com/watch?v=MZaf_9IZCrc

 @param unsortedArray array which is not sorted
 @param startPoint start point of array(left)
 @param endPoint end point of array(right)
 */
- (void)quickSortTheArray:(NSMutableArray*)unsortedArray startPoint:(int)startPoint EndPoint:(int)endPoint
{
    NSDate *methodStartTime = [NSDate date];

   
    if (startPoint-endPoint<=0) {
        //***************Array is already sorted*******************
       
        //Print sorted Array
        NSLog(@"QuickSort:");
        [self printSortedArray:unsortedArray];

        //Now check how much time does it take to sort
        NSDate *methodFinishTime = [NSDate date];
        NSTimeInterval executionTime = [methodFinishTime timeIntervalSinceDate:methodStartTime];
        NSLog(@"executionTime Quick Sort = %f", executionTime);

        return;

    }else
    {
        //Array is not sorted yet
        int pivotPosition = (int)unsortedArray.count-1;//take last element as pivot
        int wallPosition = startPoint-1;//initially take wall left most
        for (int i=0; i<endPoint; i++) {
            if ([unsortedArray[i] intValue]<[unsortedArray[pivotPosition] intValue]) {
                wallPosition++;
                [self swapElementsOfArray:unsortedArray withFirstIndex:wallPosition andSecondIndex:i];
            }
        }
        //After for loop now we have all the lesser element on left of wall now place pivot next to wall
        [self swapElementsOfArray:unsortedArray withFirstIndex:wallPosition+1 andSecondIndex:pivotPosition];
        //Do the same recursively for both left and right array
        [self quickSortTheArray:unsortedArray startPoint:0 EndPoint:wallPosition];
        [self quickSortTheArray:unsortedArray startPoint:wallPosition+1 EndPoint:endPoint];

        
    }
  

   
    
}



/**
 mathod to sort a array in ascending order using Bubble sort
 Concept: https://www.youtube.com/watch?v=6Gv8vg0kcHc

 @param unsortArray array with unsorted elements
 */
- (void)bubbleSortTheArray:(NSMutableArray*)unsortArray
{
    NSDate *methodStartTime = [NSDate date];

    BOOL isSorted = NO;
    int lastSortedArrayPosition = (int)unsortArray.count-1;//because after each ittration last object will be sorted
    
    while (!isSorted) {
        isSorted = YES;
        for (int i=0; i<lastSortedArrayPosition; i++) {
            if ([unsortArray[i] intValue]>[unsortArray[i+1] intValue]) {
                
                [self swapElementsOfArray:unsortArray withFirstIndex:i andSecondIndex:i+1];
                isSorted = NO;
            }
        }
    }
   
    //Print sorted Array
    NSLog(@"BubbleSort:");
    [self printSortedArray:unsortArray];
   
    //Now check how much time does it take to sort
    NSDate *methodFinishTime = [NSDate date];
    NSTimeInterval executionTime = [methodFinishTime timeIntervalSinceDate:methodStartTime];
    NSLog(@"executionTime Bubble Sort = %f", executionTime);

}

/**
 mathod to swap elements

 @param unsortArray array in which we need to swap values
 @param indexFirst First values index
 @param secondIndex Second values Index
 */
- (void)swapElementsOfArray:(NSMutableArray*)unsortArray withFirstIndex:(int)indexFirst andSecondIndex:(int)secondIndex
{
    NSNumber *tepm = [unsortArray objectAtIndex:indexFirst];
    [unsortArray replaceObjectAtIndex:indexFirst withObject:[unsortArray objectAtIndex:secondIndex]];
    [unsortArray replaceObjectAtIndex:secondIndex withObject:tepm];
    
    
}

/**
 Mathod to print sorted

 @param sortedArray array with sorted elements
 */
-(void)printSortedArray:(NSArray*)sortedArray
{
    NSString *sortedValues = @"";
    for (int i=0; i<sortedArray.count-1; i++) {
        sortedValues = [NSString stringWithFormat:@"%@ %d",sortedValues,[sortedArray[i] intValue]];
    }
    NSLog(@"sorted array:%@",sortedValues);

}
@end
