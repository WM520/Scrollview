//
//  ViewController.m
//  scrollView
//
//  Created by David on 16/5/25.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "ViewController.h"
#import "WMCustomScrollView.h"
#define UIScreenWidth [UIScreen mainScreen].bounds.size.width
#define UIScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic)  UIScrollView *scrollView;

@property (weak, nonatomic) UIButton *leftBtn;
@property (weak, nonatomic) UIButton *rightBtn;
@property (weak, nonatomic) UIView *leftView;
@property (weak, nonatomic) UIView *rightView;
@property (weak, nonatomic) WMCustomScrollView *customScrollView;

@end

@implementation ViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.scrollView.contentOffset = CGPointMake(0, 0);
//    self.leftBtn.selected = YES;
//    self.rightBtn.selected = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationItem.titleView = [self setUpNavTitleView];
//    [self initScrollView];
    WMCustomScrollView *customScrollView = [[WMCustomScrollView alloc] initWithFrame:CGRectMake(0, 20, UIScreenWidth, UIScreenHeight - 20) TitleHeight:50];
    customScrollView.titleName = @[@"鸣人", @"佐助", @"小樱", @"卡卡西", @"大蛇丸", @"小李"];
    customScrollView.controllersName = @[@"ViewController1", @"ViewController2", @"ViewController3", @"ViewController4",@"ViewController5", @"ViewController6"];
    [self.view addSubview: customScrollView];
    self.customScrollView = customScrollView;
}


#pragma mark -顶部转换按钮
- (UIView *)setUpNavTitleView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    
    UIButton *leftBtn = [self creatButtonWithTitle:@"鸣人" andWithTextColor:[UIColor lightGrayColor] andWithSelectedColor:[UIColor orangeColor] andWithTarget:self andWithAction:@selector(leftOnClick:) andWithCGRect:CGRectMake(0, 0, 100, 44)];
    [view addSubview:leftBtn];
    self.leftBtn = leftBtn;
    
    UIButton *rightBtn = [self creatButtonWithTitle:@"佐助" andWithTextColor:[UIColor lightGrayColor] andWithSelectedColor:[UIColor orangeColor] andWithTarget:self  andWithAction:@selector(rightOnClick:) andWithCGRect:CGRectMake(100, 0, 100, 44)];
    [view addSubview:rightBtn];
    self.rightBtn = rightBtn;
    
    return view;
}

/**
 *  左边按钮
 */
- (void)leftOnClick:(UIButton *)btn
{
    self.scrollView.contentOffset = CGPointZero;
    self.leftBtn.selected = YES;
    self.rightBtn.selected = NO;
}
/**
 *  右边按钮
 */
- (void)rightOnClick:(UIButton *)btn
{
    self.scrollView.contentOffset = CGPointMake(UIScreenWidth, 0);
    self.leftBtn.selected = NO;
    self.rightBtn.selected = YES;
}
/**
 *  初始化scrollView
 */
- (void)initScrollView
{
    self.scrollView.contentSize = CGSizeMake(UIScreenWidth * 2, UIScreenHeight - 64);
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.scrollEnabled = YES;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight - 64)];
    leftView.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:leftView];
    self.leftView = leftView;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(UIScreenWidth, 0, UIScreenWidth, UIScreenHeight - 64)];
    rightView.backgroundColor = [UIColor orangeColor];
    [self.scrollView addSubview:rightView];
    self.rightView = rightView;
}

- (UIButton *)creatButtonWithTitle:(NSString *)title andWithTextColor:(UIColor *)textColor andWithSelectedColor:(UIColor *)selectColor andWithTarget:(id)target andWithAction:(SEL)sel andWithCGRect:(CGRect)rect
{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    [btn setTitleColor:selectColor forState:UIControlStateSelected];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollView.contentOffset.x == 0)
    {
        self.leftBtn.selected = YES;
        self.rightBtn.selected = NO;
    } else if (self.scrollView.contentOffset.x == UIScreenWidth) {
        self.leftBtn.selected = NO;
        self.rightBtn.selected = YES;
    }
}

@end
