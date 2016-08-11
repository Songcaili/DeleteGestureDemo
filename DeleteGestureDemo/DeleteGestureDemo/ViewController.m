//
//  ViewController.m
//  DeleteGestureDemo
//
//  Created by 宋一听 on 16/8/11.
//  Copyright © 2016年 宋一听. All rights reserved.
//

#import "ViewController.h"
#import "xGestureRecognizer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    xGestureRecognizer *gesture = [[xGestureRecognizer alloc] initWithTarget:self action:@selector(xGestureIsRecognized)];
    
    [self.view addGestureRecognizer:gesture];
}

- (void)xGestureIsRecognized {
    self.view.backgroundColor = [self randomColor];
}

- (UIColor *)randomColor {
    CGFloat r = (arc4random()%256)/255.0;
    CGFloat g = (arc4random()%256)/255.0;
    CGFloat b = (arc4random()%256)/255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
