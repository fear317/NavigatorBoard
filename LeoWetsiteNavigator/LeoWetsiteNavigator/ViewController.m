//
//  ViewController.m
//  LeoWetsiteNavigator
//
//  Created by 张燎原 on 15/5/11.
//  Copyright (c) 2015年 张燎原. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView *wp = [self createWebsitePanelForView];
    
    [self.view addSubview:wp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)createWebsitePanelForView
{
    CGRect frame = CGRectMake(10, 10, self.view.frame.size.width - 20, 100);
    LeoWebsitePanel *wp = [[LeoWebsitePanel alloc] initWithFrame:frame];
    wp.delegate = self;
    [wp.layer setBorderColor:[UIColor redColor].CGColor];
    [wp.layer setBorderWidth:1.0];
    NSMutableArray *webSiteArr = [[NSMutableArray alloc] initWithCapacity:5];
    for (int i=0; i<100; i++) {
        [webSiteArr addObject:[NSString stringWithFormat:@"网易%d",i]];
    }
    [wp initWebsitePanelWith:webSiteArr];
    return wp;
}

- (void)websitePanelState:(BOOL)opened
{
    if (opened) {
        NSLog(@"Board is Opened");
    }else {
        NSLog(@"Board is Closed");
    }
}

- (void)didTappedCellForRowAtIndex:(NSInteger)cellIndex
{
    NSLog(@"cell index = %d", (int)cellIndex);
}

@end
