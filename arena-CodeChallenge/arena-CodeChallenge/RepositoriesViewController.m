//
//  RepositoriesViewController.m
//  arena-CodeChallenge
//
//  Created by Maila  Manzur on 29/12/16.
//  Copyright © 2016 Maila  Manzur. All rights reserved.
//

#import "RepositoriesViewController.h"
#import "RepositoriesApiManager.h"
#import "Owner.h"
#import "Repositories.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "RepositoriesTableViewCell.h"
#import "PullRequestsViewController.h"

typedef void (^LoadEnds)();
typedef void (^RefreshEnds)();

@interface RepositoriesViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (assign, nonatomic) BOOL isRefreshing;
@property (strong, nonatomic) NSNumber *page;
@property (strong, nonatomic) NSMutableArray *repositories;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation RepositoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.repositories = [NSMutableArray new];
    self.page = [NSNumber numberWithInt:1];
    [self setupRefresher];
    [self fetchRepositories:self.page];
 
}

# pragma mark View setup 

-(void)setUpTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
    
}

-(void)setupRefresher {
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(pullToRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

#pragma mark - Api Calls 
-(void)fetchRepositories:(NSNumber *)page {
    
    if (!_isRefreshing) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    [[RepositoriesApiManager sharedManager]fetchRepositoriesWithPage:page Success:^(id response) {
        if (self.page != [NSNumber numberWithInt:1]) {
            [self.repositories addObjectsFromArray:response];
        }else if ([self.repositories count] == 0) {
            [self.repositories addObjectsFromArray:response];
        }

        if (!_isRefreshing) {
            [self setUpTableView];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        
    } Failure:^(NSString *errorMsg) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Erro" message:errorMsg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *fechar = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:fechar];
        [self presentViewController:alert animated:YES completion:nil];
        
        if (!_isRefreshing) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        
    }];
    
}

#pragma mark - TableView Delegate/DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.repositories count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tableView:tableView repositoryCellForIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [RepositoriesTableViewCell cellHeight];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedIndexPath = indexPath;
    
}



-(RepositoriesTableViewCell *)tableView:(UITableView *)tableView repositoryCellForIndexPath:(NSIndexPath *)indexPath {
    RepositoriesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[RepositoriesTableViewCell cellIdentifier] forIndexPath:indexPath];
    [cell setup:[_repositories objectAtIndex:indexPath.row]];
    return cell;
    
}

#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PullRequestSegue"]) {
        PullRequestsViewController *prvc = segue.destinationViewController;
        prvc.repositories = [self.repositories objectAtIndex:self.selectedIndexPath.row];
        
    }
}


#pragma mark - Infinite scroll

-(void)loadRepositories {
    
    if (!_isRefreshing) {
        _isRefreshing = YES;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [self loadBegins:^{
            self.isRefreshing = NO;
            [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
        
    }
}

-(void)loadBegins:(LoadEnds)loadEnds {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.page = @([_page integerValue] + 1);
        [self fetchRepositories:self.page];
        sleep(1);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            loadEnds();
        });
    });
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int currentOffset = scrollView.contentOffset.y;
    int maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    int deltaOffset = maximumOffset - currentOffset;
    
    if ((35 > [self.page integerValue]) && deltaOffset <= 0)
        [self loadRepositories];
    
}

#pragma mark PullToRefresh
-(void)pullToRefresh {
    
    if (!_isRefreshing) {
        _isRefreshing = YES;
        
        [self refreshBegins:^{
            self.isRefreshing = NO;
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
        }];
    }
}

-(void)refreshBegins:(RefreshEnds)refreshEnds {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.page = [NSNumber numberWithInt:1];
        if ([self.repositories count] > 30 ) {
            [self.repositories removeObjectsInRange:NSMakeRange(30, [self.repositories count] - 30)];
        }
        [self fetchRepositories:self.page];

        sleep(1);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            refreshEnds();
        });
    });
}



@end
