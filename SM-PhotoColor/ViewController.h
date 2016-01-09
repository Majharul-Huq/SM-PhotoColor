//
//  ViewController.h
//  SM-PhotoColor
//
//  Created by Huq Majharul on 1/9/16.
//  Copyright © 2016 Huq Majharul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorsContainerView.h"

@interface ViewController : UIViewController
{
    IBOutlet    UIImageView     *imageViewPhoto;
    IBOutlet    UIToolbar       *toolbarBottom;
    ColorsContainerView         *colorsContainerView;
}

- (IBAction)actionColorView:(id)sender;

@end

