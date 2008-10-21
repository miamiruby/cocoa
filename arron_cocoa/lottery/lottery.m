#import <Foundation/Foundation.h> 
#import "LotteryEntry.h" 
int main (int argc, const char *argv[]) { 
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init]; 

	// Create the date object 
	NSCalendarDate *now = [[NSCalendarDate alloc] init]; 
	
	// Seed the random number generator 
	srandom(time(NULL)); 

    NSMutableArray *array; 
    array = [[NSMutableArray alloc] init]; 

    int i; 
    for (i = 0; i < 10; i++){ 
		// Create a date/time object that is 'i' weeks from now 
		NSCalendarDate *iWeeksFromNow; 
		iWeeksFromNow = [now dateByAddingYears:0 
										months:0 
										  days:(i * 7) 
										 hours:0 
									   minutes:0 
									   seconds:0]; 

		// Create a new instance of LotteryEntry basic way
		//LotteryEntry *newEntry = [[LotteryEntry alloc] init]; 
		//[newEntry setEntryDate:iWeeksFromNow]; 

		//Create a new instance of LotteryEntry with params
		LotteryEntry *newEntry; 
		newEntry = [[LotteryEntry alloc] initWithEntryDate:iWeeksFromNow]; 
		[array addObject:newEntry]; 
		[newEntry release]; 
		
    } 
	// Done with 'now' 
	[now release]; 
	now = nil; 
    for (LotteryEntry *entryToPrint in array) { 
        NSLog(@"%@", entryToPrint); 
    } 
	// Done with 'array' 
	[array release]; 
	array = nil; 
    [pool drain]; 
    NSLog(@"GC = %@", [NSGarbageCollector defaultCollector]); 
	return 0; 
} 
