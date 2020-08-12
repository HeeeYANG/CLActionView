//
//  CLActionView.m
//  CarLifeOfShangHai
//
//  Created by apple on 2020/7/21.
//  Copyright © 2020 YANG. All rights reserved.
//

#import "CLActionView.h"

//颜色相关
#define UIColorRGBA(color,nAlpha) UIColorMakeRGBA(color>>16, (color&0x00ff00)>>8,color&0x0000ff,nAlpha)
#define UIColorMakeRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define UIColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define CLScreenW [[UIScreen mainScreen] bounds].size.width
#define CLScreenH [[UIScreen mainScreen] bounds].size.height

#define UIFontOfRegular(fontSize) [UIFont fontWithName:@"PingFangSC-Regular" size:(fontSize)]
#define UIFontOfMedium(fontSize) [UIFont fontWithName:@"PingFangSC-Medium" size:(fontSize)]

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IOS_11  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.f)

//iphone11以及之后机型
#define IS_IPHONE_X (IS_IOS_11 && IS_IPHONE && (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) >= 375 && MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) >= 812))

@interface CLActionView ()
@property (nonatomic,strong) NSArray *titles;
@end

@implementation CLActionView

- (instancetype)initWithTitles:(NSArray *)titles
{
    self = [super init];
    if (self) {
        [self setupUI];
        [self showWithTitles:titles];
    }
    return self;
}

- (void)showWithTitles:(NSArray *)titles{
    self.titles = titles;
    float bgHeight = IS_IPHONE_X ? ((self.titles.count + 1) * 50.0 + 10 + 34) : ((self.titles.count + 1) * 50.0 + 10);
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, CLScreenH - bgHeight, CLScreenW, bgHeight)];
    bgView.layer.cornerRadius = 10;
    bgView.backgroundColor = UIColorHex(0xF8F8F8);
    [self addSubview:bgView];
    
    for (int i = 0; i < self.titles.count + 1; i++) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        float y = self.titles.count == i ? 50.0 * i + 10 : 50.0 * i;
        float height = self.titles.count == i ? 50 + 34.0 : 50.0;
        button.frame = CGRectMake(0, y , CLScreenW, height);
        button.tag = 200 + i;
        [button setTitleColor:UIColorHex(0x333333) forState:(UIControlStateNormal)];
        button.backgroundColor = [UIColor whiteColor];
        if (i == self.titles.count) {
            if (IS_IPHONE_X) {
                button.titleEdgeInsets = UIEdgeInsetsMake(-17, 0, 0, 0);
            }
            [button setTitle:@"取消" forState:(UIControlStateNormal)];
            button.titleLabel.font = UIFontOfRegular(17);
            [button addTarget:self action:@selector(tapAction) forControlEvents:(UIControlEventTouchUpInside)];
        }else{
            [button setTitle:titles[i] forState:(UIControlStateNormal)];
            button.titleLabel.font = UIFontOfMedium(17);
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        }
        [bgView addSubview:button];
        if (i < self.titles.count) {
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50.0*i, CLScreenW, 1)];
            lineView.tag = 300 + i;
            lineView.backgroundColor = UIColorHex(0xE3E3E3);
            [bgView addSubview:lineView];
        }
    }
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
}

- (void)setLineColor:(UIColor *)lineColor{
    for (int i = 1; i < self.titles.count; i++) {
        UIView *view = [self viewWithTag:300 + i];
        view.backgroundColor = lineColor;
    }
}

- (void)setTextColor:(UIColor *)textColor{
    for (int i = 0; i < self.titles.count + 1; i++) {
        UIButton *button = [self viewWithTag:200 + i];
        [button setTitleColor:textColor forState:(UIControlStateNormal)];
    }
}

- (void)setCancleTextColor:(UIColor *)cancleTextColor{
    UIButton *button = [self viewWithTag:200 + self.titles.count];
    [button setTitleColor:cancleTextColor forState:(UIControlStateNormal)];
}


- (void)setupUI{
    self.frame = [UIScreen mainScreen].bounds;
    
    UIView *tapView = [[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:tapView];
    tapView.backgroundColor = UIColorRGBA(0x000000, 0.3);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [tapView addGestureRecognizer:tap];
}

- (void)tapAction{
    [self removeFromSuperview];
}

- (void)buttonAction:(UIButton *)btn{
    [self removeFromSuperview];
    if (self.actionDidClickBlock) {
        self.actionDidClickBlock(btn.tag - 200);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
