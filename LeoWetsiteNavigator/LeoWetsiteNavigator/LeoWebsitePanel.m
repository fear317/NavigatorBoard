//
//  LeoWebsitePanel.m
//  LeoWetsiteNavigator
//
//  Created by 张燎原 on 15/5/11.
//  Copyright (c) 2015年 张燎原. All rights reserved.
//

#import "LeoWebsitePanel.h"
#import "LeoWebsiteContentPanel.h"

@interface LeoWebsitePanel ()
{
    NSInteger _cellCountsForRow;
    NSInteger _cellCountsForColumn;
    CGFloat   _cellWidth;
    CGFloat   _cellHeight;
    CGFloat   _cellSpaceForRow;
    CGFloat   _cellSpaceForColumn;
}
@property (strong, nonatomic) UIButton *switchButton;
@property (strong, nonatomic) LeoWebsiteContentPanel *defaultPanel;
@property (strong, nonatomic) UIView *secondaryPanel;
@end

@implementation LeoWebsitePanel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _cellCountsForRow     = 4.0;
        _cellCountsForColumn  = 3.0;
        _cellSpaceForRow      = 10.0;
        _cellSpaceForColumn   = 10.0;
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
- (void)initWebsitePanelWith:(NSArray *)websiteArr
{
    if (!websiteArr || websiteArr.count <= 0) {
        return;
    }
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//    _mainPanel = view;
//    [self addSubview:_mainPanel];
    
    CGFloat cellWidth = self.frame.size.width/_cellCountsForRow - _cellSpaceForRow * (_cellCountsForRow + 1)/_cellCountsForRow;
    _cellWidth = cellWidth;
    CGFloat cellHeight = self.frame.size.height/_cellCountsForColumn - _cellSpaceForColumn * (_cellCountsForColumn + 1)/_cellCountsForColumn;
    _cellHeight = cellHeight;

//    for (NSInteger cellIndex = 0; cellIndex < [websiteArr count] && cellIndex < _cellCountsForColumn * _cellCountsForRow; cellIndex ++) {
//        CGFloat originX = (_cellSpaceForRow + cellWidth) * (cellIndex%_cellCountsForRow) + _cellSpaceForRow;
//        CGFloat originY = (_cellSpaceForColumn + cellHeight)*(cellIndex/_cellCountsForRow) + _cellSpaceForColumn;
//        CGRect cellFrame = CGRectMake(originX, originY, cellWidth, cellHeight);
//        LeoWebsiteCell *cell = [[LeoWebsiteCell alloc] initWithFrame:cellFrame];
//        cell.tag = cellIndex;
//        [cell initSelfWithIcon:[UIImage imageNamed:@"wy.png"] andName:[websiteArr objectAtIndex:cellIndex]];
//        [_mainPanel addSubview:cell];
//        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedCell:)];
//        [cell addGestureRecognizer:tap];
//    }
    if (websiteArr.count >= 12) {
        NSMutableArray *defaultWebsiteArr = [[NSMutableArray alloc] initWithCapacity:3];
        for (int i = 0; i < 12; i++) {
            [defaultWebsiteArr addObject:[websiteArr objectAtIndex:i]];
        }
        _defaultPanel = (LeoWebsiteContentPanel *)[self createWebsitPanelWith:defaultWebsiteArr];
        [_defaultPanel.layer setBorderColor:[UIColor blackColor].CGColor];
        [_defaultPanel.layer setBorderWidth:1.0];
        CGRect frame = _defaultPanel.frame;
        frame.origin.y = _cellSpaceForColumn;
        _defaultPanel.frame = frame;
        [_defaultPanel updateScrollEnabled:NO];
        [self addSubview:_defaultPanel];
    }

    UIView *switchView = [self addSwitchButton];
    _switchButton = (UIButton *)switchView;
    [self addSubview:switchView];
    
    if (websiteArr.count > 12) {
        NSMutableArray *secondaryArr = [[NSMutableArray alloc] initWithCapacity:10];
        for (int i = 12; i<websiteArr.count; i++) {
            [secondaryArr addObject:[websiteArr objectAtIndex:i]];
        }
        _secondaryPanel = [self createWebsitPanelWith:secondaryArr];
        CGRect frame = _secondaryPanel.frame;
        frame.origin.y  = _defaultPanel.frame.origin.y + _defaultPanel.frame.size.height;
        _secondaryPanel.frame = frame;
        [self addSubview:_secondaryPanel];
    }
    
    [self setClipsToBounds:YES];
}

- (UIView *)addSwitchButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"arrowIconDown.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"arrowIconUp.png"] forState:UIControlStateSelected];
    CGFloat originX = (_cellSpaceForRow + _cellWidth) * _cellCountsForRow;
    CGFloat originY = (_cellSpaceForColumn + _cellHeight)*_cellCountsForColumn - 10.0;
    [button setFrame:CGRectMake(originX, originY, 10, 10)];
    [button addTarget:self action:@selector(switchButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)switchButtonClicked:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button.isSelected) {
        [button setSelected:NO];
    }else{
        [button setSelected:YES];
    }
    
    if (self.delegate) {
        [self.delegate websitePanelState:button.isSelected];
    }
    
    [self updateSecondaryPanelStatus:button.isSelected];
    
}

- (void)didTappedCell:(UITapGestureRecognizer *)recognizer
{
    LeoWebsiteCell *cell = (LeoWebsiteCell *)(recognizer.view);
    if(self.delegate)
    {
        [self.delegate didTappedCellForRowAtIndex:cell.tag];
    }
}

- (UIView *)createWebsitPanelWith:(NSArray *)websiteArr
{
    CGFloat panelHeight = 0;
    if (websiteArr.count >= _cellCountsForRow * 7) {
        panelHeight = (10+_cellHeight)*7;
    }else{
        NSInteger cellCount = (websiteArr.count - 1)/_cellCountsForRow + 1;
        panelHeight = (_cellHeight + 10.0)*cellCount;
    }
    LeoWebsiteContentPanel *view = [[LeoWebsiteContentPanel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, panelHeight)];
    [view initSecondaryWebsitePanelWith:websiteArr andCellHeight:_cellHeight  andCellCountForRow:_cellCountsForRow];
    view.delegate = self;
    return view;
}

- (void)updateSecondaryPanelStatus:(BOOL)opened
{
    if (self.secondaryPanel) {
        if (opened) {
            [UIView animateWithDuration:0.5 animations:^{
                CGRect frame = self.frame;
                frame.size.height = _defaultPanel.frame.size.height + _secondaryPanel.frame.size.height;
                self.frame = frame;
            }];
        }else {
            [UIView animateWithDuration:0.5 animations:^{
                CGRect frame = self.frame;
                frame.size.height = _defaultPanel.frame.size.height + _cellSpaceForColumn;
                self.frame = frame;
            }];
        }
    }
}

- (void)didTappedCellWithName:(NSString *)name
{
    NSLog(@" didTappedCellWithName:%@",name);
}

@end
