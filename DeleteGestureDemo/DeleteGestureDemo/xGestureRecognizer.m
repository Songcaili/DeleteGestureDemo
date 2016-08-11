//
//  xGestureRecognizer.m
//  DeleteGestureDemo
//
//  Created by 宋一听 on 16/8/11.
//  Copyright © 2016年 宋一听. All rights reserved.
//

#import "xGestureRecognizer.h"

typedef CGPoint Vector;

@interface xGestureRecognizer ()

@property(nonatomic,assign) BOOL upStroke;
@property(nonatomic,assign) BOOL downStroke;
@property(nonatomic,assign) CGPoint upPoint; //上折点
@property(nonatomic,assign) CGPoint downPoint; //下折点
@property(nonatomic,assign) CGPoint beginPoint;
@property(nonatomic,assign) CGPoint endPoint;

@end

@implementation xGestureRecognizer

- (void)reset {
    [super reset];
    _upStroke = NO;
    _downStroke = NO;
    _beginPoint = CGPointZero;
    _endPoint = CGPointZero;
    _downPoint = CGPointZero;
    _upPoint = CGPointZero;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if ([touches count] != 1) {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
    
    _beginPoint = [touches.anyObject locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    if (self.state == UIGestureRecognizerStateFailed) {
        return;
    }
    CGPoint nowPoint = [touches.anyObject locationInView:self.view];
    CGPoint prePoint = [touches.anyObject previousLocationInView:self.view];
    
    if (!_upStroke) {  //先识别上折
        if (nowPoint.x >= prePoint.x && nowPoint.y >= prePoint.y) {  //右下方向
            _upPoint = nowPoint;
        }else if (nowPoint.y < prePoint.y) {
            _upStroke = YES;
        }else {
            self.state = UIGestureRecognizerStateFailed;
        }
    }else if (!_downStroke){  //识别下折
        if (nowPoint.y < prePoint.y) {  //向上
            _downPoint = nowPoint;
        }else if (nowPoint.x < prePoint.x){  //左下
            _downStroke = YES;
        }else {
            self.state = UIGestureRecognizerStateFailed;
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    CGPoint nowPoint = [touches.anyObject locationInView:self.view];
    _endPoint = nowPoint;
    
    if (_upStroke && _downStroke) {
        BOOL isIntersect = [self isIntersect];
        if (isIntersect) {
            self.state = UIGestureRecognizerStateRecognized;
        }else {
            self.state = UIGestureRecognizerStateFailed;
        }
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    self.state = UIGestureRecognizerStateFailed;
}

#pragma mark - 判断是否相交
- (BOOL)isIntersect {
    CGPoint p1 = _beginPoint;
    CGPoint p2 = _upPoint;
    CGPoint p3 = _endPoint;
    CGPoint p4 = _downPoint;
    
    Vector p1p2 = CGPointMake(p2.x - p1.x, p2.y - p1.y);
    Vector p1p3 = CGPointMake(p3.x - p1.x, p3.y - p1.y);
    Vector p1P4 = CGPointMake(p4.x - p1.x, p4.y - p1.y);
    
    Vector p3p4 = CGPointMake(p4.x - p3.x, p4.y - p3.y);
    Vector p3p1 = CGPointMake(p1.x - p3.x, p1.y - p3.y);
    Vector p3p2 = CGPointMake(p2.x - p3.x, p2.y - p3.y);
    
    CGFloat d1 = [self vectorCross:p1p3 with:p1p2];
    CGFloat d2 = [self vectorCross:p1P4 with:p1p2];
    CGFloat d3 = [self vectorCross:p3p1 with:p3p4];
    CGFloat d4 = [self vectorCross:p3p2 with:p3p4];
    
    if (d1*d2 < 0 && d3*d4 < 0) {
        return YES;
    }else {
        return NO;
    }
}

//求向量叉积
- (CGFloat)vectorCross:(Vector)firstVector with:(Vector)secondVector {
    return firstVector.x*secondVector.y - secondVector.x*firstVector.y;
}

@end






















