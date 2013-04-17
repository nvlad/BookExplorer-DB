//
//  NVAuthor.h
//  NVARCTest
//
//  Created by Vlad Nikishin on 04.04.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import "NVPerson.h"

@class NVSequence, NVBook, NVBookAuthor, NVSequenceAuthor;

@interface NVAuthor : NVPerson {
	NSMutableArray *_sequences, *_books;
	NSInteger _bookCount;
}

@property NSMutableArray *sequences, *books;
@property (readonly) NSInteger bookCount;

-(id)initWithPerson:(NVPerson *)person;

-(NVSequence *)sequenceAtTitle:(NSString *)title;

-(void)addBooksObject:(NVBookAuthor *)object;
-(void)removeBooksObject:(NVBookAuthor *)object;

-(void)addSequencesObject:(NVSequenceAuthor *)object;
-(void)removeSequencesObject:(NVSequenceAuthor *)object;

@end
