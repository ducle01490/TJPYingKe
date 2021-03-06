//
//  TJPHomePageViewController.m
//  TJPYingKe
//
//  Created by Walkman on 2016/12/7.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import "TJPHomePageViewController.h"
#import <TJPSengment/TJPSegementBarVC.h>
#import "TJPAttentionViewController.h"
#import "TJPHotViewController.h"
#import "TJPNearByViewController.h"
#import "TJPTalentViewController.h"

#import "TJPRequestDataTool.h"

@interface TJPHomePageViewController ()

@property (nonatomic, weak) TJPSegementBarVC *segementBarVC;

@property (nonatomic, strong) NSArray *tagArr;



@end

@implementation TJPHomePageViewController


#pragma mark - lazy
- (NSArray *)tagArr {
    if (!_tagArr) {
        _tagArr = [NSArray array];
    }
    return _tagArr;
}

- (TJPSegementBarVC *)segementBarVC
{
    if (!_segementBarVC) {
        TJPSegementBarVC *vc = [[TJPSegementBarVC alloc] init];
        [self addChildViewController:vc];
        _segementBarVC = vc;
    }
    return _segementBarVC;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self loadDataForNavTag];
    
    [self setupNavigationItem];

}

- (void)loadDataForNavTag {
    WS(weakSelf)
    __block NSMutableArray *tmpArr = [NSMutableArray array];
    [[TJPRequestDataTool shareInstance] getNavigationTagModels:^(NSArray<TJPNavigationTagItem *> *tagModels) {
        for (TJPNavigationTagItem *item in tagModels) {
            [tmpArr addObject:item.tab_title];
        }
        weakSelf.tagArr = tmpArr.count ? [NSArray arrayWithArray:tmpArr] : @[@"关注", @"热门", @"附近", @"才艺"];
        //设置UI
        [weakSelf setupNavigationTitleViewWithItems:weakSelf.tagArr];
    }];
}


- (void)setupNavigationTitleViewWithItems:(NSArray *)items {
    
    self.segementBarVC.segementBar.frame = CGRectMake(0, 0, 265, 35);
    self.navigationItem.titleView = self.segementBarVC.segementBar;

    self.segementBarVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight + 64);
    [self.view addSubview:self.segementBarVC.view];
    
    TJPAttentionViewController *attentionVC = [[TJPAttentionViewController alloc] init];
    TJPHotViewController *hotVC = [[TJPHotViewController alloc] init];
    
    TJPNearByViewController *nearbyVC = [[TJPNearByViewController alloc] init];
    
    TJPTalentViewController *talentVC = [[TJPTalentViewController alloc] init];
    
    [self.segementBarVC setUpWithItems:items childVCs:@[attentionVC, hotVC, nearbyVC, talentVC]];
    
    //设置属性相关
    [self.segementBarVC.segementBar updateWithConfig:^(TJPSegementBarConfig *config) {
        config.segementBarBackColor = [UIColor clearColor];
        config.itemNormalColor = [UIColor whiteColor];
        config.itemSelectedColor = [UIColor whiteColor];
        config.itemNormalFont = [UIFont systemFontOfSize:17.f];
        config.itemSelectedFont = [UIFont systemFontOfSize:17.f];

        
        config.indicatorColor = [UIColor whiteColor];
        config.indicatorExtraW = -10;
        
    }];
}



- (void)setupNavigationItem {
    
    //left item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"title_button_search" highImage:@"title_button_search" target:self andAction:@selector(search)];
    //right item
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"title_button_more" highImage:@"title_button_more" target:self andAction:@selector(more)];

    
    
}

#pragma mark - 方法实现
- (void)search {
    
    TJPLogFunc
}

- (void)more {
    
    TJPLogFunc
    
}







@end
