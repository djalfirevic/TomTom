//
//  RESTManager.m
//  TomTom
//
//  Created by Djuro Alfirevic on 12/6/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESTManager.h"
#import "NSObject+Utilities.h"

#define kSessionTimeoutInterval 10.0
#define kRequestTimeoutInterval 30.0
#define BASE_PATH               @"http://jsonplaceholder.typicode.com"

@implementation RESTManager

#pragma mark - Designated Initializer

+ (RESTManager *)sharedInstance {
    static RESTManager *sharedManager;
    
    @synchronized(self)    {
        if (sharedManager == nil) {
            sharedManager = [[RESTManager alloc] init];
        }
    }
    
    return sharedManager;
}

#pragma mark - Public API

- (void)requestDataFromURL:(NSString *)urlString withLoader:(BOOL)loaderOn withCompletion:(RESTCompletionHandler)handler {
    if ([self isConnected]) {
        if (loaderOn) [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSString *url = [NSString stringWithFormat:@"%@%@", BASE_PATH, urlString];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        request.timeoutInterval = kRequestTimeoutInterval;
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        [configuration setTimeoutIntervalForRequest:kSessionTimeoutInterval];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        
        [request setHTTPMethod:@"GET"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        [[session dataTaskWithRequest:request
                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                  
                  if (!error) {
                      if ([request.URL isEqual:[NSURL URLWithString:url]]) {
                          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                          if ([response respondsToSelector:@selector(allHeaderFields)]) {
                              __unused NSDictionary *dictionary = [httpResponse allHeaderFields];
                              //NSLog(@"%@", [dictionary description]);
                          }
                          
                          if (data) {
                              NSError *serializationError;
                              NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
                              
                              handler(YES, dictionary, nil);
                          }
                      }
                  } else {
                      NSLog(@"%@", [error localizedDescription]);
                      
                      handler(NO, nil, error);
                  }
              });
              
          }] resume];
    }
}

@end
