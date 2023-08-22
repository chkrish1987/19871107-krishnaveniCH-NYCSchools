//
//  CustomObject.m
//  19871107-krishnaveniCH-NYCSchools
//
//  Created by Krishnaveni on 22/08/23.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CustomObject.h"

@implementation CustomObject

- (void) makePhoneCall:(NSString*) phoneNum {
    
    NSURL *urlOption1 = [NSURL URLWithString:[@"telprompt://" stringByAppendingString:phoneNum]];
    NSURL *urlOption2 = [NSURL URLWithString:[@"tel://" stringByAppendingString:phoneNum]];
    NSURL *targetURL = nil;

    if ([UIApplication.sharedApplication canOpenURL:urlOption1]) {
        targetURL = urlOption1;
    } else if ([UIApplication.sharedApplication canOpenURL:urlOption2]) {
        targetURL = urlOption2;
    }

    if (targetURL) {
        if (@available(iOS 10.0, *)) {
            [UIApplication.sharedApplication openURL:targetURL options:@{} completionHandler:nil];
        } else {
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
            [UIApplication.sharedApplication openURL:targetURL];
    #pragma clang diagnostic pop
        }
    } else {
        NSString *errorMessage = [NSString stringWithFormat:@"Cann't Make this %@ from simulator ", phoneNum];
        UIAlertController * alert = [UIAlertController alertControllerWithTitle : @"Error!"
                                                                            message :errorMessage
                                                                     preferredStyle : UIAlertControllerStyleAlert];

            UIAlertAction * ok = [UIAlertAction
                                  actionWithTitle:@"OK"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  { }];

            [alert addAction:ok];
            UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;

            while (topController.presentedViewController) {
                topController = topController.presentedViewController;
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                [topController presentViewController:alert animated:YES completion:nil];
            });
    }
}

@end
