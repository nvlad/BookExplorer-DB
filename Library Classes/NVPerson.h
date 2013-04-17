//
//  NVPerson.h
//  NVARCTest
//
//  Created by Vlad Nikishin on 04.04.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NVPerson : NSObject {
	NSString *_firstName, *_middleName, *_lastName, *_nickname;
}

@property NSString *firstName, *middleName, *lastName, *nickname;

-(NSString *)name;

-(BOOL)isEqualToPerson:(NVPerson *)person;

@end
