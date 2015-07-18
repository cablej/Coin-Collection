//
//  CoinListManager.m
//  Coin Collection
//
//  Created by Jack on 10/12/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import "CoinListManager.h"

@implementation CoinListManager {
    NSMutableData *allCoinsData;
    
    
    NSURLConnection *userCoinsConnection;
    NSURLConnection *deleteCoinConnection;
}

-(void) getUserCoinsFromServer {
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    
    NSString *post = [NSString stringWithFormat:@"userID=%@", userID];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coincollections.byethost22.com/CoinCollectionFiles/getCoinsForUser.php"]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    userCoinsConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
}

-(void) editCoin:(Coin *)newCoin {
    
}

-(void) deleteCoin:(Coin *)coin {
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    
    NSString *post = [NSString stringWithFormat:@"userID=%@&coinID=%@", userID, coin.coinID];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coincollections.byethost22.com/CoinCollectionFiles/deleteCoin.php"]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    deleteCoinConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Initialize the data object
    if(connection == userCoinsConnection) {
        allCoinsData = [[NSMutableData alloc] init];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(connection == userCoinsConnection) {
        // Append the newly downloaded data
        [allCoinsData appendData:data];
    }
    else if(connection == deleteCoinConnection) {
        NSLog(@"Connection recieved: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if(connection == userCoinsConnection) {
        
        // Create an array to store the locations
        NSMutableArray *_coins = [[NSMutableArray alloc] init];
        
        // Parse the JSON that came in
        NSError *error;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:allCoinsData options:NSJSONReadingAllowFragments error:&error];
        
        // Loop through Json objects, create question objects and add them to our questions array
        for (int i = 0; i < jsonArray.count; i++)
        {
            NSDictionary *jsonElement = jsonArray[i];
            
            // Create a new location object and set its props to JsonElement properties
            Coin *newCoin = [[Coin alloc] init];
            newCoin.coinID = jsonElement[@"ID"];
            newCoin.date = jsonElement[@"Date"];
            newCoin.name = jsonElement[@"Name"];
            
            newCoin.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:jsonElement[@"Image"]]]];
            
            newCoin.type = jsonElement[@"Type"];
            newCoin.idInCollection = jsonElement[@"IDInCollection"];
            newCoin.composition = jsonElement[@"Composition"];
            newCoin.value = jsonElement[@"Value"];
            newCoin.condition = jsonElement[@"Condition"];
            
            // Add this question to the locations array
            [_coins addObject:newCoin];
        }
        
        // Ready to notify delegate that data is ready and pass back items
        if (self.delegate)
        {
            [self.delegate coinsDownloaded:_coins];
        }
    }
}


@end
