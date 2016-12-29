//
//  PullRequestsViewController.m
//  arena-CodeChallenge
//
//  Created by Maila  Manzur on 29/12/16.
//  Copyright © 2016 Maila  Manzur. All rights reserved.
//

#import "PullRequestsViewController.h"
#import "RepositoriesApiManager.h"
#import "Repositories.h"
#import "Owner.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "PullRequestTableViewCell.h"

@interface PullRequestsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSArray *pullRequests;

@end

@implementation PullRequestsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchPullRequests];
    
}

# pragma mark View setup

-(void)setUpTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
    
}


#pragma mark - Api Calls
-(void)fetchPullRequests {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
 
    [[RepositoriesApiManager sharedManager]fetchPullRequestsWithUser:self.repositories.owner.ownerUsername andRepository:self.repositories.repositoryName Success:^(id response) {
        self.pullRequests = response;
        [self setUpTableView];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } Failure:^(NSString *errorMsg) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Erro" message:errorMsg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *fechar = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:fechar];
        [self presentViewController:alert animated:YES completion:nil];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

#pragma mark - TableView Delegate/DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.pullRequests count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tableView:tableView repositoryCellForIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [PullRequestTableViewCell cellHeight];
}

-(PullRequestTableViewCell *)tableView:(UITableView *)tableView repositoryCellForIndexPath:(NSIndexPath *)indexPath {
    PullRequestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[PullRequestTableViewCell cellIdentifier] forIndexPath:indexPath];
    [cell setup:[_pullRequests objectAtIndex:indexPath.row]];
    return cell;
    
}





@end
