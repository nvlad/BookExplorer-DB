//
//  FB2.h
//  BookExplorer
//
//  Created by Влад on 21.01.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVBookSource.h"

@class FB2Bin, NVPerson;

@interface NSXMLElement(nodeValues)

-(void)getPerson:(NVPerson **)person;

@end

@interface FB2: NVBookSource {
	NSXMLDocument *doc;
}

-(id)initWithFile:(NSString *)fileName;
-(NSArray *)getNodesFromPath:(NSString *)path;
-(NSString *)getValueFromNode:(NSXMLElement *)node byName:(NSString *)name;
-(NSString *)getValueFromPath:(NSString *)path;
//-(NSString *)getAttributeValueFromPath:(NSString *)path withName:(NSString *)name;

//-(NSString *)bookId;
//-(NSString *)sequence;
//-(NSInteger)part;
//-(NSString *)title;

//-(NSArray *)genres;

@end
