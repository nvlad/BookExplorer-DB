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

@class Library;

@interface NVDocument : NSDocument
{
	Library * library;
}

-(IBAction) onBooksAddMenu:(id)sender;

@end
