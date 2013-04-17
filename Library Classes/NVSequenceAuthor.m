//
//  NVSequenceAuthor.m
//  NVARCTest
//
//  Created by Vlad Nikishin on 09.04.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import "NVSequenceAuthor.h"
#import "NVAuthor.h"
#import "NVSequence.h"

@implementation NVSequenceAuthor

@synthesize author = _author, sequence = _sequence;

-(id)initWithAuthor:(NVAuthor *)author andSequence:(NVSequence *)sequence {
	self = [super init];
	if (self) {
		_author = author;
		_sequence = sequence;
	}
	return self;
}

-(NSString *)authorName {
	return [_author name];
}

@end
