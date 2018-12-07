//
//  User.m
//  TomTom
//
//  Created by Djuro Alfirevic on 12/7/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

#import "User.h"
#import "JSONNullChecker.h"

@implementation User

#pragma mark - Designated Initializers

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.objectId = (NSInteger)dictionary[@"id"];
        self.name = [JSONNullChecker parseString:dictionary[@"name"]];
        self.username = [JSONNullChecker parseString:dictionary[@"username"]];
        self.email = [JSONNullChecker parseString:dictionary[@"email"]];
    }
    
    return self;
}

- (instancetype)initWithDBUser:(DBUser *)dbUser {
    if (self = [super init]) {
        self.objectId = (NSInteger)dbUser.objectId;
        self.name = dbUser.name;
        self.username = dbUser.username;
        self.email = dbUser.email;
    }
    
    return self;
}

#pragma mark - Public API

- (NSString *)description {
    NSString *result = [NSString stringWithFormat:@"%@\n%@\%@",
                        self.name,
                        self.username,
                        self.email];
    
    return result;
}

@end
