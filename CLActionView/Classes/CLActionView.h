//
//  CLActionView.h
//  CarLifeOfShangHai
//
//  Created by apple on 2020/7/21.
//  Copyright © 2020 YANG. All rights reserved.
//
//    CLActionView *actionView = [[CLActionView alloc]init];
//    [actionView showWithTitles:@[@"高德地图",@"百度地图",@"腾讯地图"]];
//    actionView.actionDidClickBlock = ^(NSInteger index) {
//        NSLog(@"点击了第%d个",index);
//    };

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLActionView : UIView

/*
* 初始化
* @param titles 标题数组
*/
- (instancetype)initWithTitles:(NSArray *)titles;

/*
 * action点击Block
 * @param index 点击回传index
 */
@property (nonatomic,copy) void(^actionDidClickBlock)(NSInteger index);


//分割线颜色
@property (nonatomic,strong) UIColor *lineColor;

//字体颜色
@property (nonatomic,strong) UIColor *textColor;

//取消字体颜色
@property (nonatomic,strong) UIColor *cancleTextColor;

@end

NS_ASSUME_NONNULL_END
