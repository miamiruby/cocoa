//
//  Foo.m
//  RandomApp
//
//  Created by Paul Kruger on 10/20/08.
//  Copyright 2008 Speeduneed Inc. All rights reserved.
//

#import "Foo.h" 
@implementation Foo 
- (void)awakeFromNib 
{ 
    NSCalendarDate *now; 
    now = [NSCalendarDate calendarDate]; 
    [textField setObjectValue:now]; 
} 
- (IBAction)generate:(id)sender 
{ 
    // Generate a number between 1 and 100 inclusive 
    int generated; 
    generated = (random() % 100) + 1; 
    NSLog(@"generated = %d", generated); 
    // Ask the text field to change what it is displaying 
    [textField setIntValue:generated]; 
} 
- (IBAction)seed:(id)sender 
{ 
    // Seed the random number generator with the time 
    srandom(time(NULL)); 
    [textField setStringValue:@"Generator seeded"]; 
} 
@end 
