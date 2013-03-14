//
//  BookDataSource.m
//  BookExplorer
//
//  Created by Влад on 23.01.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import "BookDataSource.h"

@implementation BookDataSource

- (NSString*)firstName
{
	return nil;
}

- (NSString*)lastName
{
	return nil;
}

- (NSString*)author
{
	NSString *firstName, *lastName;
	firstName = [self firstName];
	lastName = [self lastName];
	return [NSString stringWithFormat:@"%@ %@", firstName, lastName];
}

- (NSString*)sequence
{
	return nil;
}

- (NSInteger)sequenceNum
{
	return 0;
}

- (NSString*)title
{
	return nil;
}

@end
