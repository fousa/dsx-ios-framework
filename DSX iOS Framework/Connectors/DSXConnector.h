//
//  DSXConnector.h
//  dsx
//
//  Created by Jelle Vandebeeck on 19/07/11.
//  Copyright 2011 10to1. All rights reserved.
//

@protocol DSXConnectorProtocol <NSObject>
@required
- (void)parserDidStartDocument:(NSXMLParser *)parser;
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
- (NSString *)command;
- (NSDictionary *)params;
@end

@interface DSXConnector : NSObject <NSXMLParserDelegate>
@property (nonatomic, retain) NSObject *delegate;
@property (nonatomic, retain) NSMutableString *currentStringValue;

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;

- (void)getData;

- (NSString *)URLString;
- (NSString *)baseURLString;
- (NSDictionary *)paramsWithCredentials;
@end
