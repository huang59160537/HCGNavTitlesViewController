//
//  ViewController.m
//  HCGNavTitlesViewController
//
//  Created by 黄成钢 on 2018/9/3.
//  Copyright © 2018 黄成钢. All rights reserved.
//

#import "ViewController.h"
#import "HCGNavTitlesViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHCGNav];

}
-(void)setHCGNav{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    HCGNavTitlesViewController * HCGNAV=[[HCGNavTitlesViewController alloc]init];
    HCGNAV.view.frame=self.view.frame;
    [self.view addSubview:HCGNAV.view];
    NSArray * items=@[@"关注",@"热门"];
    UIViewController * C1=[[UIViewController alloc]init];
    C1.view.backgroundColor = [UIColor orangeColor];
    UIViewController * C2=[[UIViewController alloc]init];
    C2.view.backgroundColor = [UIColor redColor];
    NSArray * Carray=@[C1,C2];
    [HCGNAV SetUpNavTitleItems:items andControllers:Carray];
    [self addChildViewController:HCGNAV];
    self.navigationItem.titleView=[HCGNAV UpNavTitleItems:items andFrameWidth:160 andFrameHeight:44];
}


@end
