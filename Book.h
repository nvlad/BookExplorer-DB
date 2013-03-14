//
//  Book.h
//  BookExplorer
//
//  Created by Администратор on 04.12.12.
//  Copyright (c) 2012 NVlad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookDataSource.h"

@interface NSString(FileUtils)
+ (NSString*)PathForFile:(NSString*)filename;
@end


@interface Book : NSObject

@property BookDataSource *bookData;
@property NSString *author;
@property NSString *firstName;
@property NSString *lastName;
@property NSString *sequence;
@property NSInteger sequenceNum;
@property NSString *title;

- (id)initWithBook:(BookDataSource *)book;

- (void)getBookInfo;
- (void)getBookInfoFromFile:(NSString *)fileName;

- (NSString*)description;

@end
