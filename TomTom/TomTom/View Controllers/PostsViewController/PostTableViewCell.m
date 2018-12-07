//
//  PostTableViewCell.m
//  TomTom
//
//  Created by Djuro Alfirevic on 12/6/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

#import "PostTableViewCell.h"

@implementation PostTableViewCell

#pragma mark - Properties

- (void)setPost:(Post *)post {
    _post = post;
    
    self.titleLabel.text = post.title;
}

@end
