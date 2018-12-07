//
//  NetworkFetcher.m
//  TomTom
//
//  Created by Djuro Alfirevic on 12/7/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

#import "NetworkFetcher.h"
#import "RESTManager.h"
#import "DataManager.h"
#import "Post.h"
#import "User.h"
#import "Constants.h"

@implementation NetworkFetcher

#pragma mark - Public API

- (void)fetchPosts:(void(^)(NSArray<Post *> *posts, NSError *error))completion {
    [[RESTManager sharedInstance] requestDataFromURL:POSTS_URL
                                          withLoader:YES
                                      withCompletion:^(BOOL success, NSDictionary *dictionary, NSError *error)
     {
         NSMutableArray *posts = [NSMutableArray array];
         for (NSDictionary *postDictionary in dictionary) {
             [posts addObject:[[Post alloc] initWithDictionary:postDictionary]];
         }
         
         // Store to database
         [[DataManager sharedInstance] storePostsToDatabase:posts];
         
         completion(posts, error);
     }];
}

- (void)fetchUserForId:(NSInteger)userId withCompletion:(void(^)(User *user, NSError *error))completion {
    [[RESTManager sharedInstance] requestDataFromURL:USERS_URL
                                          withLoader:YES
                                      withCompletion:^(BOOL success, NSDictionary *dictionary, NSError *error)
     {
         User *user = nil;
         for (NSDictionary *userDictionary in dictionary) {
             if ((NSInteger)userDictionary[@"id"] == userId) {
                 user = [[User alloc] initWithDictionary:userDictionary];
                 
                 // Store to database
                 [[DataManager sharedInstance] storeUserToDatabase:user];
             }
         }
         
         completion(user, error);
     }];
}

@end
