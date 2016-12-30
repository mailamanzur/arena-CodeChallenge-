//
//  StoryboardUtil.m
//  arena-CodeChallenge
//
//  Created by Maila  Manzur on 26/12/16.
//  Copyright © 2016 Maila  Manzur. All rights reserved.
//

#import "StoryboardUtil.h"
#import "PullRequestsViewController.h"
#import "RepositoriesViewController.h"


@implementation StoryboardUtil

#pragma mark - Private Methods
+(UIViewController *)viewControllerWithStoryboard:(NSString *)storyboardName controllerName:(NSString *)controllerName{
    if (!storyboardName || !controllerName)
        return nil;
    
    NSString *deviceStoryboardName = storyboardName;
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:deviceStoryboardName bundle:nil];
    if (!mainStoryboard)
        return nil;
    
    return [mainStoryboard instantiateViewControllerWithIdentifier:controllerName];
}

#pragma mark - Repositories

+(RepositoriesViewController *)repositoriesViewController{
    return (RepositoriesViewController *)[StoryboardUtil viewControllerWithStoryboard:@"Main" controllerName:@"RepositoriesViewController"];
}

#pragma mark - PullRequests

+(PullRequestsViewController *)pullRequestsViewController{
    return (PullRequestsViewController *)[StoryboardUtil viewControllerWithStoryboard:@"Main" controllerName:@"PullRequestsViewController.h"];
}

@end
