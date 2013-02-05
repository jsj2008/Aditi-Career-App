//
//  AC_SocialMedia.m
//  CareerApp
//
//  Created by Aditi technologies on 5/15/12.
//  Copyright (c) 2012 Aditi technologies. All rights reserved.
//

#import "AC_SocialMedia.h"
#import "AC_ReferFriend.h"
#import "TweetComposeViewController.h"
@implementation AC_SocialMedia
@synthesize timeline,timelineTableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Social Media", @"Careers Mobile");
        self.tabBarItem.image = [UIImage imageNamed:@"social_media_icon"];
       self.navigationItem.title=@"Careers Mobile";
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
       
    [self datareceve];
        
       

}

-(void)referFriend{
    AC_ReferFriend *referFnd=[[AC_ReferFriend alloc]initWithNibName:@"AC_ReferFriend" bundle:nil];
    UINavigationController *NavReferFnd=[[UINavigationController alloc]initWithRootViewController:referFnd];
    [self presentViewController:NavReferFnd animated:YES completion:Nil];
    
}

-(void)datareceve{
    //  First, we create a dictionary to hold our request parameters
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"weareaditi" forKey:@"screen_name"];
    [params setObject:@"5" forKey:@"count"];
    [params setObject:@"1" forKey:@"include_entities"];
    [params setObject:@"1" forKey:@"include_rts"];
    
    //  Next, we create an URL that points to the target endpoint
    NSURL *url = 
    [NSURL URLWithString:@"http://api.twitter.com/1/statuses/user_timeline.json"];
    
    //  Now we can create our request.  Note that we are performing a GET request.
    TWRequest *request = [[TWRequest alloc] initWithURL:url 
                                             parameters:params 
                                          requestMethod:TWRequestMethodGET];
    
    //  Perform our request
    [request performRequestWithHandler:
     ^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
         
         if (responseData) {
             //  Use the NSJSONSerialization class to parse the returned JSON
             NSError *jsonError;
             id timelin = 
             [NSJSONSerialization JSONObjectWithData:responseData 
                                             options:NSJSONReadingMutableLeaves 
                                               error:&jsonError];
             
             self.timeline=timelin;
             if (timelin) {
                 [self.timelineTableView reloadData];
                 // We have an object that we can parse
                 NSLog(@"%@", timelin);
             } 
             else { 
                 // Inspect the contents of jsonError
                 NSLog(@"%@", jsonError);
             }
         }
     }];
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


- (void)tweetComposeViewController:(TweetComposeViewController *)controller didFinishWithResult:(TweetComposeResult)result {
    [self dismissModalViewControllerAnimated:YES];
    //[self fetchData];
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



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.timeline count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    id tweet = [self.timeline objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = [tweet objectForKey:@"text"];
	cell.textLabel.adjustsFontSizeToFitWidth = YES;
	cell.textLabel.font = [UIFont fontWithName:@"bold" size:19];
	cell.textLabel.minimumFontSize = 10;
	cell.textLabel.numberOfLines = 4;
	cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
	
	cell.detailTextLabel.text = [tweet objectForKey:@"from_user"];
    
    NSDictionary *dic = [[NSDictionary alloc]initWithDictionary:[tweet objectForKey:@"user"] copyItems:YES];
    
	NSLog(@"image URL ...%@",[dic objectForKey:@"profile_image_url"]);
	NSURL *url = [NSURL URLWithString:[dic objectForKey:@"profile_image_url"]];
	NSData *data = [NSData dataWithContentsOfURL:url];
	cell.imageView.image = [UIImage imageWithData:data];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
