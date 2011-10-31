//
//  DSXDownloader.h
//  dsx
//
//  Created by Jelle Vandebeeck on 21/07/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import "DSXFlight.h"

@interface DSXDownloader : NSObject
@property (nonatomic, retain) NSObject *delegate;
@property (nonatomic, retain) DSXFlight *flight;

- (void)downloadIGC;

+ (NSString *)IGCDirectory;
@end
