

#import "ACSocialMedia.h"
#import "TweetComposeViewController.h"

@implementation ACSocialMedia
@synthesize timeline;

- (id)init{
    if (self = [super init]){
        self.title = NSLocalizedString(@"Social Media", @"Careers Mobile");
        self.tabBarItem.image = [UIImage imageNamed:@"social_media_icon"];
        self.navigationItem.title=@"Careers Mobile";

    }    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

        items = [[NSMutableArray alloc] initWithObjects:@"What time is it?", nil];
    
    self.navigationController.navigationBar.tintColor=UIColorFromRGB(0x0d0d0d);
    //put logo image in the navigationBar
    UIImage *ima1=[UIImage imageNamed:@"topbar_bw_c.png"];
    UIImageView* img1 = [[UIImageView alloc] initWithImage:ima1];
    img1.frame=CGRectMake(0, 0, ima1.size.width, ima1.size.height);
    
    
    [self.navigationController.navigationBar addSubview:img1]; 
    
    UIImage *img=[UIImage imageNamed:@"Refer Button"];
    UIButton *urButton = [UIButton buttonWithType:UIButtonTypeCustom];
    urButton.frame = CGRectMake(0, 0, 100,50);
    [urButton setImage:img forState:UIControlStateNormal];
    [urButton addTarget:self action:@selector(referFriend)
       forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonItemStylePlain target:self action:@selector(composeTweet)];
    self.navigationItem.rightBarButtonItem=doneButton;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ModalBackgroundNew.png"]];
    
    [self startLoading];
    [self datareceve];

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
                 [self.tableView reloadData];
                 
                 
                 [self stopLoading];
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.timeline count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
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

    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (void)refresh {
    [self performSelector:@selector(datareceve) withObject:nil afterDelay:2.0];
}

- (void)addItem {
    // Add a new time
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    NSString *now = [dateFormatter stringFromDate:[NSDate date]];
    [items insertObject:[NSString stringWithFormat:@"%@", now] atIndex:0];

    [self.tableView reloadData];

    [self stopLoading];
}
# pragma mark - Compose Tweet

- (void)composeTweet
{
    
    
    
    
    if (SYSTEM_VERSION_LESS_THAN(@"5.0")) {
        
        UIAlertView *aletView =[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Update to iOS 5.0 +" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];;
        [aletView show];
        
       
    }
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.0")) {
        TWTweetComposeViewController *tweetComposeViewController = [[TWTweetComposeViewController alloc] init];
        [tweetComposeViewController setCompletionHandler:^(TWTweetComposeViewControllerResult result) {
            [self dismissModalViewControllerAnimated:YES];
        }];
        [self presentModalViewController:tweetComposeViewController animated:YES];
    }
    
}


- (void)tweetComposeViewController:(TweetComposeViewController *)controller didFinishWithResult:(TweetComposeResult)result {
    [self dismissModalViewControllerAnimated:YES];
    //[self fetchData];
}

- (void)dealloc {
    [items release];
    [super dealloc];
}

@end

