//
//  NVTableView.m
//  BookExplorer DB
//
//  Created by Vlad Nikishin on 27.03.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import "NVTableView.h"

@implementation NVTableView

//@synthesize deleteAction;

-(SEL)deleteAction {
	return deleteAction;
}

-(void)setDeleteAction:(SEL)selector {
	deleteAction = selector;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

-(void)keyDown:(NSEvent *)theEvent {
	unichar key = [[theEvent charactersIgnoringModifiers] characterAtIndex:0];
	switch (key) {
		case NSDeleteCharacter:
			[self performDeleteAction];
			break;
		case ' ':
			break;
		default:
			[super keyDown:theEvent];
			break;
	}
}

-(void)performDeleteAction {
	[self.target performSelector:deleteAction withObject:self];
}

//- (void)drawRect:(NSRect)dirtyRect
//{
//    // Drawing code here.
//	[super drawRect:dirtyRect];
//}

@end
