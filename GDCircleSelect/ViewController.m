//
//  ViewController.m
//  GDCircleSelect
//
//  Created by xiaoyu on 15/12/16.
//  Copyright © 2015年 guoda. All rights reserved.
//

#import "ViewController.h"
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define WARN_WIDTH 250


#define SNOW_IMAGENAME         @"unlike"
#define IMAGE_X                arc4random()%(int)SCREEN_WIDTH
#define IMAGE_ALPHA            ((float)(arc4random()%10))/10
#define IMAGE_WIDTH            arc4random()%20 + 10
#define PLUS_HEIGHT            SCREEN_HEIGHT/25

#define IMAGENAMED(NAME)        [UIImage imageNamed:NAME]
@interface ViewController ()
{
    UIView *bgview;
    NSMutableArray *_imagesArray;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    [self coreLayer1];
    
//    [self coreLayer2];
    [self coreLayer3];
}
- (void)coreLayer3 {

//    CGMutablePathRef aPath = CGPathCreateMutable();
//    CGPathMoveToPoint(aPath, nil, 45, 95);
//    
//    CGPathAddCurveToPoint(aPath, nil, 80, 60, SCREEN_WIDTH/2, 0, SCREEN_WIDTH - 80, 80);
    UIBezierPath *aPath;
//    CGFloat radius = 100;
//    CGPoint arcCenter = CGPointMake(radius, radius);
    
    //弧
    
//    aPath = [UIBezierPath bezierPathWithArcCenter:arcCenter
//                                                    radius:radius
//                                                startAngle:0 endAngle:M_PI/2*4 clockwise:YES];
    bgview = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-WARN_WIDTH)/2, 100, WARN_WIDTH, WARN_WIDTH)];
//    bgview.backgroundColor = [UIColor grayColor];
    [self.view addSubview:bgview];
    
    aPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, WARN_WIDTH, WARN_WIDTH) cornerRadius:WARN_WIDTH/2];

    [aPath moveToPoint:CGPointMake(WARN_WIDTH/4, WARN_WIDTH/5)];
    [aPath addLineToPoint:CGPointMake(WARN_WIDTH/4*3, WARN_WIDTH/5)];
    
    [aPath moveToPoint:CGPointMake(WARN_WIDTH/4, WARN_WIDTH/3)];
    [aPath addLineToPoint:CGPointMake(WARN_WIDTH/4, WARN_WIDTH/3*2)];
    
    [aPath moveToPoint:CGPointMake(WARN_WIDTH/4, WARN_WIDTH/3)];
    [aPath addLineToPoint:CGPointMake(WARN_WIDTH/4*3, WARN_WIDTH/3)];
    
    [aPath moveToPoint:CGPointMake(WARN_WIDTH/4*3, WARN_WIDTH/3)];
    [aPath addLineToPoint:CGPointMake(WARN_WIDTH/4*3, WARN_WIDTH/3*2)];
    //勾
    [aPath moveToPoint:CGPointMake(WARN_WIDTH/4*3, WARN_WIDTH/3*2)];
    [aPath addLineToPoint:CGPointMake(WARN_WIDTH/4*3-15, WARN_WIDTH/3*2-15)];

    //中间竖
    [aPath moveToPoint:CGPointMake(WARN_WIDTH/2, WARN_WIDTH/5)];
    [aPath addLineToPoint:CGPointMake(WARN_WIDTH/2, WARN_WIDTH/3*2)];
    
    //左点
    [aPath moveToPoint:CGPointMake(WARN_WIDTH/3, WARN_WIDTH/2-20)];
    [aPath addLineToPoint:CGPointMake(WARN_WIDTH/3+20, WARN_WIDTH/2)];

    [aPath moveToPoint:CGPointMake(WARN_WIDTH/3, WARN_WIDTH/2)];
    [aPath addLineToPoint:CGPointMake(WARN_WIDTH/3+20, WARN_WIDTH/2+20)];
    
    //右点
    [aPath moveToPoint:CGPointMake(WARN_WIDTH/3*2-20, WARN_WIDTH/2-20)];
    [aPath addLineToPoint:CGPointMake(WARN_WIDTH/3*2, WARN_WIDTH/2)];
    
    [aPath moveToPoint:CGPointMake(WARN_WIDTH/3*2-20, WARN_WIDTH/2)];
    [aPath addLineToPoint:CGPointMake(WARN_WIDTH/3*2, WARN_WIDTH/2+20)];


    
    
    CAShapeLayer *lineLayer = [ CAShapeLayer layer];
//    lineLayer.cornerRadius = 5;
    lineLayer. fillColor = [ UIColor clearColor ]. CGColor ;
    lineLayer. path = aPath.CGPath;
    lineLayer. strokeColor = [UIColor colorWithRed:230/255.0 green:180/255.0 blue:1/255.0 alpha:1]. CGColor;
    lineLayer.lineWidth = 5;
    lineLayer.cornerRadius = 5;
    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector ( @selector (strokeEnd))];
    ani. fromValue = @0 ;
    ani. toValue = @1 ;
    ani. duration = 3 ;
    ani.repeatCount = 1;
    [lineLayer addAnimation :ani forKey : NSStringFromSelector ( @selector (strokeEnd))];
//    bgview.layer.mask = lineLayer;
    [bgview.layer addSublayer:lineLayer];
    
    //
    [self performSelector:@selector(animationDayu) withObject:nil afterDelay:3];
    [self performSelector:@selector(startDownSnow) withObject:nil afterDelay:3];

    
    
}
- (void)animationDayu {

    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 1;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.f, 1.f, 0.9f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    
    
    
//    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:
                                      kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [bgview.layer addAnimation:popAnimation forKey:nil];

}
#pragma mark - 下雪
- (void)startDownSnow {
    _imagesArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 20; ++ i) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:IMAGENAMED(SNOW_IMAGENAME)];
        float x = IMAGE_WIDTH;
        imageView.frame = CGRectMake(IMAGE_X, -30, x, x);
        imageView.alpha = IMAGE_ALPHA;
        [self.view addSubview:imageView];
        [_imagesArray addObject:imageView];
    }
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(makeSnow) userInfo:nil repeats:YES];
    
}
static int i = 0;
- (void)makeSnow
{
    i = i + 1;
    if ([_imagesArray count] > 0) {
        UIImageView *imageView = [_imagesArray objectAtIndex:0];
        imageView.tag = i;
        [_imagesArray removeObjectAtIndex:0];
        //        NSLog(@"%lu",_imagesArray.count);
        [self snowFall:imageView];
    }
    
}

- (void)snowFall:(UIImageView *)aImageView
{
    [UIView beginAnimations:[NSString stringWithFormat:@"%lu",aImageView.tag] context:nil];
    [UIView setAnimationDuration:6];
    [UIView setAnimationDelegate:self];
    aImageView.frame = CGRectMake(aImageView.frame.origin.x, SCREEN_HEIGHT, aImageView.frame.size.width, aImageView.frame.size.height);
    //    NSLog(@"%@",aImageView);
    [UIView commitAnimations];
}

- (void)addImage
{
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:[animationID intValue]];
    float x = IMAGE_WIDTH;
    imageView.frame = CGRectMake(IMAGE_X, -30, x, x);
    [_imagesArray addObject:imageView];
}



- (void)coreLayer2 {
    
    UIBezierPath *pacmanOpenPath;
    
    CGFloat radius = 40;
    CGPoint arcCenter = CGPointMake(radius, radius);
    
    //弧
    
    pacmanOpenPath = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                    radius:radius
                                                startAngle:0 endAngle:M_PI/2*4 clockwise:YES];
    
    NSMutableArray *colors = nil;
    
    if (colors == nil) {
        colors = [[NSMutableArray alloc] initWithCapacity:3];
        UIColor *color = nil;
        color = [UIColor blueColor];
        [colors addObject:(id)[color CGColor]];
        color = [UIColor redColor];
        [colors addObject:(id)[color CGColor]];
        color = [UIColor yellowColor];
        [colors addObject:(id)[color CGColor]];

    }
    //CAGradientLayer 通过指定颜色，一个开始的点，一个结束的点和梯度类型使你能够简单的在层上绘制一个梯度，效果就是颜色渐变
#if 1
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    //在指定的color中绘制渐变层

    [gradientLayer setColors:colors];
    gradientLayer.frame = CGRectMake(20, 20, 100, 100);
    
    //在 (20, 20, 100, 100) 位置绘制一个颜色渐变的层

    [self.view.layer addSublayer:gradientLayer];
#endif
    
    //CAShapeLayer 通过创建一个核心图像路径，并且分配给CAShaperLayer的path属性，从而为需要的形状指定路径。 可以指定填充路径之外的颜色，路径内的颜色，绘制路径，线宽，是否圆角等等
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.fillMode = kCAFillRuleEvenOdd;
    shapeLayer.path = pacmanOpenPath.CGPath;
    shapeLayer.strokeColor = [UIColor yellowColor].CGColor;
    shapeLayer.lineWidth = 10;
    shapeLayer.lineJoin = kCALineJoinRound;
    //当你使用时，奇数的值被绘制，然后偶数的值不被绘制。例如，如果你指定5，10，15，20，笔画将会有5个单元被绘制，接下来10不被绘制，15被绘制，20不被绘制。这种模式可以使用你喜欢的间隙来指定。请记住：奇数等于绘制而偶数不绘制。这些单元是被放在了一个放置NSNumber对象的NSArray的数组中，如果你在NSSArray中放置其他东西，会带来一些异常的效果。
//    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:20],[NSNumber numberWithInt:15],nil]];
    
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.frame = CGRectMake(10, 10, 80, 80);
    
    gradientLayer.mask = shapeLayer;
    
    CABasicAnimation *spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    spinAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    spinAnimation.fromValue = [NSNumber numberWithInt:0];
    spinAnimation.toValue = [NSNumber numberWithInt:2*M_PI];
    spinAnimation.duration = 2;
    spinAnimation.repeatCount = MAXFLOAT;
    
    [gradientLayer addAnimation:spinAnimation forKey:@"GradientRotateAnimation"];
//    [shapeLayer addAnimation:spinAnimation forKey:nil];
//    [self.view.layer addSublayer:shapeLayer];
    
    
}
- (void)coreLayer1{

#if 1
    
    UIButton * button = [[UIButton alloc] init];
    [button setFrame:CGRectMake(100, 100, 200, 200)];
    [button setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
    
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(100, 100)];
    [path addLineToPoint:CGPointMake(50, 150)];
    [path addLineToPoint:CGPointMake(150, 150)];
    [path addLineToPoint:CGPointMake(200, 100)];
    [path addLineToPoint:CGPointMake(100, 100)];
    
    CAShapeLayer *lineLayer = [ CAShapeLayer layer];
    
    lineLayer. frame = CGRectZero;
    
    lineLayer. fillColor = [ UIColor clearColor ]. CGColor ;
    
    lineLayer. path = path. CGPath ;
    
    lineLayer. strokeColor = [UIColor colorWithRed:230/255.0 green:180/255.0 blue:1/255.0 alpha:1]. CGColor;
    
    lineLayer.lineWidth = 5;
    
    lineLayer.cornerRadius = 5;
    //    lineLayer.repeatCount = 100;
//    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector ( @selector (strokeEnd))];
//    
//    ani. fromValue = @0 ;
//    
//    ani. toValue = @1 ;
//    
//    ani. duration = 2 ;
//    
//    ani.repeatCount = 100;
//    
//    [lineLayer addAnimation :ani forKey : NSStringFromSelector ( @selector (strokeEnd))];
    
    button.layer.mask = lineLayer;
//    [button.layer addSublayer:lineLayer];
#endif
    
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
}


- (void)btn {
    NSLog(@"123123");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
