//
//  PullRequestModelTest.m
//  arena-CodeChallenge
//
//  Created by Maila  Manzur on 29/12/16.
//  Copyright © 2016 Maila  Manzur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Specta.h>
#import <Expecta.h>
#import "PullRequest.h"


SpecBegin(PullRequestModelTest)

describe(@"Testes modelos PullRequest", ^{
    __block NSArray *pullRequestJSON;
    __block NSError *error;
    beforeAll(^{
        NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"PullRequest" ofType:@"json"];
        
        pullRequestJSON = (NSArray *)[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:kNilOptions error:&error];
    });
    
    it(@"Should parse dictionary into pullRequest object", ^{
        NSArray *pullRequests = [PullRequest parseArray:pullRequestJSON error:&error];

        PullRequest *pullRequest = [pullRequests objectAtIndex:0];
        
        
        expect(pullRequest.pullRequestName).to.equal(@"2.x: Fixed Javadoc for SingleToObservable");
        expect(pullRequest.pullRequestDescription).to.equal(@"A simple Javadoc typo fix.");
        
        expect([pullRequests count]).to.equal(2);
        
        
    });
    
});



SpecEnd

