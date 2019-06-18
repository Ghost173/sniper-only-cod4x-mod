//******************************************************************************
//  _____                  _    _             __
// |  _  |                | |  | |           / _|
// | | | |_ __   ___ _ __ | |  | | __ _ _ __| |_ __ _ _ __ ___
// | | | | '_ \ / _ \ '_ \| |/\| |/ _` | '__|  _/ _` | '__/ _ \
// \ \_/ / |_) |  __/ | | \  /\  / (_| | |  | || (_| | | |  __/
//  \___/| .__/ \___|_| |_|\/  \/ \__,_|_|  |_| \__,_|_|  \___|
//       | |               We don't make the game you play.
//       |_|                 We make the game you play BETTER.
//
//            Website: http://openwarfaremod.com/
//******************************************************************************

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;


monitorTimeOuts()
{
	level endon("game_ended");
	
	for (;;)
	{
		wait (0.05);
		// Check if we are in timeout mode
		if ( level.inTimeoutPeriod )
			level.timerDiscard += 50;
	}	
}

getTimePassed()
{
	if ( level.inReadyUpPeriod ) {
		return gettime();
	} else if ( !isDefined( level.timerStart ) ) {
		return 0;
	} else {
		return ( gettime() - level.timerStart - level.timerDiscard );	
	}
}

giveActionSlot4AfterDelay( hardpointType, streak )
{
	self notify("giveActionSlot4AfterDelay");
	wait (0.05);
	
	self endon("disconnect");
	self endon("death");
	self endon("giveActionSlot4AfterDelay");

	// Check what kind of delay we should be using
	if ( !isDefined( streak ) ) {
		switch ( hardpointType )
		{
			case "airstrike_mp":
				timeToUse = level.scr_airstrike_delay * 1000;
				break;
			case "helicopter_mp":
				timeToUse = level.scr_helicopter_delay * 1000;
				break;
			default:
				timeToUse = 0;
		}
	
		if ( timeToUse > 0 ) {
			playSound = true;
	
			while ( timeToUse > openwarfare\_timer::getTimePassed() )
				wait (0.05);
		}
	}

	if ( isDefined( self ) ) {
		// Assign the weapon slot 4
		self giveWeapon( hardpointType );
		self giveMaxAmmo( hardpointType );
		self setActionSlot( 4, "weapon", hardpointType );
		self.pers["hardPointItem"] = hardpointType;
		
		// Check if we should remind the player about having the hardpoint
		if ( level.scr_hardpoint_show_reminder != 0 ) {
			self thread maps\mp\gametypes\_hardpoints::hardpointReminder( hardpointType );
		}
	
		// Show the message
		if ( isDefined( streak ) || level.scr_hardpoint_show_reminder != 0 ) {
			self thread maps\mp\gametypes\_hardpoints::hardpointNotify( hardpointType, streak );
		}
	}

	return;
}


// Trims left spaces from a string
trimLeft( stringToTrim )
{
	stringIdx = 0;
	while ( stringToTrim[ stringIdx ] == " " && stringIdx < stringToTrim.size )
		stringIdx++;

	newString = getSubStr( stringToTrim, stringIdx, stringToTrim.size - stringIdx );

	return newString;
}


// Trims right spaces from a string
trimRight( stringToTrim )
{
	stringIdx = stringToTrim.size;
	while ( stringToTrim[ stringIdx ] == " " && stringIdx > 0 )
		stringIdx--;

	newString = getSubStr( stringToTrim, 0, stringIdx );

	return newString;

}


// Trims all the spaces left and right from a string
trim( stringToTrim )
{
	return ( trimLeft( trimRight ( stringToTrim ) ) );
}

xWait( timeToWait )
{
	finishWait = openwarfare\_timer::getTimePassed() + timeToWait * 1000;

	while ( finishWait > openwarfare\_timer::getTimePassed() )
		wait (0.05);

	return;
}