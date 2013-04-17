//
//  NVDocument.h
//  BookExplorer DB
//
//  Created by Влад on 15.02.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVTableView.h"

#define kBookExplorerDocumentType @"com.nvlad.bookexplorer.document"
#define kBookExplorerExtension @"nbl"

@class NVLibrary;

@interface NVDocument : NSDocument <NSTableViewDataSource, NSTableViewDelegate> {
	NVLibrary * library;
}

@property IBOutlet NVTableView *writterTableView;
@property (unsafe_unretained) IBOutlet NSTextField *statusString;
@property (unsafe_unretained) IBOutlet NSSegmentedControl *viewMode;

-(IBAction)onBooksAddMenu:(id)sender;
-(IBAction)onViewModeMenu:(id)sender;
-(IBAction)onDoubleClick:(id)sender;
-(IBAction)onDeletePressed:(id)sender;
-(IBAction)selectViewMode:(id)sender;

-(void)columnWithIdentifer:(NSString *)identifer setHidden:(BOOL)hidden;
-(void)columnWithIdentifer:(NSString *)identifer setWidth:(CGFloat)width;

-(NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView;
-(id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex;

@end
