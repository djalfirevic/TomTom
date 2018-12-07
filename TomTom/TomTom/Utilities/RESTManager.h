//
//  RESTManager.h
//  TomTom
//
//  Created by Djuro Alfirevic on 12/6/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RESTCompletionHandler)(BOOL success, NSDictionary *dictionary, NSError *error);

@interface RESTManager : NSObject
+ (id)sharedInstance;
- (void)requestDataFromURL:(NSString *)urlString withLoader:(BOOL)loaderOn withCompletion:(RESTCompletionHandler)handler;
@end
