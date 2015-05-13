//
//  LeoSecondaryWebsitePanel.h
//  LeoWetsiteNavigator
//
//  Created by 张燎原 on 15/5/11.
//  Copyright (c) 2015年 张燎原. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeoWebsiteCell.h"

@interface LeoSecondaryWebsitePanel :UIView <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) id<LeoWebsiteCellDelegate> delegate;

- (void)initSecondaryWebsitePanelWith:(NSArray *)websiteArr  andCellHeight:(NSInteger)cellHeight andCellCountForRow:(NSInteger)count;
//- (void)didTappedCellWith:(NSInteger)tag atIndexPath:(NSInteger)indexPath;

@end
