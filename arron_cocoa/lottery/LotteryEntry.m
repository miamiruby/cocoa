//
//  LotteryEntry.m
//  lottery
//
//  Created by Paul Kruger on 10/20/08.
//  Copyright 2008 Speeduneed Inc. All rights reserved.
//

#import "LotteryEntry.h" 

@implementation LotteryEntry 

- (id)init 
{ 
    return [self initWithEntryDate:[NSCalendarDate calendarDate]]; 
}

- (void)dealloc 
{ 
	NSLog(@"deallocing %@", self); 
	[entryDate release]; 
	[super dealloc]; 
}
- (id)initWithEntryDate:(NSCalendarDate *)theDate 
{ 
	if (![super init]) 
		return nil; 

	//correct
	NSAssert(theDate != nil, @"Argument must be non-nil"); 
	
	//wrong
	//NSAssert(theDate == nil, @"Argument must be nil"); 
	entryDate = [theDate retain]; 

    firstNumber = random() % 100 + 1; 
    secondNumber = random() % 100 + 1; 
    return self; 
} 

- (NSString *)description 
{ 
    NSString *result; 
	//org
	//result = [[NSString alloc] initWithFormat:@"%@ = %d and %d", [entryDate descriptionWithCalendarFormat:@"%b %d %Y"], firstNumber, secondNumber];
	
	//challenge
	result = [[NSString alloc] initWithFormat:@"%@ = %d and %d", [entryDate descriptionWithCalendarFormat:@"%a %m/%d/%y %I:%M %p"], firstNumber, secondNumber];
	
	[result autorelease]; 
    return result; 
} 

- (void)setEntryDate:(NSCalendarDate *)date 
{ 
	[date retain]; 
	[entryDate release]; 
    entryDate = date; 
} 

- (NSCalendarDate *)entryDate 
{ 
    return entryDate; 
} 

- (int)firstNumber 
{ 
    return firstNumber; 
} 

- (int)secondNumber 
{ 
    return secondNumber; 
} 

@end 

