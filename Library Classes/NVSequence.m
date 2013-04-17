//
//  NVSequence.m
//  NVARCTest
//
//  Created by Vlad Nikishin on 04.04.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import "NVSequence.h"

@implementation NVSequence

@synthesize title = _title, authors = _authors, books = _books, bookCount = _bookCount;

-(id)init {
	self = [super init];
	if (self) {
		_authors = [[NSMutableArray alloc] init];
		_books = [[NSMutableArray alloc] init];
		_bookCount = 0;
	}
	return self;
}

-(id)initWithTitle:(NSString *)title {
	self = [self init];
	if (self) {
		_title = title;
	}
	return self;
}

-(void)addBooksObject:(NVBookSequence *)object {
	[_books addObject:object];
	_bookCount = [_books count];
}
-(void)removeBooksObject:(NVBookSequence *)object {
	[_books removeObject:object];
	_bookCount = [_books count];
}

-(void)addAuthorsObject:(NVSequenceAuthor *)object {
	[_authors addObject:object];
}

-(void)removeAuthorsObject:(NVSequenceAuthor *)object {
	[_authors removeObject:object];
}

-(NSString *)author {
	return [[_authors valueForKey:@"authorName"] componentsJoinedByString:@", "];
}

@end
