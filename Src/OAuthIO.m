/*
 * (C) Copyright 2013 Webshell SAS.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

#import "OAuthIO.h"

#define kOAUTHIO_URL @"https://oauth.io/auth"

@implementation OAuthIO

- (id)initWithKey:(NSString *)key
{
    self  = [super init];
    
    if (!self)
        return nil;
    
    _key = key;
    
    return (self);
}

- (void)dealloc
{
    [super dealloc];
}

- (void)redirectWithProvider:(NSString *)provider andUrl:(NSString *)url success:(SuccessBlock)success error:(ErrorBlock)error
{
    _success = [success copy];
    _error = [error copy];
    
    OAuthIORequest *request = [[OAuthIORequest alloc] initWithBaseUrl:kOAUTHIO_URL];
    
    NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setValue:provider forKey:@"p"];
    [params setValue:_key forKey:@"k"];
    [params setValue:url forKey:@"redirect_uri"];
    NSLog(@"[DEBUG] redirectWithProvider request with params %@", params);
    [request requestWithParams:params success:^(NSData *data, NSURLRequest *request) {
        NSLog(@"[DEBUG] redirectWithProvider request success");
        _success(data, request);
        
    } error:^(NSError *error) {
        NSLog(@"[DEBUG] redirectWithProvider request error");
        _error(error);
        
    }];
    
    [request release];
}

@end
