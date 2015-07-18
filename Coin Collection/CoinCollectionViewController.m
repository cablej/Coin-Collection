//
//  CoinCollectionViewController.m
//  Coin Collection
//
//  Created by Jack on 10/13/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import "CoinCollectionViewController.h"
#import "CoinCollectionViewCell.h"

@interface CoinCollectionViewController ()

@property(strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation CoinCollectionViewController {
    CoinListManager *_listManager;
    NSArray *_coinFeed;
}

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    [_listManager getUserCoinsFromServer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Create array object and assign it to _feedItems variable
    _coinFeed = [[NSArray alloc] init];
    
    // Create new HomeModel object and assign it to _homeModel variable
    _listManager = [[CoinListManager alloc] init];
    
    _listManager.delegate = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:_listManager
                            action:@selector(getUserCoinsFromServer)
                  forControlEvents:UIControlEventValueChanged];
    
    [self.collectionView addSubview:self.refreshControl];
    
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}


-(void)coinsDownloaded:(NSArray *)coins
{
    // This delegate method will get called when the items are finished downloading
    
    // Set the downloaded items to the array
    _coinFeed = coins;
    
    // Reload the table view
    [self reloadData];
}

-(void) reloadData {
    
    [self.collectionView reloadData];
    
    [self.refreshControl endRefreshing];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _coinFeed.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CoinCollectionViewCell *coinCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CoinCell" forIndexPath:indexPath];
    
    Coin *coin = _coinFeed[indexPath.row];
    
    coinCell.imageView.image = coin.image;
    
    return coinCell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
	
}
*/

@end
