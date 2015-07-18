//
//  CoinManager.m
//  Coin Collection
//
//  Created by Jack on 10/11/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import "CoinManager.h"

@implementation CoinManager

-(id) init {
    if(self = [super init]) {
        
    }
    
    return self;
}

-(BOOL) addCoinToServer: (Coin *) coin {
    
    NSString *url = [self uploadImage:coin];
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    
    NSString *post = [NSString stringWithFormat:@"userID=%@&date=%@&name=%@&type=%@&idInCollection=%@&composition=%@&value=%@&condition=%@&imageURL=%@", userID, coin.date, coin.name, coin.type, coin.idInCollection, coin.composition, coin.value, coin.condition, url];
    NSMutableData *postData = [NSMutableData dataWithData:[post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coincollections.byethost22.com/CoinCollectionFiles/addCoin.php"]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:postData];
    
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if(conn) {
        return true;
    } else {
        return false;
    }
}

-(NSString *)uploadImage : (Coin *) coin {
    NSData *imageData = UIImageJPEGRepresentation(coin.image, 90);
    // setting up the URL to post to
    NSString *urlString = @"http://coincollections.byethost22.com/CoinCollectionFiles/uploadImage.php";
    
    // setting up the request object now
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    /*
     add some header info now
     we always need a boundary when we post a file
     also we need to set the content type
     
     You might want to generate a random boundary.. this is just the same
     as my output from wireshark on a valid html post
     */
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    /*
     now lets create the body of the post
     */
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\".jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    // now lets make the connection to the web
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    return returnString;
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data {
    NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}

@end
