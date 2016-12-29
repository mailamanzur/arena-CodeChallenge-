//
//  RepositoryModelTest.m
//  arena-CodeChallenge
//
//  Created by Maila  Manzur on 29/12/16.
//  Copyright © 2016 Maila  Manzur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Specta.h>
#import <Expecta.h>
#import "Repositories.h"
#import "Owner.h"



SpecBegin(RepositoryModelTest)

describe(@"Testes modelos Repository", ^{
    __block NSDictionary *repositoryJSON;
    __block NSError *error;
    beforeAll(^{
        NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Repository" ofType:@"json"];
        
        repositoryJSON = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:kNilOptions error:&error];
    });
    
    it(@"Should parse dictionary into Repository object", ^{
         NSArray *repositories = [Repositories parseArray:repositoryJSON[@"items"] error:&error];
        
        Repositories *repository = [repositories objectAtIndex:0];
        
        
        expect(repository.repositoryName).to.equal(@"RxJava");
        expect(repository.repositoryDescription).to.equal(@"RxJava – Reactive Extensions for the JVM – a library for composing asynchronous and event-based programs using observable sequences for the Java VM.");
        expect(repository.repositoryForks).to.equal(3537);
        expect(repository.repositoryStars).to.equal(20081);
        expect(repository.owner.ownerAvatar).to.equal(@"https://avatars.githubusercontent.com/u/6407041?v=3");
        expect(repository.owner.ownerUsername).to.equal(@"ReactiveX");
        
        expect([repositories count]).to.equal(3);
        
        
    });
    
});



SpecEnd

