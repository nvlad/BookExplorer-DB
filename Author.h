//
//  Author.h
//  BookExplorer
//
//  Created by Администратор on 04.12.12.
//  Copyright (c) 2012 NVlad. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Book;
@class Sequence;

@interface Author : NSObject

@property NSString *firstName;
@property NSString *lastName;
@property NSMutableArray *sequences;
@property NSMutableArray *books;
@property NSInteger bookCount;

- (id)initWithBook:(Book*)book;

- (Sequence *)sequenceByTitle:(NSString *)title;

- (void)addBook:(Book *)book;
- (void)addSequence:(Sequence *)sequence;

- (NSString*)description;

@end
