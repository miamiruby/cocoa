//
//  AppController.h
//  SpeakLine
//
//  Created by Paul Kruger on 10/21/08.
//  Copyright 2008 Speeduneed Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h> 
@interface AppController : NSObject 
{ 
    IBOutlet NSTextField *textField;
	NSSpeechSynthesizer *speechSynth; 
} 
- (IBAction)sayIt:(id)sender; 
- (IBAction)stopIt:(id)sender; 
@end 
