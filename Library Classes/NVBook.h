//
//  NVBook.h
//  NVARCTest
//
//  Created by Vlad Nikishin on 04.04.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NVBookSource, NVAuthor, NVBookAuthor, NVBookSequence, NVSequence;

@interface NVBook : NSObject {
	NSString *_bookId, *_title;
	NSMutableArray *_authors, *_sequences, *_translators, *_genres;
}

@property NSString *bookId, *title;
@property NSMutableArray *authors, *sequences, *translators, *genres;

-(id)initWithBookSource:(NVBookSource *)bookSource;

-(NVBookSequence *)bookSequenceAtSequence:(NVSequence *)sequence;

-(void)addAuthorsObject:(NVBookAuthor *)object;
-(void)removeAuthorsObject:(NVBookAuthor *)object;

-(void)addSequencesObject:(NVBookSequence *)object;
-(void)removeSequencesObject:(NVBookSequence *)object;

-(NSString *)author;
-(NSString *)sequence;

@end
