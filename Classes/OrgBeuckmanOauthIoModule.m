/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "OrgBeuckmanOauthIoModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation OrgBeuckmanOauthIoModule


#pragma Public APIs

-(id)initWithKey:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args, NSDictionary);

    NSString *publicKey = [TiUtils stringValue:[args objectForKey:@"publicKey"]];
    NSLog(@"[INFO] initWithKey %@", publicKey);
    
    [publicKey retain];
    
    _oauthioModal = [[OAuthIOModal alloc] initWithKey:publicKey delegate:self];
    
    return nil;
}

-(id)connect:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args, NSDictionary);

    NSString *provider = [TiUtils stringValue:[args objectForKey:@"provider"]];
    [provider retain];
    currentProvider = provider;
    
    [_oauthioModal showWithProvider:provider];
    
    return nil;
}

-(id)customUrlEntry:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    NSString *url = [TiUtils stringValue:[args objectForKey:@"url"]];
    
    [OAuthIOModal handleOAuthIOResponse:[NSURL URLWithString:url]];
    
    return nil;
}


- (void)oauthDismissed:(NSURL *)url
{
    [OAuthIOModal handleOAuthIOResponse:url];
}



-(id)exampleProp
{
	// example property getter
	return @"hello world";
}

-(void)setExampleProp:(id)value
{
	// example property setter
}


#pragma mark OAuthIO delegate methods

- (void)didReceiveOAuthIOResponse:(NSDictionary *)result
{
    NSLog(@"[INFO] RESULT:\n-------\n%@\n", result);

    NSMutableDictionary *event = [NSMutableDictionary dictionaryWithDictionary:result];
    [event setObject:currentProvider forKey:@"provider"];
    
    [self fireEvent:@"auth" withObject:event];
}

- (void)didFailWithOAuthIOError:(NSError *)error
{
    NSLog(@"[DEBUG] ERROR--------\n%@\n", error.description);
    
    NSMutableDictionary *report = [NSMutableDictionary dictionaryWithObjectsAndKeys:error.description, @"description", nil];
                                   
    [self fireEvent:@"error" withObject:report];

    [report autorelease];
}



#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"82bab9ff-9dca-4a76-ab03-2bb06f68d2ec";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"org.beuckman.oauth.io";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

@end
