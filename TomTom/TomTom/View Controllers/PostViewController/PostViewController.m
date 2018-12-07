//
//  PostViewController.m
//  TomTom
//
//  Created by Djuro Alfirevic on 12/6/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

#import "PostViewController.h"
#import "User.h"
#import "DataFetcher.h"

@interface PostViewController()
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) User *user;
@end

@implementation PostViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[DataFetcher alloc] fetchUserForId:self.post.userId withCompletion:^(User *user, NSError *error) {
        self.user = user;
        [self configureText];
    }];
}

#pragma mark - Private API

- (void)configureText {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    if (self.user) {
        NSDictionary *authorAttributes = @{ NSFontAttributeName: [UIFont boldSystemFontOfSize:15.0] };
        NSAttributedString *authorString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n\n", self.user.description]
                                                                           attributes:authorAttributes];
        
        [attributedString appendAttributedString:authorString];
    }
    
    NSDictionary *bodyAttributes = @{ NSFontAttributeName: [UIFont italicSystemFontOfSize:14.0] };
    NSAttributedString *bodyString = [[NSAttributedString alloc] initWithString:self.post.description attributes:bodyAttributes];
    
    [attributedString appendAttributedString:bodyString];
    
    self.descriptionLabel.attributedText = attributedString;
}

@end
