//
//  WLIPopularViewController.m
//  WeLike
//
//  Created by Planet 1107 on 20/11/13.
//  Copyright (c) 2013 Planet 1107. All rights reserved.
//

#import "WLIPopularViewController.h"
#import "WLILoadingCell.h"
#import "WLIPostCollectionViewCell.h"
#import "GlobalDefines.h"
#import "WLILoadingCollectionViewCell.h"

@implementation WLIPopularViewController


#pragma mark - Object lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Popular";
    }
    return self;
}


#pragma mark - View lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIButton *reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    reloadButton.adjustsImageWhenHighlighted = NO;
    reloadButton.frame = CGRectMake(0.0f, 0.0f, 40.0f, 30.0f);
    [reloadButton setImage:[UIImage imageNamed:@"nav-btn-reload.png"] forState:UIControlStateNormal];
    [reloadButton addTarget:self action:@selector(barButtonItemReloadTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:reloadButton];

    UINib *nib = [UINib nibWithNibName:@"WLIPostCollectionViewCell" bundle:nil];
    [self.collectionViewPopular registerNib:nib forCellWithReuseIdentifier:@"WLIPostCollectionViewCell"];
    [self.collectionViewRecent registerNib:nib forCellWithReuseIdentifier:@"WLIPostCollectionViewCell"];
    
    [self reloadDataOnSegment:0];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Data loading methods

- (void)reloadDataOnSegment:(int)segment {
    
    if (segment == 0) {
        loadingPopular = YES;
        [hud show:YES];
        [sharedConnect popularPostsOnPage:1 pageSize:kDefaultPageSize onCompletion:^(NSMutableArray *posts, ServerResponse serverResponseCode) {
            loadingPopular = NO;
            self.popularPosts = posts;
            [self.collectionViewPopular reloadData];
            [hud hide:NO];
            [self updateReloadButton];
        }];
    } else {
        loadingRecent = YES;
        [hud show:YES];
        [sharedConnect recentPostsWithPageSize:kDefaultPageSize onCompletion:^(NSMutableArray *posts, ServerResponse serverResponseCode) {
            loadingRecent = NO;
            self.recentPosts = posts;
            [self.collectionViewRecent reloadData];
            [hud hide:NO];
            [self updateReloadButton];
        }];
    }
}


#pragma mark - UICollectionViewDataSource methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    if (!self.collectionViewPopular.hidden) {
        return ceil(self.popularPosts.count / 3.0);
    } else {
        return ceil(self.recentPosts.count / 3.0);
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    int postsCount = 0;
    if (!self.collectionViewPopular.hidden) {
        postsCount = (int)self.popularPosts.count;
    } else {
        postsCount = (int)self.recentPosts.count;
    }

    if (postsCount) {
        int itemsCount = postsCount - ((section) * 3);
        if (itemsCount > 3) {
            itemsCount = 3;
        }
        return itemsCount;
    } else {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WLIPostCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WLIPostCollectionViewCell" forIndexPath:indexPath];
    cell.delegate = self;
    if (!self.collectionViewPopular.hidden) {
        cell.post = self.popularPosts[indexPath.section * 3 + indexPath.row];
    } else {
        cell.post = self.recentPosts[indexPath.section * 3 + indexPath.row];
    }
    [cell.imageViewPost setImageWithURL:[NSURL URLWithString:cell.post.postImagePath]];
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout methods

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(90, 90);
}


#pragma mark - Actions methods

- (IBAction)segmentedControlPopularRecentValueChanged:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == 0) {
        self.collectionViewPopular.hidden = NO;
        self.collectionViewRecent.hidden = YES;
        if (!loadingPopular) {
            [self reloadDataOnSegment:0];
        }
    } else {
        self.collectionViewPopular.hidden = YES;
        self.collectionViewRecent.hidden = NO;
        if (!loadingRecent) {
            [self reloadDataOnSegment:1];
        }
    }
    [self updateReloadButton];
}

- (void)barButtonItemReloadTouchUpInside:(UIBarButtonItem*)reloadBarButtonItem {
    
    if (self.segmentedControlPopularRecent.selectedSegmentIndex == 0 && !loadingPopular) {
        [self reloadDataOnSegment:0];
    } else if (self.segmentedControlPopularRecent.selectedSegmentIndex == 1 && !loadingRecent) {
        [self reloadDataOnSegment:1];
    }
    [self updateReloadButton];
}

- (void)updateReloadButton {
    
    if (self.segmentedControlPopularRecent.selectedSegmentIndex == 0) {
        if (loadingPopular) {
            self.navigationItem.rightBarButtonItem.enabled = NO;
        } else {
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }
    } else {
        if (loadingRecent) {
            self.navigationItem.rightBarButtonItem.enabled = NO;
        } else {
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }
    }
}

@end
