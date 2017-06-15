//
//  MenuViewController.m
//  PTLiveNew
//
//  Created by Saravanakumar on 15/06/17.
//  Copyright © 2017 NuaTransMedia. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
arry_menu = @[@"Home",@"Live TV",
              @"LatestNews",@"TamilNadu",@"India",@"International",@"Sports",@"Cinema",@"Technology",@"Programmes",@"Live Audio",@"Settings",@"About us",@"Feedback",@"Share This App",@"Rate This App"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // If you're serving data from an array, return the length of the array:
    return [arry_menu count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImageView *imgmenu = (UIImageView *)[cell viewWithTag:1];
    UILabel *lblmenu = (UILabel *)[cell viewWithTag:2];
    
    
    imgmenu.image = [UIImage imageNamed:[arry_menu objectAtIndex:indexPath.row]];

    
    lblmenu.text = [NSString stringWithFormat:@"%@",[arry_menu objectAtIndex:indexPath.row]];
    
    
    
    return cell;
}





@end
