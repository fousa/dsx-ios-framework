//
//  NSString+Encryption.m
//  dsx
//
//  Created by Jelle Vandebeeck on 18/07/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import "NSString+DSX.h"
#import "NSDictionary+DSX.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (DSX)

#pragma mark - URL

- (NSString *)DSXNormalizeWithQuery:(id)query {
    if (query) self = [NSString stringWithFormat:@"%@%@", self, [self DSXNormalizeQuery:query]];
    
    return self;
}

- (NSString *)DSXNormalizeQuery:(id)query {
    if ([query isKindOfClass:[NSString class]]) 
        return [NSString stringWithFormat:@"?%@",query];
    if ([query isKindOfClass:[NSDictionary class]])
        return [(NSDictionary *) query DSXToQueryString];
    return nil;
}

#pragma mark - Generation

- (NSString*)DSXmd5 {
	const char *cStr = [self UTF8String];
	unsigned char result[16];
	CC_MD5(cStr, strlen(cStr), result);
	return [[NSString stringWithFormat:
			@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3], 
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			] lowercaseString]; 
}

#pragma mark - Date converters

- (NSDate *)DSXDate {
    static NSDateFormatter *dateConverter = nil;
    if (dateConverter == nil) {
        dateConverter = [[NSDateFormatter alloc] init];
        [dateConverter setDateFormat:@"yyyy-MM-dd"];
	}
    
	return [dateConverter dateFromString:self];
}

@end
