//
//  LatestNewsViewController.h
//  PTLiveNew
//
//  Created by Saravanakumar on 15/06/17.
//  Copyright © 2017 NuaTransMedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LatestNewsViewController : UIViewController
{
    NSDictionary *tempDictLatestNews;
    NSMutableArray *muarrLatestNews;
}
@property (weak, nonatomic) IBOutlet UITableView *LatestView;

@end
