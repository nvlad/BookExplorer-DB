//
//  BookDataSource.h
//  BookExplorer DB
//
//  Created by Vlad Nikishin on 27.03.13.
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
