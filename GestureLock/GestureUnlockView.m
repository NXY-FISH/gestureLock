//
//  GestureUnlock.m
//  lunbo
//
//  Created by 聂晓昀 on 2018/10/8.
//  Copyright © 2018年 HP. All rights reserved.
//

#import "GestureUnlockView.h"
#import "LockBtnView.h"
@interface GestureUnlockView()
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) LockBtnView *lockBtnView;
@end
@implementation GestureUnlockView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createSubviews];
    }
    return self;
}
-(void)createSubviews
{
    self.backImageView = [[UIImageView alloc] init];
    self.backImageView.image = [UIImage imageNamed:@"Home_refresh_bg"];
    [self addSubview:self.backImageView];
    
    self.lockBtnView = [[LockBtnView alloc] init];
    [self addSubview:self.lockBtnView];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.backImageView.frame = self.bounds;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat y = ([UIScreen mainScreen].bounds.size.height - [UIScreen mainScreen].bounds.size.width) / 2.0;
    self.lockBtnView.frame = CGRectMake(0, y, width, width);
}
@end
