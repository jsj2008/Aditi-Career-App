//
//  AC_WhyAditi.m
//  CareerApp
//
//  Created by Aditi technologies on 5/15/12.
//  Copyright (c) 2012 Aditi technologies. All rights reserved.
//

#import "AC_WhyAditi.h"
#import "AC_ReferFriend.h"
#import "ViewController.h"
#import "AC_ComicsPage.h"
@implementation AC_WhyAditi
@synthesize carousel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Why Aditi", @"");
        self.tabBarItem.image = [UIImage imageNamed:@"why_aditi_icon"];
       // self.navigationItem.title=@"Careers Mobile";
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
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
   // self.navigationItem.title=@"";
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //put logo image in the navigationBar
    UIImage *ima1=[UIImage imageNamed:@"topbar_bw_c.png"];
    UIImageView* img1 = [[UIImageView alloc] initWithImage:ima1];
    img1.frame=CGRectMake(0, 0, ima1.size.width, ima1.size.height);
    
    
    [self.navigationController.navigationBar addSubview:img1]; 

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.tintColor=UIColorFromRGB(0x0d0d0d);
    
   
          UIImage *img=[UIImage imageNamed:@"refer_button"];
        UIButton *urButton = [UIButton buttonWithType:UIButtonTypeCustom];
        urButton.frame = CGRectMake(0, 0, img.size.width,img.size.width);
        [urButton setImage:img forState:UIControlStateNormal];
        [urButton addTarget:self action:@selector(referFriend)
           forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithTitle:@"Refer" style:UIBarButtonItemStylePlain target:self action:@selector(referFriend)];
    
    UIBarButtonItem *mybutton = [[UIBarButtonItem alloc]initWithCustomView:urButton];
    
    self.navigationItem.rightBarButtonItem=mybutton;
        
        
  
    carousel.type=1;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"personal_stories_bg_b.png"]];

}
-(void)readStories:(id)sender{
    
    
    UIButton *snderButton = (UIButton *)sender;
      if(snderButton.tag==1){
        
        UIViewController *readViewController=[[AC_ComicsPage alloc]initWithNibName:@"AC_ComicsPage" bundle:nil];
        [self.navigationController pushViewController:readViewController animated:YES];
          
          
      }else{

          UIViewController *readViewController=[[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
          [self.navigationController pushViewController:readViewController animated:YES];
        
      }
}

-(void)referFriend{
    
    AC_ReferFriend *referFnd=[[AC_ReferFriend alloc]initWithNibName:@"AC_ReferFriend" bundle:nil];
    UINavigationController *NavReferFnd=[[UINavigationController alloc]initWithRootViewController:referFnd];
    [self presentViewController:NavReferFnd animated:YES completion:Nil];
    
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
    return YES;
}
#pragma mark icarosel metheds
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 3;
}
- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    //limit the number of items views loaded concurrently (for performance reasons)
    return 3;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
    //create a numbered view
    UIView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grid-2.png"]];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 300)];
    lbl.textAlignment=UITextAlignmentCenter;
    lbl.backgroundColor=[UIColor clearColor];
    lbl.text=[NSString stringWithFormat:@"title -%d",index];
    
    //[view addSubview:lbl];
    if(index==0){
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"grid-2"]];
    imageView.frame=CGRectMake(0, 20, 250, 400);
   // [view addSubview:imageView];

    }if(index==1){
        UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"grid-2"]];
        imageView.frame=CGRectMake(0, 20, 250, 400);
       // [view addSubview:imageView];
        
    }if(index==2){
        UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"grid-2"]];
        imageView.frame=CGRectMake(0, 20, 250, 400);
      //  [view addSubview:imageView];
        
    }
    UIButton *btnAppy = [UIButton buttonWithType:UIButtonTypeCustom];
    btnAppy.frame = CGRectMake(30, 50, 150, 100);
    btnAppy.tag=index;
  //  [btnAppy setTitle:[NSString stringWithFormat:@"Why Aditi -%d",index] forState:UIControlStateNormal];
    [btnAppy addTarget:self action:@selector(readStories:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnAppy];
    return view;
}
- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 0;
}
- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    //usually this should be slightly wider than the item views
    return 300;
}
- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    //wrap all carousels
    return YES;
}
//- (void)carouselDidEndScrollingAnimation:(iCarousel *)aCarousel
//{
//    [label setText:[NSString stringWithFormat:@"%@", [descriptions objectAtIndex:aCarousel.currentItemIndex]]];
//}
@end
