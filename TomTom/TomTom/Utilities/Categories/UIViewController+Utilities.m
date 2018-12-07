//
//  UIViewController+Utilities.m
//  TomTom
//
//  Created by Djuro Alfirevic on 12/6/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

#import "UIViewController+Utilities.h"

@implementation UIViewController (Utilities)

#pragma mark - Public API

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:NULL];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:NULL];
}

@end
