//
//  CrosshairsAppDelegate.m
//  Crosshairs
//
//  Created by Zach Waugh on 9/23/10.
//  Copyright 2010 zachwaugh.com. All rights reserved.
//

#import "CHAppDelegate.h"
#import "DDHotKeyCenter.h"
#import "CHPreferencesController.h"
#import "CHView.h"

@interface CHAppDelegate ()

- (void)checkForBetaExpiration;
- (void)createStatusItem;

@end


@implementation CHAppDelegate

@synthesize window, view, statusItem, statusMenu;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[self checkForBetaExpiration];
	
	NSRect windowRect = NSZeroRect;
	
	for (NSScreen *screen in [NSScreen screens])
	{
		windowRect = NSUnionRect([screen frame], windowRect);
	}
	
	[self.window setFrame:windowRect display:YES animate:NO];
	
	DDHotKeyCenter *hotKeyCenter = [[[DDHotKeyCenter alloc] init] autorelease];
	[hotKeyCenter registerHotKeyWithKeyCode:19 modifierFlags:(NSShiftKeyMask | NSCommandKeyMask) target:self action:@selector(hotkeyWithEvent:) object:nil];
	
	[self createStatusItem];
	[self activateApp:nil];
}


- (void)dealloc
{
	[[NSStatusBar systemStatusBar] removeStatusItem:self.statusItem];
	self.statusItem = nil;
	self.statusMenu = nil;
	
	[super dealloc];
}


- (void)checkForBetaExpiration
{
	NSDate *expiration = [NSDate dateWithNaturalLanguageString:@"2010-11-01 23:59:00"];
	
	if ([expiration earlierDate:[NSDate date]] == expiration)
	{
		NSLog(@"Beta has expired!");
		NSAlert *alert = [NSAlert alertWithMessageText:@"I'm sorry, this beta version has expired. Please download a new version" defaultButton:@"Ok" alternateButton:nil otherButton:nil informativeTextWithFormat:@""];
		[alert runModal];
		[NSApp terminate:nil];
	}
}


- (void)createStatusItem
{
	// Build the statusbar menu
	self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
	[self.statusItem setImage:[NSImage imageNamed:@"crosshairs_menu_off.png"]];
	[self.statusItem setAlternateImage:[NSImage imageNamed:@"crosshairs_menu_on.png"]];
	[self.statusItem setHighlightMode:YES];
	[self.statusItem setMenu:self.statusMenu];
}


- (void)hotkeyWithEvent:(NSEvent *)event
{
	[NSApp activateIgnoringOtherApps:YES];
	[self.window makeKeyAndOrderFront:nil];
}


- (void)activateApp:(id)sender
{
	[NSApp activateIgnoringOtherApps:YES];
	[self.window makeKeyAndOrderFront:nil];
}


- (void)openWebsite:(id)sender
{
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://zachwaugh.com/crosshairs?ref=app"]];
}


- (void)showPreferences:(id)sender
{
	CHPreferencesController *preferencesController = [[[CHPreferencesController alloc] initWithWindowNibName:@"CHPreferencesController"] autorelease];
	[preferencesController showWindow:sender];
}

@end
