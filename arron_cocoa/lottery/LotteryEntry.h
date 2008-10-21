//
//  LotteryEntry.h
//  lottery
//
//  Created by Paul Kruger on 10/20/08.
//  Copyright 2008 Speeduneed Inc. All rights reserved.
//

#import <Foundation/Foundation.h> 
@interface LotteryEntry : NSObject { 

    NSCalendarDate *entryDate; 
    int firstNumber; 
    int secondNumber; 

} 
- (id)initWithEntryDate:(NSCalendarDate *)theDate; 

- (void)setEntryDate:(NSCalendarDate *)date; 

- (NSCalendarDate *)entryDate; 

- (int)firstNumber; 

- (int)secondNumber; 

@end
