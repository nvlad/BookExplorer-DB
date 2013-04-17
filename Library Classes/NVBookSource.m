//
//  NVBookSource.m
//  NVARCTest
//
//  Created by Vlad Nikishin on 04.04.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import "NVBookSource.h"
#import "NVBookSourceSequence.h"

#import "NVAuthor.h"

@implementation NVBookSource

@synthesize bookId = _bookId,
				title = _title,
				file = _file,
				sequences = _sequences,
				authors = _authors,
				translators = _translators,
				genres = _genres;

-(id)init {
	self = [super init];
	if (self) {
		_sequences = [[NSMutableArray alloc] init];
		_authors = [[NSMutableArray alloc] init];
		_translators = [[NSMutableArray alloc] init];
		_genres = [[NSMutableArray alloc] init];
	}
	return self;
}

-(void)addSequence:(NSString *)title withPart:(NSInteger)part {
	NVBookSourceSequence *sequence = [[NVBookSourceSequence alloc] initWithTitle:title andPart:part];
	[_sequences addObject:sequence];
}
-(void)addAuthor:(NVPerson *)person {
	NVAuthor *author = [[NVAuthor alloc] initWithPerson:person];
	[_authors addObject:author];
}

@end
