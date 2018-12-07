//
//  PostsViewController.m
//  TomTom
//
//  Created by Djuro Alfirevic on 12/6/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

#import "PostsViewController.h"
#import "PostViewController.h"
#import "PostTableViewCell.h"
#import "Post.h"
#import "DataFetcher.h"

@interface PostsViewController() <UITableViewDataSource, UITableViewDelegate>
@property (weak ,nonatomic) IBOutlet UITableView *tableView;
@property (strong ,nonatomic) NSArray<Post *> *posts;
@end

@implementation PostsViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self fetchPosts];
}

#pragma mark - Private API

- (void)fetchPosts {
    [[[DataFetcher alloc] init] fetchPosts:^(NSArray<Post *> *posts, NSError *error) {
        self.posts = posts;
        [self.tableView reloadData];
    }];
}

#pragma mark - Segue Management

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[PostViewController class]]) {
        PostViewController *toViewController = (PostViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        toViewController.post = self.posts[indexPath.row];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    
    cell.post = self.posts[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
