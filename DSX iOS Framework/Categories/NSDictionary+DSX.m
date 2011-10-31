//
//  NSDictionary+URLFormatter.m
//  dsx
//
//  Created by Jelle Vandebeeck on 19/07/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import "NSDictionary+DSX.h"

@implementation NSDictionary (DSX)

- (NSString *)DSXToQueryString {
    return [self DSXToQueryString:nil];
}

- (NSString *)DSXToQueryString:(NSString *)aNamespace {
    NSMutableArray *paramsArray = [NSMutableArray arrayWithCapacity:[[self allKeys] count]];
    for (NSString *key in self) {
        if (!aNamespace) {
            [paramsArray addObject:[NSString stringWithFormat:@"%@=%@", [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [[[self objectForKey:key] description] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        } else {
            [paramsArray addObject:[NSString stringWithFormat:@"%@[%@]=%@", 
                                    aNamespace, 
                                    [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], 
                                    [[[self objectForKey:key] description]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        }
    }
    return [NSString stringWithFormat:@"?%@",[paramsArray componentsJoinedByString:@"&"]];
}

@end
