//
//  Coin.h
//  Coin Collection
//
//  Created by Jack on 10/12/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coin : NSObject

-(id) initWithDate : (NSString *) date : (NSString *) name;
-(id) initWithDate : (NSString *) date : (NSString *) name : (UIImage*) image : (NSString *) type : (NSString*) idInCollection : (NSString *) composition : (NSString*) value : (NSString *) condition;
-(id) initWithDate:(NSString *)date :(NSString *)name : (NSString *) coinID;
-(id) initWithDate : (NSString *) date : (NSString *) name : (UIImage*) image : (NSString *) type : (NSString*) idInCollection : (NSString *) composition : (NSString*) value : (NSString *) condition : (NSString *) coinID;


@property(strong, nonatomic) NSString *date;
@property(strong, nonatomic) NSString *name;

@property(strong, nonatomic) UIImage *image;

@property(strong, nonatomic) NSString *type;
@property(strong, nonatomic) NSString *idInCollection;
@property(strong, nonatomic) NSString *composition;

@property(strong, nonatomic) NSString *coinID;

@property(strong, nonatomic) NSString *value;
@property(strong, nonatomic) NSString *condition;

@end
