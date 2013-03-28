//
//  Library.m
//  BookExplorer
//
//  Created by Администратор on 04.12.12.
//  Copyright (c) 2012 NVlad. All rights reserved.
//

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

- (void)addBook:(Book *)book {
	if (!books) {
		authors = [[NSMutableArray alloc] init];
		sequences = [[NSMutableArray alloc] init];
		books = [[NSMutableArray alloc] init];
	}
	[books addObject:book];
	
	NSInteger aId = [authors indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop){
		if ([[book author] isEqualToString:[obj description]]) {
			*stop = YES;
			return YES;
		}
		return NO;
	}];
	Author *author;
	if (aId == NSNotFound) {
		NSLog(@"New author \"%@\"", [book author]);
		author = [[Author alloc] initWithBook:book];
		[authors addObject:author];
	} else {
//		NSLog(@"Author index: %ld", aId);
		author = [authors objectAtIndex:aId];
		[author addBook:book];
	}
	if ([book.sequence isNotEqualTo:@""]) {
		NSInteger sId = [sequences indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop){
			if ([[book sequence] isEqualToString:[obj title]]) {
				*stop = YES;
				return YES;
			}
			return NO;
		}];
		Sequence *sequence;
		if (sId == NSNotFound) {
			NSLog(@"New sequence \"%@\"", [book sequence]);
			sequence = [[Sequence alloc] init:[book sequence] withAuthor:author];
			[author addSequence:sequence];
			[sequences addObject:sequence];
		} else {
			sequence = [sequences objectAtIndex:sId];
		}
		[sequence addBook:book];
	}
}

- (void)loadBookFromURL:(NSURL *)url
{
	[self loadBookFromFile:[url path]];
}

- (void)loadBookFromFile:(NSString *)file {
	if ([file hasSuffix:@".fb2"]) {
		BookDataSource *bookDataSource = [[FB2 alloc] initWithFile:file];
		Book *book = [[Book alloc] initWithBook: bookDataSource];
		[self addBook:book];
	}
}


- (void)loadBooksFromPath:(NSString *)path {
	NSFileManager *fileMgr = [NSFileManager defaultManager];
	NSArray *bookList = [fileMgr contentsOfDirectoryAtPath:path error:nil];
	NSInteger bookCount = [bookList count];
    
	for (NSInteger j = 0; j < bookCount; j++) {
		NSString *filename = [NSString stringWithFormat:@"%@/%@", path, [bookList objectAtIndex:j]];
		[self loadBookFromFile:filename];
	}
}

@end