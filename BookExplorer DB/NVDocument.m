//
//  NVDocument.m
//  BookExplorer DB
//
//  Created by Влад on 15.02.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import "NVDocument.h"
#import "Library.h"
#import "Author.h"
#import "Sequence.h"
#import "Book.h"

@implementation NVDocument

#define kLibrary @"Library"

NSInteger currentViewMode = 0;

- (id)init
{
    self = [super init];
    if (self) {
		// Add your subclass-specific initialization here.
		 library = [[Library alloc] init];
//		 [books addObject:@"Hello, World!"];
		 [self setDisplayName:@"BookExplorer - Untitled"];
//		 [self setDraft:YES];
    }
    return self;
}

- (NSString *)windowNibName
{
	// Override returning the nib file name of the document
	// If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
	return @"NVDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
	[super windowControllerDidLoadNib:aController];
	// Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem
{
	return YES;
}

-(IBAction)onBooksAddMenu:(id)sender
{
	NSOpenPanel* openDlg = [NSOpenPanel openPanel];
	[openDlg setCanChooseFiles:YES];
	[openDlg setAllowsMultipleSelection:YES];
	[openDlg setCanChooseDirectories:NO];
	NSArray *types = [NSArray arrayWithObjects:@"fb2", @"epub", nil];
	[openDlg setAllowedFileTypes:types];
	if ([openDlg runModal] == NSOKButton) {
		NSArray* urls = [openDlg URLs];
		for (int i = 0; i < [urls count]; i++) {
			NSURL *url = [urls objectAtIndex:i];
			[library loadBookFromURL:url];
		}
		[self.writterTableView reloadData];
	}
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
	NSLog(@"Document type: %@", typeName);
	if ([typeName isEqualToString:kBookExplorerDocumentType]) {
		NSData *data;
		NSMutableDictionary *doc = [NSMutableDictionary dictionary];
		NSString *errorString;
//		NSLog(@"Books: %@", [NSKeyedArchiver archivedDataWithRootObject:library]);
		[doc setObject:[NSKeyedArchiver archivedDataWithRootObject:library] forKey:kLibrary];
		data = [NSPropertyListSerialization dataFromPropertyList:doc format:NSPropertyListXMLFormat_v1_0 errorDescription:&errorString];
		if (!data) {
			if (!outError) {
				NSLog(@"dataFromPropertyList failed with %@", errorString);
			} else {
				NSDictionary *errorUserInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"BookExplorer document couldn't be written", NSLocalizedDescriptionKey, (errorString ? errorString : @"An unknown error occured."), NSLocalizedFailureReasonErrorKey, nil];
				
				// In this simple example we know that no one's going to be paying attention to the domain and code that we use here.
				*outError = [NSError errorWithDomain:@"BookExplorerErrorDomain" code:-1 userInfo:errorUserInfo];
			}
			
		}
		return data;
	} else {
		if (outError) *outError = [NSError errorWithDomain:@"BookExplorerErrorDomain" code:-1 userInfo:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"Unsupported data type: %@", typeName] forKey:NSLocalizedFailureReasonErrorKey]];
	}
	// Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
	// You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
	//	NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
	//	@throw exception;
	return nil;
}

- (void)setLibrary:(Library *)data
{
	if (library != data) {
//		library = [data mutableCopy];
		library = data;
		NSLog(@"%@", library);
	}
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
	BOOL result = NO;
	// we only recognize one data type.  It is a programming error to call this method with any other typeName
	assert([typeName isEqualToString:kBookExplorerDocumentType]);
	
	NSString *errorString;
	NSDictionary *documentDictionary = [NSPropertyListSerialization propertyListFromData:data
																							  mutabilityOption:NSPropertyListImmutable
																											format:NULL errorDescription:&errorString];
	
	if (documentDictionary) {
		[self setLibrary:[NSKeyedUnarchiver unarchiveObjectWithData:[documentDictionary objectForKey:kLibrary]]];
		result = YES;
	} else {
		if (!outError) {
			NSLog(@"propertyListFromData failed with %@", errorString);
		} else {
			NSDictionary *errorUserInfo = [NSDictionary dictionaryWithObjectsAndKeys: @"BookExplorer document couldn't be read", NSLocalizedDescriptionKey, (errorString ? errorString : @"An unknown error occured."), NSLocalizedFailureReasonErrorKey, nil];
			
			*outError = [NSError errorWithDomain:@"BookExplorerErrorDomain" code:-1 userInfo:errorUserInfo];
		}
		result = NO;
	}
	// we don't want any of the operations involved in loading the new document to mark it as dirty, nor should they be undo-able, so clear the undo stack
	[[self undoManager] removeAllActions];
	return result;
	
	// Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
	// You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
	// If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
	//	NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
	//	@throw exception;
	return YES;
}

- (void)columnWithIdentifer:(NSString *)identifer setHidden:(BOOL)hidden
{
	NSInteger colId = [self.writterTableView columnWithIdentifier:identifer];
	NSTableColumn *col = [self.writterTableView.tableColumns objectAtIndex:colId];
	[col setHidden:hidden];
}

- (void)columnWithIdentifer:(NSString *)identifer setWidth:(CGFloat)width
{
	NSInteger colId = [self.writterTableView columnWithIdentifier:identifer];
	NSTableColumn *col = [self.writterTableView.tableColumns objectAtIndex:colId];
	[col setWidth:width];
}

- (IBAction)selectViewMode:(id)sender {
	NSInteger segment = [self.viewMode selectedSegment];
	if (currentViewMode != segment) {
		currentViewMode = segment;
		NSLog(@"Switch to %ld segment", currentViewMode);
		[self.writterTableView reloadData];
	}
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
	NSInteger count = 0;
	switch (currentViewMode) {
		case 0:
			count = [library.authors count];
			NSLog(@"Писатели");
			[self columnWithIdentifer:@"title" setHidden:YES];
			[self columnWithIdentifer:@"sequence" setHidden:YES];
			[self columnWithIdentifer:@"sequenceNum" setHidden:YES];
			[self columnWithIdentifer:@"bookCount" setHidden:NO];
//			[self.statusString setValue:[NSString stringWithFormat:<#(NSString *), ...#>]]
			break;
		case 1:
			count = [library.sequences count];
			[self columnWithIdentifer:@"title" setHidden:YES];
			[self columnWithIdentifer:@"sequence" setHidden:NO];
			[self columnWithIdentifer:@"sequenceNum" setHidden:YES];
			[self columnWithIdentifer:@"bookCount" setHidden:NO];
			break;
		case 2:
			count = [library.books count];
			[self columnWithIdentifer:@"bookCount" setHidden:YES];
			[self columnWithIdentifer:@"title" setHidden:NO];
			[self columnWithIdentifer:@"sequence" setHidden:NO];
			[self columnWithIdentifer:@"sequenceNum" setHidden:NO];
			break;
	}
	NSLog(@"Row in Table: %ld", count);
	return count;
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
	//	NSLog(@"%ld", rowIndex);
	//	NSLog(@"%@", identifier);
	//    NSLog(@"%@", [[library.books objectAtIndex:rowIndex] title]);
	//    if ([identifier isEqualToString:@"MainCell"]) {
	//	NSTableCellView *cellView = [[NSTableCellView alloc] init];
	//	NSTableCellView *cellView = [aTableView makeViewWithIdentifier:identifier owner:self];
	//	cellView.objectValue = [[library.books objectAtIndex:rowIndex] title];
	//	NSLog(@"%@ - %@", cellView.objectValue, [[library.books objectAtIndex:rowIndex] title]);
	//	return cellView;
	//    }
	NSString *identifier = [aTableColumn identifier];
	NSString *text;
	Author *author;
	Sequence *sequence;
	switch (currentViewMode) {
		case 0:
			author = [library.authors objectAtIndex:rowIndex];
			if ([identifier isEqual:@"author"])
				text = [NSString stringWithFormat:@"%@", author];
			else
				text = [author valueForKey:identifier];
			break;
		case 1:
			sequence = [library.sequences objectAtIndex:rowIndex];
			if ([identifier isEqual:@"sequence"])
				text = [NSString stringWithFormat:@"%@", [sequence title]];
			else if ([identifier isEqual:@"author"])
				text = [NSString stringWithFormat:@"%@", [sequence author]];
			else
				text = [[library.sequences objectAtIndex:rowIndex] valueForKey:identifier];
			break;
		case 2:
			text = [[library.books objectAtIndex:rowIndex] valueForKey:identifier];
			if ([identifier isEqual:@"sequenceNum"] && [[text description] isEqual:@"0"]) {
				//				NSLog(@"typeof text \"%@\"", [[text description] isEqual:@"0"]);
				Book *book = [library.books objectAtIndex:rowIndex];
				if (![book sequence] || [[book sequence] isEqual:@""])
					text = @"";
			}
			break;
	}
	//	NSString *text = [[library.books objectAtIndex:rowIndex] valueForKey:identifier];
	if (!text || [text isEqual:@"(null)"])
		text = @"";
	NSCell *cell = [[NSCell alloc] initTextCell:text];
	if ([identifier isEqual:@"sequenceNum"] || [identifier isEqual:@"bookCount"])
		[cell setAlignment:NSCenterTextAlignment];
	return cell;
	//	return nil;
	//	return [[library.Books objectAtIndex:rowIndex] author];
}

@end
