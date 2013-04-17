//
//  BookDataSource.h
//  BookExplorer DB
//
//  Created by Vlad Nikishin on 27.03.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NVBookSource: NSObject {
	NSString *_bookId, *_sequence, *_title, *_file;
	NSMutableArray *_authors, *_translators, *_genres;
	NSInteger _part;
}

@property (readonly) NSString		*bookId, *title, *sequence, *file;
@property (readonly) NSArray		*authors, *translators, *genres;
@property (readonly) NSInteger	part;

-(id)initFromDictionary:(NSDictionary *)data;

@end
