//
//  NVSequenceAuthor.h
//  NVARCTest
//
//  Created by Vlad Nikishin on 09.04.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NVSequence, NVAuthor;

@interface NVSequenceAuthor : NSObject {
	__weak NVAuthor *_author;
	__weak NVSequence *_sequence;
}

@property (weak) NVAuthor *author;
@property (weak) NVSequence *sequence;

-(id)initWithAuthor:(NVAuthor *)author andSequence:(NVSequence *)sequence;

-(NSString *)authorName;

@end
