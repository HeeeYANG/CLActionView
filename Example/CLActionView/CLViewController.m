//
//  CLViewController.m
//  CLActionView
//
//  Created by zcy1226@hotmail.com on 08/12/2020.
//  Copyright (c) 2020 zcy1226@hotmail.com. All rights reserved.
//

#import "CLViewController.h"
#import <CLActionView.h>


@interface CLViewController ()

@end

@implementation CLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}
- (IBAction)showActionView:(id)sender {
    CLActionView *actionView = [[CLActionView alloc]initWithTitles:@[@"高德地图",@"百度地图",@"腾讯地图"]];
    actionView.actionDidClickBlock = ^(NSInteger index) {
        NSLog(@"点击了第%d个",(int)index);
    };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
