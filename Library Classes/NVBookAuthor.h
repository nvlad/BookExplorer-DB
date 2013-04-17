//
//  NVBookAuthor.h
//  NVARCTest
//
//  Created by Vlad Nikishin on 05.04.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NVBook, NVAuthor;

@interface NVBookAuthor : NSObject {
	__weak NVBook *_book;
	__weak NVAuthor *_author;
}

@property (weak) NVBook *book;
@property (weak) NVAuthor *author;

-(id)initWithBook:(NVBook *)book andAuthor:(NVAuthor *)author;

-(NSString *)authorName;

@end
