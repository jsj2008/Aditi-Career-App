//
//  ACSecondViewController.m
//  CareerApp
//
//  Created by Aditi technologies on 5/15/12.
//  Copyright (c) 2012 Aditi technologies. All rights reserved.
//

#import "ACSecondViewController.h"
#import "AC_ReferFriend.h"
#import "AC_ApplyForPosition.h"
#import "ACAppDelegate.h"
#import "CurrentOpenings.h"
@interface ACSecondViewController()

-(void)readFavoriteList;


@end
@implementation ACSecondViewController
@synthesize _jobScrollView,_posiotionListView,_jobDiscriptionScrollView,_searchScrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Favourites", @"Favourites");
        self.tabBarItem.image = [UIImage imageNamed:@"favourites_icon"];
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
    
    self.navigationController.navigationBar.tintColor=UIColorFromRGB(0x0d0d0d);
    

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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self readFavoriteList];
  
   
      [self positionListViewCreation];
    [self customizeSearchScrllview];
    }
-(void)readFavoriteList{
    
    if(jobName){
        jobName=nil;
    }
    jobName=[[NSMutableArray alloc]initWithContentsOfFile:[kFavoritePath stringByExpandingTildeInPath]];
     [self customJobView];
    
    
}

-(NSInteger )checkFavoriteFile:(NSInteger )jobId{
    NSMutableArray *myFavArry=[[NSMutableArray alloc]initWithContentsOfFile:[kFavoritePath stringByExpandingTildeInPath]];
    
    
    
    if(myFavArry.count > 0){
        
        
        for(int i=0;i<myFavArry.count;i++){
            
        //    NSMutableDictionary *jabDic = [myFavArry objectAtIndex:i];
            if(jobId == [[myFavArry objectAtIndex:i]integerValue]){
                return i;
            }
            
        }
        
    }
    return 0;
  
}

-(void)deleteFromFavList:(id)sender{
    UIButton *button =(UIButton *)sender;
    
    NSInteger index = [self checkFavoriteFile: button.tag];
    NSMutableArray *deletedAyy=[[NSMutableArray alloc]initWithContentsOfFile:[kFavoritePath stringByExpandingTildeInPath]];
    [deletedAyy removeObjectAtIndex:index];
    [deletedAyy writeToFile:[kFavoritePath stringByExpandingTildeInPath] atomically:YES];
    
    [self readFavoriteList];
    
    
}
-(void)positionListViewCreation{
    
    
    //jobName=[[NSMutableArray alloc]initWithObjects:@".Net",@"iOS",@"HR",@"UI Design",@"Inside Sales", nil];
    
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

-(void)openPositionList{
    
    _posiotionListView.frame=CGRectMake(320, 30, 320, 350);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [self.view addSubview:_posiotionListView];
    _posiotionListView.frame=CGRectMake(0, 43, 320, 350);
    
    [UIView commitAnimations];
    
}
-(IBAction)closePositionListView:(id)sender{
    
    [_posiotionListView removeFromSuperview];
}
-(IBAction)ApplyForJOb:(id)sender{
    
    AC_ApplyForPosition *referFnd=[[AC_ApplyForPosition alloc]initWithNibName:@"AC_ApplyForPosition" bundle:nil];
    UINavigationController *NavReferFnd=[[UINavigationController alloc]initWithRootViewController:referFnd];
    [self presentViewController:NavReferFnd animated:YES completion:Nil];
    
    
    
}
 
-(void)customJobView{
    
    for(UIView *views in self._jobScrollView.subviews){
        [views removeFromSuperview];
    }
       
    appDelegate = (ACAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableArray *myArry=appDelegate.currentopeningsArry;

    double xPos = 10;
    double yPos = 10;
    double widthOfView = 290;
    double heightOfView = 70;
    
    for (int i=0; i<jobName.count; i++) {
        int index = [[jobName objectAtIndex:i]intValue];
        
         CurrentOpenings *curentOpening =[myArry objectAtIndex:index-1];
        
        UIView *jobView = [[UIView alloc] init];
        jobView.frame = CGRectMake(xPos, yPos, widthOfView, heightOfView);
        // jobView.backgroundColor = [UIColor redColor];
        UIImageView *bagImgView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"current_opening_bagr"]];
        bagImgView.frame= CGRectMake(0, 0, widthOfView, heightOfView);
        [jobView addSubview:bagImgView];
        UILabel *lblJobTitle = [[UILabel alloc] init];
        lblJobTitle.frame = CGRectMake(10, 0, widthOfView-50, 75);

        lblJobTitle.text =curentOpening._JobTitle;
        lblJobTitle.backgroundColor = [UIColor clearColor];
        [jobView addSubview:lblJobTitle];
        
        UIButton *btnFav = [UIButton buttonWithType:UIButtonTypeCustom];
        btnFav.frame = CGRectMake(widthOfView-50, 10, 30, 30);
        btnFav.tag=[curentOpening._JobId intValue];
        
        //[btnFav setTitle:[[jobName objectAtIndex:i]objectForKey:@"groupname"] forState:UIControlStateNormal];
        [btnFav addTarget:self action:@selector(deleteFromFavList:) forControlEvents:UIControlEventTouchUpInside];
        
        [btnFav setImage:[UIImage imageNamed:@"DelFavourite"] forState:UIControlStateNormal];
        [jobView addSubview:btnFav];
        
        UIButton *btnAppy = [UIButton buttonWithType:UIButtonTypeCustom];
        btnAppy.frame =lblJobTitle.frame;
        [btnAppy addTarget:self action:@selector(openPositionList) forControlEvents:UIControlEventTouchUpInside];
        [jobView addSubview:btnAppy];
        
        [self._jobScrollView addSubview:jobView];
        
        yPos=yPos+heightOfView + 20;
        
        self._jobScrollView.contentSize = CGSizeMake(self._jobScrollView.frame.size.width, heightOfView*jobName.count);
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


-(void)referFriend{
    AC_ReferFriend *referFnd=[[AC_ReferFriend alloc]initWithNibName:@"AC_ReferFriend" bundle:nil];
    UINavigationController *NavReferFnd=[[UINavigationController alloc]initWithRootViewController:referFnd];
    [self presentViewController:NavReferFnd animated:YES completion:Nil];
    
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
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    //   [_jobScrollView addGestureRecognizer:singleTap];
    [_searchScrollView setContentSize:(CGSizeMake(320, 420))];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
        return YES;
    } else {
        return YES;
    }
}

@end
