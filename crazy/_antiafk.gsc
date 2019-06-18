#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init()
{	
	[[level.on]]( "spawned", ::AFKMonitor );
}

AFKMonitor()
{
    self endon("disconnect");
	self endon("joined_spectators");
    self endon("game_ended");
	level endon ("vote started");
	self endon ("isKnifing");
	self endon ( "inintro" );
	hmmmmm = 0;
	while(isAlive(self))
	{
		ori = self.origin;
		angles = self.angles;
		wait 1;
		if(isAlive(self) && self.sessionteam != "spectator")
		{
			if(self.origin == ori && angles == self.angles)
			{
				hmmmmm++;
			}
			else
			{
				hmmmmm = 0;
			}
			if(hmmmmm == 20)
			{
				self iPrintlnBOld("^3You ^3Appear To Be ^1AFK!");
			}
			if(hmmmmm >= 30)
			{
				self.sessionteam = "spectator";
				self.sessionstate = "spectator";
				self [[level.spawnSpectator]]();
				self notify("sdfsdfdsf");
				iPrintln("^2" +self.name + " ^3Appears To Be ^1AFK!");
				return;
			}
		}
		else	
		{
			hmmmmm = 0;
		}
	}
}