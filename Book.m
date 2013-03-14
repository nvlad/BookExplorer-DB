//
//  Book.m
//  BookExplorer
//
//  Created by Администратор on 04.12.12.
//  Copyright (c) 2012 NVlad. All rights reserved.
//

#import "Book.h"

@implementation NSString (FileUtils)

+(NSString*)PathForFile:(NSString*)filename
{
    return [[NSBundle mainBundle] pathForResource:filename ofType:nil];
}

@end


@implementation Book

@synthesize bookData, author, sequence, sequenceNum, title;

- (id)initWithBook:(BookDataSource*)book
{
	if (self = [super init]) {
		[self setTitle:[book title]];
		[self setFirstName:[book firstName]];
		[self setLastName:[book lastName]];
		[self setAuthor:[book author]];
		[self setSequence:[book sequence]];
		if (self.sequence) {
			[self setSequenceNum:[book sequenceNum]];
		}
//        [self getBookInfo];
	}
	return self;
}


- (void)getBookInfo
{
	if (self.bookData) {
	}
}

- (void)getBookInfoFromFile:(NSString *)fileName
{
}

-(NSString*)description
{
    if (self.sequence)
        return [NSString stringWithFormat:@"%@ (Sequence: %@, Book No %ld)", self.title, self.sequence, self.sequenceNum];
    else
        return [NSString stringWithString:self.title];
}

@end
