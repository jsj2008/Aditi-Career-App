//
//  ACSecondViewController.h
//  CareerApp
//
//  Created by Aditi technologies on 5/15/12.
//  Copyright (c) 2012 Aditi technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACAppDelegate.h"
@interface ACSecondViewController : UIViewController{
    NSMutableArray *jobName;
    ACAppDelegate *appDelegate;
}
@property(nonatomic,strong)IBOutlet UIScrollView *_jobScrollView;
@property(nonatomic,strong)IBOutlet UIView *_posiotionListView;
@property(nonatomic,strong)IBOutlet UIScrollView *_jobDiscriptionScrollView;
@property(nonatomic,strong)IBOutlet UIScrollView *_searchScrollView;
-(void)customJobView;
-(void)positionListViewCreation;
-(IBAction)ApplyForJOb:(id)sender;
-(IBAction)closePositionListView:(id)sender;
-(void)customizeSearchScrllview;
@end
