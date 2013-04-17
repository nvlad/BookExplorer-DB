//
//  NVPerson.m
//  NVARCTest
//
//  Created by Vlad Nikishin on 04.04.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import "NVPerson.h"

@implementation NVPerson

@synthesize firstName = _firstName, middleName = _middleName, lastName = _lastName, nickname = _nickname;

-(NSString *)name {
	if (_firstName && _middleName && _lastName)
		return [NSString stringWithFormat:@"%@ %@ %@", _lastName, _firstName, _middleName];
	else if (_firstName && _lastName)
		return [NSString stringWithFormat:@"%@ %@", _lastName, _firstName];
	else if (_firstName)
		return _firstName;
	else if (_lastName)
		return _lastName;
	return nil;
}

-(BOOL)isEqualToPerson:(NVPerson *)person {
	BOOL firstName = YES, middleName = YES, lastName = YES, nickname = YES;
	if (_firstName && ![_firstName isCaseInsensitiveLike:[person firstName]])
		firstName = NO;
	if (_middleName && ![_middleName isCaseInsensitiveLike:[person middleName]])
		middleName = NO;
	if (_lastName && ![_lastName isCaseInsensitiveLike:[person lastName]])
		lastName = NO;
	if (_nickname && ![_nickname isCaseInsensitiveLike:[person nickname]])
		nickname = NO;
	if (firstName && middleName && lastName && nickname)
		return YES;
	return NO;
}

@end
