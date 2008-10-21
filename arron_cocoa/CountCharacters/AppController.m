
#import "AppController.h" 

@implementation AppController

- (id)init 
{ 
    [super init]; 
    NSLog(@"init"); 
    return self; 
} 

- (IBAction)countCharacters:(id)sender 
{ 
	NSString *myinput = [mytextField stringValue];
	NSString *myoutput = [mytextLabel stringValue];
    // Is the string zero-length? 
    if ([myinput length] == 0) { 
        NSLog(@"string from %@ is of zero-length", myinput); 
        return; 
    } 
	//[myoutput value] = [myinput value];
	//NSLog(@"Have started to say: %d", [myinput length]); 

//	NSLog(@"%d has characters", [myinput stringValue]);
	NSLog(@"'%@' has %d characters", myinput, [myinput length]);
	NSLog(@"'%@' has %d characters", myoutput, [myoutput length]);
	
	NSString* concatedString = [NSString stringWithFormat:@"'%@' has %d characters", myoutput, [myoutput length]];	
	[mytextLabel setStringValue:concatedString];
} 
@end 
