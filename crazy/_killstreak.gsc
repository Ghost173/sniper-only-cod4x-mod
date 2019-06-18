#include maps\mp\gametypes\_hud_util;
#include maps\mp\_utility;
#include common_scripts\utility;
#include braxi\_common;
#include openwarfare\_eventmanager;

init()
{
    precacheItem( "radar_mp" );
	precacheItem( "airstrike_mp" );
	precacheItem( "helicopter_mp" );
	precacheItem( "artillery_mp" );	
	
	makeDvarServerInfo( "ui_uav_allies", 0 );
	makeDvarServerInfo( "ui_uav_axis", 0 );
	setDvar( "ui_uav_allies", 0 );
	setDvar( "ui_uav_axis", 0 );
	setDvar( "ui_uav_client", 0 );
	
	level.hardpointItems = [];
	priority = 0;
	level.hardpointItems["radar_mp"] = priority;
	priority++;
	level.hardpointItems["airstrike_mp"] = priority;
	priority++;
	level.hardpointItems["helicopter_mp"] = priority;
	priority++;
	precacheLocationSelector( "map_artillery_selector" );

	level.airstrikefx = loadfx ("explosions/clusterbomb");
	level.mortareffect = loadfx ("explosions/artilleryExp_dirt_brown");
	level.bombstrike = loadfx ("explosions/wall_explosion_pm_a");
	
	level.fx_airstrike_afterburner = loadfx ("fire/jet_afterburner");
	level.fx_airstrike_contrail = loadfx ("smoke/jet_contrail");
	
	level.fx_heli_dust = loadfx ("treadfx/heli_dust_default");
	level.fx_heli_water = loadfx ("treadfx/heli_water");
	level.artilleryDangerMaxRadius = 450;
	level.artilleryDangerMinRadius = 300;
	level.artilleryDangerForwardPush = 1.5;
	level.artilleryDangerOvalScale = 6.0;
	
	level.artilleryMapRange = level.artilleryDangerMinRadius * .3 + level.artilleryDangerMaxRadius * .7;
	
	level.artilleryDangerMaxRadiusSq = level.artilleryDangerMaxRadius * level.artilleryDangerMaxRadius;
	
	level.artilleryDangerCenters = [];
	
	level.radarViewTime = 30; // time radar remains active

	level.numHardpointReservedObjectives = 0;
	precacheShader("hud_suitcase_bomb");
	precachemodel ( "com_plasticcase_beige_big" );
	precacheItem("artillery_mp");
	precacheModel("projectile_cbu97_clusterbomb");
	precacheModel("vehicle_80s_sedan1_green_destructible_mp");
	precacheModel("vehicle_mig29_desert");
	precacheModel("vehicle_mi24p_hind_desert");
	precacheModel("vehicle_cobra_helicopter_fly");
	level.fx[0]=loadfx("fire/fire_smoke_trail_m");
	level.fx[1]=loadfx("fire/tank_fire_engine");
	level.fx[2]=loadfx("smoke/smoke_trail_black_heli");
	level.chopper_fx["explode"]["medium"] = loadfx("explosions/aerial_explosion");
	level.chopper_fx["fire"]["trail"]["medium"] = loadfx ("smoke/smoke_trail_black_heli");
	level.chopper_fx["explode"]["large"] = loadfx ("explosions/aerial_explosion_large");		
	level.nukecalled = false;
	level.napalm = false;
	level.bombing = false;  
	level.artilleryDangerMaxRadius = 100;
	level.cancallnuke = false;

	level thread onPlayerConnect();
}

onPlayerConnect()
{
	for( ;; )
	{
		level waittill( "connecting", player );
		player thread onSpawnPlayer();
		
	}
}

onSpawnPlayer()
{
	self endon ( "disconnect" );
	while( 1 )
	{
		self waittill( "spawned_player" );
		self notify("endthisbs");
		self thread Streak_Launcher();
		self thread doKillstreaks();
	}
}
 
doKillstreaks()  
{
        self endon ("death");
		 self endon ("endthisbs");
		self endon("disconnect");
 
        self.startscore = self.pers["kills"];
       
    while(1)
	{
		if(self.killcount != self.pers["kills"] - self.startscore)
		{
            self.killcount = self.pers["kills"] - self.startscore;
            switch(self.killcount)
			{
				case 3:
					self notify("newstreak");
					self thread kills3();
						break;
				case 7:
					self notify("newstreak");
					self thread kills7();
						break;
				case 10:
					self notify("newstreak");
					self thread kills10();
						break;
				
				case 12:
					self notify("newstreak");
					self thread kills12();
						break;
				
				case 16:
					self notify("newstreak");
					self thread kills16();
						break;
				case 20:
					self notify("newstreak");
					self thread kills20();
						break;
			}
		}
		wait 0.05;
	}
}
 
kills3()
{
	playSoundOnPlayers("killingspree");
	
	iPrintlnBold("^2" + self.name +" ^7 has a killstreak of ^13");
	iPrintln("^2" + self.name +" ^7 has a killstreak of ^13");
	self.maxhealth=200;
	self.health = self.maxhealth;
		wait 0.5;
	self iPrintlnBold("^1Extra Health For 30secs");
		wait 30;
	self.maxhealth=100;
	self.health = self.maxhealth;
	self iPrintlnBold("^1Extra Health Ended");
}
 
kills7()
{
	playSoundOnPlayers("unstoppable");
	
	iPrintlnBold("^2" + self.name +" ^7 has a killstreak of ^17");
	iPrintln("^2" + self.name +" ^7 has a killstreak of ^17");
	self iPrintlnbold("^1You earned a ^3Kamikaze Bomber. Press ^3[[{+actionslot 4}]^3]^7 to use it.");
	self giveweapon("radar_mp");
	self SetActionSlot( 4, "weapon","radar_mp" );
}

kills10()
{
	playSoundOnPlayers("dominating");
	
	iPrintlnBold("^2" + self.name +" ^7 has a killstreak of ^110");
	iPrintln("^2" + self.name +" ^7 has a killstreak of ^110");
	self iPrintlnbold( "^2You Earned SPEED For 20secs" );
	self iPrintln( "^2Speed For 20secs" );
	self SetMoveSpeedScale( 1.8 );
	self.maxhealth = 100;
	self.health = self.maxhealth;
	wait 20;
	self iPrintlnbold( "^1Speed Ended" );
	self SetMoveSpeedScale( 1.2 );
	self.maxhealth = 100;
	self.health = self.maxhealth;
}

kills12()
{
playSoundOnPlayers("godlike");
iPrintlnBold("^2" + self.name +" ^7 has a killstreak of ^112");
self iPrintlnbold("^1You earned a ^3Kamikaze Bomber. Press ^3[[{+actionslot 4}]^3]^7 to use it.");
self giveweapon("radar_mp");
self SetActionSlot( 4, "weapon","radar_mp" );
self iPrintlnbold("^1Use in 20 sec. you got 2 strikes.^3^^");
wait 25;
self iPrintlnbold("^1You earned a ^3Kamikaze Bomber. Press ^3[[{+actionslot 4}]^3]^7 to use it.");
self giveweapon("radar_mp");
self SetActionSlot( 4, "weapon","radar_mp" );
}
	
kills16()
{
	playSoundOnPlayers("holyshit");
	wait 0.3;
	iPrintlnBold("^2" + self.name +" ^7 has a killstreak of ^114");
	iPrintln("^2" + self.name +" ^7 has a killstreak of ^114");
	self iPrintlnbold( "^2You Are invisible For 20Sec" );
	self thread vip\burn::burning();
	self.hideOn = 1;
	self.newhide.origin = self.origin;
	self.dvar [ "afk_time"] = 40;
	self hide();
	self linkto(self.newhide);
	wait 20;
	self iPrintlnbold( "^1Invisible Ended" );
	self.hideOn = 0;
	self show();
	self unlink();
	
}

kills20()
{
	playSoundOnPlayers("rampage");
	
	self thread Nuke_Launch();
	iPrintlnBold("^2" + self.name +" ^2 HAS A KILLSTREAK OF ^120");
	iPrintln("^2" + self.name +" ^2 HAS A KILLSTREAK OF ^120");
	wait 03;
	iPrintln("^2" + self.name +" ^2 Has A Nuke");
	iPrintlnBold("^2" + self.name +" ^2 Has A Nuke");
	self thread vip\burn::burning();
}

HeliFlyIn(ori)
{
	level.flyin = spawn("script_model",(ori[0],20000,5000));
	level.flyin setModel("vehicle_cobra_helicopter_fly");
	level.flyin.angles = (10, 270, 0);
	level.flyin playloopsound("mp_hind_helicopter");
	level.nukelauncher2 = spawn( "script_model", (ori[0],20000,4800) );
	level.nukelauncher2 setModel( "com_plasticcase_beige_big" );
	level.nukelauncher2.angles = (0, 270, 0);
	
	wait .05;
	
	level.flyin MoveTo((ori[0],ori[1],5000),10);
	level.nukelauncher2 MoveTo((ori[0],ori[1],4800),10);
	level.nukelauncher2 waittill("movedone");
	level.flyin MoveTo((0,-20000,5000),10);
	level.nukelauncher2 MoveTo((ori),2);
	wait 11;
	level.flyin stoploopsound("mp_hind_helicopter");
	level.flyin delete();
}

Streak_Launcher()
{
	self endon("disconnect");
	self endon ("endthisbs");
	self endon("death");
	wait 1;
	for(;;)
	{
		self.curweap2 = self getCurrentWeapon();
				
		self waittill("weapon_change");
			
		if(self getCurrentWeapon() == "radar_mp")
		{
			thread KamikazeBomber(self);
			wait 1;
			self TakeWeapon( "radar_mp");
			wait 0.1;
			if(self.curweap2 != "none")
				self switchToWeapon( self.curweap2 );
		}
		wait .05;
	}
}

KamikazeBomber(player) 
{ 
	wait 1;
	while(isDefined(level.kamikazeinuse) && level.kamikazeinuse)
		wait .05;
		
	level.kamikazeinuse = true;	
	location = (0, 0, player.origin[2]);
	loc = undefined;
	random = randomint(4);
	switch(getDvar("mapname"))
	{
	case "mp_crossfire":
		switch(random)
		{
			case 0:
				loc = (4610, -1241, 82);
				break;
			case 1:
				loc = (5378, -1684, 74);
				break;	
			case 2:
				loc = (4647, -3022, -52);
				break;
			case 3:
				loc = (5057, -2315, 42);
				break;
			default: loc = (0, 0, player.origin[2]);
		}
		break;
		
	case "mp_crash":
		switch(random)
		{
			case 0:
				loc = (331, 284, 203);
				break;
			case 1:
				loc = (54, -321, 196);
				break;	
			case 2:
				loc = (1063, -776, 131);
				break;
			case 3:
				loc = (1106, 867, 195);
				break;
			default: loc = (0, 0, player.origin[2]);
		}
		break;
		
	case "mp_backlot":
		switch(random)
		{
			case 0:
				loc = (-361, 1401, 124);
				break;
			case 1:
				loc = (-133, -41, 127);
				break;	
			case 2:
				loc = (-60, -916, 118);
				break;
			case 3:
				loc = (928, 6, 119);
				break;
			default: loc = (0, 0, player.origin[2]);
		}
		break;		
		
	case "mp_nuketown":
		switch(random)
		{
			case 0:
				loc = (159, 520, 83);
				break;
			case 1:
				loc = (429, -406, 83);
				break;	
			case 2:
				loc = (-1236, 337, 172);
				break;
			case 3:
				loc = (1529, 225, 156);
				break;
			default: loc = (0, 0, player.origin[2]);
		}
		break;	
		
	case "mp_strike":
		switch(random)
		{
			case 0:
				loc = (-1131, -226, 68);
				break;
			case 1:
				loc = (448, -56, 68);
				break;	
			case 2:
				loc = (-561, 710, 112);
				break;
			case 3:
				loc = (-372, 13, 107);
				break;
			default: loc = (0, 0, player.origin[2]);
		}
		break;	
		
	default: loc = (0, 0, player.origin[2]);
	}
	Kamikaze = spawn("script_model", (loc + ( 4400, 2950, 6000 ))); 
	Kamikaze setModel( "vehicle_mig29_desert" ); 
	Angles = vectorToAngles( loc - (player.origin+(8000,5000,10000))); 
	Kamikaze.angles = Angles; 

	Kamikaze moveto(loc, 2.5); 
	for(i=0;i<50;i++)
	{
		playfx(level.chopper_fx["fire"]["trail"]["medium"] ,(Kamikaze.origin  + ( 44, 29.5, 60 )));
		playfx(level.fx[0] ,(Kamikaze.origin  + ( 44, 29.5, 60 )));
		Kamikaze playloopsound("veh_mig29_dist_loop");
		wait .05;
	}
	Kamikaze stoploopsound("veh_mig29_dist_loop");
	Kamikaze moveto(loc-(0,0,5000), .1); 
	Kamikaze playSound( "exp_suitcase_bomb_main" ); 
	Kamikaze playSound( "exp_suitcase_bomb_main" ); 
	Kamikaze playSound( "exp_suitcase_bomb_main" ); 
	Kamikaze playSound( "exp_suitcase_bomb_main" ); 
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin); 
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(400,0,0)); 
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,400,0)); 
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(400,400,0)); 
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,0,400)); 
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin-(400,0,0)); 
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin-(0,400,0)); 
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin-(400,400,0)); 
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,0,800)); 
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(200,0,0)); 
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,200,0)); 
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(200,200,0)); 
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,0,200)); 
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin-(200,0,0)); 
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin-(0,200,0)); 
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin-(200,200,0)); 
	playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,0,200)); 
	Earthquake( 0.4, 4, Kamikaze.origin, 800 ); 
	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
	{
		if(isDefined(players[i]) && players[i] != player && players[i].sessionstate == "playing" )
		{
			if ( level.teamBased ) 
			{
				if(players[i].team != player.team)
				{	
					if( distance(Kamikaze.origin, players[i].origin) <= 700 )
						players[i] thread [[level.callbackPlayerDamage]](player,player,300,8,"MOD_RIFLE_BULLET","airstrike_mp",(0,0,0),(0,0,0),"torso_upper",0);
				}
			}
			else
			{
				if( distance(Kamikaze.origin, players[i].origin) <= 700 )
					players[i] thread [[level.callbackPlayerDamage]](player,player,300,8,"MOD_RIFLE_BULLET","airstrike_mp",(0,0,0),(0,0,0),"torso_upper",0);
			}
		}
	}
	wait .1;
	RadiusDamage( Kamikaze.origin, 1000, 1000, 1, player ); 
	Kamikaze delete(); 
	level.kamikazeinuse = false;	
}

Nuke_Launch()
{
	self endon("disconnect");
	level.nukelauncher = spawn( "script_model", (self.origin+(0,-10,0)) );
	level.nukelauncher setModel( "com_plasticcase_beige_big" );
	timer = 3;
	for(;;)
	{
		self maps\mp\_utility::clearLowerMessage();
		if(isdefined(level.nukelauncher) && distance(self.origin, level.nukelauncher.origin) <40 && !level.oitcrunning)
		{
			self maps\mp\_utility::setLowerMessage("^7Press ^3[[{+usereload}]] ^7to call a Nuke!");
			if(self usebuttonpressed() && self.sessionstate == "playing")
			{
				self DisableWeapons();
				self freezeControls( true );
				self.entschaerfen = self maps\mp\gametypes\_hud_util::createBar((1,1,1), 128, 8);
				self.entschaerfen maps\mp\gametypes\_hud_util::setPoint("CENTER", 0, 0, 0);
				self.entschaerfen maps\mp\gametypes\_hud_util::updateBar(0, 1/timer );
				for(i=0;i<61;i++)
				{
					if(!self UseButtonPressed() || self.sessionstate != "playing")
					{
						if(isDefined(self.entschaerfen))
							self.entschaerfen maps\mp\gametypes\_hud_util::destroyElem();	
						self EnableWeapons();
						self freezeControls( false );
						i = 100;
					}
					wait .05;
					if(i == 60)
					{
						if(!level.nukecalled)
						{
							thread nuke(level.nukelauncher.origin,self,true);
							if(isdefined(level.nukelauncher))
							level.nukelauncher delete();
							level.nukecalled = true;
						}
						if(isDefined(self.entschaerfen))
							self.entschaerfen maps\mp\gametypes\_hud_util::destroyElem();	
						self EnableWeapons();
						self freezeControls( false );
						self maps\mp\_utility::clearLowerMessage();
						return;
					}
				}
			}
		}
		wait .05;
	}
							if(isDefined(self.entschaerfen))
							self.entschaerfen maps\mp\gametypes\_hud_util::destroyElem();	
}

BlurFade(time,ammout,startblur)
{	
	self endon("disconnect");
	if(!isDefined(time) || !isDefined(ammout) )	return;
	if(ammout <= startblur) add = false;
	else add = true;
	milisecs = time * 20;
	add2blur = ammout / 20;
	for(i=0;i<milisecs;i++)
	{
		if(add)
			startblur += add2blur;
		else
			startblur -= add2blur;			
		self setClientDvar("r_blur", startblur);
		wait .05;
	}

}

Nuke(ori,owner,endround)
{
	while(isDefined(level.nukeinuse) && level.nukeinuse)
		wait .05;
		
	level.nukeinuse = true;
	thread NukeTimer();
	wait 11;
	self setClientDvar("r_fog", "1");
	SetExpFog(9999999, 999999994, 1, 1, 1, 2);
	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
	{
		players[i] thread BlurFade(2,.7,0);
	}
	setdvar("timescale", ".9");
	wait 0.4;
	SetExpFog(256, 512, 1, 0, 0, 2);
	setdvar("timescale", ".8");
	wait 0.4;
	setdvar("timescale", ".7");
	VisionSetNaked( "cargoship_blast", 2 );
	wait 0.4;
	Earthquake( 0.8, 5, owner.origin, 999999 );
	setdvar("timescale", ".6");
	wait 0.4;
	playSoundOnAllPlayers( "nuke_detonate" );
	playSoundOnAllPlayers( "nuke_aftermath" );
	wait 6;
	playSoundOnAllPlayers( "geiger" );
	owner suicide();
	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
	{
		if(isDefined(players[i]) && players[i] != owner && players[i].sessionstate == "playing" )
			players[i] thread [[level.callbackPlayerDamage]](owner,owner,2147483647,8,"MOD_RIFLE_BULLET",owner getCurrentWeapon(),(0,0,0),(0,0,0),"torso_upper",0);
	}
	wait .1;
	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
	{	
		if(isDefined(players[i]) && players[i].sessionstate == "playing")
			players[i] suicide();
	}
	
	playFx(level.chopper_fx["explode"]["medium"]);
	playFx(level.chopper_fx["explode"]["large"],ori);
	Earthquake( 0.8, 5, owner.origin, 999999 );
	wait 0.4;
	setdvar("timescale", ".6");
	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
	{
		players[i] thread BlurFade(1.5,0,.7);
	}
	wait 0.5;
	setdvar("timescale", ".7");
	wait 0.5;
	setdvar("timescale", ".8");
	wait 0.5; 
	if(isDefined(endround) && endround )
		thread maps\mp\gametypes\_globallogic::default_onTimeLimit();
	setdvar("timescale", ".9");
	//self setClientDvar ("r_filmusetweaks", "1");
	self setClientDvar("r_fog", "0");
	//self setClientDvar("r_blur", "0");
	visionSetNaked( getDvar( "mapname" ), 1 );
	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
		players[i] thread promod\client::use_config();
	
	wait 0.1;
	setdvar("timescale", "1");
	if(isDefined(endround) && endround)
	{
		players = getAllPlayers();
		for( i = 0; i < players.size; i++ )
		{
			players[i] freezecontrols(true);
		}
	}
		
	level.nukeinuse = false;
}

NukeTimer()
{
	level.nuke_icon = newHudElem();
    level.nuke_icon.foreground = true;
	level.nuke_icon.alignX = "left";
	level.nuke_icon.alignY = "top";
	level.nuke_icon.horzAlign = "left";
    level.nuke_icon.vertAlign = "top";
    level.nuke_icon.x = 115;
    level.nuke_icon.y = 20;
	level.nuke_icon.alpha = 0;
	level.nuke_icon.sort = 100;
 	level.nuke_icon.hidewheninmenu = true;
	level.nuke_icon.archived = false;
	level.nuke_icon setShader("hud_suitcase_bomb", 39, 39);
	level.nuke_icon FadeOverTime(.5);
	level.nuke_icon.alpha = 1;

	level.nuketimer = newHudElem();
    level.nuketimer.foreground = true;
	level.nuketimer.alignX = "left";
	level.nuketimer.alignY = "top";
	level.nuketimer.horzAlign = "left";
    level.nuketimer.vertAlign = "top";
    level.nuketimer.x = 115;
    level.nuketimer.y = 53;
    level.nuketimer.sort = 0;
	level.nuketimer.alpha = 0;
  	level.nuketimer.fontScale = 1.6;
	level.nuketimer.color = (1, .5, 0);
	level.nuketimer.font = "objective";
 	level.nuketimer.hidewheninmenu = true;
	level.nuketimer setTimer(10);
	level.nuketimer FadeOverTime(.5);
	level.nuketimer.alpha = 1;
	
	for(i=0;i<21;i++)
	{
		playSoundOnPlayers( "nuke_warning" );
	}
	wait 12;
	level.nuketimer FadeOverTime(1.0);
	level.nuketimer.alpha = 0;
	level.nuke_icon FadeOverTime(1.0);
	level.nuke_icon.alpha = 0;
	wait 1.0;
	level.nuketimer destroy();
	level.nuke_icon destroy();
}

RandomNuke()
{
	self endon("disconnect");
	ori = (0,9,9);
	wait 500; //500
	spawntime = randomInt(200);//200
	wait spawntime;
	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
	{
		if(isDefined(players[i]))
			ori = players[i].origin;
	}
	time = randomInt(100);//100
	wait time;
	
	if(isdefined(ori))
	{
		wait 10;
		level.cancallnuke = true;
	}
}

canSpawnNuke()
{
	self endon("disconnect");
	self endon("death");
	while(!level.cancallnuke)
		wait .05;
	timer = 3;
	for(;;)
	{
		self maps\mp\_utility::clearLowerMessage();
		if(isdefined(level.nukelauncher2) && distance(self.origin, level.nukelauncher2.origin) <40 && !level.oitcrunning)
		{
			self maps\mp\_utility::setLowerMessage("^7Press ^3[[{+usereload}]] ^7to call a Nuke!");
			if(self usebuttonpressed() && self.sessionstate != "dead" )
			{
				self DisableWeapons();
				self freezeControls( true );
				self.entschaerfen = self maps\mp\gametypes\_hud_util::createBar((1,1,1), 128, 8);
				self.entschaerfen maps\mp\gametypes\_hud_util::setPoint("CENTER", 0, 0, 0);
				self.entschaerfen maps\mp\gametypes\_hud_util::updateBar(0, 1/timer );
				
				for(i=0;i<61;i++)
				{
					if(!self UseButtonPressed() || self.sessionstate == "dead")
					{
						if(isDefined(self.entschaerfen))
							self.entschaerfen maps\mp\gametypes\_hud_util::destroyElem();	
						self EnableWeapons();
						self freezeControls( false );
						i = 100;
					}
					wait .05;
					if(i == 60 )
					{
						if(!level.nukecalled)
						{
							thread nuke(level.nukelauncher2.origin,self,true);
							level.nukelauncher2 delete();
							level.nukecalled = true;
						}
						if(isDefined(self.entschaerfen))
							self.entschaerfen maps\mp\gametypes\_hud_util::destroyElem();	
						self EnableWeapons();
						self freezeControls( false );
						self maps\mp\_utility::clearLowerMessage();
						return;
					}
				}
			}
		}
		wait .05;
	}
							if(isDefined(self.entschaerfen))
							self.entschaerfen maps\mp\gametypes\_hud_util::destroyElem();	
}
Gunner()
{

    if (getDvar("ChopperGunner") == "1") {
        i("Chopper Gunner Already in Use");

    }
    if (getDvar("ChopperGunner") == "0") {

        self thread doGunner();
    }
}

doGunner() {
    self endon("enter");
    setDvar("ChopperGunner", "1");
    self.gun = self getcurrentweapon();
    i("Chopper Gunner Ready");
    wait 2;
    i("Press [{+actionslot 4}] To Enter");
    self giveWeapon("briefcase_bomb_mp");
    self SetActionSlot(4, "");
    wait 0.1;
    self SetActionSlot(4, "weapon", "briefcase_bomb_mp");
    wait 0.1;
    for (;;) {
        if (self getcurrentweapon() == "briefcase_bomb_mp") {
            wait 0.3;
            self thread gunny();
        }
        wait 0.3;
    }
}


gunny() {
/*Chopper Gunner by x_DaftVader_x*/

    self notify("enter");
	
    team = self.pers["team"];
    otherTeam = level.otherTeam[team];
    wait 4;
    self.cs = createIcon("black", 1000, 1000);
    self.cs setPoint("CENTER", "CENTER");
    self.cs.alpha = 1.5;
    level.height = 860;
    if (isdefined(level.airstrikeHeightScale)) {
        level.height *= level.airstrikeHeightScale;
    }
    level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins, level.spawnMaxs);
    start = self.origin + (0, 0, level.height);
    self.ChopperGunner = true;
    self thread ChopperGunner(start);
}
ChopperGunner(start) {
    self allowAds(false);
    weapon = self getcurrentweapon();
    pos = self getOrigin();
    chopper = spawn("script_model", start);
    chopper setModel("vehicle_cobra_helicopter_fly");
    chopper notsolid();
    chopper setcontents(0);
    self thread GunnerFly(chopper, start);
    chopper playLoopSound("mp_hind_helicopter");
    self thread monitorfire();
	self thread monitordrop();
    self thread firegunner();
	self thread HeliGod();
	wait 0.1;
    self linkTo(chopper, "tag_player", (0, 0, 3), (0, 0, 0));
    self detachAll();
    self hide();
    wait 0.30;
    self.cs.alpha = 1.2;
    wait 0.3;
    self.cs.alpha = 1;
    wait 0.3;
    self.cs.alpha = 0.5;
    wait 0.3;
    self.cs destroy();
	self takeallweapons();
    self thread GunnerGun();
    wait 0.1;
    self thread EndGunner(chopper, weapon, pos);
}
GunnerGun() {
    self thread crosshairs(0, -35, 8, 2);
    self thread crosshairs(0, 35, 8, 2);
    self thread crosshairs(-29, 0, 2, 8);
    self thread crosshairs(29, 0, 2, 8);
    self thread crosshairs(-64, 0, 2, 9);
    self thread crosshairs(64, 0, 2, 9);
    self thread crosshairs(0, -65, 2, 65);
    self thread crosshairs(0, 65, 2, 65);
    self thread crosshairs(-65, 0, 65, 2);
    self thread crosshairs(65, 0, 65, 2);
}
EndGunner(chopper, weapon, pos) {
    self endon("death");
    self endon("disconnect");
    wait 60;
    self unlink();
    self allowAds(true);
    self show();
    chopper delete();
    self SetOrigin(pos);
    self freezeControls(false);
    self giveWeapon("ak74u_mp");
    self giveweapon("deserteaglegold_mp");
    wait 0.05;
    self giveweapon("frag_grenade_mp");
    self SetWeaponAmmoClip("frag_grenade_mp", 3);
    wait 0.1;
    self switchtoweapon("ak74u_mp");
    setDvar("ChopperGunner", "0");
    self thread HeliGodOff();
    self notify("die");
    self setModel("modelname"); 
}
monitorfire() {
    self endon("die");
    self endon("chopper_down");
    self endon("death");
	self endon("disconnect");
    for (;;)
	{
        if (self attackbuttonpressed()) self notify("fire");
        wait 0.1;
    }
}
monitordrop()
{
    self endon("die");
    self endon("death");
	self endon("disconnect");
    for (;;)
	{
        if (self usebuttonpressed()) self notify("drop");
        wait 0.1;
    }
}
FireGunner()
{
    self endon("die");
    self endon("death");
	self endon("disconnect");
    for (leech = 0; leech < 20; leech++)
	{
        self waittill("fire");
        location = GetCursorPos2();
        playFx(level.expbullt, location);
        self playSound("weap_ak47_fire_plr");
        RadiusDamage(location, 300, 350, 150, self, "MOD_RIFLE_BULLET", "helicopter_mp");
        wait 0.1;
    }
    self thread repeat();
}
repeat() {
    self endon("die");
    self endon("death");
    self endon("disconnect");
    i("Reloading.....");
    wait 1.5;
    self thread FireGunner();
}
crosshairs(x, y, width, height) {
    C = newClientHudElem(self);
    C.width = width;
    C.height = height;
    C.align = "CENTER";
    C.relative = "MIDDLE";
    C.children = [];
    C.sort = 3;
    C.alpha = 0.3;
    C setParent(level.uiParent);
    C setShader("white", width, height);
    C.hidden = false;
    C setPoint("CENTER", "MIDDLE", x, y);
    C thread destroyaftertime();
}
destroyaftertime() {
    wait 60;
    self destroy();
}
GunnerFly(chopper, start) {
    self endon("death");
    self endon("disconnect");
    self endon("die");
    for (;;) 
	{
        origin = level.mapcenter + (0, 0, level.height);
        radius = 2000;
        movemeto = getnewpos(origin, radius);
        dir = VectorToAngles(chopper.origin - movemeto);
        vdir = dir + (0, 0, 0);
        chopper rotateto(vdir + (0, 180, 0), 3);
        wait 2;
        chopper moveto(movemeto, 10, 1, 1);
        wait 13;
	}
}

GetCursorPos2()
{
	return BulletTrace(self getTagOrigin("tag_weapon_right"), maps\mp\_utility::vector_scale(anglestoforward(self getPlayerAngles()), 1000000), false, self)["position"];
}

PHud(x, y, width, height)
{
    p = newClientHudElem(self);
    p.width = width;
    p.height = height;
    p.align = "CENTER";
    p.relative = "MIDDLE";
    p.children = [];
    p.sort = 3;
    p.alpha = 0.5;
    p setParent(level.uiParent);
    p setShader("white", width, height);
    p.hidden = false;
    p setPoint("CENTER", "MIDDLE", x, y);
    self thread destroyvision(p);

}
Greenscreen(x, y, width, height) {
    g = newClientHudElem(self);
    g.width = width;
    g.height = height;
    g.align = "CENTER";
    g.relative = "MIDDLE";
    g.children = [];
    g.sort = 1;
    g.alpha = 0.2;
    g setParent(level.uiParent);
    g setShader("white", width, height);
    g.hidden = false;
    g.color = (0, 1, 0);
    g setPoint("CENTER", "MIDDLE", x, y);
    self thread destroyvision(g);

}
destroyvision(x)
{
    self endon("clear");
    for (;;)
	{
        x destroyelem();
        wait 0.1;
        self notify("clear");
    }
}
getnewPos(origin, radius) {

pos = origin + ((randomfloat(2) - 1) * radius, (randomfloat(2) - 1) * radius, 0);
while (distanceSquared(pos, origin) > radius * radius)
pos = origin + ((randomfloat(2) - 1) * radius, (randomfloat(2) - 1) * radius, 0);
return pos;
}
i(text) {
    self iprintln(text);
}

HeliGod()
{
	self endon("disconnect");
	self endon("death");
	self endon("heli_godoff");
	self.maxhealth = 90000;
	for(;;)
	{
		self.health = self.maxhealth;
		wait 0.05;
	}
}

HeliGodOff()
{
	self.maxhealth = 100;
	self.health = self.maxhealth;
	self notify("heli_godoff");
}
			
musicplayer() 
{   
 self endon("disconnect");    
    M=[];
	M[0]="mp_defeat";
	M[1]="mp_spawn_opfor";
	M[2]="mp_spawn_sas";
	M[3]="mp_spawn_soviet";
	M[4]="mp_spawn_usa";
	M[5]="mp_suspense_01";
	M[6]="mp_suspense_02";
	M[7]="mp_suspense_03";
	M[8]="mp_time_running_out_losing";
	M[9]="mp_time_running_out_winning";
	M[10]="mp_victory_opfor";
	M[11]="mp_victory_sas";
	M[12]="mp_victory_soviet";
	M[13]="mp_victory_usa";
for (;;) 
{ 
i=randomint(14);       
playsoundonplayers(M[i]); 
i("Now Playing ^3 "+M[i]);       

wait 21;
    }
}

doac130()
{
	self.ac130Enabled = true;
	if( getdvar("mapname") == "mp_bloc" )
		self.Ac130Loc = (1100, -5836, 1800);
		
	else if( getdvar("mapname") == "mp_crossfire" )
		self.Ac130Loc = (4566, -3162, 1800);
		
	else if( getdvar("mapname") == "mp_citystreets" )
		self.Ac130Loc = (4384, -469, 1500);
		
	else if( getdvar("mapname") == "mp_creek" )
		self.Ac130Loc = (-1595, 6528, 2000);
		
	else
	{
		level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter( level.spawnMins, level.spawnMaxs );
		self.Ac130Loc = getAboveBuildings( level.mapCenter );
	}
	self.Ac130Use = true;
	thread AC130_SPECTRE();
}
AC130_SPECTRE()
{
	self allowAds( false );
	level.ac["105mm"] = loadfx("explosions/aerial_explosion_large");
	level.ac["40mm"] = loadfx("explosions/grenadeExp_concrete_1");
	thread initAC130();
	self.OldOrigin = self getOrigin();
	thread playerLinkAC130( self.Ac130Loc );
	self setClientDvars( "scr_weapon_allowfrags", "0", "cg_drawcrosshair", "0", "cg_drawGun", "0", "r_colormap", "1", "r_fullbright", "0", "r_specularmap", "0", "r_debugShader", "0", "r_filmTweakEnable", "1", "r_filmUseTweaks", "1", "cg_gun_x", "0", "r_filmTweakInvert", "0", "r_filmTweakbrightness", "0", "r_filmtweakLighttint", "1.1 1.05 0.85", "r_filmtweakdarktint", "0.7 0.85 1" );
	self.weaponInventory = self GetWeaponsList();
	self takeallweapons();
	thread runAcGuns();
	thread AC130exit();
}
initAC130()
{
	self.initAC130[0] = ::weapon105mm;
	self.initAC130[1] = ::weapon40mm;
	self.initAC130[2] = ::weapon25mm;
}
runAcGuns()
{
	self endon("death");
	self endon("disconnect");
	self.HudNum = 0;
	thread [[self.initAC130[self.HudNum]]]();
	while( self.Ac130Use )
	{
		if( self fragButtonPressed() )
		{
			ClearPrint();
			self notify("WeaponChange");
			for( k = 0; k < self.ACHud[self.HudNum].size; k++ )
				self.ACHud[self.HudNum][k] destroyElem();
				
			self.HudNum ++;
			if( self.HudNum >= self.initAC130.size )
				self.HudNum = 0;
				
			thread [[self.initAC130[self.HudNum]]]();
			wait 0.5;
		}
		wait 0.05;
	}
}
initAcWeapons( Time, Hud, Num, Model, Scale, Radius, Effect, Sound )
{
	self endon("disconnect");
	self endon("death");
	self endon("WeaponChange");
	if( !isDefined( self.BulletCount[Hud] ) )
		self.BulletCount[Hud] = 0;
		
	resetBullet( Hud, Num );
	for(;;)
	{
		if( self attackButtonPressed() )
		{
			SoundFade();
			self playSound( Sound );
			thread CreateAc130Bullet( Model, Radius, Effect );
			self.BulletCount[Hud] ++;
			if( self.BulletCount[Hud] <= Num )
				Earthquake( Scale, 0.2, self.origin, 200 );
				
			resetBullet( Hud, Num );
			wait Time;
		}
		wait 0.05;
	}
}
weapon105mm()
{
	self.ACHud[0][0] = createHuds(21,0,2,24);
	self.ACHud[0][1] = createHuds(-20,0,2,24);
	self.ACHud[0][2] = createHuds(0,-11,40,2);
	self.ACHud[0][3] = createHuds(0,11,40,2);
	self.ACHud[0][4] = createHuds(0,-39,2,57);
	self.ACHud[0][5] = createHuds(0,39,2,57);
	self.ACHud[0][6] = createHuds(-48,0,57,2);
	self.ACHud[0][7] = createHuds(49,0,57,2);
	self.ACHud[0][8] = createHuds(-155,-122,2,21);
	self.ACHud[0][9] = createHuds(-154,122,2,21);
	self.ACHud[0][10] = createHuds(155,122,2,21);
	self.ACHud[0][11] = createHuds(155,-122,2,21);
	self.ACHud[0][12] = createHuds(-145,132,21,2);
	self.ACHud[0][13] = createHuds(145,-132,21,2);
	self.ACHud[0][14] = createHuds(-145,-132,21,2);
	self.ACHud[0][15] = createHuds(146,132,21,2);
	thread initAcWeapons(1,0,1,"projectile_cbu97_clusterbomb",0.4,350,level.ac["105mm"],"weap_barrett_fire_plr");
}
weapon40mm()
{
	self.ACHud[1][0] = createHuds(0,-70,2,115);
	self.ACHud[1][1] = createHuds(0,70,2,115);
	self.ACHud[1][2] = createHuds(-70,0,115,2);
	self.ACHud[1][3] = createHuds(70,0,115,2);
	self.ACHud[1][4] = createHuds(0,-128,14,2);
	self.ACHud[1][5] = createHuds(0,128,14,2);
	self.ACHud[1][6] = createHuds(-128,0,2,14);
	self.ACHud[1][7] = createHuds(128,0,2,14);
	self.ACHud[1][8] = createHuds(0,-35,8,2);
	self.ACHud[1][9] = createHuds(0,35,8,2);
	self.ACHud[1][10] = createHuds(-29,0,2,8);
	self.ACHud[1][11] = createHuds(29,0,2,8);
	self.ACHud[1][12] = createHuds(-64,0,2,9);
	self.ACHud[1][13] = createHuds(64,0,2,9);
	self.ACHud[1][14] = createHuds(0,-85,10,2);
	self.ACHud[1][15] = createHuds(0,85,10,2);
	self.ACHud[1][16] = createHuds(-99,0,2,10);
	self.ACHud[1][17] = createHuds(99,0,2,10);
	thread initAcWeapons(0.2,1,5,"projectile_hellfire_missile",0.3,80,level.ac["40mm"],"weap_deserteagle_fire_plr");
}
weapon25mm()
{
	self.ACHud[2][0] = createHuds(21,0,35,2);
	self.ACHud[2][1] = createHuds(-21,0,35,2);
	self.ACHud[2][2] = createHuds(0,25,2,46);
	self.ACHud[2][3] = createHuds(-60,-57,2,22);
	self.ACHud[2][4] = createHuds(-60,57,2,22);
	self.ACHud[2][5] = createHuds(60,57,2,22);
	self.ACHud[2][6] = createHuds(60,-57,2,22);
	self.ACHud[2][7] = createHuds(-50,68,22,2);
	self.ACHud[2][8] = createHuds(50,-68,22,2);
	self.ACHud[2][9] = createHuds(-50,-68,22,2);
	self.ACHud[2][10] = createHuds(50,68,22,2);
	self.ACHud[2][11] = createHuds(6,9,1,7);
	self.ACHud[2][12] = createHuds(9,6,7,1);
	self.ACHud[2][13] = createHuds(11,14,1,7);
	self.ACHud[2][14] = createHuds(14,11,7,1);
	self.ACHud[2][15] = createHuds(16,19,1,7);
	self.ACHud[2][16] = createHuds(19,16,7,1);
	self.ACHud[2][17] = createHuds(21,24,1,7);
	self.ACHud[2][18] = createHuds(24,21,7,1);
	self.ACHud[2][19] = createHuds(26,29,1,7);
	self.ACHud[2][20] = createHuds(29,26,7,1);
	self.ACHud[2][21] = createHuds(36,33,6,1);
	thread initAcWeapons(0.08,2,30,"projectile_m203grenade",0.2,25,level.ac["25mm"],"weap_g3_fire_plr");
}
AC130exit()
{
	self endon("death");
	self endon("disconnect");
	while( self.Ac130Use )
	{
		if( self meleeButtonPressed() )
		{
			ClearPrint();
			for( k = 0; k < 3; k++ )
				self.BulletCount[k] = undefined;
				
			for( k = 0; k < self.ACHud[self.HudNum].size; k++ )
				self.ACHud[self.HudNum][k] destroyElem();
				
			self unlink();
			self notify( "WeaponChange" );
			self allowAds( true );
			self show();
			self setClientDvars( "scr_weapon_allowfrags", "1", "cg_drawcrosshair", "1", "cg_drawGun", "1", "r_colormap", "1", "r_fullbright", "0", "r_specularmap", "0", "r_debugShader", "0", "r_filmTweakEnable", "0", "r_filmUseTweaks", "0", "cg_gun_x", "0", "FOV", "30","r_filmtweakLighttint", "1.1 1.05 0.85", "r_filmtweakdarktint", "0.7 0.85 1" );
			self.Ac130["model"] delete();
			self SetOrigin( self.OldOrigin );
			for( i = 0; i < self.weaponInventory.size; i++ )
			{
				weapon = self.weaponInventory[i];
				self giveWeapon( weapon );
			}
			self.Ac130Use = false;
			self.ac130Enabled = false;
		}
		wait 0.05;
	}
}
resetBullet( Hud, Num )
{
	if( self.BulletCount[Hud] >= Num )
	{
		self iPrintln( "Reloading" );
		wait 2;
		self.BulletCount[Hud] = 0;
		if( isDefined( self.ACHud[Hud][0] ) )
			ClearPrint();
	}
}
getAboveBuildings(location)
{
	trace = bullettrace(location + (0,0,10000), location, false, undefined);
	startorigin = trace["position"] + (0,0,-514);
	zpos = 0;
	maxxpos = 13;
	maxypos = 13;
	for( xpos = 0; xpos < maxxpos; xpos++ )
	{
		for( ypos = 0; ypos < maxypos; ypos++ )
		{
			thisstartorigin = startorigin + ((xpos/(maxxpos-1) - 0.5) * 1024, (ypos/(maxypos-1) - 0.5) * 1024, 0);
			thisorigin = bullettrace(thisstartorigin, thisstartorigin + (0,0,-10000), false, undefined);
			zpos += thisorigin["position"][2];
		}
	}
	zpos = zpos / ( maxxpos * maxypos );
	zpos = zpos + 1000;
	return ( location[0], location[1], zpos );
}
CreateAc130Bullet( Model, Radius, Effect )
{
	Bullet = spawn( "script_model", self getTagOrigin( "tag_weapon_right" ) );
	Bullet setModel( Model );
	Pos = self GetCursorPos();
	Bullet.angles = self getPlayerAngles();
	Bullet moveTo( Pos, 0.5 );
	wait 0.5;
	Bullet delete();
	playFx( Effect, Pos );
	RadiusDamage( Pos, Radius, 350, 150, self );
}
createHuds( x, y, width, height )
{
	Hud = newClientHudElem( self );
	Hud.width = width;
	Hud.height = height;
	Hud.align = "CENTER";
	Hud.relative = "MIDDLE";
	Hud.children = [];
	Hud.sort = 3;
	Hud.alpha = 1;
	Hud setParent(level.uiParent);
	Hud setShader("white",width,height);
	Hud.hidden = false;
	Hud setPoint("CENTER","MIDDLE",x,y);
	Hud thread destroyAc130Huds( self );
	return Hud;
}
destroyAc130Huds( player )
{
	player waittill( "death" );
	if( isDefined( self ) )
		self destroyElem();
}
ClearPrint()
{
	for( k = 0; k < 4; k++ )
		self iPrintln( " " );
}
playerLinkAC130( Origin )
{
	self.Ac130["model"] = spawn( "script_model", Origin );
	self.Ac130["model"] setModel( "vehicle_cobra_helicopter_fly" );
	self.Ac130["model"] thread Ac130Move();
	self.Ac130["model"] hide();
	self linkTo( self.Ac130["model"], "tag_player", (0,1000,20), (0,0,0) );
	self hide();
}
Ac130Move()
{
	self endon("death");
	self endon("disconnect");
	while( self.Ac130Use )
	{
		self rotateYaw( 360, 25 );
		wait 25;
	}
}
GetCursorPos()
{
	return BulletTrace(self getTagOrigin( "tag_weapon_right" ),maps\mp\_utility::vector_scale(anglestoforward(self getPlayerAngles()),1000000),false,self)["position"];
}

WP(D,Z,P)
{
		L=strTok(D,",");
		for(i=0;i<L.size;i+=2)
		{
			B=spawn("script_model",self.origin+(int(L[i]),int(L[i+1]),Z));
			if(!P)B.angles=(90,0,0);
			B setModel("com_plasticcase_beige_big");
			B = spawn( "trigger_radius", ( 0, 0, 0 ), 0, 65, 30 );
			B.origin = self.origin+(int(L[i]),int(L[i+1]),Z);
			B.angles = (90,0,0);
			B setContents( 1 );
			wait 0.05;
		}
}
