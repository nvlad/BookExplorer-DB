//
//  NVAuthor.m
//  NVARCTest
//
//  Created by Vlad Nikishin on 04.04.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import "NVAuthor.h"
#import "NVSequence.h"
#import "NVBook.h"
#import "NVBookAuthor.h"
#import "NVSequenceAuthor.h"

@implementation NVAuthor

@synthesize sequences = _sequences, books = _books, bookCount = _bookCount;

-(id)initWithPerson:(NVPerson *)person {
	self = [super init];
	if (self) {
		[self setFirstName:[person firstName]];
		[self setMiddleName:[person middleName]];
		[self setLastName:[person lastName]];
		[self setNickname:[person nickname]];
		_sequences = [[NSMutableArray alloc] init];
		_books = [[NSMutableArray alloc] init];
	}
	return self;
}

-(NVSequence *)sequenceAtTitle:(NSString *)title {
	for (NVSequenceAuthor *sequenceAuthor in _sequences) {
		if ([[[sequenceAuthor sequence] title] isEqualToString:title])
			return [sequenceAuthor sequence];
	}
	return nil;
}

-(void)addBooksObject:(NVBookAuthor *)object {
	[_books addObject:object];
	_bookCount = [_books count];
}
-(void)removeBooksObject:(NVBookAuthor *)object {
	[_books removeObject:object];
	_bookCount = [_books count];
}

-(void)addSequencesObject:(NVSequenceAuthor *)object {
	[_sequences addObject:object];
}
-(void)removeSequencesObject:(NVSequenceAuthor *)object {
	[_sequences removeObject:object];
}
@end
