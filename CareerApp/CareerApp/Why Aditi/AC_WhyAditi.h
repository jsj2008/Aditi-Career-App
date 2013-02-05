//
//  AC_WhyAditi.h
//  CareerApp
//
//  Created by Aditi technologies on 5/15/12.
//  Copyright (c) 2012 Aditi technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface AC_WhyAditi : UIViewController<iCarouselDelegate,iCarouselDataSource>
@property(nonatomic,strong)IBOutlet iCarousel *carousel;
-(void)readStories;
@end
