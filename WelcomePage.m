//
//  WelcomePage.m
//  Cycling
//
//  Created by Rezaul Karim on 24/9/15.
//  Copyright (c) 2015 Rezaul Karim. All rights reserved.
//

#import "WelcomePage.h"
#import "rootViewController.h"

@interface WelcomePage (){
    UILabel *success, *percent;
    NSTimer *timer;
    int counter;
    
}

@property (weak, nonatomic) IBOutlet UIView *playerView;
@end

@implementation WelcomePage

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    counter = 0;
    success = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-20, self.view.frame.size.height/2-15, 40, 30)];
    success.font = [UIFont fontWithName:@"System" size:12.0];
    success.text = @"OK";
    success.textAlignment = NSTextAlignmentCenter;
    success.textColor = [UIColor greenColor];
    
    percent = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-20, self.view.frame.size.height/2-15, 40, 30)];
    percent.font = [UIFont fontWithName:@"System" size:12.0];
    percent.text = @"0%";
    percent.textAlignment = NSTextAlignmentCenter;
    percent.textColor = [UIColor greenColor];
    [self.view addSubview:percent];
    
    [self makeCircle:25 duration:4.0 stroke:[UIColor redColor]];
    [self makeCircle:50 duration:3.0 stroke:[UIColor blueColor]];
    [self makeCircle:75 duration:2.0 stroke:[UIColor yellowColor]];
    [self makeCircle:100 duration:1.0 stroke:[UIColor greenColor]];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.086
                                             target:self
                                           selector:@selector(progress)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User Defined Method -
-(CAShapeLayer*) makeCircle:(int)radius duration:(CGFloat)duration stroke:(UIColor*)color{
    
    CAShapeLayer *circle = [CAShapeLayer layer];
    // Make a circular shape
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                             cornerRadius:radius].CGPath;
    // Center the shape in self.view
    circle.position = CGPointMake(CGRectGetMidX(self.view.frame)-radius,
                                  CGRectGetMidY(self.view.frame)-radius);
    
    // Configure the apperence of the circle
    circle.fillColor = [UIColor clearColor].CGColor;
    circle.strokeColor = color.CGColor;
    circle.lineWidth = 1;
    // Add to parent layer
    [self.view.layer addSublayer:circle];
    
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.startPoint = CGPointMake(0.5,1.0);
    gradientLayer.endPoint = CGPointMake(0.5,0.0);
    gradientLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    NSMutableArray *colors = [NSMutableArray array];
    for (int i = 0; i < 14; i++) {
        [colors addObject:(id)[[UIColor colorWithHue:(0.1 * i) saturation:1 brightness:1 alpha:1] CGColor]];
    }
    gradientLayer.colors = colors;
    
    [gradientLayer setMask:circle];
    [self.view.layer addSublayer:gradientLayer];
    
    
    // Configure animation
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = duration; // "animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    // Add the animation to the circle
    [circle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
    
    return circle;
}

-(void)progress{
    counter += 2;
    percent.text = [NSString stringWithFormat:@"%d%@", counter,@"%"];
    if (counter == 100) {
        [timer invalidate];
        timer = nil;
        percent.hidden = YES;
        [self.view addSubview:success];
    }
//    if (timer == nil) {
//        [NSThread sleepForTimeInterval:3.0];
//        RootViewController *root = [self.storyboard instantiateViewControllerWithIdentifier:@"rootStoryBoard"];
//        [self presentViewController:root animated:NO completion:nil];
//    }
    if (timer == nil) {
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            rootViewController *root = [self.storyboard instantiateViewControllerWithIdentifier:@"rootViewController"];
            [self presentViewController:root animated:NO completion:nil];
        });
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
