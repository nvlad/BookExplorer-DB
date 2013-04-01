//
//  Book.m
//  BookExplorer
//
//  Created by Администратор on 04.12.12.
//  Copyright (c) 2012 NVlad. All rights reserved.
//

#import "Book.h"
#import "Sequence.h"
#import "Author.h"

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

@synthesize bookData, bookId, author, sequence, sequenceNum, title, file;

-(void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:bookId forKey:kBookId];
	[aCoder encodeObject:title forKey:kTitle];
	[aCoder encodeInt64:sequenceNum forKey:kSequenceNum];
	[aCoder encodeObject:file forKey:kFile];
	[aCoder encodeObject:[self.author firstName] forKey:kFirstName];
	[aCoder encodeObject:[self.author lastName] forKey:kLastName];
	[aCoder encodeObject:[self.sequence title] forKey:kSequence];
}
-(id)initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
	bookId = [aDecoder decodeObjectForKey:kBookId];
	title = [aDecoder decodeObjectForKey:kTitle];
	sequenceNum = [aDecoder decodeInt64ForKey:kSequenceNum];
	//	firstName = [aDecoder decodeObjectForKey:kFirstName];
	//	lastName = [aDecoder decodeObjectForKey:kLastName];
	//	author = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
	//	sequence = [aDecoder decodeObjectForKey:kSequence];
	return self;
}

-(id)initWithBook:(BookDataSource*)book {
	if (self = [super init]) {
		[self setBookId:[book bookId]];
		[self setTitle:[book title]];
//		[self setFirstName:[book firstName]];
//		[self setLastName:[book lastName]];
//		[self setAuthor:[book author]];
//		[self setSequence:[book sequence]];
		if (book.sequence) {
			[self setSequenceNum:[book sequenceNum]];
		}
//        [self getBookInfo];
	}
	return self;
}


-(void)getBookInfo {
	if (self.bookData) {
	}
}
-(void)getBookInfoFromFile:(NSString *)fileName {
}

-(NSString*)description {
    if (self.sequence)
        return [NSString stringWithFormat:@"%@ (Sequence: %@, Book No %ld)", self.title, [self.sequence description], self.sequenceNum];
    else
        return [NSString stringWithString:self.title];
}

@end
