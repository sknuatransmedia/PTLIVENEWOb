//
//  ViewController.h
//  PTLiveNew
//
//  Created by Saravanakumar on 15/06/17.
//  Copyright © 2017 NuaTransMedia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTSlidingPagesDataSource.h"
#import "TTSliddingPageDelegate.h"
@interface ViewController : UIViewController<TTSlidingPagesDataSource, TTSliddingPageDelegate>
{
    NSArray *viewPagerTitleName;
}
@property (weak, nonatomic) IBOutlet UIView *ViewPager;


@end

