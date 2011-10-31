//
//  DSXFlight.m
//  dsx
//
//  Created by Jelle Vandebeeck on 19/07/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import "DSXFlight.h"

@implementation DSXFlight
@synthesize day, pilot, igcURLString, competitionId;

#pragma mark - Memory

- (void)dealloc {
    self.day = nil;
    self.pilot= nil;
    self.igcURLString = nil;
    self.competitionId = nil;
    
    [super dealloc];
}

@end
