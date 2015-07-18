//
//  CoinCollectionViewController.h
//  Coin Collection
//
//  Created by Jack on 10/13/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoinListManager.h"
#import "Coin.h"

@interface CoinCollectionViewController : UICollectionViewController <CoinListProtocol, UICollectionViewDataSource, UICollectionViewDelegate>

@end
