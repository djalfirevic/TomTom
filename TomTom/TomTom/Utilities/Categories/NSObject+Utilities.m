//
//  NSObject+Utilities.m
//  TomTom
//
//  Created by Djuro Alfirevic on 12/6/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

#import "NSObject+Utilities.h"
#import "Reachability.h"

@implementation NSObject (Utilities)

#pragma mark - Public API

- (BOOL)isConnected {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = reachability.currentReachabilityStatus;
    
    if (status == NotReachable) {
        return NO;
    }
    
    return YES;
}

@end
