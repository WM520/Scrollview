//
//  WMCustomScrollView.m
//  scrollView
//
//  Created by David on 16/6/3.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "WMCustomScrollView.h"
#define titleNameWidth 50
#define labelWidth 100
#define normalFont [UIFont systemFontOfSize:16]
#define selectFont [UIFont systemFontOfSize:20]

@interface WMCustomScrollView()<UIScrollViewDelegate>
{
    NSInteger _pageNum;
    NSInteger _lastSelectedLabelTag;
    
}

@end

@implementation WMCustomScrollView


- (instancetype)initWithFrame:(CGRect)frame TitleHeight:(CGFloat)titleHeight
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleHeight = titleHeight;
        
        UIScrollView *contentScrollView = [[UIScrollView alloc] init];
        contentScrollView.pagingEnabled = YES;
        contentScrollView.showsVerticalScrollIndicator = NO;
        contentScrollView.showsHorizontalScrollIndicator = NO;
        contentScrollView.bounces = NO;
        contentScrollView.delegate = self;
        self.contentScrollView = contentScrollView;
        [self addSubview:contentScrollView];
        
        UIScrollView *titleScrollView = [[UIScrollView alloc] init];
        titleScrollView.showsHorizontalScrollIndicator = NO;
        self.titleScrollView = titleScrollView;
        [self addSubview:titleScrollView];
        self.titleScrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.titleHeight);
        self.contentScrollView.frame = CGRectMake(0, self.titleHeight, self.frame.size.width, self.frame.size.height - self.titleHeight);
    }
    return self;
}


- (void)setControllersName:(NSArray *)controllersName
{
    _controllersName = controllersName;
    _contentScrollView.contentSize = CGSizeMake(self.frame.size.width * controllersName.count, self.frame.size.height);
    
    for (int i = 0; i < controllersName.count; i++) {
        Class cls = NSClassFromString(controllersName[i]);
        UIViewController *vc = [[cls alloc] init];
        vc.view.backgroundColor = [UIColor colorWithRed:arc4random() % 255 /255.f green:arc4random() % 255 /255.f blue:arc4random() % 255 /255.f alpha:1];
        UIView *view = vc.view;
        CGFloat viewX = self.frame.size.width * i;
        CGRect frame = view.frame;
        frame.origin.x = viewX;
        view.frame = frame;
        NSLog(@"%@", NSStringFromCGRect(view.frame));
        [_contentScrollView addSubview:view];
    }
    
}

- (void)setTitleName:(NSArray *)titleName
{
    _titleName = titleName;
    CGFloat labelW = labelWidth;
    NSLog(@"%f", _titleScrollView.frame.size.width);
    _titleScrollView.contentSize = CGSizeMake(labelW * titleName.count, 0);
    for (int i = 0; i < titleName.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        CGFloat labelX = labelW * i;
        CGFloat labelY = 0;
        CGFloat labelH = _titleScrollView.frame.size.height;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = normalFont;
        label.text = titleName[i];
        label.userInteractionEnabled = YES;
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        label.tag = 1000 + i;
        [_titleScrollView addSubview:label];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabel:)];
        [label addGestureRecognizer:tap];
        
        // 设置默认选项
        if (i == 0) {
            label.textColor = [UIColor redColor];
            label.font = selectFont;
            _lastSelectedLabelTag = 1000;
        }
    }
}

- (void)tapLabel:(UITapGestureRecognizer *)sender
{
    NSInteger index = sender.view.tag - 1000;
    
    
    CGFloat offsetX = index * self.frame.size.width;
    
    [_contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    NSInteger tagOfLabel = sender.view.tag;
    UILabel *nowLabel = (UILabel *)[self viewWithTag:tagOfLabel];
    
    nowLabel.textColor = [UIColor redColor];
    nowLabel.font = selectFont;
    
    UILabel *lastLabel = (UILabel *)[self viewWithTag:_lastSelectedLabelTag];
    
    lastLabel.font = normalFont;
    lastLabel.textColor = [UIColor blackColor];
    
    _lastSelectedLabelTag = tagOfLabel;
    
    if (index >= 2 && index < self.controllersName.count - 1) {
        NSInteger orx = nowLabel.tag - 1000;
        [_titleScrollView setContentOffset:CGPointMake(orx * lastLabel.frame.size.width - (self.frame.size.width/2), 0) animated:YES];
    }
    
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / self.frame.size.width;
    
    NSInteger labelOfTag = 1000 + index;
    
    if (labelOfTag == _lastSelectedLabelTag) {
        return;
    }
    
    UILabel *nowLabel = (UILabel *)[self viewWithTag:labelOfTag];
    
    nowLabel.textColor = [UIColor redColor];
    nowLabel.font = selectFont;
    
    UILabel *lastLabel = (UILabel *)[self viewWithTag:_lastSelectedLabelTag];
    lastLabel.textColor = [UIColor blackColor];
    lastLabel.font = normalFont;
    
    _lastSelectedLabelTag = labelOfTag;
    
    if (index >= 2 && index < self.controllersName.count - 1) {
        CGFloat offsetX = (index - 2) *lastLabel.frame.size.width;
        [_titleScrollView setContentOffset:CGPointMake(offsetX + 10, 0) animated:YES];
    }
    
}



@end
