//
//  ColorsContainerView.h
//  SM-PhotoColor
//
//  Created by Huq Majharul on 1/9/16.
//  Copyright © 2016 Huq Majharul. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define  VIEW_BACKGROUND_COLOR       UIColorFromRGB(0x333333)

#define COLORSIZE_HEIGHT    76.0f

@protocol ColorsContainerViewDelegate <NSObject>
- (void)updateColorValue:(NSMutableArray*)colors;
@end

@interface ColorsContainerView : UIView
{
    IBOutlet    UIView          *viewColors;
    IBOutlet    UIScrollView    *scrollViewColors;
    
    NSMutableArray              *arrColors;
}

@property (nonatomic, assign) BOOL isVisible;
@property (nonatomic, retain) id<ColorsContainerViewDelegate> delegate;

- (void)setup;

- (void)showMenu;
- (void)hideMenu;

@end
