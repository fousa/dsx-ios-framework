//
//  DSXDay.h
//  dsx
//
//  Created by Jelle Vandebeeck on 19/07/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import "DSXContest.h"

@interface DSXDay : NSObject
@property (nonatomic, retain) DSXContest *contest;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSMutableArray *flights;
@end
