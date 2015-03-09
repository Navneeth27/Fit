//
//  WLITimelineViewController.m
//  WeLike
//
//  Created by Planet 1107 on 20/11/13.
//  Copyright (c) 2013 Planet 1107. All rights reserved.
//

#import "WLITimelineViewController.h"
#import "WLIPostCell.h"
#import "WLILoadingCell.h"
#import "GlobalDefines.h"
#import "LQSViewController.h"
#import "WLIActivityViewController.h"

@implementation WLITimelineViewController

#pragma mark - Object lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Fitovate";
    }
    return self;
}


#pragma mark - View lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self reloadData:YES];
    
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Activity" style:UIBarButtonItemStylePlain target:self action:@selector(goToActivity)];
    self.navigationItem.leftBarButtonItem = anotherButton;
    
    
    
    UIButton *button =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    [button setImage:[UIImage imageNamed:@"messagesbutton.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goToMessages) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem =back;
}




-(void)goToMessages {
    NSLog(@"Eh up, someone just pressed the button!");
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:nil action:nil];
    LQSViewController *newVc = [[LQSViewController alloc]init];
    [self.navigationController pushViewController:newVc animated:YES];
                                
}
-(void)goToActivity {
    NSLog(@"Going to activity!");
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:nil action:nil];
    WLIActivityViewController *newVc = [[WLIActivityViewController alloc]init];
    [self.navigationController pushViewController:newVc animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Data loading methods

- (void)reloadData:(BOOL)reloadAll {
    
    loading = YES;
    int page;
    if (reloadAll) {
        loadMore = YES;
        page = 1;
    } else {
        page  = (self.posts.count / kDefaultPageSize) + 1;
    }
    [sharedConnect timelineForUserID:sharedConnect.currentUser.userID page:page pageSize:kDefaultPageSize onCompletion:^(NSMutableArray *posts, ServerResponse serverResponseCode) {
        loading = NO;
        self.posts = posts;
        loadMore = posts.count == kDefaultPageSize;
        [self.tableViewRefresh reloadData];
        [refreshManager tableViewReloadFinishedAnimated:YES];
    }];
}


#pragma mark - UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1){
        static NSString *CellIdentifier = @"WLIPostCell";
        WLIPostCell *cell = (WLIPostCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"WLIPostCell" owner:self options:nil] lastObject];
            cell.delegate = self;
        }
        cell.post = self.posts[indexPath.row];
        return cell;
    } else {
        static NSString *CellIdentifier = @"WLILoadingCell";
        WLILoadingCell *cell = (WLILoadingCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"WLILoadingCell" owner:self options:nil] lastObject];
        }
        
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
    if (section == 1) {
        return self.posts.count;
    } else {
        if (loadMore) {
            return 1;
        } else {
            return 0;
        }
    }
}


#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        return [WLIPostCell sizeWithPost:self.posts[indexPath.row]].height;
    } else if (indexPath.section == 0){
        return 44 * loading * self.posts.count == 0;
    } else {
        return 44 * loadMore;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2 && loadMore && !loading) {
        [self reloadData:NO];
    }
}


#pragma mark - WLIPostCellDelegate methods

- (void)toggleLikeForPost:(WLIPost*)post sender:(WLIPostCell*)senderCell {
    
    if (post.likedThisPost) {
        [senderCell.buttonLike setImage:[UIImage imageNamed:@"btn-like.png"] forState:UIControlStateNormal];
        post.postLikesCount--;
        post.likedThisPost = NO;
        if (post.postLikesCount == 1) {
            [senderCell.buttonLikes setTitle:[NSString stringWithFormat:@"%d like", post.postLikesCount] forState:UIControlStateNormal];
        } else {
            [senderCell.buttonLikes setTitle:[NSString stringWithFormat:@"%d likes", post.postLikesCount] forState:UIControlStateNormal];
        }
        [[WLIConnect sharedConnect] removeLikeWithLikeID:post.postID onCompletion:^(ServerResponse serverResponseCode) {
            if (serverResponseCode != OK) {
                [senderCell.buttonLike setImage:[UIImage imageNamed:@"btn-liked.png"] forState:UIControlStateNormal];
                post.postLikesCount++;
                post.likedThisPost = YES;
                if (post.postLikesCount == 1) {
                    [senderCell.buttonLikes setTitle:[NSString stringWithFormat:@"%d like", post.postLikesCount] forState:UIControlStateNormal];
                } else {
                    [senderCell.buttonLikes setTitle:[NSString stringWithFormat:@"%d likes", post.postLikesCount] forState:UIControlStateNormal];
                }
            }
        }];
    } else {
        [senderCell.buttonLike setImage:[UIImage imageNamed:@"btn-liked.png"] forState:UIControlStateNormal];
        post.postLikesCount++;
        post.likedThisPost = YES;
        if (post.postLikesCount == 1) {
            [senderCell.buttonLikes setTitle:[NSString stringWithFormat:@"%d like", post.postLikesCount] forState:UIControlStateNormal];
        } else {
            [senderCell.buttonLikes setTitle:[NSString stringWithFormat:@"%d likes", post.postLikesCount] forState:UIControlStateNormal];
        }
        [[WLIConnect sharedConnect] setLikeOnPostID:post.postID onCompletion:^(WLILike *like, ServerResponse serverResponseCode) {
            if (serverResponseCode != OK) {
                [senderCell.buttonLike setImage:[UIImage imageNamed:@"btn-like.png"] forState:UIControlStateNormal];
                post.postLikesCount--;
                post.likedThisPost = NO;
                if (post.postLikesCount == 1) {
                    [senderCell.buttonLikes setTitle:[NSString stringWithFormat:@"%d like", post.postLikesCount] forState:UIControlStateNormal];
                } else {
                    [senderCell.buttonLikes setTitle:[NSString stringWithFormat:@"%d likes", post.postLikesCount] forState:UIControlStateNormal];
                }
            }
        }];
    }
}

@end
