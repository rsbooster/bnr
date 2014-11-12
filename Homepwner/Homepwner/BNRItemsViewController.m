//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by Roman Solyakh on 11.11.14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemsViewController ()

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end


@implementation BNRItemsViewController

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self)
    {
        for (int i=0; i<20; i++)
        {
            [[BNRItemStore sharedStore] createItem];
        }
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return  [self init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    self.tableView.tableHeaderView = self.headerView;
}

#pragma mark - Actions and Outlets

- (UIView *)headerView
{
    if(!_headerView)
    {
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
    }
    return _headerView;
}

- (IBAction)addNewItem:(id)sender
{
    
}

- (IBAction)toggleEditingMode:(id)sender
{
    if (self.isEditing)
    {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [self setEditing:NO animated:YES];
    }
    else
    {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self setEditing:YES animated:YES];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[BNRItemStore sharedStore] itemsCountInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    
    BNRItem *item = [[BNRItemStore sharedStore] itemInSection:indexPath.section withIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@, $%d", item.info, item.price];
    return cell;
}

@end
