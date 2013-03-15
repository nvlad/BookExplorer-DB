//
//  FB2.h
//  BookExplorer
//
//  Created by Влад on 21.01.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookDataSource.h"

@interface FB2: BookDataSource

@property NSXMLDocument *doc;
@property NSString *file;

- (id)initWithFile:(NSString *)fileName;
- (NSArray*)getNodeFromPath:(NSString *)path;
- (NSString*)getValueFromPath:(NSString *)path;
- (NSString*)getAttributeValueFromPath:(NSString*)path withName:(NSString*)name;

- (NSString*)firstName;
- (NSString*)lastName;
- (NSString*)author;
- (NSString*)sequence;
- (NSInteger)sequenceNum;
- (NSString*)title;

@end
