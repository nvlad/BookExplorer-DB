//
//  BookDataSource.h
//  BookExplorer
//
//  Created by Влад on 23.01.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookDataSource: NSObject
-(NSString*)bookId;
-(NSString*)firstName;
-(NSString*)lastName;
-(NSString*)author;
-(NSString*)sequence;
-(NSInteger)sequenceNum;
-(NSString*)title;
-(NSString*)file;
-(NSDictionary*)genres;
@end
