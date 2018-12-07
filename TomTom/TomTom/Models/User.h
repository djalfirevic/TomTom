//
//  User.h
//  TomTom
//
//  Created by Djuro Alfirevic on 12/7/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBUser+CoreDataClass.h"

@interface User : NSObject
@property (nonatomic) NSInteger objectId;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *email;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithDBUser:(DBUser *)dbUser;
@end
