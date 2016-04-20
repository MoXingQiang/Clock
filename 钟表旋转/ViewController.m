//
//  ViewController.m
//  钟表旋转
//
//  Created by MXQ on 16/4/19.
//  Copyright © 2016年 MXQ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    CALayer *secondLayer;
    CALayer *minuteLayer;
    CALayer *hourLayer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addClock];
    
    [self clockStartRun];
}


//添加钟表

-(void)addClock{
    
    //背景图
    UIImageView *imgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Image"]];
    imgv.frame = CGRectMake(0, 0, 400, 400);
    imgv.center = self.view.center;
    [self.view addSubview:imgv];
    
    //添加秒针
    CALayer *second = [CALayer layer];
    second.backgroundColor = [[UIColor orangeColor] CGColor];
    second.frame = CGRectMake(0, 0, 6, 200);
    second.position = self.view.center;
    second.anchorPoint = CGPointMake(0.5, 1);
    
    //添加分针
    CALayer *minute = [CALayer layer];
    minute.backgroundColor = [[UIColor yellowColor] CGColor];
    minute.frame = CGRectMake(0, 0, 10, 180);
    minute.position = self.view.center;
    minute.anchorPoint = CGPointMake(0.5, 1);
    
    //添加时针
    CALayer *hour = [CALayer layer];
    hour.backgroundColor = [[UIColor blackColor] CGColor];
    hour.frame = CGRectMake(0, 0, 16, 160);
    hour.position = self.view.center;
    hour.anchorPoint = CGPointMake(0.5, 1);
    
    secondLayer = second;
    minuteLayer = minute;
    hourLayer = hour;
    
    [self.view.layer addSublayer:second];
    [self.view.layer addSublayer:minute];
    [self.view.layer addSublayer:hour];
    
}

-(void)clockStartRun{
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runStart) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

-(void)runStart{
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents * cmp =[cal components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    
    NSInteger currentSecond = cmp.second;//一秒==6度
    NSInteger currentMinute = cmp.minute;//一分钟==6度
    NSInteger currentHour = cmp.hour;//一时==30度

    NSInteger secondDegress = currentSecond * 6;
    NSInteger minuteDegress = currentMinute * 6;
    NSInteger hourDress = currentHour * 30 + currentMinute/60*30;//由分针带动
    
    //角度转为弧度
    CGFloat secondArc = secondDegress*M_PI/180;
    CGFloat minuteArc = minuteDegress*M_PI/180;
    CGFloat hourArc = hourDress*M_PI/180;
    
    NSLog(@"----%f,%f",hourDress/180*M_PI,hourArc);
    
    //计算需要转过的角度
    secondLayer.transform = CATransform3DMakeRotation(secondArc, 0, 0, 1);
    minuteLayer.transform = CATransform3DMakeRotation(minuteArc, 0, 0, 1);
    hourLayer.transform = CATransform3DMakeRotation(hourArc, 0, 0, 1);
    
}
@end
