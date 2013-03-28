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

-(id)target {
	return target;
}

-(void)setTarget:(id)anObject {
	target = anObject;
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
	if(key == NSDeleteCharacter)
	{
//		SEL action = NSSelectorFromString(self.onDeletePressed);
		[self performDeleteAction];
		return;
	}
	[super keyDown:theEvent];
}

-(void)performDeleteAction {
	[target performSelector:deleteAction withObject:self];
}

//- (void)drawRect:(NSRect)dirtyRect
//{
//    // Drawing code here.
//	[super drawRect:dirtyRect];
//}

@end
