//
//  StoryboardUtil.h
//  arena-CodeChallenge
//
//  Created by Maila  Manzur on 26/12/16.
//  Copyright © 2016 Maila  Manzur. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RepositoriesViewController, PullRequestsViewController;
@interface StoryboardUtil : UIStoryboard

//Repositories
+(RepositoriesViewController *)repositoriesViewController;
//PullRequests
+(PullRequestsViewController *)pullRequestsViewController;

@end
