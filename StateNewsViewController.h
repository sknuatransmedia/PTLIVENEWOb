//
//  StateNewsViewController.h
//  PTLiveNew
//
//  Created by Saravanakumar on 15/06/17.
//  Copyright © 2017 NuaTransMedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StateNewsViewController : UIViewController
{
    NSDictionary *tempDictStateNews;
    NSMutableArray *muarrStateNews;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end
