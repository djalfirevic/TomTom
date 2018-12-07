//
//  DatabaseFetcher.m
//  TomTom
//
//  Created by Djuro Alfirevic on 12/7/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

#import "DatabaseFetcher.h"
#import <CoreData/CoreData.h>
#import "DBPost+CoreDataClass.h"
#import "DBUser+CoreDataClass.h"
#import "AppDelegate.h"

@interface DatabaseFetcher()
@property (strong, nonatomic) AppDelegate *appDelegate;
@end

@implementation DatabaseFetcher

#pragma mark - Properties

- (AppDelegate *)appDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

#pragma mark - Public API

- (void)fetchPosts:(void(^)(NSArray<Post *> *posts, NSError *error))completion {
    NSError *error = nil;
    NSArray<DBPost *> *dbPosts = [self.appDelegate.persistentContainer.viewContext executeFetchRequest:DBPost.fetchRequest error:&error];
    
    NSMutableArray *posts = [NSMutableArray array];
    for (DBPost *dbPost in dbPosts) {
        [posts addObject:[[Post alloc] initWithDBPost:dbPost]];
    }
    
    completion(posts, error);
}

- (void)fetchUserForId:(NSInteger)userId withCompletion:(void(^)(User *user, NSError *error))completion {
    NSError *error = nil;
    NSArray<DBUser *> *dbUsers = [self.appDelegate.persistentContainer.viewContext executeFetchRequest:DBUser.fetchRequest error:&error];
    
    User *user = nil;
    for (DBUser *dbUser in dbUsers) {
        if (dbUser.objectId == userId) {
            user = [[User alloc] initWithDBUser:dbUser];
        }
    }
    
    completion(user, error);
}

@end
