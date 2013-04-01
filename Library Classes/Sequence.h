//
//  Sequence.h
//  BookExplorer
//
//  Created by Администратор on 04.12.12.
//  Copyright (c) 2012 NVlad. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Book;
@class Author;

@interface Sequence : NSObject

@property NSString *title;
@property Author *author;
@property NSMutableArray *books;
@property NSInteger bookCount;

-(id)init:(NSString*)title withAuthor:(Author *)author;

-(void)addBook:(Book *)book;

-(void)removeBooks:(NSSet *)objects;
-(void)removeBooksObject:(Book *)object;
-(void)removeBooksAtIndexes:(NSIndexSet *)indexes;

@end
