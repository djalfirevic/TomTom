//
//  JSONNullChecker.m
//  TomTom
//
//  Created by Djuro Alfirevic on 12/7/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

#import "JSONNullChecker.h"

@implementation JSONNullChecker

#pragma mark - Public API

+ (NSString *)parseString:(id)object {
    if (object == nil) return @"";
    
    return [object isKindOfClass:[NSNull class]] ? @"" : object;
}

@end
