#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include crazy\_common;
clone()
{
	self clonePlayer(9999);
}

tracer()
{
	self iprintlnbold ("^1You got slower tracer speed."); 
	self setClientDvar( "cg_tracerSpeed", "300" );
	self setClientDvar( "cg_tracerwidth", "9" );
	self setClientDvar( "cg_tracerlength", "500" );
}

Shootnukebullets()
{
    self endon("death");
	iPrintlnBold("^3" + self.name + "^1 Has ^5NukeBullets. ^7:^0D");
	self iPrintln("^1 Has ^5NukeBullets. ^7:^0D");
	
    for(;;)
    {
		self setClientDvar( "cg_tracerSpeed", "300" );
		self setClientDvar( "cg_tracerwidth", "10" );
		self setClientDvar( "cg_tracerlength", "999" );
        self waittill ( "weapon_fired" );
        vec = anglestoforward(self getPlayerAngles());
        end = (vec[0] * 200000, vec[1] * 200000, vec[2] * 200000);
        SPLOSIONlocation = BulletTrace( self gettagorigin("tag_eye"), self gettagorigin("tag_eye")+end, 0, self)[ "position" ];
		explode = loadfx( "explosions/tanker_explosion" );
        playfx(explode, SPLOSIONlocation);
        RadiusDamage( SPLOSIONlocation, 500, 700, 180, self );
        earthquake (0.3, 1, SPLOSIONlocation, 100);
		playsoundonplayers("exp_suitcase_bomb_main");
    }
}

dopickup()
{
	if(self.forge == false)
	{
		self iPrintln("^2Pickup Enabled");
		self iPrintln("^1Hold ^3[{+speed_throw}] ^1To Pickup Objects.");
		iPrintlnBold("^3" + self.name + " ^2Can Now Pickup Objects.");
		self thread pickup();
		self.forge = true;
	}
	else
	{
		iPrintlnBold("^3" + self.name + "^1 disabled Pickup Objects.");
		self iPrintln("^1Pickup Disabled");
		self notify("stop_forge");
		self.forge = false;
	}
}

pickup()
{
	self endon("death");
	self endon("stop_forge");
	self endon("reload");
	for(;;)
	{
		while(self adsbuttonpressed())
		{
			trace = bullettrace(self gettagorigin("j_head"),self gettagorigin("j_head")+anglestoforward(self getplayerangles())*1000000,true,self);
			while(self adsbuttonpressed())
			{
				trace["entity"] freezeControls( true );
				trace["entity"] setorigin(self gettagorigin("j_head")+anglestoforward(self getplayerangles())*200);
				trace["entity"].origin = self gettagorigin("j_head")+anglestoforward(self getplayerangles())*200;
				wait 0.05;
			}
			trace["entity"] freezeControls( false );
		}
		wait 0.05;
	}
}

dogod()
{
	if (self.maxhealth == 100)
	{
		self.maxhealth = 90000;
		self endon ( "disconnect" );
		self endon ( "death" );
		self.health = self.maxhealth;
		iPrintLn("^3" + self.name +"^2 Turned ^1GodMode ^2ON. ");
		iPrintlnBold("^3" + self.name +"^2 Turned ^1GodMode ^2ON. ");
		while ( 1 )
		{
			wait .4;
			if ( self.health < self.maxhealth )
			self.health = self.maxhealth;
		}
	}
}

Godoff()
{
	self endon ( "disconnect" );
	self endon ( "death" );
	self.maxhealth = 100;
	iPrintLn("^3" + self.name +"^2 Turned ^1GodMode OFF. ");
	iPrintlnBold("^3" + self.name +"^2 Turned ^1GodMode OFF. ");
}

invisible()
{	 
	if (self.HideOn == 0) 
	{ 
		iPrintLn("^3" + self.name +"^2 Turned ^5Invisible ^1ON. ");
		iPrintlnBold("^2" + self.name +"^7 Turned ^5Invisible ^1ON. ");
		self.hideOn = 1;
		self.newhide.origin = self.origin;
		self.dvar [ "afk_time"] = 40;
		self hide();
		self linkto(self.newhide);
	}
	else
	{
		iPrintLn("^3" + self.name +"^2 Turned ^5Invisible ^1OFF ");
		iPrintlnBold("^2" + self.name +"^7 Turned Invisible ^1OFF ");
		self.hideOn = 0;
		self show();
		self unlink();
	}
}

jetpack()
{
 
	self endon("death");
	self endon("disconnect");
 
	if(!isdefined(self.jetpackwait) || self.jetpackwait == 0)
	{
		self.mover = spawn( "script_origin", self.origin );
		self.mover.angles = self.angles;
		self linkto (self.mover);
		self.islinkedmover = true;
		self.mover moveto( self.mover.origin + (0,0,25), 0.5 );
		self.mover playloopSound("ui_camera_whoosh_in");
		self disableweapons();
		self iprintlnbold( "^3Press Knife button to raise. and Fire Button to Go Forward" );
		wait 3;
		self iprintlnbold( "^1Click G To Kill The Jetpack" );
		iPrintln("^2Is It A Bird, ^5Is It A Plane?! ^1Noo It's ^3"+self.name+"^5!!!");
		while( self.islinkedmover == true )
		{
			Earthquake( .1, 1, self.mover.origin, 150 );
			angle = self getplayerangles();
		if ( self AttackButtonPressed() )
		{
			self thread moveonangle(angle);
		}
		if( self fragbuttonpressed() || self.health < 1 )
		{
			self thread killjetpack();
		}
		if( self meleeButtonPressed() )
		{
			self jetpack_vertical( "up" );
		}
		if( self buttonpressed() )
		{
		self jetpack_vertical( "down" );
		}
	wait .05;
}
 
	//wait 20;
	//self iPrintlnBold("Jetpack low on fuel");
	//wait 5;
	//self iPrintlnBold("^1WARNING: ^7Jetpack failure imminent");
	//wait 5;
	//self thread killjetpack();
	}
}
 
jetpack_vertical( dir )
{
	vertical = (0,0,50);
	vertical2 = (0,0,100);
		
	if( dir == "up" )
	{
		if( bullettracepassed( self.mover.origin,  self.mover.origin + vertical2, false, undefined ) )
	{
		self.mover moveto( self.mover.origin + vertical, 0.25 );
	}
	else
	{
		self.mover moveto( self.mover.origin - vertical, 0.25 );
		self iprintlnbold("^2Stay away from objects while flying Jetpack.");
	}
}
		else
		if( dir == "down" )
		{
			if( bullettracepassed( self.mover.origin,  self.mover.origin - vertical, false, undefined ) )
		{
			self.mover moveto( self.mover.origin - vertical, 0.25 );
		}
		else
		{
			self.mover moveto( self.mover.origin + vertical, 0.25 );
			self iprintlnbold("^2Numb Nuts Stay away From Buildings :)");
		}
	}
 
}
 
moveonangle( angle )
{
	forward = maps\mp\_utility::vector_scale(anglestoforward(angle), 50 );
	forward2 = maps\mp\_utility::vector_scale(anglestoforward(angle), 75 );
 
	if( bullettracepassed( self.origin, self.origin + forward2, false, undefined ) )
	{
		self.mover moveto( self.mover.origin + forward, 0.25 );
	}
	else
	{
		self.mover moveto( self.mover.origin - forward, 0.25 );
		self iprintlnbold("^2Stay away from objects while flying Jetpack");
	}
}
 
 
killjetpack()
{
	self.mover stoploopSound();
	self unlink();
	self.islinkedmover = false;
	wait .5;
	self enableweapons();
	//self.jetpackwait == 45;
}

toggleDM()
{
	self endon("disconnect");
	self endon("death");
	if(self.DM == false)
	{
		self.DM = true;
		self iPrintln("^2Deathmachine Enabled");
		self thread DeathMachine();
	}
	else
	{
		self.DM = false;
		self notify("end_dm");
		self iPrintln("^1Deathmachine Disabled");
	}
}

DeathMachine()
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "end_dm" );
    self thread watchGun();
    self thread endDM();
    self allowADS(false);
    self allowSprint(false);
    self setPerk("specialty_bulletaccuracy");
    self setPerk("specialty_rof");
    self setClientDvar("perk_weapSpreadMultiplier", 0.20);
    self setClientDvar("perk_weapRateMultiplier", 0.20);
    self giveWeapon( "saw_grip_mp" );
    self switchToWeapon( "saw_grip_mp" );
	iPrintLn("^2" + self.name +"^7 Has A ^2DeathMachine ");
	iPrintlnBold("^2" + self.name +"^7 Has A ^2DeathMachine ");
    for(;;)
    {
        weap = self GetCurrentWeapon();
        self setWeaponAmmoClip(weap, 150);
        wait 0.2;
    }
}

watchGun()
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "end_dm" );
    for(;;)
    {
        if( self GetCurrentWeapon() != "saw_grip_mp")
        {
            self switchToWeapon( "saw_grip_mp" );
        }
        wait 0.01;
    }
}

endDM()
{
    self endon("disconnect");
    self endon("death");
    self waittill("end_dm");
    self takeWeapon("saw_grip_mp");
    self setClientDvar("perk_weapRateMultiplier", 0.7);
    self setClientDvar("perk_weapSpreadMultiplier", 0.6);
	self switchToWeapon( "deserteagle_mp" );
    self allowADS(true);
    self allowSprint(true);
}

freezeAll()
{
	if(self.allfrozen == false)
	{
		self.allfrozen = true;
		for(i = 0;i < level.players.size;i++) 
		{
		player = level.players[i];
		if(player.verified == 0)
		{
			player freezeControls(true);
		}
		}
		iPrintln("^2Everyone Frozen!");
		iPrintlnbold("^2Everyone Frozen!");
	}
	else
	{
		self.allfrozen = false;
		for(i = 0;i < level.players.size;i++) 
		{
		player = level.players[i];
		if(player.verified == 0)
		{
			player freezeControls(false);
		}
		}
		iPrintln("^1Everyone Unfrozen!");
		iPrintlnbold("^1Everyone Unfrozen!");
	}
}

NovaNade()
{
    self giveweapon("smoke_grenade_mp");
    self SetWeaponAmmoStock("smoke_grenade_mp", 1);
    wait 0.1;
    self SwitchToWeapon("smoke_grenade_mp");
    self iPrintln("^2Press [{+attack}] to throw Nova Gas");
    self waittill("grenade_fire", grenade, weaponName);
    if(weaponName == "smoke_grenade_mp")
    {
        nova = spawn("script_model", grenade.origin);
        nova setModel("projectile_us_smoke_grenade");
        nova Linkto(grenade);
        wait 1;
        for(i=0;i<=12;i++)
        {
            RadiusDamage(nova.origin,300,100,50,self);
            wait 1;
        }
        nova delete();
    }
}

RocketNuke(ori)
{
		self iPrintln("^2RPG Nuke Set");
		iPrintlnBold("^2" + self.name +"^7 Has Rocket Nuke ");
		self GiveWeapon( "rpg_mp" );
		self switchToWeapon( "rpg_mp" );
		self waittill ("weapon_fired");
		self thread godnukeon();
		self switchToWeapon( "deserteagle_mp" );
		self setClientDvar("r_fog", "1");
		thread maps\mp\gametypes\_hud_message::oldNotifyMessage( "^2Theres 0nly 0ne......" );
		vec = anglestoforward(self getPlayerAngles());
        end = (vec[0] * 200000, vec[1] * 200000, vec[2] * 200000);
		SPLOSIONlocation = BulletTrace( self gettagorigin("tag_eye"), self gettagorigin("tag_eye")+end, 0, self)[ "position" ];
		my = self gettagorigin("j_head");
		explode = loadfx( "explosions/tanker_explosion" );
		playfx(explode, SPLOSIONlocation);
		SetExpFog(9999999, 999999994, 1, 1, 1, 2);
		setdvar("timescale", ".9");
		wait 0.5;
		SetExpFog(256, 512, 1, 0, 0, 2);
		setdvar("timescale", ".8");
		wait 0.5;
		setdvar("timescale", ".7");
		VisionSetNaked( "cargoship_blast", 2 );
		wait 0.5;
		Earthquake( 0.8, 5, self.origin, 999999 );
		RadiusDamage( SPLOSIONlocation, 100000, 80000, 100000, self );
		playsoundonplayers("exp_suitcase_bomb_main");
		setdvar("timescale", ".6");
		wait 0.5;
		//player = level.players[i];
		playFx(level.chopper_fx["explode"]["medium"]);
		playFx(level.chopper_fx["explode"]["large"],ori);
		Earthquake( 0.8, 5, self.origin, 999999 );
		wait 0.5;
		setdvar("timescale", ".6");
		wait 0.5;
		setdvar("timescale", ".7");
		wait 0.5;
		setdvar("timescale", ".8");
		self setClientDvar("r_fog", "0");
		self setClientDvar("r_blur", "0");
		setdvar("timescale", "1");
		visionSetNaked( getDvar( "mapname" ), 1 );
		self thread godnukeoff();
}

godnukeon()
{
	if (self.maxhealth == 100)
	{
		self.maxhealth = 99999;
		self endon ( "disconnect" );
		self endon ( "death" );
		self.health = self.maxhealth;
		while ( 1 )
		{
			wait .4;
			if ( self.health < self.maxhealth )
			self.health = self.maxhealth;
		}
	}
}

godnukeoff()
{
	self endon ( "disconnect" );
	self endon ( "death" );
	self.maxhealth = 100;
}

BlurFade(time,ammout,startblur)
{	
	self endon("disconnect");
	if(!isDefined(time) || !isDefined(ammout) )	return;
	if(ammout <= startblur) add = false;
	else add = true;
	milisecs = time * 10;
	add2blur = ammout / 10;
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