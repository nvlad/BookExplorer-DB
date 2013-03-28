//
//  NVTableView.h
//  BookExplorer DB
//
//  Created by Vlad Nikishin on 27.03.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NVTableView : NSTableView {

	SEL deleteAction;
//	id target;
}

-(SEL)deleteAction;
-(void)setDeleteAction:(SEL)selector;

@end
