//
//  NVSequence.h
//  NVARCTest
//
//  Created by Vlad Nikishin on 04.04.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NVAuthor, NVBook, NVBookSequence, NVSequenceAuthor;

@interface NVSequence : NSObject {
	NSString *_title;
	NSMutableArray *_authors, *_books;
	NSInteger _bookCount;
}

@property NSString *title;
@property NSMutableArray *authors, *books;
@property (readonly) NSInteger bookCount;

-(id)initWithTitle:(NSString *)title;

-(void)addBooksObject:(NVBookSequence *)object;
-(void)removeBooksObject:(NVBookSequence *)object;

-(void)addAuthorsObject:(NVSequenceAuthor *)object;
-(void)removeAuthorsObject:(NVSequenceAuthor *)object;

-(NSString *)author;

@end
