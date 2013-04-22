//
//  NVLibrary.h
//  NVARCTest
//
//  Created by Vlad Nikishin on 04.04.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NVBookSource, NVBookSourceSequence, NVBook, NVSequence, NVBookSequence, NVAuthor, NVPerson;

@interface NVLibrary : NSObject {
	NSMutableArray *_books, *_sequences, *_authors;
}

@property NSMutableArray *books, *sequences, *authors;

-(NVBook *)bookAtBookId:(NSString *)bookId;
-(NVAuthor *)authorAtPerson:(NVPerson *)person;
-(NVSequence *)sequenceAtBookSourceSequence:(NVBookSourceSequence *)bookSourceSequence;
-(NVSequence *)sequenceAtTitleInAuthors:(NSString *)title inAuthors:(NSArray *)authors;

//-(NVSequence *)sequenceAtAuthor:(NVAuthor *)author andBookSourceSequence:(NVBookSourceSequence *)bookSourceSequence;

-(void)addBookFromBookSource:(NVBookSource *)bookSource;

-(void)removeBooks:(NSSet *)objects;
-(void)removeBooksObject:(NVBook *)object;
-(void)removeBooksAtIndexes:(NSIndexSet *)indexes;
-(void)removeBooksAtIndex:(NSInteger)index;

-(void)removeSequences:(NSSet *)objects;
-(void)removeSequencesObject:(NVSequence	*)object;
-(void)removeSequencesAtIndexes:(NSIndexSet *)indexes;
-(void)removeSequencesAtIndex:(NSInteger)index;

-(void)removeAuthors:(NSSet *)objects;
-(void)removeAuthorsObject:(NVAuthor *)object;
-(void)removeAuthorsAtIndexes:(NSIndexSet *)indexes;
-(void)removeAuthorsAtIndex:(NSInteger)index;

-(void)loadBookFromURL:(NSURL *)url;
-(void)loadBookFromFile:(NSString *)file;
-(void)loadBooksFromPath:(NSString *)path;


-(void)sortBooks;
-(void)sortSequences;
-(void)sortAuthors;

@end
