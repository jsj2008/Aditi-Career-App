//
//  CurrentOpenings.h
//  SampleWebservice
//
//  Created by Aditi technologies on 6/12/12.
//  Copyright (c) 2012 Aditi technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentOpenings : NSObject{
    NSString * _JobCode;
    NSString * _JobExperience;
    NSString * _JobId;
    NSString * _JobLocation;
    NSString * _JobShortDescription;
    NSString * _JobTitle;
}
@property(nonatomic,strong)NSString * _JobCode;
@property(nonatomic,strong)NSString * _JobExperience;
@property(nonatomic,strong)NSString * _JobId;
@property(nonatomic,strong)NSString * _JobLocation;
@property(nonatomic,strong)NSString * _JobShortDescription;
@property(nonatomic,strong)NSString * _JobTitle;


@end
