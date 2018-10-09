//
//  ViewController.m
//  GestureLock
//
//  Created by 聂晓昀 on 2018/10/9.
//  Copyright © 2018年 HP. All rights reserved.
//

#import "ViewController.h"
#import "GestureUnlockView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GestureUnlockView *lockView = [[GestureUnlockView alloc] init];
    lockView.frame = self.view.bounds;
    [self.view addSubview:lockView];
}


@end
