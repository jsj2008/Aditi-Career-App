//
//  ACFirstViewController.m
//  CareerApp
//
//  Created by Aditi technologies on 5/15/12.
//  Copyright (c) 2012 Aditi technologies. All rights reserved.
//

#import "ACFirstViewController.h"
#import "AC_ReferFriend.h"
#import "AC_ApplyForPosition.h"
#import "TweetComposeViewController.h"
#import "FacebookController.h"
#import "ACAppDelegate.h"
#import "CurrentOpenings.h"
@interface ACFirstViewController()

-(void)customNavigationitems;
-(void)customizeSearchScrllview;
-(void)customJobView;
-(void)makeFavorite:(id)sender;
-(void)positionListViewCreation;


@end




@implementation ACFirstViewController
@synthesize _searchScrollView,_jobScrollView;
@synthesize _posiotionListView,_jobDiscriptionScrollView;
@synthesize _searchBar,_searchPickerView;
@synthesize searchOptionsArry;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Open Position ", @"Open Position");
        self.tabBarItem.image = [UIImage imageNamed:@"open_positions_icon"];
        self.navigationItem.title=@"Careers Mobile";
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self customNavigationitems];
    [self customizeSearchScrllview];
    [self customJobView];
    [self positionListViewCreation];
    
    for(UITextField  *text in self._searchScrollView.subviews){
        if([text isKindOfClass:[UITextField class]]){
            //UIImageView *myView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_bg.png"]];
           // [text  setRightView:myView];
            //[text  setRightViewMode:UITextFieldViewModeAlways];
           
        }
    }
    
    for(UIImageView *imageView in self.navigationController.navigationBar.subviews){
        if([imageView isKindOfClass:[UIImageView class]]){
            //[self.navigationController.navigationBar sendSubviewToBack:imageView];
            
        }
    }
   
   
}
-(IBAction)jobsearchButtonsClicked:(id)sender{
    UIButton *senderButton = (UIButton *)sender;
    
    if(searchOptionsArry){
        searchOptionsArry=nil;
        
    }
    if(senderButton.tag== [kLocationButtonTag intValue]){
         searchOptionsArry=[[NSMutableArray alloc]initWithObjects:@"Bangaluru",@"Chennai", nil];
        
    } if(senderButton.tag== [kExperienceButtonTag intValue]){
        
         searchOptionsArry=[[NSMutableArray alloc]initWithObjects:@"2 - 4",@"4 - 5",@"5 - 10", @" 10 +" ,nil];
    } if(senderButton.tag== [kRoleButtonTag intValue]){
        
         searchOptionsArry=[[NSMutableArray alloc]initWithObjects:@"Senior Development Engineer",@"Project Manager"@"GPM", nil];
    }
    self._searchPickerView.frame=CGRectMake(0, 155, self._searchPickerView.frame.size.width, self._searchPickerView.frame.size.height);
    [self._searchPickerView reloadAllComponents];
    [self.view addSubview:self._searchPickerView];

    
   
}
-(void)positionListViewCreation{
  
    
    jobName=[[NSMutableArray alloc]initWithObjects:@".Net",@"iOS",@"HR",@"UI Design",@"Inside Sales", nil];
    
    appDelegate = (ACAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableArray *jobName1=appDelegate.currentopeningsArry;
    
    
    double xPos = 0;
    double yPos = 0;
    double widthOfView = 258;
    double heightOfView = 242;
    
    for (int i=0; i<jobName1.count; i++) {
        
        CurrentOpenings *curentOpening = [jobName1 objectAtIndex:i];
        
        
        UIView *jobView = [[UIView alloc] init];
        jobView.frame = CGRectMake(xPos, yPos, widthOfView, heightOfView);
       
        UIImageView *bagImgView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Paper Clipping"]];
        bagImgView.frame= CGRectMake(0, 0, widthOfView, heightOfView);
        [jobView addSubview:bagImgView];
        
        UILabel *lblJobTitle = [[UILabel alloc] init];
        lblJobTitle.frame = CGRectMake(50, 50, 80, 25);
        lblJobTitle.text =curentOpening._JobTitle;
        lblJobTitle.backgroundColor = [UIColor clearColor];
        [jobView addSubview:lblJobTitle];
        
        UITextView *jobDiscription=[[UITextView alloc]init];
        jobDiscription.frame=CGRectMake(20, 100, 180, 200);
        jobDiscription.text=curentOpening._JobShortDescription;
        jobDiscription.backgroundColor=[UIColor clearColor];
        jobDiscription.editable=NO;
        [jobView addSubview:jobDiscription];
        
        
        
        [self._jobDiscriptionScrollView addSubview:jobView];
        
        
        xPos+=widthOfView;
        
         [self._jobDiscriptionScrollView setContentSize:CGSizeMake(widthOfView*i, 0)];
        [self._jobDiscriptionScrollView setPagingEnabled:YES];
        
    }
   
    

    
}
-(void)referFriend{
    AC_ReferFriend *referFnd=[[AC_ReferFriend alloc]initWithNibName:@"AC_ReferFriend" bundle:nil];
    UINavigationController *NavReferFnd=[[UINavigationController alloc]initWithRootViewController:referFnd];
    [self presentViewController:NavReferFnd animated:YES completion:Nil];
    
}
-(void)customJobView{
  //  NSMutableArray *jobName=[[NSMutableArray alloc]initWithObjects:@".Net",@"iOS",@"HR",@"UI Design",@"Inside Sales", nil];
    appDelegate = (ACAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableArray *jobName1=appDelegate.currentopeningsArry;
    double xPos = 15;
    double yPos = 05;
    double widthOfView = 290;
    double heightOfView = 70;
    
    for (int i=0; i<jobName1.count; i++) {
        
        CurrentOpenings *curentOpening = [jobName1 objectAtIndex:i];
        
        
        
        
        UIView *jobView = [[UIView alloc] init];
        jobView.frame = CGRectMake(xPos, yPos, widthOfView, heightOfView);
       // jobView.backgroundColor = [UIColor redColor];
        UIImageView *bagImgView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"current_opening_bagr"]];
        bagImgView.frame= CGRectMake(0, 0, widthOfView, heightOfView);
        [jobView addSubview:bagImgView];
        UILabel *lblJobTitle = [[UILabel alloc] init];
        lblJobTitle.frame = CGRectMake(10, 0, widthOfView-50, 75);
        lblJobTitle.numberOfLines=3;
        lblJobTitle.text = curentOpening._JobTitle;
        
        lblJobTitle.backgroundColor = [UIColor clearColor];
        [jobView addSubview:lblJobTitle];
        
        UIButton *btnFav = [UIButton buttonWithType:UIButtonTypeCustom];
        btnFav.frame = CGRectMake(widthOfView-50, 10, 30, 30);
        [btnFav addTarget:self action:@selector(makeFavorite:) forControlEvents:UIControlEventTouchUpInside];
        btnFav.tag=[curentOpening._JobId intValue];
       // [btnFav setTitle:@"Favourite" forState:UIControlStateNormal];
        [btnFav setImage:[UIImage imageNamed:@"AddFavourite"] forState:UIControlStateNormal];
        [jobView addSubview:btnFav];
        
        UIButton *btnAppy = [UIButton buttonWithType:UIButtonTypeCustom];
        btnAppy.frame = CGRectMake(10, 0, widthOfView-100, 70);
        [btnAppy addTarget:self action:@selector(openPositionList) forControlEvents:UIControlEventTouchUpInside];
        [jobView addSubview:btnAppy];
        
        [self._jobScrollView addSubview:jobView];
        
        
        yPos=yPos+heightOfView + 20;
        
       self._jobScrollView.contentSize = CGSizeMake(self._jobScrollView.frame.size.width, heightOfView*jobName1.count);
//            
//        if(UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)){
//            if (i>0 && ((i+1)%3==0)) {
//                xPos = 10;
//                yPos = yPos+heightOfView+10;
//            }else
//                xPos = xPos +widthOfView+10;
//             self._jobScrollView.contentSize = CGSizeMake(self._jobScrollView.frame.size.width, heightOfView*jobName1.count/2);
//        }else{
//            if (i>0 && ((i+1)%2==0)) {
//                xPos = 10;
//                yPos = yPos+heightOfView+10;
//            }else
//                xPos = xPos +widthOfView+10;
//             self._jobScrollView.contentSize = CGSizeMake(self._jobScrollView.frame.size.width, heightOfView*jobName1.count/2);
//        }
        
    }
    
   
}
-(void)openPositionList{

    _posiotionListView.frame=CGRectMake(320, 43, 320, 350);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [self.view addSubview:_posiotionListView];
    _posiotionListView.frame=CGRectMake(0, 43, 320, 350);
    
    [UIView commitAnimations];
    
}

-(BOOL)checkFavoriteFile:(NSInteger )jobId{
    NSMutableArray *myFavArry=[[NSMutableArray alloc]initWithContentsOfFile:[kFavoritePath stringByExpandingTildeInPath]];
    
    
    if(myFavArry.count==0)return YES;
    
    if(myFavArry.count > 0){
        
        
        for(int i=0;i<myFavArry.count;i++){
            
           
            if(jobId ==[[myFavArry objectAtIndex:i]integerValue] ){
                return NO;
            }
        
        }
    
    }
    
    return YES;
}
-(void)makeFavorite:(id)sender{
    appDelegate = (ACAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableArray *myArry=appDelegate.currentopeningsArry;
   
    
    UIButton *senr = (UIButton *)sender;
    if([self checkFavoriteFile:senr.tag]){
        NSMutableArray *myFavArry=[[NSMutableArray alloc]initWithContentsOfFile:[kFavoritePath stringByExpandingTildeInPath]];
        
         
        
       
        [myFavArry addObject:[NSString stringWithFormat:@"%d",senr.tag]];

        
        [myFavArry writeToFile:[kFavoritePath stringByExpandingTildeInPath] atomically:YES];
    }
   
    
}
-(IBAction)closePositionListView:(id)sender{
    
    [_posiotionListView removeFromSuperview];
}
-(IBAction)ApplyForJOb:(id)sender{
    
    AC_ApplyForPosition *referFnd=[[AC_ApplyForPosition alloc]initWithNibName:@"AC_ApplyForPosition" bundle:nil];
    UINavigationController *NavReferFnd=[[UINavigationController alloc]initWithRootViewController:referFnd];
    [self presentViewController:NavReferFnd animated:YES completion:Nil];



}
-(IBAction)ShareJobDetails:(id)sender {
	
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Share" delegate:self cancelButtonTitle:@"Cancel " destructiveButtonTitle:@"Twitter" otherButtonTitles:@"Facebook",@"E-mail", nil];
	
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	
    [popupQuery showInView:self.view];
	
    
	
}



-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if (buttonIndex == 0) {
		
		[self performSelector:@selector(composeTweet)];
    } else if (buttonIndex == 1) {
		
      [self performSelector:@selector(FaceBookCall)];
		
    } else if (buttonIndex == 2) {
		
        
		
    } else if (buttonIndex == 3) {
		
     
		
    }
	
}

#pragma mark - Compose Tweet

- (void)composeTweet
{
    
    TWTweetComposeViewController *tweetComposeViewController = [[TWTweetComposeViewController alloc] init];
    [tweetComposeViewController setCompletionHandler:^(TWTweetComposeViewControllerResult result) {
        [self dismissModalViewControllerAnimated:YES];
    }];
    [self presentModalViewController:tweetComposeViewController animated:YES];
    
    
    
}
-(void)FaceBookCall{
    FacebookController * facebookViewController = [[FacebookController alloc] initWithNibName: @"Facebook_iphone" 
                                                                                       bundle: nil];
    UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController: facebookViewController];
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController: navController animated: YES];
   

}
-(void)customNavigationitems{
    
    self.navigationController.navigationBar.tintColor=UIColorFromRGB(0x0d0d0d);
    self.navigationController.navigationBar.tintColor=[UIColor clearColor];
    
    //put logo image in the navigationBar
    UIImage *ima1=[UIImage imageNamed:@"topbar_bw_c.png"];
    UIImageView* img1 = [[UIImageView alloc] initWithImage:ima1];
    img1.frame=CGRectMake(0, 0, ima1.size.width, ima1.size.height);
    
    
    [self.navigationController.navigationBar addSubview:img1]; 
    
    UIImage *img=[UIImage imageNamed:@"refer_button"];
    UIButton *urButton = [UIButton buttonWithType:UIButtonTypeCustom];
    urButton.frame = CGRectMake(0, 0, img.size.width,img.size.width);
    [urButton setImage:img forState:UIControlStateNormal];
    [urButton addTarget:self action:@selector(referFriend)
       forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithTitle:@"Refer" style:UIBarButtonItemStylePlain target:self action:@selector(referFriend)];
    
    UIBarButtonItem *mybutton = [[UIBarButtonItem alloc]initWithCustomView:urButton];
    
    self.navigationItem.rightBarButtonItem=mybutton;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ModalBackgroundNew.png"]];
    
    
    
    
    
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
      //  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
        return NO;
    } else {
        return NO;
    }
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
   //[self customJobView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{    
    
    
    if(scrollView.tag==4545){
        
    
        [self.view bringSubviewToFront:self._searchScrollView];
    }
      
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scroll View offset %@",NSStringFromCGPoint(scrollView.contentOffset));
    if(scrollView.tag==4545){
        
        if(scrollView.contentOffset.y<-80){
            scrollView.frame=CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height);
         
        }
        if(scrollView.contentOffset.y<-40 && scrollView.frame.origin.y==0){
            
            scrollView.frame=CGRectMake(0, -196, scrollView.frame.size.width, scrollView.frame.size.height);
                        scrollView.backgroundColor=[UIColor clearColor]
            ;
             [self.view sendSubviewToBack:self._searchScrollView];
        }
    }
  
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   
    if(scrollView.tag==4545){
        
        if(scrollView.contentOffset.y<-115){
        [self.view bringSubviewToFront:self._searchScrollView];
        }if(scrollView.contentOffset.y>-115 && scrollView.frame.origin.y==-196){
            [self.view sendSubviewToBack:self._searchScrollView];
        }

    }
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}
//cutom Animation for search ScrollView
-(void)customizeSearchScrllview{
    for (UIView *subview in self._searchBar.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            UIView *bg = [[UIView alloc] initWithFrame:subview.frame];
            bg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Search Bar"]];
            [self._searchBar insertSubview:bg aboveSubview:subview];
            [subview removeFromSuperview];
            break;
        }
    }   
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
 //   [_jobScrollView addGestureRecognizer:singleTap];
  [_searchScrollView setContentSize:(CGSizeMake(320, 420))];
}

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{ 
    for(UISearchBar *txt in self._searchScrollView.subviews){
        if([txt isKindOfClass:[UISearchBar class]]){
            [txt resignFirstResponder];
            
        }
    }
}


#pragma mark -
#pragma mark Picker View Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	
	return [self.searchOptionsArry count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	return [self.searchOptionsArry objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	
	[self._searchPickerView removeFromSuperview];
    
    NSLog(@"Selected Color: %@. Index of selected color: %i", [self.searchOptionsArry objectAtIndex:row], row);
}


@end
