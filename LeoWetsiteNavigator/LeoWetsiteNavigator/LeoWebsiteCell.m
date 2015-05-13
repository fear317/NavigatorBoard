//
//  LeoWebsiteCell.m
//  LeoWetsiteNavigator
//
//  Created by 张燎原 on 15/5/11.
//  Copyright (c) 2015年 张燎原. All rights reserved.
//

#import "LeoWebsiteCell.h"

@implementation LeoWebsiteCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)initSelfWithIcon:(UIImage *)icon andName:(NSString *)name
{
    if (!self.websiteIcon) {
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
        [iconView setImage:icon];
        self.websiteIcon = iconView;
        [self addSubview:iconView];
    }else {
        [self.websiteIcon setImage:icon];
    }
    
    if (!self.websiteName) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.websiteIcon.frame.size.width + 2.0, 0, self.frame.size.width - self.websiteIcon.frame.size.width - 2.0, self.frame.size.height)];
        [label setText:name];
        self.websiteName = label;
        [self addSubview:label];
    }else{
        [self.websiteName setText:name];
    }
}
@end
