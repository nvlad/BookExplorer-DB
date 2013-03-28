//
//  Sequence.m
//  BookExplorer
//
//  Created by Администратор on 04.12.12.
//  Copyright (c) 2012 NVlad. All rights reserved.
//

#import "Sequence.h"
#import "Book.h"

@implementation Sequence

@synthesize title, author, books, bookCount;

- (id)init:(NSString *)aTitle withAuthor:(Author *)aAuthor
{
	self = [super init];
	if (self) {
		title = aTitle;
		author = aAuthor;
		books = [[NSMutableArray alloc] init];
		
//		[self	addBook:book];
	}
	return self;
}

- (void)addBook:(Book *)book
{
	if (!books)
		books = [[NSMutableArray alloc] init];
	[books addObject:book];
	bookCount = [books count];
	NSLog(@"Sequence \"%@\" avaible %ld of books", title, bookCount);
}

@end
