//
//  Post.m
//  TomTom
//
//  Created by Djuro Alfirevic on 12/6/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

#import "Post.h"
#import "JSONNullChecker.h"

@implementation Post

#pragma mark - Designated Initializers

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.userId = (NSInteger)dictionary[@"userId"];
        self.objectId = (NSInteger)dictionary[@"userId"];
        self.title = [JSONNullChecker parseString:dictionary[@"title"]];
        self.body = [JSONNullChecker parseString:dictionary[@"body"]];
    }
    
    return self;
}

- (instancetype)initWithDBPost:(DBPost *)dbPost {
    if (self = [super init]) {
        self.userId = (NSInteger)dbPost.userId;
        self.objectId = (NSInteger)dbPost.objectId;
        self.title = dbPost.title;
        self.body = dbPost.body;
    }
    
    return self;
}

#pragma mark - Public API

- (NSString *)description {
    return self.body;
}

@end
