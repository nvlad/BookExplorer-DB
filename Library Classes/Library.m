//
//  Library.m
//  BookExplorer
//
//  Created by Администратор on 04.12.12.
//  Copyright (c) 2012 NVlad. All rights reserved.
//

//#import "BookDataSource.h"
#import "Library.h"
#import "Author.h"
#import "Sequence.h"
#import "Book.h"
#import "FB2.h"

@implementation Library

#define kBooks @"Books"
#define kSeries @"Series"
#define kAuthors @"Authors"


@synthesize authors, sequences, books;

-(void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:books	forKey:kBooks];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
	NSLog(@"Library - initWithCoder");
	NSArray *tmp = [aDecoder decodeObjectForKey:kBooks];
	for (NSInteger i = 0; i < [tmp count]; i++) {
		[self addBook:[tmp objectAtIndex:i]];
	}
	return self;
	
}

-(NSInteger)getAuthorIndex:(BookDataSource *)book {
	NSInteger index = [authors indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
		if ([[[book author] description] isEqualToString:[obj description]]) {
			*stop = YES;
			return YES;
		}
		return NO;
	}];
	return index;
}
-(NSInteger)getSequnceIndex:(BookDataSource *)book {
	NSString *sequenceTitle = [book sequence];
	NSInteger index = [sequences indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop){
		if ([sequenceTitle isEqualToString:[obj title]]) {
			*stop = YES;
			return YES;
		}
		return NO;
	}];
	return index;
}
-(NSInteger)getBookIndex:(BookDataSource *)book {
	NSString *bookId = [book bookId];
	NSInteger index = [books indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop){
		if ([bookId isEqualToString:[obj bookId]]) {
			*stop = YES;
			return YES;
		}
		return NO;
	}];
	return index;
}

-(void)addBook:(BookDataSource *)bookSource {
	if (!books) {
		authors = [[NSMutableArray alloc] init];
		sequences = [[NSMutableArray alloc] init];
		books = [[NSMutableArray alloc] init];
	}
	if ([self getBookIndex:bookSource] != NSNotFound) {
		NSLog(@"Book with ID \"%@\" exist on library", [bookSource bookId]);
		return;
	}
	Book *book = [[Book alloc] initWithBook:bookSource];
	[books addObject:book];
	
	Author *author;
	NSInteger authorIndex = [self getAuthorIndex:bookSource];
	if (authorIndex == NSNotFound) {
		NSLog(@"New author \"%@\"", [bookSource author]);
		author = [[Author alloc] initWithBookDataSource:bookSource];
		[author addBook:book];
		[authors addObject:author];
	} else {
		author = [authors objectAtIndex:authorIndex];
		[author addBook:book];
	}
	[book setAuthor:author];
	
	if ([bookSource.sequence isNotEqualTo:@""]) {
		Sequence *sequence;
		NSInteger sequenceIndex = [self getSequnceIndex:bookSource];
		if (sequenceIndex == NSNotFound) {
			NSLog(@"New sequence \"%@\"", [bookSource sequence]);
			sequence = [[Sequence alloc] init:[[bookSource sequence] description] withAuthor:author];
			[author addSequence:sequence];
			[sequences addObject:sequence];
		} else {
			sequence = [sequences objectAtIndex:sequenceIndex];
		}
		[sequence addBook:book];
		[book setSequence:sequence];
	}
//	[books addObject:book];
}

-(void)removeBooks:(NSSet *)objects {
	
}
-(void)removeBooksObject:(Book *)object {
	if ([object sequence]) {
		[object.sequence removeBooksObject:object];
		if ([object.sequence bookCount] == 0) {
			[object.author removeSequencesObject:[object sequence]];
			[self.sequences removeObject:[object sequence]];
		}
	}
	[object.author removeBooksObject:object];
	if ([object.author bookCount] == 0) {
		[authors removeObject:[object author]];
	}
	[self.books removeObject:object];
}
-(void)removeBooksAtIndexes:(NSIndexSet *)indexes{
		for (NSInteger row = [indexes lastIndex]; row != NSNotFound; row = [indexes indexLessThanIndex:row]) {
			[self removeBooksObject:[self.books objectAtIndex:row]];
		}
}

-(void)removeSequences:(NSSet *)objects {
	
}
-(void)removeSequencesObject:(Sequence *)object {
	Book *book;
	for (NSInteger i = [object.books count] -1; i >= 0; i--) {
		book = [object.books objectAtIndex:i];
		[object.author removeBooksObject:book];
		[object.books removeObject:book];
		[books removeObject:book];
	}
	[object.author.sequences removeObject:object];
	[sequences removeObject:object];
	if ([object.author.books count] == 0)
		[authors removeObject:[object author]];
}
-(void)removeSequencesAtIndexes:(NSIndexSet *)indexes {
	for (NSInteger row = [indexes lastIndex]; row != NSNotFound; row = [indexes indexLessThanIndex:row]) {
		[self removeSequencesObject:[self.sequences objectAtIndex:row]];
	}
}

-(void)removeAuthors:(NSSet *)objects {
	
}
-(void)removeAuthorsObject:(Author *)object {
	Book *book;
	for (NSInteger i = [object.books count] -1; i >= 0; i--) {
		book = [object.books objectAtIndex:i];
		[object.author removeBooksObject:book];
		[object.books removeObject:book];
		[books removeObject:book];
	}
	[object.author.sequences removeObject:object];
	[sequences removeObject:object];
	if ([object.author.books count] == 0)
		[authors removeObject:[object author]];
	
}
-(void)removeAuthorsAtIndexes:(NSIndexSet *)indexes {
	for (NSInteger row = [indexes lastIndex]; row != NSNotFound; row = [indexes indexLessThanIndex:row]) {
		[self removeAuthorsObject:[self.authors objectAtIndex:row]];
	}
}

-(void)loadBookFromURL:(NSURL *)url {
	[self loadBookFromFile:[url path]];
}
-(void)loadBookFromFile:(NSString *)file {
	if ([file hasSuffix:@".fb2"]) {
		BookDataSource *bookDataSource = [[FB2 alloc] initWithFile:file];
//		Book *book = [[Book alloc] initWithBook: bookDataSource];
		[self addBook:bookDataSource];
	}
}
-(void)loadBooksFromPath:(NSString *)path {
	NSFileManager *fileMgr = [NSFileManager defaultManager];
	NSArray *bookList = [fileMgr contentsOfDirectoryAtPath:path error:nil];
	NSInteger bookCount = [bookList count];
    
	for (NSInteger j = 0; j < bookCount; j++) {
		NSString *filename = [NSString stringWithFormat:@"%@/%@", path, [bookList objectAtIndex:j]];
		[self loadBookFromFile:filename];
	}
}

@end
