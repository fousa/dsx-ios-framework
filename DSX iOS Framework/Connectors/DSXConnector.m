//
//  DSXConnector.m
//  dsx
//
//  Created by Jelle Vandebeeck on 19/07/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import "DSXConnector.h"

#import "NSString+DSX.h"

@class ASIHTTPRequest;

// Remove ASIHTTPRequest warnings
@interface ASIHTTPRequest : NSObject
- (id)initWithURL:(NSURL *)URL;
- (void)setDelegate:(id)object;
- (void)startAsynchronous;
- (NSData *)responseData;
@end

// Remove Coby warnings
@interface NSMutableDictionary (RemoveWarnings)
- (void)set:(id)object for:(NSString *)key;
@end

@implementation DSXConnector
@synthesize delegate, currentStringValue, username, password;

#pragma mark - Fetching

- (void)getData {
    NSURL *URL = [NSURL URLWithString:[self URLString]];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:URL];
    [request setDelegate:self];
    [request startAsynchronous];
    [request release];
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    NSString *dataString = [[[NSString alloc] initWithData:[request responseData] encoding:NSASCIIStringEncoding] autorelease];
    NSData *responseData = [dataString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:responseData];
    [parser setDelegate:self];
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    [parser release];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    if ([self.delegate respondsToSelector:@selector(connectionError)]) {
        [self.delegate performSelector:@selector(connectionError)];
    }
}

#pragma mark - XML Parser

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if(!self.currentStringValue) self.currentStringValue = [[[NSMutableString alloc] init] autorelease];
	
	[self.currentStringValue appendString:string];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if ([self.delegate respondsToSelector:@selector(parseError)]) {
        [self.delegate performSelector:@selector(parseError)];
    }
}

- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validError {
    if ([self.delegate respondsToSelector:@selector(parseError)]) {
        [self.delegate performSelector:@selector(parseError)];
    }
}

#pragma mark - URL

- (NSString *)URLString {
    return [[NSString stringWithFormat:@"%@%@", [self baseURLString], [self performSelector:@selector(command)]] DSXNormalizeWithQuery:[self paramsWithCredentials]];
}

- (NSString *)baseURLString {
    return @"http://www.d-s-x.it/dsxserver/";
}

- (NSDictionary *)paramsWithCredentials {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[self performSelector:@selector(params)]];
    [params set:self.username for:@"username"];
    [params set:[[self.password stringByAppendingString:username] DSXmd5] for:@"cpassword"];
    [params set:@"1" for:@"xml"];
    
    return params;
}


@end
