//
//  BaseTableViewCell.h
//  arena-CodeChallenge
//
//  Created by Maila  Manzur on 26/12/16.
//  Copyright © 2016 Maila  Manzur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

+(CGFloat)cellHeight;

+(NSString *)cellIdentifier;

-(void)setup:(id)object;

+(void)registerForTableView:(UITableView*)tableview;

@end
