//
//  ColorsContainerView.m
//  SM-PhotoColor
//
//  Created by Huq Majharul on 1/9/16.
//  Copyright © 2016 Huq Majharul. All rights reserved.
//

#import "ColorsContainerView.h"
#import "UIColor+Expanded.h"

#define COLOR_WIDTH     28.0f
#define COLOR_HEIGHT    28.0f
#define TOTAL_ROW       2

@implementation ColorsContainerView

-(instancetype)init{
    if (self = [super init]) {
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"ColorsContainerView" owner:self options:nil];
        self = [subviewArray objectAtIndex:0];
    }
    return self;
}

- (void)setup
{
    scrollViewColors.backgroundColor    = [UIColor clearColor];
    
    viewColors.backgroundColor          = VIEW_BACKGROUND_COLOR;

    
    NSUInteger  colorsCount = 0;
    arrColors   = [[NSMutableArray alloc] init];
    
    // Color Buttons
    NSString    *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"colorset"];
    NSError     *error;
    NSArray     *directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error];
    for (NSString *fileName in directoryContents) {
        [arrColors addObject:fileName];
    }
    
    colorsCount = arrColors.count;
    
    float   GAP     = (CGRectGetHeight(scrollViewColors.frame) - COLOR_HEIGHT * TOTAL_ROW) / (TOTAL_ROW + 1);
    float   posX    = GAP;
    float   posY    = GAP;
    int     index   = 0;
    for (NSString *color in arrColors) {
        UIButton    *button     = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame            = CGRectMake(posX, posY, COLOR_WIDTH, COLOR_HEIGHT);
        BOOL            isColor = index < colorsCount;
        NSString        *path   = isColor ? [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"colorset"] :
                                            [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"imageset"];
        [button setImage:[UIImage imageWithContentsOfFile:[path stringByAppendingPathComponent:color]] forState:UIControlStateNormal];
        [button.layer setCornerRadius:COLOR_WIDTH / 2];
        button.layer.masksToBounds = YES;
        button.tag  = index + 1;
        
        [button addTarget:self action:@selector(actionColorValue:) forControlEvents:UIControlEventTouchUpInside];
        [scrollViewColors addSubview:button];
        posX += COLOR_WIDTH + GAP;
        index ++;
        if (index % ((arrColors.count / 2) + 1) == 0) {
            posX = COLOR_WIDTH - GAP / 2;
            posY += COLOR_HEIGHT + GAP;
        }
    }
    
    scrollViewColors.contentSize    = CGSizeMake((COLOR_WIDTH + GAP) * (arrColors.count / 2 + 1) + GAP,CGRectGetHeight(scrollViewColors.frame));
}

- (IBAction)actionCloseMe:(id)sender
{
    [self hideMenu];
}

- (void)hideMenu
{
    CGRect  rect     = self.frame;
    rect.origin.y    += rect.size.height;
    
    [UIView animateWithDuration:0.5
                          delay:0.2
         usingSpringWithDamping:0.6
          initialSpringVelocity:1.0
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                            animations:^{
                         self.frame                    = rect;
                     } completion:^(BOOL finished) {
                         self.isVisible = NO;
                     }];
}
- (void)showMenu
{
    CGRect  rect       = self.frame;
    rect.origin.y      -= rect.size.height;
    
    [UIView animateWithDuration:0.8
                          delay:0.0
         usingSpringWithDamping:0.5
          initialSpringVelocity:2.0
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.frame          = rect;
                     } completion:^(BOOL finished) {
                         self.isVisible = YES;
                     }];
}

- (void)actionColorValue:(id)sender
{
    [self actionCloseMe:sender];
    UIButton    *button     = (UIButton*)sender;
    
    NSString        *colorStr   = [[arrColors objectAtIndex:button.tag-1] stringByDeletingPathExtension];
    NSMutableArray  *colors     = [UIColor colorWithHex:colorStr];

    if ([self.delegate respondsToSelector:@selector(updateColorValue:)])
        [self.delegate updateColorValue:colors];
}

@end

