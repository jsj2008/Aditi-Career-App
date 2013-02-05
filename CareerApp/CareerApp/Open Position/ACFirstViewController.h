//
//  ACFirstViewController.h
//  CareerApp
//
//  Created by Aditi technologies on 5/15/12.
//  Copyright (c) 2012 Aditi technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import "ACAppDelegate.h"
@interface ACFirstViewController : UIViewController<UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource>  {
    ACAppDelegate *appDelegate;
    NSMutableArray *jobName;
    NSMutableArray *searchOptionsArry;
}

-(IBAction)ApplyForJOb:(id)sender;
-(IBAction)ShareJobDetails:(id)sender;
-(IBAction)closePositionListView:(id)sender;
-(IBAction)jobsearchButtonsClicked:(id)sender;
@property(nonatomic,strong)IBOutlet UIPickerView *_searchPickerView;
@property(nonatomic,strong)IBOutlet UIScrollView *_searchScrollView;
@property(nonatomic,strong)IBOutlet UIScrollView *_jobScrollView;
@property(nonatomic,strong)IBOutlet UIView *_posiotionListView;
@property(nonatomic,strong)IBOutlet UIScrollView *_jobDiscriptionScrollView;
@property(nonatomic,strong)IBOutlet UISearchBar *_searchBar;
@property(nonatomic,strong)  NSMutableArray *searchOptionsArry;
@end
