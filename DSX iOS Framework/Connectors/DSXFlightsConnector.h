//
//  DSXFlightsConnector.h
//  dsx
//
//  Created by Jelle Vandebeeck on 19/07/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import "DSXConnector.h"

#import "DSXContest.h"

@interface DSXFlightsConnector : DSXConnector <DSXConnectorProtocol>
@property (nonatomic, retain) DSXContest *contest;
@end
