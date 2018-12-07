//
//  Post.h
//  TomTom
//
//  Created by Djuro Alfirevic on 12/6/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBPost+CoreDataClass.h"

@interface Post : NSObject
@property (nonatomic) NSInteger userId;
@property (nonatomic) NSInteger objectId;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *body;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithDBPost:(DBPost *)dbPost;
@end
