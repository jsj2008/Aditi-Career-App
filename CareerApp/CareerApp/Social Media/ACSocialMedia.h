
#import <UIKit/UIKit.h>
#import "PullRefreshTableViewController.h"
#import <Twitter/Twitter.h>
@interface ACSocialMedia : PullRefreshTableViewController {
    NSMutableArray *items;
}
@property (strong, nonatomic) id timeline;
-(void)datareceve;
@end
