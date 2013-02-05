//
//  AC_ReferFriend.m
//  CareerApp
//
//  Created by Aditi technologies on 5/16/12.
//  Copyright (c) 2012 Aditi technologies. All rights reserved.
//

#import "AC_ReferFriend.h"

@implementation AC_ReferFriend
@synthesize _scrollView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
            self.title = NSLocalizedString(@"Refer a friend ", @"Refer a friend");
            //self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)customNavigationitems{
    UIImage *submitImage=[UIImage imageNamed:@"submit_button"];
    UIImage *cancelImage=[UIImage imageNamed:@"cancel_button"];
    
    
    
    UIButton *urButton = [UIButton buttonWithType:UIButtonTypeCustom];
    urButton.frame = CGRectMake(0, 0, submitImage.size.width,submitImage.size.width);
    [urButton setImage:submitImage forState:UIControlStateNormal];
    [urButton addTarget:self action:nil
       forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:urButton];
    
    
    UIButton *urButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    urButton1.frame = CGRectMake(0, 0, cancelImage.size.width,cancelImage.size.width);
    [urButton1 setImage:cancelImage forState:UIControlStateNormal];
    [urButton1 addTarget:self action:@selector(cancelMe)
        forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButtton = [[UIBarButtonItem alloc]initWithCustomView:urButton1];
    
    
    self.navigationItem.rightBarButtonItem = rightButton;
    self.navigationItem.leftBarButtonItem = leftButtton;
 self.navigationController.navigationBar.tintColor=UIColorFromRGB(0x0d0d0d);
    
}
-(void)cancelMe{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavigationitems];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [_scrollView addGestureRecognizer:singleTap];  
}

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{ 
    for(UITextField *txt in _scrollView.subviews){
        if([txt isKindOfClass:[UITextField class]]){
            [txt resignFirstResponder];
             [_scrollView setContentOffset:CGPointMake(0 , 0)];
        }
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{           // became first responder

    if(textField.tag==5||textField.tag==6){
         [_scrollView setContentOffset:CGPointMake(0 , 150)];   
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    
    if(UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)){
       
        _scrollView.contentSize=CGSizeMake(0, 450);
    
    }else{
     
        _scrollView.contentSize=CGSizeMake(0, 0);
    }
    
}

@end
