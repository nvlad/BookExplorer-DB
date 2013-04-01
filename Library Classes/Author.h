//
//  Author.h
//  BookExplorer
//
//  Created by Администратор on 04.12.12.
//  Copyright (c) 2012 NVlad. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BookDataSource, Book, Sequence;

@interface Author : NSObject

@property NSString *firstName;
@property NSString *lastName;
@property NSMutableArray *sequences;
@property NSMutableArray *books;
@property NSInteger bookCount;

-(id)initWithBookDataSource:(BookDataSource *)book;

-(Sequence *)sequenceByTitle:(NSString *)title;

-(void)addBook:(Book *)book;
-(void)addSequence:(Sequence *)sequence;

-(void)removeBooks:(NSSet *)objects;
-(void)removeBooksObject:(Book *)object;
-(void)removeBooksAtIndexes:(NSIndexSet *)indexes;

-(void)removeSequences:(NSSet *)objects;
-(void)removeSequencesObject:(Sequence *)object;
-(void)removeSequencesAtIndexes:(NSIndexSet *)indexes;

-(NSString*)description;

@end
