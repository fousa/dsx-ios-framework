//
//  NSDate+Formatter.m
//  igcreader
//
//  Created by Jelle Vandebeeck on 22/07/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import "NSDate+DSX.h"

@implementation NSDate (DSX)

- (NSString *)DSXURLFormat {
    static NSDateFormatter *DSXURLFormatter = nil;
    if (DSXURLFormatter == nil) {
        DSXURLFormatter = [[NSDateFormatter alloc] init];
        [DSXURLFormatter setDateFormat:@"yyyy-MM-dd"];
	}
    
	return [DSXURLFormatter stringFromDate:self];
}

@end