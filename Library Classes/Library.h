//
//  Library.h
//  BookExplorer
//
//  Created by Администратор on 04.12.12.
//  Copyright (c) 2012 NVlad. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BookDataSource, Author, Sequence, Book;

@interface Library : NSObject <NSCoding>

@property NSMutableArray *authors;
@property NSMutableArray *sequences;
@property NSMutableArray *books;

-(NSInteger)getAuthorIndex:(BookDataSource *)book;
-(NSInteger)getSequnceIndex:(BookDataSource *)book;
-(NSInteger)getBookIndex:(BookDataSource *)book;

-(void)addBook:(BookDataSource *)book;

-(void)removeBooks:(NSSet *)objects;
-(void)removeBooksObject:(Book *)object;
-(void)removeBooksAtIndexes:(NSIndexSet *)indexes;

-(void)removeSequences:(NSSet *)objects;
-(void)removeSequencesObject:(Sequence	*)object;
-(void)removeSequencesAtIndexes:(NSIndexSet *)indexes;

-(void)removeAuthors:(NSSet *)objects;
-(void)removeAuthorsObject:(Author *)object;
-(void)removeAuthorsAtIndexes:(NSIndexSet *)indexes;

-(void)loadBookFromURL:(NSURL *)url;
-(void)loadBookFromFile:(NSString *)file;
-(void)loadBooksFromPath:(NSString *)path;


@end
