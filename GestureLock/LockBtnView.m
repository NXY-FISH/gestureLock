//
//  LockBtnView.m
//  lunbo
//
//  Created by 聂晓昀 on 2018/10/8.
//  Copyright © 2018年 HP. All rights reserved.
//

#import "LockBtnView.h"
#define screenW [UIScreen mainScreen].bounds.size.width
@interface LockBtnView()
/**
  存放选中的按钮
 */
@property (nonatomic,strong) NSMutableArray *selectBtnArray;
/**
  记录手指当前的点
 */
@property (nonatomic,assign) CGPoint currentPoint;
@end
@implementation LockBtnView
-(NSMutableArray *)selectBtnArray
{
    if (_selectBtnArray == nil) {
        _selectBtnArray = [NSMutableArray array];
    }
    return _selectBtnArray;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
        //如果不设置背景颜色,绘制过程会出现错乱, 为什么?
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)createSubViews
{
    for (int i = 0; i < 9; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.userInteractionEnabled = NO;
        btn.tag = i;
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        [self addSubview:btn];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    int column = 3;
    CGFloat btnW = 74;
    CGFloat space = (screenW - column * btnW) / (column + 1);
    for (int i = 0; i < 9; i ++) {
        int rowNumber = i / column;
        int columnNumber = i % column;
        UIButton *btn = (UIButton *)[self.subviews objectAtIndex:i];
        CGFloat x = space + (btnW + space) * columnNumber;
        CGFloat y = space + (btnW + space) * rowNumber;
        btn.frame = CGRectMake(x, y, btnW, btnW);
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //获取手指当前的点
    CGPoint currentP = [self getCurrentPointWith:touches];
    //判断点在不在按钮上
    UIButton *btn = [self btnRectContainPoint:currentP];
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        [self.selectBtnArray addObject:btn];
    }
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //获取手指当前的点
    CGPoint currentP = [self getCurrentPointWith:touches];
    self.currentPoint = currentP;
    //判断点在不在按钮上
    UIButton *btn = [self btnRectContainPoint:currentP];
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        [self.selectBtnArray addObject:btn];
    }
    //重绘
    [self setNeedsDisplay];
}
//手指离开
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSMutableString *string = [NSMutableString string];
    //取消所有选中按钮
    for (UIButton *btn in self.selectBtnArray) {
        btn.selected = NO;
        [string appendFormat:@"%ld",btn.tag];
    }
    NSLog(@"%@",string);
    //清空所有连线
    [self.selectBtnArray removeAllObjects];
    //重绘
    [self setNeedsDisplay];
}
-(void)drawRect:(CGRect)rect
{
    if (self.selectBtnArray.count) {
        //描述路径
        UIBezierPath *path = [UIBezierPath bezierPath];
        //取出所有选中的按钮
        for (int i = 0; i < self.selectBtnArray.count; i++) {
            UIButton *btn = [self.selectBtnArray objectAtIndex:i];
            if (i == 0) {
                //如果是第一个按钮, 让他的中心成为起点
                [path moveToPoint:btn.center];
            }else{
                [path addLineToPoint:btn.center];
            }
        }
        //添加一根线到当前手指
        [path addLineToPoint:self.currentPoint];
        //设置线的状态
        [path setLineWidth:10];
        [[UIColor redColor] set];
        [path setLineJoinStyle:kCGLineJoinRound];
        [path stroke];
    }
}
//获取手指当前的点
-(CGPoint)getCurrentPointWith:(NSSet<UITouch *> *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    return currentPoint;
}
//判断点在不在按钮上
-(UIButton *)btnRectContainPoint:(CGPoint)point
{
    for (UIButton *btn  in self.subviews) {
        //点在按钮身上
        if (CGRectContainsPoint(btn.frame, point)) {
            return btn;
        }
    }
    return nil;
}
@end
