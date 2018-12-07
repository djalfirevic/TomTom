//
//  DataFetcher.m
//  TomTom
//
//  Created by Djuro Alfirevic on 12/7/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

#import "DataFetcher.h"
#import "NetworkFetcher.h"
#import "DatabaseFetcher.h"
#import "NSObject+Utilities.h"

@interface DataFetcher()
@property (strong ,nonatomic) DatabaseFetcher *databaseFetcher;
@property (strong ,nonatomic) NetworkFetcher *networkFetcher;
@end

@implementation DataFetcher

#pragma mark - Properties

- (DatabaseFetcher *)databaseFetcher {
    return [[DatabaseFetcher alloc] init];
}

- (NetworkFetcher *)networkFetcher {
    return [[NetworkFetcher alloc] init];
}

#pragma mark - Public API

- (void)fetchPosts:(void (^)(NSArray<Post *> *, NSError *))completion {
    if ([self shouldPerformNetworkFetch]) {
        [self.networkFetcher fetchPosts:^(NSArray<Post *> *posts, NSError *error) {
            completion(posts, error);
        }];
    } else {
        [self.databaseFetcher fetchPosts:^(NSArray<Post *> *posts, NSError *error) {
            completion(posts, error);
        }];
    }
}

- (void)fetchUserForId:(NSInteger)userId withCompletion:(void(^)(User *user, NSError *error))completion {
    if ([self shouldPerformNetworkFetch]) {
        [self.networkFetcher fetchUserForId:userId withCompletion:^(User *user, NSError *error) {
            completion(user, error);
        }];
    } else {
        [self.databaseFetcher fetchUserForId:userId withCompletion:^(User *user, NSError *error) {
            completion(user, error);
        }];
    }
}

#pragma mark - Private API

- (BOOL)shouldPerformNetworkFetch {
    return [self isConnected];
}

@end
