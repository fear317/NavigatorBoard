//
//  LeoWebsiteCell.h
//  LeoWetsiteNavigator
//
//  Created by 张燎原 on 15/5/11.
//  Copyright (c) 2015年 张燎原. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeoWebsiteCellDelegate <NSObject>

- (void)didTappedCellWithName:(NSString *)name;

@end

@interface LeoWebsiteCell : UIView
@property (strong, nonatomic) UILabel *websiteName;
@property (strong, nonatomic) UIImageView *websiteIcon;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) id<LeoWebsiteCellDelegate> delegate;

- (void)initSelfWithIcon:(UIImage *)icon andName:(NSString *)name
;

@end
