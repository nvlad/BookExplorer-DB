//
//  NVBookSequences.h
//  NVARCTest
//
//  Created by Vlad Nikishin on 04.04.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVBook.h"
#import "NVSequence.h"

@interface NVBookSequence : NSObject {
	__weak NVBook *_book;
	__weak NVSequence *_sequence;
	NSInteger _part;
}

@property (weak) NVBook *book;
@property (weak) NVSequence *sequence;
@property NSInteger part;

-(id)initWithBook:(NVBook *)book andWithSequence:(NVSequence *)sequence andPart:(NSInteger)part;

-(NSString *)title;

@end
