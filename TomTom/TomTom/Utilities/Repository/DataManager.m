//
//  DataManager.m
//  TomTom
//
//  Created by Djuro Alfirevic on 12/7/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

#import "DataManager.h"
#import "Post.h"
#import "DBPost+CoreDataClass.h"
#import "DBUser+CoreDataClass.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface DataManager()
@property (strong, nonatomic) AppDelegate *appDelegate;
@end

@implementation DataManager

#pragma mark - Properties

- (AppDelegate *)appDelegate {
    return (AppDelegate *)UIApplication.sharedApplication.delegate;
}

#pragma mark - Designated Initializer

+ (DataManager *)sharedInstance {
    static DataManager *sharedManager;
    
    @synchronized(self)    {
        if (sharedManager == nil) {
            sharedManager = [[DataManager alloc] init];
        }
    }
    
    return sharedManager;
}

#pragma mark - Public API

- (void)storePostsToDatabase:(NSArray *)posts {
    [self removeAllPosts];
    
    for (Post *post in posts) {
        DBPost *dbPost = (DBPost *)[NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([DBPost class])
                                                                 inManagedObjectContext:self.appDelegate.persistentContainer.viewContext];
        dbPost.userId = post.userId;
        dbPost.objectId = post.objectId;
        dbPost.title = post.title;
        dbPost.body = post.body;
        
        [self.appDelegate saveContext];
    }
}

- (void)storeUserToDatabase:(User *)user {
    if ([self userExistsInDatabase:user.objectId]) {
        return;
    }
    
    DBUser *dbUser = (DBUser *)[NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([DBUser class])
                                                             inManagedObjectContext:self.appDelegate.persistentContainer.viewContext];
    dbUser.objectId = user.objectId;
    dbUser.name = user.name;
    dbUser.username = user.username;
    dbUser.email = user.email;
    
    [self.appDelegate saveContext];
}

- (BOOL)userExistsInDatabase:(NSInteger)userId {
    NSFetchRequest *fetchRequest = DBUser.fetchRequest;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId == %ld", userId];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [self.appDelegate.persistentContainer.viewContext executeFetchRequest:fetchRequest error:&error];
    
    return results.count == 1;
}

#pragma mark - Private API

- (void)removeAllPosts {
    NSBatchDeleteRequest *deleteRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:DBPost.fetchRequest];
    
    NSError *error = nil;
    [self.appDelegate.persistentContainer.persistentStoreCoordinator executeRequest:deleteRequest
                                                                        withContext:self.appDelegate.persistentContainer.viewContext error:&error];
    
    if (error) {
        NSLog(@"DELETE error: %@", error.localizedDescription);
    }
}

@end
