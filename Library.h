//
//  Library.h
//  BookExplorer
//
//  Created by Администратор on 04.12.12.
//  Copyright (c) 2012 NVlad. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Author, Sequence, Book;

@interface Library : NSObject

@property NSMutableArray *authors;
@property NSMutableArray *sequences;
@property NSMutableArray *books;

- (void)addBook:(Book *)book;

- (void)loadBookFromURL:(NSURL *)url;
- (void)loadBookFromFile:(NSString *)file;
- (void)loadBooksFromPath:(NSString *)path;


@end
