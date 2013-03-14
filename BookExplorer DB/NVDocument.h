//
//  NVDocument.h
//  BookExplorer DB
//
//  Created by Влад on 15.02.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define kBookExplorerDocumentType @"com.nvlad.bookexplorer.document"
#define kBookExplorerExtension @"nbl"

@interface NVDocument : NSDocument
{
	NSMutableArray *books;
}

-(IBAction) onBooksAddMenu:(id)sender;

@end
