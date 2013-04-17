//
//  NVBookSequences.m
//  NVARCTest
//
//  Created by Vlad Nikishin on 04.04.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import "NVBookSequence.h"

@implementation NVBookSequence

@synthesize book = _book, sequence = _sequence, part = _part;

-(id)initWithBook:(NVBook *)book andWithSequence:(NVSequence *)sequence andPart:(NSInteger)part {
	self = [super init];
	if (self) {
		_book = book;
		_sequence = sequence;
		_part = part;
	}
	return self;
}

-(NSString *)title {
	return [_sequence title];
}

-(NSString *)description {
	return [NSString stringWithFormat:@"%@ - %@ #%ld", [_sequence title], [_book title], _part];
}

@end
