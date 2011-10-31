//
//  DSXFlightsConnector.m
//  dsx
//
//  Created by Jelle Vandebeeck on 19/07/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import "DSXFlightsConnector.h"

#import "NSString+DSX.h"
#import "NSDate+DSX.h"

#import "DSXFlight.h"
#import "DSXDay.h"

@class ASIHTTPRequest;

// Remove ASIHTTPRequest warnings
@interface ASIHTTPRequest : NSObject
- (NSData *)responseData;
@end

@interface DSXFlightsConnector ()
@property (nonatomic, retain) NSMutableArray *days;
@property (nonatomic, retain) DSXFlight *currentFlight;
@end

@implementation DSXFlightsConnector
@synthesize days, contest, currentFlight;

#pragma mark URL Constructors

- (NSString *)command {
    return @"getflights.php";
}

- (NSDictionary *)params {
    return [NSDictionary dictionaryWithObjectsAndKeys:self.contest.name, @"contestname", nil];
}

#pragma mark - Request

- (void)requestFinished:(ASIHTTPRequest *)request {
    NSString *dataString = [[[NSString alloc] initWithData:[request responseData] encoding:NSASCIIStringEncoding] autorelease];
    dataString = [@"<flights>" stringByAppendingFormat:@"%@</flights>", dataString];
    NSData *responseData = [dataString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:responseData];
    [parser setDelegate:self];
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    [parser release];
}

#pragma mark - XML Parser

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.days = [NSMutableArray array];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if([elementName isEqualToString:@"flight"]) {
		if (!self.currentFlight) self.currentFlight = [[DSXFlight new] autorelease];
		return;
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if([elementName isEqualToString:@"flight"]) {
        [self.currentFlight.day.flights addObject:self.currentFlight];
        if (![self.days containsObject:self.currentFlight.day]) {
            [self.days addObject:self.currentFlight.day];
        }
		self.currentFlight = nil;
    }
    
	if([elementName isEqualToString:@"pilot"]) {
		self.currentFlight.pilot = [self.currentStringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	}
    
	if([elementName isEqualToString:@"competitionid"]) {
		self.currentFlight.competitionId = [self.currentStringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	}
    
	if([elementName isEqualToString:@"igc"]) {
		self.currentFlight.igcURLString = [self.currentStringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	}
    
	if([elementName isEqualToString:@"date"]) {
		NSString *dateString = [self.currentStringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        DSXDay *currentDay = nil;
        for (DSXDay *day in self.days) {
            if ([[day.date DSXURLFormat] isEqualToString:dateString]) {
                currentDay = [day retain];
                break;
            }
        }
        if (currentDay == nil) {
            currentDay = [DSXDay new];
            currentDay.date = [dateString DSXDate];
            currentDay.contest = self.contest;
            currentDay.flights = [NSMutableArray array];
        }
        self.currentFlight.day = currentDay;
        [currentDay release];
        currentDay = nil;
	}
    
    self.currentStringValue = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    self.contest.days = self.days;
    if ([self.delegate respondsToSelector:@selector(didReceiveContest:)]) {
        [self.delegate performSelector:@selector(didReceiveContest:) withObject:self.contest];
    }
}

@end
