//
//  BAOneTableViewController.m
//  博爱微博
//
//  Created by 孙博岩 on 15/8/1.
//  Copyright © 2015年 boai. All rights reserved.
//

#import "BAOneTableViewController.h"
#import "UIBarButtonItem+Item.h"

@interface BAOneTableViewController ()

@end

@implementation BAOneTableViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
//    NSLog(@"%s", __func__);
    return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (IBAction)jumpToTwo:(id)sender
{
//    BATwoViewController *twoVC = [[BATwoViewController alloc] init];
//    [self.navigationController pushViewController:twoVC animated:YES];
}



//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//#pragma mark - Table view data source
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 3;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *ID = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    
//    if (!cell)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//        cell.backgroundColor = [UIColor clearColor];
//    }
//    
//    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
//    return cell;
//}




@end
