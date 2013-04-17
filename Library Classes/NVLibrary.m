//
//  NVLibrary.m
//  NVARCTest
//
//  Created by Vlad Nikishin on 04.04.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import "NVLibrary.h"
#import "NVBook.h"
#import "NVBookAuthor.h"
#import "NVSequence.h"
#import "NVBookSequence.h"
#import "NVPerson.h"
#import "NVAuthor.h"
#import "NVSequenceAuthor.h"

#import "FB2.h"
#import "NVBookSource.h"
#import "NVBookSourceSequence.h"

@implementation NVLibrary

@synthesize books = _books, sequences = _sequences, authors = _authors;

-(id)init {
	self = [super init];
	if (self) {
		_books = [[NSMutableArray alloc] init];
		_sequences = [[NSMutableArray alloc] init];
		_authors = [[NSMutableArray alloc] init];
	}
	NSLog(@"[NVLibrary init]: %@", [self description]);
	return self;
}

-(NVBook *)bookAtBookId:(NSString *)bookId {
	NSInteger index = [_books indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop){
		if ([bookId isEqualToString:[obj bookId]]) {
			*stop = YES;
			return YES;
		}
		return NO;
	}];
	if (index != NSNotFound)
		return [_books objectAtIndex:index];
	return nil;
}
-(NVAuthor *)authorAtPerson:(NVPerson *)person {
	NSInteger index = [_authors indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop){
		if ([obj isEqualToPerson:person]) {
			*stop = YES;
			return YES;
		}
		return NO;
	}];
	if (index != NSNotFound)
		return [_authors objectAtIndex:index];
	
	return nil;
}

-(NVSequence *)sequenceAtBookSourceSequence:(NVBookSourceSequence *)bookSourceSequence {
	for (NVSequence *sequence in _sequences) {
		if ([[sequence title] isEqualToString:[bookSourceSequence title]])
			return sequence;
	}
	return nil;
}

-(NVSequence *)sequenceAtTitleInAuthors:(NSString *)title inAuthors:(NSArray *)authors {
	NVSequence *sequence;
	for (NVAuthor *author in authors) {
		sequence = [author sequenceAtTitle:title];
		if (sequence)
			return sequence;
	}
	return nil;
}

-(void)addBookFromBookSource:(NVBookSource *)bookSource {
	NVBook *book = [self bookAtBookId:[bookSource bookId]];
	if (book) {
		return;
	}
	book = [[NVBook alloc] initWithBookSource:bookSource];
	NVAuthor *author;
	NVSequence *sequence;
	NSMutableArray *authors = [[NSMutableArray alloc] init];
	[_books addObject:book];

	for (NVPerson *person in [bookSource authors]) {
		author = [self authorAtPerson:person];
		if (!author) {
			author = [[NVAuthor alloc] initWithPerson:person];
			[_authors addObject:author];
		}
		[authors addObject:author];
		NVBookAuthor *bookAuthor = [[NVBookAuthor alloc] initWithBook:book
																			 andAuthor:author];
		[author addBooksObject:bookAuthor];
		[book addAuthorsObject:bookAuthor];
	}

	for (NVBookSourceSequence *bookSourceSequence in [bookSource sequences]) {
		NVBookSequence *bookSequence = nil;
		for (author in authors) {
			sequence = [author sequenceAtTitle:[bookSourceSequence title]];
			if (!sequence) {
				sequence = [self sequenceAtTitleInAuthors:[bookSourceSequence title] inAuthors:authors];
				if (!sequence) {
					sequence = [[NVSequence alloc] initWithTitle:[bookSourceSequence title]];
					[_sequences addObject:sequence];
				}
				NVSequenceAuthor *sequenceAuthor = [[NVSequenceAuthor alloc] initWithAuthor:author
																									 andSequence:sequence];
				[sequence addAuthorsObject:sequenceAuthor];
				[author addSequencesObject:sequenceAuthor];
			}
			if (!bookSequence) {
				bookSequence = [[NVBookSequence alloc] initWithBook:book
																andWithSequence:sequence
																		  andPart:[bookSourceSequence part]];
				[sequence addBooksObject:bookSequence];
			}
			[book addSequencesObject:bookSequence];
		}
	}
}

-(void)removeBooks:(NSSet *)objects {
	
}
-(void)removeBooksObject:(NVBook *)object {
	NVSequence *sequence;
	NVAuthor *author;
	NVSequenceAuthor *sequenceAuthor;
	NVBookSequence *bookSequence;
	NVBookAuthor *bookAuthor;
	for (NSInteger i = [[object sequences] count]; i > 0; i-- ) {
		bookSequence = [[object sequences] objectAtIndex:0];
		sequence = [bookSequence sequence];
		[sequence removeBooksObject:bookSequence];
		if ([sequence bookCount] == 0) {
			[_sequences removeObject:sequence];
			for (NSInteger j = [[object authors] count]; j > 0; j--) {
				sequenceAuthor = [[object authors] objectAtIndex:0];
				[[sequenceAuthor author] removeSequencesObject:sequenceAuthor];
				[sequence removeAuthorsObject:sequenceAuthor];
			}
		}
		sequence = nil;
		[object removeSequencesObject:bookSequence];
	}
	for (NSInteger i = [[object authors] count]; i > 0; i--) {
		bookAuthor = [[object authors] objectAtIndex:0];
		author = [bookAuthor author];
		[author removeBooksObject:bookAuthor];
		if ([author bookCount] == 0) {
			[_authors removeObject:author];
		}
	}
	[_books removeObject:object];
}
-(void)removeBooksAtIndexes:(NSIndexSet *)indexes{
	for (NSInteger row = [indexes lastIndex]; row != NSNotFound; row = [indexes indexLessThanIndex:row]) {
		[self removeBooksObject:[_books objectAtIndex:row]];
	}
}
-(void)removeBooksAtIndex:(NSInteger)index {
	[self removeBooksObject:[_books objectAtIndex:index]];
}

-(void)removeSequences:(NSSet *)objects {
	
}
-(void)removeSequencesObject:(NVSequence *)object {
	for (NSInteger i = [object bookCount]; i > 0; i--) {
		[self removeBooksObject:[[[object books] objectAtIndex:0] book]];
	}
}
-(void)removeSequencesAtIndexes:(NSIndexSet *)indexes {
	for (NSInteger row = [indexes lastIndex]; row != NSNotFound; row = [indexes indexLessThanIndex:row]) {
		[self removeSequencesObject:[_sequences objectAtIndex:row]];
	}
}
-(void)removeSequencesAtIndex:(NSInteger)index {
	[self removeSequencesObject:[_sequences objectAtIndex:index]];
}

-(void)removeAuthors:(NSSet *)objects {
	
}
-(void)removeAuthorsObject:(NVAuthor *)object {
	for (NSInteger i = [object bookCount]; i > 0; i--) {
		[self removeBooksObject:[[[object books] objectAtIndex:0] book]];
	}
}
-(void)removeAuthorsAtIndexes:(NSIndexSet *)indexes {
	for (NSInteger row = [indexes lastIndex]; row != NSNotFound; row = [indexes indexLessThanIndex:row]) {
		[self removeAuthorsObject:[_authors objectAtIndex:row]];
	}
}
-(void)removeAuthorsAtIndex:(NSInteger)index {
	[self removeAuthorsObject:[_authors objectAtIndex:index]];
}

-(void)loadBookFromURL:(NSURL *)url {
	[self loadBookFromFile:[url path]];
}
-(void)loadBookFromFile:(NSString *)file {
	if ([file hasSuffix:@".fb2"]) {
		NVBookSource *bookDataSource = [[FB2 alloc] initWithFile:file];
		//		Book *book = [[Book alloc] initWithBook: bookDataSource];
		[self addBookFromBookSource:bookDataSource];
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
