//
//  ViewController.m
//  SM-PhotoColor
//
//  Created by Huq Majharul on 1/9/16.
//  Copyright © 2016 Huq Majharul. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<ColorsContainerViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor   = VIEW_BACKGROUND_COLOR;
    
    // Color Bar Initialize
    colorsContainerView       = [[ColorsContainerView alloc] init];
    colorsContainerView.frame = CGRectMake(0, CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame), COLORSIZE_HEIGHT);
    colorsContainerView.delegate = self;
    [self.view addSubview:colorsContainerView];
    [colorsContainerView setup];
    colorsContainerView.isVisible = NO;
    
    
    // Single Click On ImageView
    UITapGestureRecognizer *singleTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTapOnView:)];
    singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:singleTap];
}

-(void)handleSingleTapOnView:(UIGestureRecognizer*)gestureView
{
    NSLog(@"handleSingleTapOnView");
    
    if (colorsContainerView.isVisible) {
        [colorsContainerView hideMenu];
    }
}

- (IBAction)actionColorView:(id)sender
{
    [colorsContainerView showMenu];
}

#pragma mark Image Color Change
- (UIImage*)changeColor:(UIImage*)image withColor:(NSMutableArray*)rgb
{
    CGRect          imageRect   = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:imageRect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context,
                             [[rgb objectAtIndex:0] floatValue],
                             [[rgb objectAtIndex:1] floatValue],
                             [[rgb objectAtIndex:2] floatValue],
                             0.2);
    CGContextFillRect(context,imageRect);
    CGContextSaveGState(context);
    
    return UIGraphicsGetImageFromCurrentImageContext();
}

#pragma mark ColorsContainerViewDelegate
- (void)updateColorValue:(NSMutableArray*)colors
{
    imageViewPhoto.image = [UIImage imageNamed:@"test-background.png"];
    imageViewPhoto.image = [self changeColor:imageViewPhoto.image withColor:colors];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
