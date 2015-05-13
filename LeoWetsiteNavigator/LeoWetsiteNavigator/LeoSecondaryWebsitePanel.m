//
//  LeoSecondaryWebsitePanel.m
//  LeoWetsiteNavigator
//
//  Created by 张燎原 on 15/5/11.
//  Copyright (c) 2015年 张燎原. All rights reserved.
//

#import "LeoSecondaryWebsitePanel.h"

@interface LeoSecondaryWebsitePanel ()
{
    CGFloat _cellHeight;
    CGFloat _cellCountsForRow;
}
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *wetsiteArr;
@end

@implementation LeoSecondaryWebsitePanel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _cellHeight = 0;
        _cellCountsForRow = 3;
//        [self.layer setBorderColor:[UIColor blueColor].CGColor];
//        [self.layer setBorderWidth:1.0];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _cellHeight + 10.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //(_wetsiteArr.count- 1)/_cellCountsForRow + 1
    if (_wetsiteArr && _wetsiteArr.count > 0) {
        return (_wetsiteArr.count-1)/_cellCountsForRow + 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"secondaryPanelCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        for (int i = 0; i < _cellCountsForRow; i++) {
            if (indexPath.row < (_wetsiteArr.count- 1)/_cellCountsForRow + 1) {
                NSString *websiteName = [_wetsiteArr objectAtIndex:indexPath.row*_cellCountsForRow + i];
                LeoWebsiteCell *websiteCell = [self createWebsiteCellWith:[UIImage imageNamed:@"wy.png"] and:websiteName];
                CGRect frame = websiteCell.frame;
                frame.origin.x =10*i + websiteCell.frame.size.width*i + 10.0;
                websiteCell.frame = frame;
                websiteCell.tag = i;
                websiteCell.indexPath = indexPath;
                [cell addSubview:websiteCell];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
        }
//        return cell;
    }else {
        NSArray *websiteCellArr = [cell subviews];
        for (UIView *subView in websiteCellArr) {
            if ([subView isKindOfClass:[LeoWebsiteCell class]]) {
                NSInteger tag = subView.tag;
                NSString *websiteName = [_wetsiteArr objectAtIndex:indexPath.row*_cellCountsForRow + tag];
                LeoWebsiteCell *websiteCell = (LeoWebsiteCell *)subView;
                [websiteCell initSelfWithIcon:[UIImage imageNamed:@"wy.png"] andName:websiteName];
                websiteCell.indexPath = indexPath;
            }
        }
    }
    return cell;
}

- (void)initSecondaryWebsitePanelWith:(NSArray *)websiteArr andCellHeight:(NSInteger)cellHeight andCellCountForRow:(NSInteger)count
{
    _cellHeight = cellHeight;
    _cellCountsForRow = count;
    if (!_tableView && websiteArr.count > 0) {
        UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        _tableView = tv;
        tv.delegate = self;
        tv.dataSource = self;
        _wetsiteArr = websiteArr;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//        [tv.layer setBorderColor:[UIColor greenColor].CGColor];
//        [tv.layer setBorderWidth:1.0];
        [self addSubview:tv];
    }
}

- (LeoWebsiteCell *)createWebsiteCellWith:(UIImage *)icon and:(NSString *)name
{
    CGFloat cellWidth = self.frame.size.width/_cellCountsForRow - 10*(_cellCountsForRow+1)/_cellCountsForRow;
    LeoWebsiteCell *cell = [[LeoWebsiteCell alloc] initWithFrame:CGRectMake(0, 0, cellWidth, _cellHeight)];
//    [cell.layer setBorderColor:[UIColor blackColor].CGColor];
//    [cell.layer setBorderWidth:1.0];
    [cell initSelfWithIcon:icon andName:name];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedWebsiteCell:)];
    [cell addGestureRecognizer:tap];
    cell.delegate = self.delegate;
    return cell;
}

- (void)didTappedWebsiteCell:(UITapGestureRecognizer *)recognizer
{
    LeoWebsiteCell *websiteCell = (LeoWebsiteCell *)recognizer.view;
    NSLog(@"tapped websiteCell:%@",websiteCell.websiteName);
    if (self.delegate) {
        [self.delegate didTappedCellWithName:websiteCell.websiteName.text];
    }
}
@end
