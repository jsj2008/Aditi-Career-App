//
//  ACAppDelegate.h
//  CareerApp
//
//  Created by Aditi technologies on 5/15/12.
//  Copyright (c) 2012 Aditi technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SplashView.h"
@interface ACAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>{
    NSMutableArray *currentopeningsArry;
   
    UIActivityIndicatorView *myIndicator;
    SplashView *viewcontroller;
}@property(nonatomic,strong)SplashView *viewcontroller;
@property(strong,nonatomic)NSMutableArray *currentopeningsArry;
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;
-(void)parsedata;
-(void)DownloadCompleted;
@end
