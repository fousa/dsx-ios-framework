//
//  DSXFlight.h
//  dsx
//
//  Created by Jelle Vandebeeck on 19/07/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import "DSXDay.h"

@interface DSXFlight : NSObject
@property (nonatomic, retain) DSXDay *day;
@property (nonatomic, retain) NSString *pilot;
@property (nonatomic, retain) NSString *competitionId;
@property (nonatomic, retain) NSString *igcURLString;
@end