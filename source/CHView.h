//
//  CHView.h
//  Crosshairs
//
//  Created by Zach Waugh on 9/23/10.
//  Copyright 2010 zachwaugh.com. All rights reserved.
//


typedef enum
{
	CHResizeTopLeft,
	CHResizeTopCenter,
	CHResizeTopRight,
	CHResizeRightCenter,
	CHResizeBottomRight,
	CHResizeBottomCenter,
	CHResizeBottomLeft,
	CHResizeLeftCenter
} CHResizeDirection;

#import <Cocoa/Cocoa.h>

@interface CHView : NSView
{
	NSPoint startPoint;
	NSPoint lastPoint;
	NSRect overlayRect;

	NSDictionary *textAttrs;
	
	NSColor *fillColor;
	
	NSCursor *crosshairsCursor;
	NSCursor *resizeRightDiagonalCursor;
	NSCursor *resizeLeftDiagonalCursor;
	
	CHResizeDirection resizeDirection;
	
	float fillOpacity;
	
	BOOL alternateColor;
	BOOL dragging;
	BOOL drawing;
	BOOL resizing;
	BOOL shiftPressed;
	BOOL commandPressed;
}

@property(assign) NSPoint startPoint;
@property(assign) NSPoint lastPoint;
@property(assign) NSRect overlayRect;
@property(retain) NSColor *fillColor;
@property(retain) NSDictionary *textAttrs;
@property(retain) NSCursor *crosshairsCursor;
@property(retain) NSCursor *resizeRightDiagonalCursor;
@property(retain) NSCursor *resizeLeftDiagonalCursor;
@property(assign) CHResizeDirection resizeDirection;
@property(assign) float fillOpacity;
@property(assign, getter=isDragging) BOOL dragging;
@property(assign, getter=isDrawing) BOOL drawing;
@property(assign, getter=isResizing) BOOL resizing;
@property(assign, getter=isShiftPressed) BOOL shiftPressed;
@property(assign, getter=isCommandPressed) BOOL commandPressed;
@property(assign, getter=isAlternateColor) BOOL alternateColor;

@end
