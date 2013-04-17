//
//  FB2.m
//  BookExplorer
//
//  Created by Влад on 21.01.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import "FB2.h"
#import "FB2Bin.h"
#import "NVPerson.h"
#import "NVAuthor.h"

@implementation NSXMLElement (nodeValues)

#define kFirstName @"first-name"
#define kMiddleName @"middle-name"
#define kLastName @"last-name"
#define kNickname @"nickname"

-(void)getPerson:(NVPerson **)person {
	*person = [[NVPerson alloc] init];
	NSString *nodeValue;
	for (NSXMLElement *node in [self children]) {
		nodeValue = [[node stringValue] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		if ([nodeValue isEqualToString:@""])
			continue;
		if ([node.name isEqualToString:kFirstName])
			[*person setFirstName:nodeValue];
		else if ([node.name isEqualToString:kLastName])
			[*person setLastName:nodeValue];
		else if ([node.name isEqualToString:kMiddleName])
			[*person setMiddleName:nodeValue];
		else if ([node.name isEqualToString:kNickname])
			[*person setNickname:nodeValue];
	}
}

@end

@implementation FB2

#define kSequenceName @"name"
#define kSequencePart @"number"

-(id)initWithFile:(NSString *)fileName {
	self = [super init];
	NSError *error;
	//    NSString *fbFile =[NSString PathForFile:fileName];
	if (fileName) {
		NSData *data = [[NSData alloc]initWithContentsOfFile:fileName options:NSDataReadingMappedIfSafe error:&error];
		if (data) {
			_file = fileName;
			doc = [[NSXMLDocument alloc]initWithData:data options:NSXMLDocumentValidate error:&error];
			[self initBookDataFromDoc];
			NSLog(@"File \"%@\" loaded...", fileName);
		} else {
			NSLog(@"Error: %@", [error localizedDescription]);
		}
	}
	doc = nil;
	return self;
}

-(NSArray *)getNodesFromPath:(NSString *)path {
	NSError *error;
	NSArray *result = [doc nodesForXPath:path error:&error];
	if (result)
		return result;
	NSLog(@"Error: %@", [error localizedDescription]);
	return nil;
}
-(NSXMLElement *)getNodeFromPath:(NSString *)path {
	NSError *error;
	NSArray *result = [doc nodesForXPath:path error:&error];
	if (result && [result count])
		return [result objectAtIndex:0];
	NSLog(@"Error: %@", [error localizedDescription]);
	return nil;
}
-(NSString *)getValueFromNode:(NSXMLElement *)node byName:(NSString *)name {
	NSArray *nodes = [node elementsForName:name];
	return [[nodes objectAtIndex:0] stringValue];
}
-(NSString *)getValueFromPath:(NSString *)path {
	NSArray *result =[self getNodesFromPath:path];
	if (result) {
		return [[result objectAtIndex:0] stringValue];
	}
	return nil;
}

-(void)initAuthors {
	NSArray *authors = [self getNodesFromPath:@"/FictionBook/description/title-info/author"];
	if ([authors count] == 0)
		return;
	if (_authors) {
		_authors = [[NSMutableArray alloc] init];
	}
	NVPerson *person;
	for (NSInteger i = 0; i < [authors count]; i++) {
		[[authors objectAtIndex:i] getPerson:&person];
		[self addAuthor:person];
	}
}
-(void)initSequences {
	NSArray *sequences = [self getNodesFromPath:@"/FictionBook/description/title-info/sequence"];
	if ([sequences count] == 0)
		return;
	if (_sequences) {
		_sequences = [[NSMutableArray alloc] init];
	}
	for (NSInteger i = 0; i < [sequences count]; i++) {
		[self addSequence:[[[sequences objectAtIndex:i] attributeForName:kSequenceName] stringValue]
					withPart:[[[[sequences objectAtIndex:i] attributeForName:kSequencePart] stringValue] integerValue]];
	}
}
-(void)initTranslators {
	NSArray *translators = [self getNodesFromPath:@"/FictionBook/description/title-info/translator"];
	if ([translators count] == 0)
		return;
	if (_translators) {
		_translators = [[NSMutableArray alloc] init];
	}
	for (NSInteger i = 0; i < [translators count]; i++) {
		NVAuthor *person;
		[[translators objectAtIndex:i] getPerson:&person];
		[_translators addObject:person];
//		NSLog(@"Translators: %@", person);
	}
}
-(void)initGenres {
	NSArray *genres = [self getNodesFromPath:@"/FictionBook/description/title-info/genre"];
	if ([genres count]) {
		NSMutableArray *data = [[NSMutableArray alloc] init];
		for (NSInteger i = 0; i < [genres count]; i++) {
			[data addObject:[[genres objectAtIndex:i] stringValue]];
		}
		_genres = data;
	}
	NSLog(@"Genres: %@", genres);
}
-(void)initBookDataFromDoc {
	_bookId = [self getValueFromPath:@"/FictionBook/description/document-info/id"];
	_title = [self getValueFromPath:@"/FictionBook/description/title-info/book-title"];
	[self initAuthors];
	[self initTranslators];
	[self initSequences];
//	NSXMLElement *node = [self getNodeFromPath:@"/FictionBook/description/title-info/sequence"];
//	_sequence = [[node attributeForName:kSequenceName] stringValue];
//	_part = [[[node attributeForName:kSequencePart] stringValue] integerValue];
	[self initGenres];
}

@end
