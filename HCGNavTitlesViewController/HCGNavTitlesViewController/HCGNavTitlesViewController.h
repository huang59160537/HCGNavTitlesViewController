//
//  HCGNavTitlesViewController.h
//  NavTitles
//
//  Created by mac on 2018/6/7.
//  Copyright © 2018年 HCG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HCGNavTitlesDelegate<NSObject>

-(bool)didSelectController:(NSInteger)index;

@end

@interface HCGNavTitlesViewController : UIViewController

@property (nonatomic, weak) id<HCGNavTitlesDelegate> delegate;

-(void)SetUpNavTitleItems:(NSArray*)items andControllers:(NSArray*)controllers;

-(UIView*)UpNavTitleItems:(NSArray*)itmes andFrameWidth:(float)width andFrameHeight:(float)height;


@end
