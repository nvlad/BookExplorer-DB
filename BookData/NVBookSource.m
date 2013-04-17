//
//  BookDataSource.m
//  BookExplorer DB
//
//  Created by Vlad Nikishin on 27.03.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import "NVBookSource.h"

@implementation NVBookSource

@synthesize bookId = _bookId,
				authors = _authors,
				translators = _translators,
				sequence = _sequence,
				part = _part,
				title = _title,
				file = _file,
				genres = _genres;

-(id)initFromDictionary:(NSDictionary *)data {
	self = [super init];
	if (self) {
		
	}
	return self;
}

@end
