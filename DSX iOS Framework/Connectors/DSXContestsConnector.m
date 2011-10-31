//
//  DSXContestsConnector.m
//  dsx
//
//  Created by Jelle Vandebeeck on 19/07/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import "DSXContestsConnector.h"

#import "DSXContest.h"

@interface DSXContestsConnector ()
@property (nonatomic, retain) NSMutableArray *contests;
@property (nonatomic, retain) DSXContest *currentContest;
@end

@implementation DSXContestsConnector
@synthesize contests, currentContest;

#pragma mark URL Constructors

- (NSString *)command {
    return @"getactivecontests.php";
}

- (NSDictionary *)params {
    return [NSDictionary dictionaryWithObjectsAndKeys:@"", @"", nil];
}

#pragma mark - XML Parser

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.contests = [NSMutableArray array];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if([elementName isEqualToString:@"contest"]) {
		if (!self.currentContest) self.currentContest = [[DSXContest new] autorelease];
		return;
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if([elementName isEqualToString:@"contest"]) {
        [self.contests addObject:self.currentContest];
		self.currentContest = nil;
        return;
    }
    
	if([elementName isEqualToString:@"contestname"]) {
		self.currentContest.name = [self.currentStringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	}
    
	if([elementName isEqualToString:@"contestdisplayname"]) {
		self.currentContest.displayName = [self.currentStringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	}
    
    self.currentStringValue = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if ([self.delegate respondsToSelector:@selector(didReceiveContests:)]) {
        [self.delegate performSelector:@selector(didReceiveContests:) withObject:self.contests];
    }
}

@end
