//
//  HCGNavTitlesViewController.m
//  NavTitles
//
//  Created by mac on 2018/6/7.
//  Copyright © 2018年 HCG. All rights reserved.
//

#import "HCGNavTitlesViewController.h"


@interface HCGNavTitlesViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView * ScrollView;
@property (nonatomic,strong)UIView *NavView;
@property (nonatomic,strong)UIView *line;

@property (nonatomic, assign) NSInteger currentPage;
@end

#define LineWidth 35.0f

@implementation HCGNavTitlesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor grayColor];
    _ScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _ScrollView.bounces=NO;
    _ScrollView.delegate = self;
    _ScrollView.pagingEnabled = YES;
    _ScrollView.showsVerticalScrollIndicator = NO;
    _ScrollView.showsHorizontalScrollIndicator = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:_ScrollView];
    
}

-(void)SetUpNavTitleItems:(NSArray*)items andControllers:(NSArray*)controllers{
    _ScrollView.backgroundColor=[UIColor orangeColor];
    NSAssert(items.count != 0 || items.count == controllers.count, @"个数不一致, 请自己检查");
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    for (int i=0; i<controllers.count; i++) {
        UIViewController *vc=controllers[i];
        vc.view.frame = CGRectMake(i *  self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self addChildViewController:vc];
        [_ScrollView addSubview:vc.view];
        _ScrollView.contentSize = CGSizeMake(self.view.frame.size.width*self.childViewControllers.count, self.view.frame.size.height);
    }
    
}
-(UIView *)UpNavTitleItems:(NSArray*)itmes andFrameWidth:(float)width andFrameHeight:(float)height {
    _NavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    CGFloat BtnWidth=width/itmes.count;
    CGFloat LineW = (BtnWidth-LineWidth)/2;

    for (int i=0; i<itmes.count; i++) {
        UIButton * navbtn=[[UIButton alloc]init];
        navbtn.frame=CGRectMake(i*BtnWidth, 0, BtnWidth, height);
        navbtn.tag=10000+i;
        navbtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [navbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (i!=0) {
            [navbtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        [navbtn setTitle:itmes[i] forState:UIControlStateNormal];
        [navbtn addTarget:self action:@selector(NavBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_NavView addSubview:navbtn];
        
    }
    _line= [[UIView alloc]initWithFrame:CGRectMake(LineW, height-1.5,LineWidth, 1.5)];
    _line.backgroundColor=[UIColor blackColor];
    [_NavView addSubview:_line];
    return _NavView;
}

-(void)NavBtnClick:(UIButton*)sender{
    NSInteger index=sender.tag-10000;

    for (UIButton *btn in self.NavView.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.currentPage = index;
    [self scrollButtonViewDidScrollToIndex:index];
}

- (void)scrollButtonViewDidScrollToIndex:(NSInteger)index {
    [_ScrollView setContentOffset:CGPointMake(self.view.frame.size.width*index, 0) animated:YES];
}

- (UIScrollView *)ScrollView {
    if (!_ScrollView) {
        UIScrollView *ScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _ScrollView.bounces=YES;
        _ScrollView.delegate = self;
        _ScrollView.pagingEnabled = YES;
        _ScrollView.showsVerticalScrollIndicator = NO;
        _ScrollView.showsHorizontalScrollIndicator = NO;
        
        [self.view addSubview:ScrollView];
        _ScrollView = ScrollView;
    }
    return _ScrollView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width = self.view.frame.size.width;
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger scrollIndex = offsetX / width;
    CGFloat BtnWidth=self.NavView.frame.size.width/2;
    CGFloat progress = (offsetX-width*scrollIndex) / width * 2;
    CGFloat LineW = (BtnWidth-LineWidth)/2;
    if (progress<1) {
        [UIView animateWithDuration:0.1 animations:^{
            self.line.frame=CGRectMake(scrollIndex*(BtnWidth)+LineW, self.line.frame.origin.y, LineWidth+BtnWidth*progress, 1.5);
        }];
    } else {
        [UIView animateWithDuration:0.1 animations:^{
            self.line.frame=CGRectMake(scrollIndex*(BtnWidth)+LineW+BtnWidth*(progress-1), self.line.frame.origin.y, LineWidth+BtnWidth-BtnWidth*(progress-1), 1.5);
        }];
    }
    NSLog(@"----------%f---------%f",self.ScrollView.contentSize.width,self.ScrollView.contentSize.height);
    NSLog(@"------------size:%f",self.ScrollView.frame.size.height);

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat width = self.view.frame.size.width;
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger scrollIndex = offsetX / width;
    NSInteger tag = scrollIndex + 10000;
    [self NavBtnClick:[self.NavView viewWithTag:tag]];
    
}

@end
