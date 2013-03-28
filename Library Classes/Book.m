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

#define kBookId @"bookId"
#define kFirstName @"firstName"
#define kLastName @"lastName"
#define kTitle @"Title"
#define kSequence @"Sequence"
#define kSequenceNum @"sequenceNum"
#define kFile @"File"

@synthesize bookData, bookId, firstName, lastName, author, title, sequence, sequenceNum, file;

-(void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:bookId forKey:kBookId];
	[aCoder encodeObject:firstName forKey:kFirstName];
	[aCoder encodeObject:lastName forKey:kLastName];
	[aCoder encodeObject:title forKey:kTitle];
	[aCoder encodeObject:sequence forKey:kSequence];
	[aCoder encodeInt64:sequenceNum forKey:kSequenceNum];
	[aCoder encodeObject:file forKey:kFile];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
	bookId = [aDecoder decodeObjectForKey:kBookId];
	firstName = [aDecoder decodeObjectForKey:kFirstName];
	lastName = [aDecoder decodeObjectForKey:kLastName];
	author = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
	title = [aDecoder decodeObjectForKey:kTitle];
	sequence = [aDecoder decodeObjectForKey:kSequence];
	sequenceNum = [aDecoder decodeInt64ForKey:kSequenceNum];
	return self;
}

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
