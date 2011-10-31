//
//  NSDictionary+URLFormatter.h
//  dsx
//
//  Created by Jelle Vandebeeck on 19/07/11.
//  Copyright 2011 10to1. All rights reserved.
//

@interface NSDictionary (DSX)
- (NSString *)DSXToQueryString;
- (NSString *)DSXToQueryString:(NSString *)aNamespace;
@end
