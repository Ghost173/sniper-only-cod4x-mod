#include maps\mp\gametypes\_hud_util;
#include crazy\_common;

promod()
{
        normal();

	level endon( "endmap" );
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "joined_spectators" );
        
        self iPrintlnBold( "^5Promod Vision!!" );
	self setClientDvar("cg_fov", 110);
        self setClientDvar("cg_fovscale", 1.225);
        self setClientDvar("r_fullbright", 0);
        self setClientDvar( "r_specularmap", 0);
        self setClientDvar("r_debugShader", 0);
        self setClientDvar( "r_filmTweakEnable", "0" );
        self setClientDvar( "r_filmUseTweaks", "0" );
        self setClientDvar( "pr_filmtweakcontrast", "1.3" );
        self setClientDvar( "r_lighttweaksunlight", "1.55" );
}

laser()
{
	if(self.lf == false)
	{
		self setClientDvar("cg_laserForceOn", 1);
		self.lf = true;
		self iPrintln( "^2laserForce On" );
	}
	else
	{
		self setClientDvar("cg_laserForceOn", 0);
		self.lf = false;
		self iPrintln( "^1laserForce Off" );
	}
}

chrome()
{
        normal();

	level endon( "endmap" );
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "joined_spectators" );
        
        self iPrintlnBold( "^5Chrome Vision!!" );
        self setClientDvar( "r_specularmap", 2);
}

cartoon()
{
        normal();

        self iPrintlnBold( "^5Cartoon Vision!!" );
        self setClientDvar("r_fullbright", "1");
}

rainbow()
{
        normal();

        self iPrintlnBold( "^5Rainbow Vision!!" );
        self setClientDvar("r_debugShader", "1");  
}

normal()
{
	self setClientDvar("cg_fov", 80);
        self setClientDvar("cg_fovscale", 1);
        self setClientDvar("r_fullbright", 0);
        self setClientDvar( "r_specularmap", 0);
        self setClientDvar("r_debugShader", 0);
        self setClientDvar( "r_filmTweakEnable", "0" );
        self setClientDvar( "r_filmUseTweaks", "0" );
        self setClientDvar( "r_filmtweakcontrast", "1.4" );
        self setClientDvar( "r_lighttweaksunlight", "1" );
        self setClientDvar( "r_filmTweakInvert", "");
        self setClientDvar( "r_filmTweakbrightness", "0");
        self setClientDvar( "r_filmtweakLighttint", "1.1 1.05 0.85");
        self setClientDvar( "r_filmtweakdarktint", "0.7 0.85 1");
        self setClientDvar("r_fullbright", "0");

}

BetterCrosshair()
{
    self iPrintln("^2Better Crosshairs Set");
	{
		self BetterCrosshair1("+", 2.3, 0.3);
	}
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