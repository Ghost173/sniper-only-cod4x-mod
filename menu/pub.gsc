#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include crazy\_common;

knife()
{
	self giveWeapon("knife_mp");
	self givemaxammo("knife_mp");
	self switchtoweapon( "knife_mp" );
}
r700()
{
	self giveWeapon("remington700_mp");
	self givemaxammo("remington700_mp");
	self switchtoweapon( "remington700_mp" );
}
burn()
{
	self iprintlnbold ("^1You Are On Fire!!"); 
        while(isAlive(self))
	{
		playFx( level.dist , self.origin );
		wait .1;
	}
}
info()
{
	self iprintlnbold ("^3Mod Created By ^2| RH | ^5CircUiT - ^6Need Mod Like this contact CircUiT"); 
}

laser()
{
	if(self.lf == false)
	{
		self.lf = true;
		self setClientDvar("cg_laserForceOn", 1);
		self iPrintln( "^2laserForce On" );
	}
	else
	{
		self.lf = false;
		self setClientDvar("cg_laserForceOn", 0);
		self iPrintln( "^1laserForce Off" );
	}
}

togglethird1()
{
	if( self.third == false )
	{
		self thread togglethird2();
		self SetClientDvars( "cg_thirdPerson", "1","cg_fov", "cg_drawcrosshair", "1", "115","cg_thirdPersonAngle", "354" );
		self setDepthOfField( 0, 128, 512, 4000, 6, 1.8 );
		wait 0.1;
		self.third = true;
		self iPrintlnBold( "^3Y^7ou ^3e^7nabled ^3ThirdPerson ^3m^7ode!" );
		wait 0.1;
		self BetterCrosshair1("+", 2.3, 0.3);
	}
	else
	{
		self SetClientDvars( "cg_thirdPerson", "0","cg_fov", "65","cg_thirdPersonAngle", "0" );
		self setDepthOfField( 0, 0, 512, 4000, 4, 0 );
		wait 0.1;
		self.third = false;
		self iPrintlnBold( "^3Y^7ou ^3d^7isabled ^3ThirdPerson ^3m^7ode!" );
	}
}
togglethird2()
{
	self endon ( "togglethird_stop" );
}

BetterCrosshair1(text, scale, speed)
{
    Leeches = self createfontstring("objective", scale, self);
    Leeches setpoint("CENTER");
    Leeches settext(text);
    self thread CrosshairDestroy(Leeches);
    self setclientdvar("cg_crosshairAlpha", 0);
    rand = [];
    for(;;)
	{
		for(i=0;i<=3;i++)
		{
			random = randomInt( 100 ); rand[i] = random/100;
        }
		Leeches.color = (rand[0],rand[1],rand[2]);
		wait(speed);
    }
}
CrosshairDestroy(elem)
{
    self waittill("death");
	self endon( "disconnect" );
    elem destroy();
}