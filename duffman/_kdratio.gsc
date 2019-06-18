/*===================================================================||
||/|¯¯¯¯¯¯¯\///|¯¯|/////|¯¯|//|¯¯¯¯¯¯¯¯¯|//|¯¯¯¯¯¯¯¯¯|//\¯¯\/////¯¯//||
||/|  |//\  \//|  |/////|  |//|  |/////////|  |//////////\  \///  ///||
||/|  |///\  \/|  |/////|  |//|  |/////////|  |///////////\  \/  ////||
||/|  |///|  |/|  |/////|  |//|   _____|///|   _____|//////\    /////||
||/|  |////  //|  \/////|  |//|  |/////////|  |/////////////|  |/////||
||/|  |///  ////\  \////  ////|  |/////////|  |/////////////|  |/////||
||/|______ //////\_______/////|__|/////////|__|/////////////|__|/////||
||===================================================================||
||     DO NOT USE, SHARE OR MODIFY THIS FILE WITHOUT PERMISSION      ||
||===================================================================*/

#include duffman\_common;


init()
{

	addConnectThread(::initStats,"once");
	addConnectThread(::ShowKDRatio);
	wait .05;
	for(;;wait 1)
	{
		if( game["state"] == "playing") continue;
		players = getAllPlayers();
		for(i=0;i<players.size;i++)
		{
			if(isDefined(players[i]))
			{
				if(isDefined(players[i].mc_kdratio))
					players[i].mc_kdratio thread FadeOut(1);
				if(isDefined(players[i].mc_accuracy))
					players[i].mc_accuracy thread FadeOut(1);
				if(isDefined(players[i].mc_streak))
					players[i].mc_streak thread FadeOut(1);
				if(isDefined(players[i].mc_kc))
					players[i].mc_kc thread FadeOut(1);
			}
		}				
	}
}

initStats() {
	self.pers["shoots"] = 1;
	self.pers["hits"] = 1;
	if(!isDefined(self.pers["gottags"]))
		self.pers["gottags"] = 0;
}

ShowKDRatio()
{
	self notify( "new_KDRRatio" );
	self endon( "new_KDRRatio" );
	self endon( "disconnect" );
	
	wait 1;
	if( IsDefined( self.mc_kdratio ) )	self.mc_kdratio Destroy();
	if( IsDefined( self.mc_accuracy ) )	self.mc_accuracy Destroy();
	if( IsDefined( self.mc_streak ) )	self.mc_streak Destroy();
	if( IsDefined( self.mc_kc ) )	self.mc_kc Destroy();
	
	
	self.mc_streak = NewClientHudElem(self);
	self.mc_streak.x = 110;
	self.mc_streak.y = -465;
	self.mc_streak.horzAlign = "left";
	self.mc_streak.vertAlign = "bottom";
	self.mc_streak.alignX = "left";
	self.mc_streak.alignY = "middle";
	self.mc_streak.alpha = 0;
	self.mc_streak.fontScale = 1.4;
	self.mc_streak.hidewheninmenu = true;
	self.mc_streak.label = &"^2Killstreak:^1 &&1";
	self.mc_streak FadeOverTime(.5);
	self.mc_streak.alpha = 1;
	self.mc_streak.glowcolor = (0.3, 0.3, 0.3);
	self.mc_streak.glowalpha = 1;
	
	self.mc_kdratio = NewClientHudElem(self);
	self.mc_kdratio.x = 110;
	self.mc_kdratio.y = -453;
	self.mc_kdratio.horzAlign = "left";
	self.mc_kdratio.vertAlign = "bottom";
	self.mc_kdratio.alignX = "left";
	self.mc_kdratio.alignY = "middle";
	self.mc_kdratio.alpha = 0;
	self.mc_kdratio.fontScale = 1.4;
	self.mc_kdratio.hidewheninmenu = true;
	self.mc_kdratio.label = &"^2K/D Ratio:^1 &&1";
	self.mc_kdratio FadeOverTime(.5);
	self.mc_kdratio.alpha = 1;
	self.mc_kdratio.glowcolor = (0.3, 0.3, 0.3);
	self.mc_kdratio.glowalpha = 1;
	
	self.mc_accuracy = NewClientHudElem(self);
	self.mc_accuracy.x = 110;
	self.mc_accuracy.y = -441;
	self.mc_accuracy.horzAlign = "left";
	self.mc_accuracy.vertAlign = "bottom";
	self.mc_accuracy.alignX = "left";
	self.mc_accuracy.alignY = "middle";
	self.mc_accuracy.alpha = 0;
	self.mc_accuracy.fontScale = 1.4;
	self.mc_accuracy.hidewheninmenu = true;
	//self.mc_accuracy.label = &"^2Accuracy: &&1";
	self.mc_accuracy.label = self getLangString("ACCURACY"); //level.lang["DEU"]["ACCURACY"];
	self.mc_accuracy FadeOverTime(.5);
	self.mc_accuracy.alpha = 1;
	self.mc_accuracy.glowcolor = (0.3, 0.3, 0.3);
	self.mc_accuracy.glowalpha = 1;
	
	if(level.gametype == "kc")
	{
		self.mc_kc = NewClientHudElem(self);
		self.mc_kc.x = 110;
		self.mc_kc.y = -428;
		self.mc_kc.horzAlign = "left";
		self.mc_kc.vertAlign = "bottom";
		self.mc_kc.alignX = "left";
		self.mc_kc.alignY = "middle";
		self.mc_kc.alpha = 0;
		self.mc_kc.fontScale = 1.4;
		self.mc_kc.hidewheninmenu = true;
		self.mc_kc.label = &"^2Kill confirms:^1 &&1";
		self.mc_kc FadeOverTime(.5);
		self.mc_kc.alpha = 1;
		self.mc_kc.glowcolor = (0.3, 0.3, 0.3);
		self.mc_kc.glowalpha = 1;
	}
	
	color = (0,0,0);
	first = true;
	for(;;)
	{
		if(first)
			first = 0;
		else 
			wait .5;//** let the code time till he MAY kill someone	
		if(!isDefined(self) || !isDefined(self.pers) || !isDefined(self.pers[ "hits" ]) || !isDefined(self.pers[ "kills" ]) || !isDefined(self.pers[ "deaths" ]) || !isDefined(self.pers[ "shoots" ]) || !isDefined(self.mc_kdratio) || !isDefined(self.mc_accuracy) || !isDefined(self.mc_streak))
			return;	
		if( IsDefined( self.pers[ "kills" ] ) && IsDefined( self.pers[ "deaths" ] ) )
		{
			if( self.pers[ "deaths" ] < 1 ) ratio = self.pers[ "kills" ];
			else ratio = int( self.pers[ "kills" ] / self.pers[ "deaths" ] * 100 ) / 100;
			if(ratio < 1) color = (1,ratio / 2,0);
			else if(ratio > 1) color = (1.7 - ratio,1,0);
			else color = (1,1,0);				
			self.mc_kdratio FadeOverTime(.5);
			self.mc_kdratio.color = color;
			self.mc_kdratio setValue(ratio);
		}
		acu = int(self.pers[ "hits" ] / self.pers[ "shoots" ] * 10000)/100;
		self.mc_accuracy FadeOverTime(.5);
		if(acu < 10.00) color1 = (0.9, 0.3, 0.0);
			else color1 = (0, 1.0, 0);
		self.mc_accuracy.color = color1;
		if(isDefined(acu)) self.mc_accuracy SetValue( acu );
		else self.mc_accuracy setValue( 100 );
		if(isdefined(self.cur_kill_streak)) self.mc_streak setValue(self.cur_kill_streak);
		else self.mc_streak setValue(0);
		if(level.gametype == "kc")
			self.mc_kc setValue( self.pers["gottags"] );
		self common_scripts\utility::waittill_any("disconnect","death","weapon_fired","weapon_change","player_killed");
	}
}