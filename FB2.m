//
//  FB2.m
//  BookExplorer
//
//  Created by Влад on 21.01.13.
//  Copyright (c) 2013 NVlad. All rights reserved.
//

#import "FB2.h"

@implementation FB2

- (id)initWithFile:(NSString *)fileName
{
    self = [super init];
    NSError *error;
    //    NSString *fbFile =[NSString PathForFile:fileName];
    if (fileName) {
        NSData *data = [[NSData alloc]initWithContentsOfFile:fileName options:NSDataReadingMappedIfSafe error:&error];
        if (data) {
            self.doc = [[NSXMLDocument alloc]initWithData:data options:NSXMLDocumentValidate error:&error];
            NSLog(@"File loaded...");
        } else {
            NSLog(@"Error: %@", [error localizedDescription]);
        }
    }
    return self;
}

- (NSArray*)getNodeFromPath:(NSString *)path
{
    NSError *error;
    NSArray *result = [self.doc objectsForXQuery:path constants:nil error:&error];
    if (result)
        return result;
    NSLog(@"Error: %@", [error localizedDescription]);
    return nil;
}

- (NSString*)getValueFromPath:(NSString *)path
{
    NSArray *result =[self getNodeFromPath:path];
    if (result) {
        //        NSInteger count = [result count];
        //        NSLog(@"Count: %ld", count);
        //        for (i = 0; i < count; i++) {
        //                        NSLog(@"%@: %@", [[result objectAtIndex:i] name], [[result objectAtIndex:i] stringValue]);
        //            NSLog(@"Sequence name: %@", [[[result objectAtIndex:i] attributeForName:@"name"] stringValue]);
        //            NSLog(@"Order in sequence: %@", [[[result objectAtIndex:i] attributeForName:@"number"] stringValue]);
        //        }
        return [[result objectAtIndex:0] stringValue];
    }
    return nil;
}

- (NSString*)getAttributeValueFromPath:(NSString *)path withName:(NSString *)name
{
    NSArray *result = [self getNodeFromPath:path];
    if (result && [result count]) {
        //        NSInteger count = [result count];
        //        NSLog(@"Count: %ld", count);
        //        for (i = 0; i < count; i++) {
        //                        NSLog(@"%@: %@", [[result objectAtIndex:i] name], [[result objectAtIndex:i] stringValue]);
        //            NSLog(@"Sequence name: %@", [[[result objectAtIndex:i] attributeForName:@"name"] stringValue]);
        //            NSLog(@"Order in sequence: %@", [[[result objectAtIndex:i] attributeForName:@"number"] stringValue]);
        //        }
        return [[[result objectAtIndex:0] attributeForName:name] stringValue];
//        return [[result objectAtIndex:0] stringValue];
    }
    return nil;
}

- (NSString*)firstName
{
	return [self getValueFromPath:@"/FictionBook/description/title-info/author/first-name"];
}

- (NSString*)lastName
{
	return [self getValueFromPath:@"/FictionBook/description/title-info/author/last-name"];
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
    return [self getAttributeValueFromPath:@"/FictionBook/description/title-info/sequence"
                                  withName:@"name"];
}

- (NSInteger)sequenceNum
{
    return [[self getAttributeValueFromPath:@"/FictionBook/description/title-info/sequence"
                                   withName:@"number"] integerValue];
}

- (NSString*)title
{
	return [self getValueFromPath:@"/FictionBook/description/title-info/book-title"];
}

@end
