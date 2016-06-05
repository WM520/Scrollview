//
//  WMCustomScrollView.h
//  scrollView
//
//  Created by David on 16/6/3.
//  Copyright © 2016年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMCustomScrollView : UIView


@property (nonatomic, weak) UIScrollView *contentScrollView;
@property (nonatomic, weak) UIScrollView *titleScrollView;
@property (nonatomic, copy) NSArray *controllersName;
@property (nonatomic, copy) NSArray *titleName;

@property (nonatomic, assign) CGFloat titleHeight;


- (instancetype)initWithFrame:(CGRect)frame TitleHeight:(CGFloat)titleHeight;

@end
