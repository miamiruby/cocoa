#import "GameBoard.h"


@implementation GameBoard

//designated initializer for superclass
- (id) initWithFrame:(NSRect) frame {
    if (self = [super initWithFrame: frame]) {
        //set up player colors
        playerColors[PLAYER_1] = [NSColor redColor];
        playerColors[PLAYER_2] = [NSColor blackColor];
        
        //set up board colors
        boardColors[0] = [NSColor lightGrayColor];
        boardColors[1] = [NSColor darkGrayColor];
        
        //initialize board
        int i; int j;
        for (i=0; i< DIMENSION; i++)
            for (j=0; j <DIMENSION; j++) {
                board[i][j] = EMPTY;
                piecesPaths[i][j] = nil;
            }
		
        //set up initial layout for a game of LOA
        for (i=0; i <DIMENSION; i += DIMENSION-1)
            for (j=1; j <DIMENSION-1; j++) {

				NSLog(@"player_1 x = %d, y = %d", i, j);
				NSLog(@"player_2 x = %d, y = %d", j, i);

                board[i][j] = PLAYER_1;
                board[j][i] = PLAYER_2;
            }
		
        //nothing is hovered or selected yet
        hoveredCoord = NIL_POINT;
        selectedCoord = NIL_POINT;
        
        //current dimension of a square on the board
        squareDim = frame.size.width/DIMENSION;
    }
    
    return self;
}

//outlets, etc. have been setup by here...
- (void)awakeFromNib {    
    //keep the window a square if the user resizes
    //(also remember to set the springs in interface builder)
    [[self window] setContentAspectRatio:NSMakeSize(1.0,1.0)];
    
    //register for mouse events
    [[self window] setAcceptsMouseMovedEvents: YES];
}

//for receiving mouse events
- (BOOL) acceptsFirstResponder {
    return YES;
} 

//recalculate the dimension for a board square when the view is resized
- (void) setFrame: (NSRect) frame {
    [super setFrame: frame];
    squareDim = frame.size.width/DIMENSION;
}


//draws the view, although never called explicitly
- (void)drawRect:(NSRect)rect {
    [self drawBoardBackgroundInRect:rect];
    
    //draw all pieces on the board by using the "board"
    //also store the bezier paths for detecting mouseovers
    int i; int j;
    for (i=0; i < DIMENSION; i++)
        for (j=0; j < DIMENSION; j++)
            if (board[i][j] == PLAYER_1) {
                if (piecesPaths[i][j] != nil)
                    [piecesPaths[i][j] release];
                
                piecesPaths[i][j] = [[self drawPieceForCoord:NSMakePoint(i,j) andPlayer:PLAYER_1] retain];
            }
			else if (board[i][j] == PLAYER_2) {
				if (piecesPaths[i][j] != nil)
					[piecesPaths[i][j] release];
				
				piecesPaths[i][j] = [[self drawPieceForCoord:NSMakePoint(i,j) andPlayer:PLAYER_2] retain];
			}
}

//clean up piecesPaths
- (void)dealloc {    
    int i; int j;
    for (i=0; i< DIMENSION; i++)
        for (j=0; j< DIMENSION; j++)
            if (piecesPaths[i][j] != nil)
                [piecesPaths[i][j] release];
    
    [super dealloc];
}

//the board should have a checkered appearance
-(NSColor*)squareColorForBoardCoord:(NSPoint)p {
    return ((int)p.x % 2 == (int)p.y % 2) ? boardColors[0] : boardColors[1]; 
}

//draw the background of the board
- (void)drawBoardBackgroundInRect:(NSRect)rect {
    int i; int j;
    for (i=0; i < DIMENSION; i++)
        for (j=0; j < DIMENSION; j++) {
            [[self squareColorForBoardCoord:NSMakePoint(i,j)] set];
            [self drawRectForBoardCoord:NSMakePoint(i,j)];            
        }    
}

//call though to drawRectForBoardCoord:andHighlight: and default highlighting to NO
- (void) drawRectForBoardCoord:(NSPoint)p {
    [self drawRectForBoardCoord:p andHighlight:NO];
}

//given a board coordinate such as (1,1), draw that board square and optionally highlight it
- (void)drawRectForBoardCoord:(NSPoint)p andHighlight:(BOOL)h {
    if (!h)
        [NSBezierPath fillRect:[self rectForBoardCoord:p]];
    else {
        NSLog(@"highlighting");
        NSRect r = [self rectForBoardCoord:p];
        [[[self squareColorForBoardCoord:p] blendedColorWithFraction:0.6 ofColor:[NSColor yellowColor]] set];
        [NSBezierPath fillRect:r];
    }
}

//find the drawing area on the view that corresponds to the coordinate 
//board is like quadrant 1 of cartesian plane with origin in lower left.
- (NSRect) rectForBoardCoord:(NSPoint)p {
    NSRect rect = [self bounds];
    
    NSRect r;
    r.origin = NSMakePoint(rect.origin.x+ p.x*squareDim, rect.origin.y+ p.y*squareDim);
    r.size = NSMakeSize(squareDim, squareDim);
    
    return r;
}


//given a board coordinate such as (1,1), draw the piece, which may get highlighted
//if the mouse is hovering over it.
- (NSBezierPath*)drawPieceForCoord:(NSPoint)p andPlayer:(int)player {    
    NSRect r = [self rectForBoardCoord:p];
    
    //shrink the rectangle a bit so that pieces don't touch the edges
    r.origin.x += PIECE_MARGIN/2;
    r.origin.y += PIECE_MARGIN/2;
    r.size.width -= PIECE_MARGIN;
    r.size.height -= PIECE_MARGIN;
    
    NSBezierPath *path;
    
    path = [NSBezierPath bezierPathWithOvalInRect:r];
    
    if (hoveredCoord.x == p.x && hoveredCoord.y == p.y) {
        [[NSColor yellowColor] set];
        [path fill];
        
        NSRect highlightedRect = r;
        
        highlightedRect.origin.x +=HIGHLIGHT_MARGIN/2;
        highlightedRect.origin.y +=HIGHLIGHT_MARGIN/2;
        highlightedRect.size.width -= HIGHLIGHT_MARGIN;
        highlightedRect.size.height -= HIGHLIGHT_MARGIN;
        NSBezierPath *body = [NSBezierPath bezierPathWithOvalInRect:highlightedRect];
        
        [playerColors[player] set];
        [body fill];
    }
    else { 
        [playerColors[player] set];
        [path fill];
    }
    
    //Give your board pieces a nice texture with something like this...
    NSBezierPath *texture;
    while (r.size.width > 0) {
        r.origin.x += 2;
        r.origin.y += 2;
        r.size.width -= 4;
        r.size.height -= 4;
        texture = [NSBezierPath bezierPathWithOvalInRect:r];
        [[NSColor whiteColor] set];
        [texture stroke];
    }
    
    return path;
}

//based on a mouse click, determine the corresponding board coordinate
-(NSPoint)boardCoordForClickPoint:(NSPoint)p {
    int x=-1; int y=-1;
    
    while (p.x > 0) {  
        p.x -= squareDim;
        x++;
    }
    
    while (p.y > 0) {   
        p.y -= squareDim;
        y++;
    }
    
    return NSMakePoint(x,y);
}

//used for moving
- (void)movePieceFromCoord:(NSPoint)p1 toCoord:(NSPoint)p2 {
    NSLog(@"Attempting to move piece from (%f,%f) to (%f,%f)", p1.x,p1.y,p2.x,p2.y);
    
    //make sure move isn't in place
    if (p1.x == p2.x && p1.y == p2.y)
        return;
    
    //make sure there is a piece at p1
    if (board[(int)p1.x][(int)p1.y] == EMPTY)
        return;
    
    //update the board
    int player = board[(int)p1.x][(int)p1.y];
    board[(int)p1.x][(int)p1.y] = EMPTY;
    board[(int)p2.x][(int)p2.y] = player;
    
    [self setNeedsDisplay:YES];
}

- (void)mouseMoved:(NSEvent *)event {
    // get the mouse position in view coordinates
    NSPoint mouse;
    mouse = [self convertPoint: [event locationInWindow]  fromView: nil];
    
    //no need to redraw anything in this case, the piece is still highlighted
    if (hoveredCoord.x != NIL_POINT.x && hoveredCoord.y != NIL_POINT.y && 
        [piecesPaths[(int)hoveredCoord.x][(int)hoveredCoord.y] containsPoint: mouse])
        return;
    
    //otherwise, check to see if a piece is being moused over
    int i; int j;
    for (i = 0; i < DIMENSION; i++) 
        for (j = 0; j < DIMENSION; j++) 
            if (board[i][j] != EMPTY)
                if ([piecesPaths[i][j] containsPoint: mouse]) {
                    hoveredCoord = NSMakePoint(i,j);
                    [self setNeedsDisplay:YES];
                    return;
                }
	
	//no pieces were being moused over. no need to redraw unless we neeed
	//to un-highlight a piece
	if (hoveredCoord.x != NIL_POINT.x && hoveredCoord.y != NIL_POINT.y) {
		[self setNeedsDisplay:YES];
		hoveredCoord = NIL_POINT;
	}
} 

- (void)mouseDown:(NSEvent*)event {
    //get the mouse position in view coordinates
    NSPoint mouse;
    mouse = [self convertPoint: [event locationInWindow]  fromView: nil];
    
    //if there was a previous click, save it
    NSPoint previousPoint = NIL_POINT;
    if (selectedCoord.x != NIL_POINT.x && selectedCoord.y != NIL_POINT.y)
        previousPoint = selectedCoord;
    
    //get the new board square that was clicked in.
    selectedCoord = [self boardCoordForClickPoint:mouse];
    
    if (previousPoint.x != NIL_POINT.x && previousPoint.y != NIL_POINT.y) {
        [self movePieceFromCoord:previousPoint toCoord:selectedCoord];
        selectedCoord = NIL_POINT;
    }
}

@end
