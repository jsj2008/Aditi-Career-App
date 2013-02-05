//
//  AC_SocialMedia.h
//  CareerApp
//
//  Created by Aditi technologies on 5/15/12.
//  Copyright (c) 2012 Aditi technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
@interface AC_SocialMedia : UIViewController{
    id timeline;
}
@property(strong,nonatomic)IBOutlet UITableView *timelineTableView;
@property (strong, nonatomic) id timeline;
-(void)datareceve;

@end
