//
//  NVBookSourceSequence.m
//  NVARCTest
//
//  Created by Vlad Nikishin on 05.04.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import "NVBookSourceSequence.h"

@implementation NVBookSourceSequence

@synthesize title = _title, part = _part;

-(id)initWithTitle:(NSString *)title andPart:(NSInteger)part {
	self = [super init];
	if (self) {
		[self setTitle:title];
		[self setPart:part];
	}
	return self;
}

@end
