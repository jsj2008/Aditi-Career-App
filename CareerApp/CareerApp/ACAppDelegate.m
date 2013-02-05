//
//  ACAppDelegate.m
//  CareerApp
//
//  Created by Aditi technologies on 5/15/12.
//  Copyright (c) 2012 Aditi technologies. All rights reserved.
//

#import "ACAppDelegate.h"

#import "ACFirstViewController.h"

#import "ACSecondViewController.h"

#import "AC_WhyAditi.h"
#import "AC_SocialMedia.h"
#import "ACSocialMedia.h"
#import "XMLParser.h"
#import "CurrentOpenings.h"
#import "SplashView.h"
@interface ACAppDelegate()

-(void)creatFavoritePath;

@end

@implementation ACAppDelegate

@synthesize window = _window;
@synthesize viewcontroller;
@synthesize tabBarController = _tabBarController;
@synthesize currentopeningsArry;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor=[UIColor redColor];
    // Override point for customization after application launch.
     [self creatFavoritePath];
    
    myIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    myIndicator.frame=CGRectMake(10, 100, 30, 40);
	myIndicator.center = CGPointMake(160, 240);
	//myIndicator.hidesWhenStopped = YES;
 //   [self.window addSubview:myIndicator];
    
   
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"AC",@"CompanyCode" ,nil];
  
   
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewcontroller = [[SplashView alloc] initWithNibName:@"SplashView" bundle:nil];
    } else {
        self.viewcontroller = [[SplashView alloc] initWithNibName:@"SplashView" bundle:nil];
    }
   // self.window.rootViewController = self.viewcontroller;
    //[self.window makeKeyAndVisible];
  
    [self DownloadCompleted];
    
    [self.window makeKeyAndVisible];
    return YES;
    
   
}
-(void)DownloadCompleted{
    
    self.viewcontroller= nil;
    
    
    UIViewController *viewController1, *viewController2, *viewController3, *viewController4;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewController1 = [[ACFirstViewController alloc] initWithNibName:@"ACFirstViewController_iPhone" bundle:nil];
        viewController2 = [[ACSecondViewController alloc] initWithNibName:@"ACSecondViewController_iPhone" bundle:nil];
        viewController3 = [[AC_WhyAditi alloc] initWithNibName:@"AC_WhyAditi" bundle:nil];
        // viewController4 = [[AC_SocialMedia alloc] initWithNibName:@"AC_SocialMedia" bundle:nil];
        viewController4 = [[ACSocialMedia alloc] init];
    } else {
        viewController1 = [[ACFirstViewController alloc] initWithNibName:@"ACFirstViewController_iPad" bundle:nil];
        viewController2 = [[ACSecondViewController alloc] initWithNibName:@"ACSecondViewController_iPad" bundle:nil];
        viewController3 = [[AC_WhyAditi alloc] initWithNibName:@"AC_WhyAditi_iPad" bundle:nil];
        viewController4 = [[AC_SocialMedia alloc] initWithNibName:@"AC_SocialMedia_iPad" bundle:nil];
        
    }
    UINavigationController *vi1=[[UINavigationController alloc]initWithRootViewController:viewController1];
    UINavigationController *vi2=[[UINavigationController alloc]initWithRootViewController:viewController2];
    UINavigationController *vi3=[[UINavigationController alloc]initWithRootViewController:viewController3];
    UINavigationController *vi4=[[UINavigationController alloc]initWithRootViewController:viewController4];
    
    
    self.tabBarController = [[UITabBarController alloc] init];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage: [UIImage imageNamed:@"bottom_bar.png"]];
    [self.tabBarController.tabBar addSubview:imageView];
    
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:vi1,vi2,vi3,vi4,nil];
    self.window.rootViewController = self.tabBarController;
}

-(void)parsedata{
    
    NSMutableArray *dataArry = [[NSMutableArray alloc]initWithContentsOfFile:[@"~/Library/Caches/currentOpenings.plist" stringByExpandingTildeInPath]];
    
    
    
    
    if(dataArry.count>0){
    NSData *data=[dataArry objectAtIndex:0];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
	
	//Initialize the delegate.
	XMLParser *parser = [[XMLParser alloc] initXMLParser];
	
	//Set delegate
	[xmlParser setDelegate:parser];
	
	//Start parsing the XML file.
	BOOL success = [xmlParser parse];
	
        if(success){
		NSLog(@"No Errors %d",currentopeningsArry.count);
        CurrentOpenings *curt = [currentopeningsArry objectAtIndex:1];
        
            NSLog(@"current discription %@",curt._JobLocation);
        }            
	else
		NSLog(@"Error Error Error!!!");
    }
    
    
}

-(void)creatFavoritePath{
    
    NSMutableArray * analyticsArry = [[NSMutableArray alloc]init];
    [analyticsArry writeToFile:[kFavoritePath stringByExpandingTildeInPath]  atomically:YES];
    
    
   
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
