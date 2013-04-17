//
//  NVBook.m
//  NVARCTest
//
//  Created by Vlad Nikishin on 04.04.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import "NVBook.h"
#import "NVBookSource.h"
#import "NVSequence.h"
#import "NVBookSequence.h"

@implementation NVBook

@synthesize bookId = _bookId,
				title = _title,
				sequences = _sequences,
				authors = _authors,
				translators = _translators,
				genres = _genres;

-(id)initWithBookSource:(NVBookSource *)bookSource {
	self = [super init];
	if (self) {
		[self setBookId:[bookSource bookId]];
		[self setTitle:[bookSource title]];
		_sequences = [[NSMutableArray alloc] init];
		_authors = [[NSMutableArray alloc] init];
		_translators = [[NSMutableArray alloc] init];
		_genres = [[NSMutableArray alloc] init];
	}
	return self;
}

-(NVBookSequence *)bookSequenceAtSequence:(NVSequence *)sequence {
	for (NVBookSequence *bookSequence in _sequences)
		if ([sequence isEqual:[bookSequence sequence]])
			return bookSequence;
	return nil;
}

-(void)addAuthorsObject:(NVBookAuthor *)object {
	[_authors addObject:object];
}
-(void)removeAuthorsObject:(NVBookAuthor *)object {
	[_authors removeObject:object];
}

-(void)addSequencesObject:(NVBookSequence *)object {
	[_sequences addObject:object];
}
-(void)removeSequencesObject:(NVBookSequence *)object {
	[_sequences removeObject:object];
}

-(NSString *)author {
	return [[_authors valueForKey:@"authorName"] componentsJoinedByString:@", "];
}

-(NSString *)sequence {
	return [[_sequences valueForKey:@"title"] componentsJoinedByString:@", "];
}
-(NSString *)sequenceNum {
	return [[_sequences valueForKey:@"part"] componentsJoinedByString:@", "];
}

@end
