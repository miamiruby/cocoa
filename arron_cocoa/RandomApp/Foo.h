//
//  Foo.h
//  RandomApp
//
//  Created by Paul Kruger on 10/20/08.
//  Copyright 2008 Speeduneed Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h> 

@interface Foo : NSObject { 

    IBOutlet NSTextField *textField; 

} 

-(IBAction)seed:(id)sender; 

-(IBAction)generate:(id)sender; 

@end 

