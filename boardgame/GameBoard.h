#import <Cocoa/Cocoa.h>

//handy macro
#define NIL_POINT NSMakePoint(-1,-1)

//a few constants
enum {
    DIMENSION = 8,
    EMPTY = -1,
    PLAYER_1 = 0,
    PLAYER_2 = 1,
    PIECE_MARGIN = 4,
    HIGHLIGHT_MARGIN = 4
};

@interface GameBoard : NSView {  
    
    //our primary game board data structure
    int board[DIMENSION][DIMENSION];
    
    //the bezier paths make it easy to determine if a piece is being moused over
    NSBezierPath *piecesPaths[DIMENSION][DIMENSION];
    
    //handy ivars used with mouse-related events
    NSPoint hoveredCoord;
    NSPoint selectedCoord;
    
    //board specific attributes
    float squareDim;
    NSColor *playerColors[2];
    NSColor *boardColors[2];
}

//A few standard methods to override and get set up
- (BOOL)acceptsFirstResponder;
- (id)initWithFrame:(NSRect)frame;
- (void)awakeFromNib;
- (void)setFrame:(NSRect)frame;
- (void)dealloc;

//The workhorses
- (void)mouseDown:(NSEvent*)event;
- (void)mouseMoved:(NSEvent *)event;
- (void)drawRect:(NSRect)rect;


//Some domain specific methods
- (NSRect)rectForBoardCoord:(NSPoint)p;
- (NSColor*)squareColorForBoardCoord:(NSPoint)p;
- (void)drawRectForBoardCoord:(NSPoint)p andHighlight:(BOOL)h;
- (void)drawRectForBoardCoord:(NSPoint)p;
- (NSBezierPath*)drawPieceForCoord:(NSPoint)p andPlayer:(int)player;
- (NSPoint)boardCoordForClickPoint:(NSPoint)p;
- (void)movePieceFromCoord:(NSPoint)p1 toCoord:(NSPoint)p2;
- (void)drawBoardBackgroundInRect:(NSRect)rect;


@end

