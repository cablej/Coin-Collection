//
//  CoinManager.h
//  Coin Collection
//
//  Created by Jack on 10/11/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coin.h"

@interface CoinManager : NSObject

-(BOOL) addCoinToServer: (Coin *) coin;

@end
