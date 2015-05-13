//
//  LeoWebsitePanel.h
//  LeoWetsiteNavigator
//
//  Created by 张燎原 on 15/5/11.
//  Copyright (c) 2015年 张燎原. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeoWebsiteCell.h"

@protocol LeoWebsitePanelDelegate <NSObject>

- (void)websitePanelState:(BOOL)opened;
- (void)didTappedCellForRowAtIndex:(NSInteger)cellIndex;
@end

@interface LeoWebsitePanel : UIView<LeoWebsiteCellDelegate>

@property (nonatomic, strong) NSArray *websiteArr;
@property (weak, nonatomic) id<LeoWebsitePanelDelegate> delegate;

- (void)initWebsitePanelWith:(NSArray *)websiteArr;
- (void)didTappedCellWithName:(NSString *)name;

@end
