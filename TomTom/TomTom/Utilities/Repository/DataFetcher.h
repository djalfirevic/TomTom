//
//  DataFetcher.h
//  TomTom
//
//  Created by Djuro Alfirevic on 12/7/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"
#import "User.h"

@interface DataFetcher : NSObject
- (void)fetchPosts:(void(^)(NSArray<Post *> *posts, NSError *error))completion;
- (void)fetchUserForId:(NSInteger)userId withCompletion:(void(^)(User *user, NSError *error))completion;
@end
