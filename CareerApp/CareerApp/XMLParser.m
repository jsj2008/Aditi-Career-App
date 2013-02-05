//
//  XMLParser.m
//  XML
//
//  Created by iPhone SDK Articles on 11/23/08.
//  Copyright 2008 www.iPhoneSDKArticles.com.
//

#import "XMLParser.h"
#import "CurrentOpenings.h"
#import "ACAppDelegate.h"


@implementation XMLParser

- (XMLParser *) initXMLParser {
	
	[super init];
	
	appDelegate = (ACAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	return self;            
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName 
	attributes:(NSDictionary *)attributeDict {
	
	if([elementName isEqualToString:@"GetCurrentJobOpeningsResponse"]) {
		//Initialize the array.
        
		appDelegate.currentopeningsArry = [[NSMutableArray alloc] init];
	}
	else if([elementName isEqualToString:@"a:Job"]) {
		
		
		aCurrentOpenings = [[CurrentOpenings alloc] init];
	
	}else if([elementName isEqualToString:@"a:JobCode"]) {
		
		
		//aCurrentOpenings = [[CurrentOpenings alloc] init];
        
	}else if([elementName isEqualToString:@"a:JobExperience"]) {
		
		
		//aCurrentOpenings = [[CurrentOpenings alloc] init];
        
	}else if([elementName isEqualToString:@"a:JobId"]) {
		
		
		//aCurrentOpenings = [[CurrentOpenings alloc] init];
        
	}else if([elementName isEqualToString:@"a:JobLocation"]) {
		
		
		//aCurrentOpenings = [[CurrentOpenings alloc] init];
        
	}else if([elementName isEqualToString:@"a:JobShortDescription"]) {
		
		
		//aCurrentOpenings = [[CurrentOpenings alloc] init];
        
	}else if([elementName isEqualToString:@"a:JobTitle"]) {
		
		
		//aCurrentOpenings = [[CurrentOpenings alloc] init];
        
	}
	
	NSLog(@"Processing Element: %@", elementName);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string { 
	
	if(!currentElementValue) 
		currentElementValue = [[NSMutableString alloc] initWithString:string];
	else
		[currentElementValue appendString:string];
	
	NSLog(@"Processing Value: %@", currentElementValue);
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	
	
	//There is nothing to do if we encounter the Books element here.
	//If we encounter the Book element howevere, we want to add the book object to the array
	// and release the object.
	if([elementName isEqualToString:@"a:Job"]) {
		[appDelegate.currentopeningsArry addObject:aCurrentOpenings];
        
       
        NSLog(@"titl: %@",aCurrentOpenings._JobTitle);
        NSLog(@"DISCRIPTION111 : %@",aCurrentOpenings._JobShortDescription);
		
		[aCurrentOpenings release];
		aCurrentOpenings = nil;
	}if([elementName isEqualToString:@"a:JobCode"]) {
		
        //[aCurrentOpenings set_JobCode:currentElementValue];
        aCurrentOpenings._JobCode=currentElementValue;
        
        
        
        
	}if([elementName isEqualToString:@"a:JobExperience"]) {
		
        aCurrentOpenings._JobExperience=currentElementValue;
        
        
	}if([elementName isEqualToString:@"a:JobId"]) {
		
        aCurrentOpenings._JobId=currentElementValue;
        
        
	}if([elementName isEqualToString:@"a:JobLocation"]) {
		
       aCurrentOpenings._JobLocation=currentElementValue;
        
        
	}if([elementName isEqualToString:@"a:JobTitle"]) {
		
        aCurrentOpenings._JobTitle=currentElementValue;
        
          
        
	}if([elementName isEqualToString:@"a:JobShortDescription"]) {
		
        aCurrentOpenings._JobShortDescription=currentElementValue;
        
        
        
	}
	
	
	[currentElementValue release];
	currentElementValue = nil;
}

- (void) dealloc {
	
	[aCurrentOpenings release];
	[currentElementValue release];
	[super dealloc];
}

@end
