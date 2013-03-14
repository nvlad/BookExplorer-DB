//
//  NVDocument.m
//  BookExplorer DB
//
//  Created by Влад on 15.02.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import "NVDocument.h"
#import "Library.h"

@implementation NVDocument

#define kLibrary @"Library"
//#define kSeries @"Series"
//#define kAuthors @"Authors"

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
	}
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
	NSLog(@"Document type: %@", typeName);
	if ([typeName isEqualToString:kBookExplorerDocumentType]) {
		NSData *data;
		NSMutableDictionary *doc = [NSMutableDictionary dictionary];
		NSString *errorString;
		NSLog(@"Books: %@", [NSKeyedArchiver archivedDataWithRootObject:library]);
		[doc setObject:library forKey:kLibrary];
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
		library = [data mutableCopy];
		NSLog(@"%@", library);
	}
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
	BOOL result = NO;
	// we only recognize one data type.  It is a programming error to call this method with any other typeName
	assert([typeName isEqualToString:kBookExplorerDocumentType]);
	
	NSString *errorString;
	NSDictionary *documentDictionary = [NSPropertyListSerialization propertyListFromData:data mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:&errorString];
	
	if (documentDictionary) {
		[self setLibrary:[documentDictionary objectForKey:kLibrary]];
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

@end
