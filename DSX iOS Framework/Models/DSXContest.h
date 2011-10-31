//
//  DSXContest.h
//  dsx
//
//  Created by Jelle Vandebeeck on 19/07/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface DSXContest : NSObject
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *displayName;
@property (nonatomic, retain) NSString *countryCode;
@property (nonatomic, retain) NSString *site;
@property (nonatomic, retain) NSDate *from;
@property (nonatomic, retain) NSDate *to;
@property (nonatomic, retain) NSNumber *dateDelay;
@property (nonatomic, retain) NSDate *utcOffset;
@property (nonatomic, assign) CLLocationCoordinate2D location;
@property (nonatomic, retain) NSArray *days;
@end
