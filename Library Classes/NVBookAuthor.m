//
//  NVBookAuthor.m
//  NVARCTest
//
//  Created by Vlad Nikishin on 05.04.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import "NVBookAuthor.h"
#import "NVBook.h"
#import "NVAuthor.h"

@implementation NVBookAuthor

@synthesize book = _book, author = _author;

-(id)initWithBook:(NVBook *)book andAuthor:(NVAuthor *)author {
	self = [super init];
	if (self) {
		[self setBook:book];
		[self setAuthor:author];
	}
	return self;
}

-(NSString *)description {
	return [NSString stringWithFormat:@"%@ - %@", [_author name], [_book title]];
}

-(NSString *)authorName {
	return [_author name];
}

@end