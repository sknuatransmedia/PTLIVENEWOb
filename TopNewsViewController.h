//
//  TopNewsViewController.h
//  PTLiveNew
//
//  Created by Saravanakumar on 15/06/17.
//  Copyright © 2017 NuaTransMedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopNewsViewController : UIViewController
{
    NSDictionary *tempDict;
    NSMutableArray *muarrTopNews;
}
@property (weak, nonatomic) IBOutlet UIView *viwNewsContainer;
@property (weak, nonatomic) IBOutlet UIView *viwHeaderPlayer;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end
