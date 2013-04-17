//
//  NVBookSource.h
//  NVARCTest
//
//  Created by Vlad Nikishin on 04.04.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NVBookSourceSequence, NVPerson;

@interface NVBookSource : NSObject {
	NSString *_file;
	NSString *_bookId, *_title;
	NSMutableArray *_sequences, *_authors, *_translators, *_genres;
}

@property NSString *file;
@property NSString *bookId, *title;
@property NSMutableArray *sequences, *authors, *translators, *genres;

-(void)addSequence:(NSString *)title withPart:(NSInteger)part;
-(void)addAuthor:(NVPerson *)person;

@end
