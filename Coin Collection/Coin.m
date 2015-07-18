//
//  Coin.m
//  Coin Collection
//
//  Created by Jack on 10/12/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import "Coin.h"

@implementation Coin

-(id) initWithDate:(NSString *)date :(NSString *)name {
    
    if(self = [super init]) {
        _date = date;
        _name = name;
    }
    
    return self;
}

-(id) initWithDate:(NSString *)date :(NSString *)name : (NSString *) coinID {
    
    if(self = [super init]) {
        _date = date;
        _name = name;
        _coinID = coinID;
    }
    
    return self;
}

-(id) initWithDate:(NSString *)date :(NSString *)name :(UIImage *)image :(NSString *)type :(NSString *)idInCollection :(NSString *)composition :(NSString *)value :(NSString *)condition {
    if(self = [super init]) {
        _date = date;
        _name = name;
        _image = image;
        _type = type;
        _idInCollection = idInCollection;
        _composition = composition;
        _value = value;
        _condition = condition;
    }
    
    return self;
}


-(id) initWithDate:(NSString *)date :(NSString *)name :(UIImage *)image :(NSString *)type :(NSString *)idInCollection :(NSString *)composition :(NSString *)value :(NSString *)condition : (NSString *) coinID {
    if(self = [super init]) {
        _date = date;
        _name = name;
        _image = image;
        _type = type;
        _idInCollection = idInCollection;
        _composition = composition;
        _value = value;
        _condition = condition;
        _coinID = coinID;
    }
    
    return self;
}


@end
