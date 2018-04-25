//
//  dayTravelRangeView.m
//  travelRange
//
//  Created by 何泽的mac on 2018/4/4.
//  Copyright © 2018年 何泽的mac. All rights reserved.
//

#import "dayTravelRangeView.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation dayTravelRangeView
{
    NSArray * _redArray;
    NSArray * _blueArray;
    NSArray * _greenArray;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //宽等于 一天等于1440分钟 / (宽度)
    //首先灰色是静止，那么给他一天都静止
    //绿色40-90
    //蓝色小于40
    //红色大于90
    //线条颜色
    
    ///假定数据数组
    //超过90的 红
    NSArray * redArray = _redArray;
    //小于40的 蓝
    NSArray * blueArray = _blueArray;
    
    //40 - 90的 绿
    NSArray * greenArray = _greenArray;
 
    float pointWidth = 1440.0 / (kScreenWidth - 63 - 20);
///画超过90的线
    for (int i = 0; i < redArray.count; i ++) {
        NSArray * arr = redArray[i];
        UIColor *color = [UIColor colorWithRed:254/255.0 green:40/255.0 blue:69/255.0 alpha:1];
        [color set];
        //创建path
        float X1= [arr[0] floatValue] /pointWidth ;
        float X2= [arr[1] floatValue] /pointWidth;
        UIBezierPath* path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(X1, self.bounds.size.height/2)];
        [path addLineToPoint:CGPointMake(X2, self.bounds.size.height/2)];
        path.lineWidth = self.bounds.size.height;
        [path stroke];
    }
    
//画小于40的线
    for (int i = 0; i < blueArray.count; i++) {
        NSArray * arr = blueArray[i];
        UIColor *color = [UIColor colorWithRed:0/255.0 green:149/255.0 blue:239/255.0 alpha:1];
        [color set];
        //创建path
        float X1= [arr[0] floatValue] /pointWidth ;
        float X2= [arr[1] floatValue] /pointWidth;
        UIBezierPath* path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(X1, self.bounds.size.height/2)];
        [path addLineToPoint:CGPointMake(X2, self.bounds.size.height/2)];
        path.lineWidth = self.bounds.size.height;
        [path stroke];
    }
//画40-90的线
    for (int i = 0; i < greenArray.count; i++) {
        NSArray * arr = greenArray[i];
        UIColor *color = [UIColor colorWithRed:0/255.0 green:210/255.0 blue:122/255.0 alpha:1];
        [color set];
        //创建path
        float X1= [arr[0] floatValue] /pointWidth ;
        float X2= [arr[1] floatValue] /pointWidth;
        UIBezierPath* path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(X1, self.bounds.size.height/2)];
        [path addLineToPoint:CGPointMake(X2, self.bounds.size.height/2)];
        path.lineWidth = self.bounds.size.height;
        [path stroke];
    }

}
*/
-(void)setModel:(dayTravelRangeModel *)model{
    
    _redArray = model.redArray;
    _blueArray = model.blueArray;
    _greenArray = model.greenArray;
    
//    [self setNeedsDisplay];

    ///CAShapeLayer实现方法
    [self load_CAShapeLayer];
    
}

-(void)load_CAShapeLayer{
    float pointWidth = 1440.0 / (kScreenWidth - 63 - 20);
    for (int i = 0; i < _redArray.count; i ++) {
        NSArray * arr = _redArray[i];
        UIColor *color = [UIColor colorWithRed:254/255.0 green:40/255.0 blue:69/255.0 alpha:1];
        //创建path
        float X1= [arr[0] floatValue] /pointWidth;
        float X2= [arr[1] floatValue] /pointWidth;
        [self createShapeLayer:color startPoint:X1 addLineTo_Point:X2];
        
    }
    
    for (int i = 0; i < _blueArray.count; i++) {
        NSArray * arr = _blueArray[i];
        UIColor *color = [UIColor colorWithRed:0/255.0 green:149/255.0 blue:239/255.0 alpha:1];
        //创建path
        float X1= [arr[0] floatValue] /pointWidth;
        float X2= [arr[1] floatValue] /pointWidth;
        [self createShapeLayer:color startPoint:X1 addLineTo_Point:X2];
    }
    
    for (int i = 0; i < _greenArray.count; i++) {
        NSArray * arr = _greenArray[i];
        UIColor *color = [UIColor colorWithRed:0/255.0 green:210/255.0 blue:122/255.0 alpha:1];
        //创建path
        float X1= [arr[0] floatValue] /pointWidth;
        float X2= [arr[1] floatValue] /pointWidth;
        [self createShapeLayer:color startPoint:X1 addLineTo_Point:X2];
    }
}


- (UIBezierPath *)startPoint:(CGFloat)startPoint_X addLineTo_Point:(CGFloat)linePoint_X
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = self.bounds.size.height;
    [path moveToPoint:CGPointMake(startPoint_X, self.bounds.size.height/2)];
    [path addLineToPoint:CGPointMake(linePoint_X, self.bounds.size.height/2)];
    return path;
}

- (CAShapeLayer *)createShapeLayer:(UIColor *)color startPoint:(CGFloat)startPoint_X addLineTo_Point:(CGFloat)linePoint_X
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = self.bounds.size.height;
    [path moveToPoint:CGPointMake(startPoint_X, self.bounds.size.height/2)];
    [path addLineToPoint:CGPointMake(linePoint_X, self.bounds.size.height/2)];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 1;
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.repeatCount = 1;
    
    CAShapeLayer *layer = [CAShapeLayer layer];
//    layer.frame = CGRectMake(0, 0, 50, 50);
    //设置背景色
//        layer.backgroundColor = [UIColor cyanColor].CGColor;
    //设置描边色
    layer.path = path.CGPath;
    layer.strokeColor = color.CGColor;
    //设置填充色
    layer.lineWidth = self.bounds.size.height;
    layer.fillColor = color.CGColor;
    [layer addAnimation:animation forKey:@"strokeEndAnimation"];
    
    [self.layer addSublayer:layer];
    
    return layer;
}

@end
