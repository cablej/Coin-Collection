//
//  CoinListManager.h
//  Coin Collection
//
//  Created by Jack on 10/12/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coin.h"

@protocol CoinListProtocol <NSObject>

- (void)coinsDownloaded:(NSArray *)coins;

@end

@interface CoinListManager : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, weak) id<CoinListProtocol> delegate;

-(void) getUserCoinsFromServer;

-(void) editCoin : (Coin *) newCoin;

-(void) deleteCoin : (Coin *) coin;

@end
