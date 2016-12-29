//
//  StoryboardUtil.m
//  arena-CodeChallenge
//
//  Created by Maila  Manzur on 26/12/16.
//  Copyright © 2016 Maila  Manzur. All rights reserved.
//

#import "StoryboardUtil.h"


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



@end
