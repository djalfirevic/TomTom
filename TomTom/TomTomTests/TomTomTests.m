//
//  TomTomTests.m
//  TomTomTests
//
//  Created by Djuro Alfirevic on 12/6/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NetworkFetcher.h"
#import "DataManager.h"
#import "User.h"
#import "DBUser+CoreDataClass.h"

@interface TomTomTests : XCTestCase
@property (strong, nonatomic) NetworkFetcher *networkFetcher;
@end

@implementation TomTomTests

#pragma mark - Setup

- (void)setUp {
    self.networkFetcher = [[NetworkFetcher alloc] init];
}

- (void)tearDown {
    self.networkFetcher = nil;
}

#pragma mark - Tests

- (void)testFetchPosts {
    XCTestExpectation *requestExpectation = [self expectationWithDescription:@"Fetch Posts Request"];
    
    [self.networkFetcher fetchPosts:^(NSArray<Post *> *posts, NSError *error) {
        [requestExpectation fulfill];
        
        XCTAssertNotNil(posts, "🛑 Fetching posts failed");
        XCTAssertTrue(posts.count > 0, "🛑 Fetching posts failed");
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        if (error) {
            XCTFail("🛑 Request timed out");
        }
    }];
}

- (void)testSaveUserToDatabase {
    DataManager *dataManager = [DataManager sharedInstance];
    
    User *user = [[User alloc] init];
    user.objectId = 1;
    user.name = @"Djuro";
    user.username = @"djalfirevic";
    user.email = @"djalfirevic@gmail.com";
    
    [dataManager storeUserToDatabase:user];
    
    XCTAssertTrue([dataManager userExistsInDatabase:1], "🛑 User doesn't exist in database");
}

@end
