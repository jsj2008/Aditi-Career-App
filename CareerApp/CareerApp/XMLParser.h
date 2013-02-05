//
//  XMLParser.h
//  XML
//
//  Created by iPhone SDK Articles on 11/23/08.
//  Copyright 2008 www.iPhoneSDKArticles.com.
//

#import <UIKit/UIKit.h>

@class ACAppDelegate, CurrentOpenings;

@interface XMLParser : NSObject<NSXMLParserDelegate> {

	NSMutableString *currentElementValue;
	
	ACAppDelegate *appDelegate;
	CurrentOpenings *aCurrentOpenings; 
}

- (XMLParser *) initXMLParser;

@end
