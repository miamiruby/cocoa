#import <Cocoa/Cocoa.h>

@interface AppController : NSObject 
{ 
	IBOutlet NSTextField *mytextField;
    IBOutlet NSTextField *mytextLabel;

} 
- (IBAction)countCharacters:(id)sender;
@end 
