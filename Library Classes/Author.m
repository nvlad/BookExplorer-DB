//
//  Author.m
//  BookExplorer
//
//  Created by Администратор on 04.12.12.
//  Copyright (c) 2012 NVlad. All rights reserved.
//

#import "BookDataSource.h"
#import "Author.h"
#import "Sequence.h"
#import "Book.h"

@implementation Author

#define kFirstName @"firstName"
#define kLastName @"lastName"
#define kSequences @"Sequences"
#define kBooks @"Books"
#define kBookCount @"bookCount"

@synthesize firstName, lastName, sequences, books, bookCount;

//-(void)encodeWithCoder:(NSCoder *)aCoder {
//	[aCoder encodeObject:firstName forKey:kFirstName];
//	[aCoder encodeObject:lastName forKey:kLastName];
////	[aCoder encodeObject:sequences forKey:kSequences];
//	[aCoder encodeObject:books forKey:kBooks];
//	[aCoder encodeInt64:bookCount forKey:kBookCount];
//}
//-(id)initWithCoder:(NSCoder *)aDecoder {
//	self = [super init];
//	firstName = [aDecoder decodeObjectForKey:kFirstName];
//	lastName = [aDecoder decodeObjectForKey:kLastName];
//	books = [aDecoder decodeObjectForKey:kBooks];
//	bookCount = [aDecoder decodeInt64ForKey:kBookCount];
//	return self;
//}

-(id)initWithBookDataSource:(BookDataSource *)book {
	self = [super init];
	if (self) {
		firstName = [book firstName];
		lastName = [book lastName];
//		[self addBook:book];
	}
	return self;
}

-(Sequence *)sequenceByTitle:(NSString *)title {
	for (Sequence *seq in sequences) {
		if ([seq.title isEqual:title])
			return seq;
	}
	return nil;
}


-(void)addBook:(Book *)book {
	if (!books)
		books = [[NSMutableArray alloc] init];
	[books addObject:book];
	bookCount = [books count];
	NSLog(@"Author \"%@ %@\" avaible %ld of books", firstName, lastName, bookCount);
}
-(void)addSequence:(Sequence *)sequence {
	if (!sequences)
		sequences = [[NSMutableArray alloc] init];
	[sequences addObject:sequence];
}

-(void)removeBooks:(NSSet *)objects {
	
}
-(void)removeBooksObject:(Book *)object {
	[books removeObject:object];
	bookCount = [books count];
}
-(void)removeBooksAtIndexes:(NSIndexSet *)indexes {
	
}

-(void)removeSequences:(NSSet *)objects {
	
}
-(void)removeSequencesObject:(Sequence *)object {
	
}
-(void)removeSequencesAtIndexes:(NSIndexSet *)indexes {
	
}

-(NSString*)description {
	return [NSString stringWithFormat:@"%@ %@", firstName, lastName];
}

@end