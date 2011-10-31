//
//  NSString+Encryption.h
//  dsx
//
//  Created by Jelle Vandebeeck on 18/07/11.
//  Copyright 2011 10to1. All rights reserved.
//

@interface NSString (DSX)
- (NSString *)DSXNormalizeWithQuery:(id)query;
- (NSString *)DSXNormalizeQuery:(id)query;
- (NSString *)DSXmd5;
- (NSDate *)DSXDate;
@end
