//
//  DSXContest.m
//  dsx
//
//  Created by Jelle Vandebeeck on 19/07/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import "DSXContest.h"

@implementation DSXContest
@synthesize to, from, name, site, location, dateDelay, utcOffset, countryCode, displayName, days;

#pragma mark - Memory

- (void)dealloc {
    self.to = nil;
    self.from = nil;
    self.name = nil;
    self.site = nil;
    self.dateDelay = nil;
    self.utcOffset = nil;
    self.countryCode = nil;
    self.displayName = nil;
    self.days = nil;
    
    [super dealloc];
}

@end
