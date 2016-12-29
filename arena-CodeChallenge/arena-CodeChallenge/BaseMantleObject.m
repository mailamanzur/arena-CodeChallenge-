//
//  BaseMantleObject.m
//  arena-CodeChallenge
//
//  Created by Maila  Manzur on 26/12/16.
//  Copyright © 2016 Maila  Manzur. All rights reserved.
//

#import "BaseMantleObject.h"

@implementation BaseMantleObject

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return [NSDictionary mtl_identityPropertyMapWithModel:self.class];
}

-(NSDictionary*)asDictError:(NSError**)error{
    return  [MTLJSONAdapter JSONDictionaryFromModel:self error:error];
}

+(instancetype)parse:(NSDictionary*)dc error:(NSError**)error{
    return [MTLJSONAdapter modelOfClass:self.class
                     fromJSONDictionary:dc
                                  error:error];
}

+(NSArray*)asArrayOfDictFromModelArray:(NSArray*)objects error:(NSError**)error{
    return [MTLJSONAdapter JSONArrayFromModels:objects  error:error];
}

+(NSArray*)parseArray:(NSArray*)objs error:(NSError**)error{
    return [MTLJSONAdapter modelsOfClass:self.class
                           fromJSONArray:objs
                                   error:error];
}

@end

