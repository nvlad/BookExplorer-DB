//
//  NVBookSourceSequence.h
//  NVARCTest
//
//  Created by Vlad Nikishin on 05.04.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NVBookSourceSequence : NSObject {
	NSString *_title;
	NSInteger _part;
}

@property NSString *title;
@property NSInteger part;

-(id)initWithTitle:(NSString *)title andPart:(NSInteger)part;

@end
