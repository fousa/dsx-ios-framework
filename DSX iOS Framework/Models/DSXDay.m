//
//  DSXDay.m
//  dsx
//
//  Created by Jelle Vandebeeck on 19/07/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import "DSXDay.h"

@implementation DSXDay
@synthesize date, contest, flights;

#pragma mark - Memory

- (void)dealloc {
    self.date = nil;
    self.contest = nil;
    self.flights = nil;
    
    [super dealloc];
}

@end
