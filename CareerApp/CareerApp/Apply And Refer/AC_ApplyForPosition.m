//
//  AC_ApplyForPosition.m
//  CareerApp
//
//  Created by Aditi technologies on 5/17/12.
//  Copyright (c) 2012 Aditi technologies. All rights reserved.
//

#import "AC_ApplyForPosition.h"

@implementation AC_ApplyForPosition
@synthesize _applyScrollView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Apply For Position ", @"Apply For Position");

    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavigationitems];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [_applyScrollView addGestureRecognizer:singleTap];  
}

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{ 
    for(UITextField *txt in _applyScrollView.subviews){
        if([txt isKindOfClass:[UITextField class]]){
            [txt resignFirstResponder];
            [_applyScrollView setContentOffset:CGPointMake(0 , 0)];
        }
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{           // became first responder
    
    if(textField.tag==5||textField.tag==6){
        [_applyScrollView setContentOffset:CGPointMake(0 , 150)];   
    }
}

-(void)customNavigationitems{
    UIImage *submitImage=[UIImage imageNamed:@"submit_button"];
    UIImage *cancelImage=[UIImage imageNamed:@"cancel_button"];
    
     self.navigationController.navigationBar.tintColor=UIColorFromRGB(0x0d0d0d);
   
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
    
}


-(void)cancelMe{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
