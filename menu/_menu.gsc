#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include crazy\_common;

init()
{
	level.shaders = strTok("ui_host;line_vertical;nightvision_overlay_goggles;hud_arrow_left",";");
	for(i=0;i<level.shaders.size;i++)
	precacheShader(level.shaders[i]);
	level.menu["name"] = [];
	precacheMenu( "clientcmd" );
	
	
//------------------Menu options-------------------
//         Displayname    function
    addmenu("^5Knife. ^1[Chaaku]","pub",menu\pub::knife);
	addmenu("^5Ninja. ^1[Fire]","pub",menu\pub::burn);
	addmenu("^5Laser.","pub",menu\pub::laser);
	addmenu("^5Third Person.","pub",menu\pub::togglethird1);
	addmenu("^5Info", "pub",menu\pub::info);
	addmenu("^2Get R700 Sniper", "pub",menu\pub::r700);
	
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
		self setClientDvar("menu", 0);
		self crazy\_common::clientCmd("bind M openscriptmenu -1 menu");
		self thread onmenuresponse();
		self iprintln("Press ^2[M] ^7 For Menu");
	}
}

onmenuresponse()
{
	self endon("disconnect");
	level endon ("vote started");
	self.inmenu = false;
	for(;;)
	{
		self waittill("menuresponse", menu, response);
		if(response == "menu")
		{
			if(self.inmenu)
			{
				self endMenu();
				continue;
			}

			self.inmenu = true;
			
			while(!self isOnGround())
				wait .05;
			
			self thread Menu();
			self disableWeapons();
			self freezeControls(true);			
			self allowSpectateTeam( "allies", false );
			self allowSpectateTeam( "axis", false );
			self allowSpectateTeam( "none", false );
		}
	}
}
	

menu()
{
	self endon("close_menu");
	self endon("disconnect");
	self thread Blur(0,2);
	submenu = "pub";
	self.menu[0] = addTextHud( self, -200, 0, .6, "left", "top", "right",0, 101 );	
	self.menu[0] setShader("nightvision_overlay_goggles", 400, 650);
	self.menu[0] thread FadeIn(.5,true,"right");
	self.menu[1] = addTextHud( self, -200, 0, .5, "left", "top", "right", 0, 101 );	
	self.menu[1] setShader("black", 400, 650);	
	self.menu[1] thread FadeIn(.5,true,"right");
	self.menu[2] = addTextHud( self, -200, 89, .5, "left", "top", "right", 0, 102 );		
	self.menu[2] setShader("line_vertical", 600, 22);
	self.menu[2] thread FadeIn(.5,true,"right");	
	self.menu[3] = addTextHud( self, -190, 93, 1, "left", "top", "right", 0, 104 );		
	self.menu[3] setShader("ui_host", 14, 14);			
	self.menu[3] thread FadeIn(.5,true,"right");
	self.menu[4] = addTextHud( self, -165, 100, 1, "left", "middle", "right", 1.4, 103 );
	self.menu[4] settext(GetMenuStuct(submenu));
	self.menu[4] thread FadeIn(.5,true,"right");
	self.menu[5] = addTextHud( self, -170, 400, 1, "left", "middle", "right" ,1.4, 103 );
	self.menu[5] settext("^7Select: ^3[Right or Left Mouse]^7\nUse: ^3[[{+activate}]]^7\nLeave: ^3[[{+melee}]]");	
	self.menu[5] thread FadeIn(.5,true,"right");
	self.menubg = addTextHud( self, 0, 0, .5, "left", "top", undefined , 0, 101 );	
	self.menubg.horzAlign = "fullscreen";
	self.menubg.vertAlign = "fullscreen";
	self.menubg setShader("black", 640, 480);
	self.menubg thread FadeIn(.2);
	
	for(selected=0;!self meleebuttonpressed();wait .05)
	{
		if(self Attackbuttonpressed())
		{
			self playLocalSound( "mouse_over" );
			if(selected == level.menu["name"][submenu].size-1) selected = 0;
			else selected++;	
		}
		if(self adsbuttonpressed())
		{
			self crazy\_common::clientCmd("-speed_throw");
			self playLocalSound( "mouse_over" );
			if(selected == 0) selected = level.menu["name"][submenu].size-1;
			else selected--;
		}
		if(self adsbuttonpressed() || self Attackbuttonpressed())
		{
			if(submenu == "pub")
			{
				self.menu[2] moveOverTime( .05 );
				self.menu[2].y = 89 + (16.8 * selected);	
				self.menu[3] moveOverTime( .05 );
				self.menu[3].y = 93 + (16.8 * selected);	
			}
			else
			{
				self.menu[7] moveOverTime( .05 );
				self.menu[7].y = 10 + self.menu[6].y + (16.8 * selected);	
			}
		}
		if((self adsbuttonpressed() || self Attackbuttonpressed()) && !self useButtonPressed()) wait .15;
		if(self useButtonPressed())
		{
			if(!isString(level.menu["script"][submenu][selected+1]))
			{
				self thread [[level.menu["script"][submenu][selected+1]]]();
				self thread endMenu();
				self notify("close_vip_menu");
			}
			else
			{
				abstand = (16.8 * selected);
				submenu = level.menu["script"][submenu][selected+1];
				self.menu[6] = addTextHud( self, -430, abstand + 50, .5, "left", "top", "right", 0, 101 );	
				self.menu[6] setShader("black", 200, 300);	
				self.menu[6] thread FadeIn(.5,true,"left");
				self.menu[7] = addTextHud( self, -430, abstand + 60, .5, "left", "top", "right", 0, 102 );		
				self.menu[7] setShader("line_vertical", 200, 22);
				self.menu[7] thread FadeIn(.5,true,"left");
				self.menu[8] = addTextHud( self, -219, 93 + (16.8 * selected), 1, "left", "top", "right", 0, 104 );		
				self.menu[8] setShader("hud_arrow_left", 14, 14);			
				self.menu[8] thread FadeIn(.5,true,"left");
				self.menu[9] = addTextHud( self, -420, abstand + 71, 1, "left", "middle", "right", 1.4, 103 );
				self.menu[9] settext(GetMenuStuct(submenu));
				self.menu[9] thread FadeIn(.5,true,"left");
				selected = 0;
				wait .2;
			}
		}
	}
	self thread endMenu();
}

endMenu()
{
	self notify("close_menu");
	for(i=0;i<self.menu.size;i++) self.menu[i] thread FadeOut(1,true,"right");
	self thread Blur(2,0);
	self.menubg thread FadeOut(1);
	self.inmenu = false;
	self enableWeapons();
	self freezeControls(false);
	self allowSpectateTeam( "allies", true );
	self allowSpectateTeam( "axis", true );
	self allowSpectateTeam( "none", true );
}

addMenu(name,menu,script)
{
	if(!isDefined(level.menu["name"][menu])) level.menu["name"][menu] = [];
	level.menu["name"][menu][level.menu["name"][menu].size] = name;
	level.menu["script"][menu][level.menu["name"][menu].size] = script;
}

addSubMenu(displayname,name)
{
	addmenu(displayname,"pub",name);
}

GetMenuStuct(menu)
{
	itemlist = "";
	for(i=0;i<level.menu["name"][menu].size;i++) itemlist = itemlist + level.menu["name"][menu][i] + "\n";
	return itemlist;
}

addTextHud( who, x, y, alpha, alignX, alignY, vert, fontScale, sort )
{ //stealed braxis function like a boss xD
	if( isPlayer( who ) ) hud = newClientHudElem( who );
	else hud = newHudElem();

	hud.x = x;
	hud.y = y;
	hud.alpha = alpha;
	hud.sort = sort;
	hud.alignX = alignX;
	hud.alignY = alignY;
	if(isdefined(vert))
		hud.horzAlign = vert;
	if(fontScale != 0)
		hud.fontScale = fontScale;
	return hud;
}

FadeOut(time,slide,dir)
{	
	if(!isDefined(self)) return;
	if(isdefined(slide) && slide)
	{
		self MoveOverTime(0.2);
		if(isDefined(dir) && dir == "right") self.x+=600;
		else self.x-=600;
	}
	self fadeovertime(time);
	self.alpha = 0;
	wait time;
	if(isDefined(self)) self destroy();
}

FadeIn(time,slide,dir)
{
	if(!isDefined(self)) return;
	if(isdefined(slide) && slide)
	{
		if(isDefined(dir) && dir == "right") self.x+=600;
		else self.x-=600;	
		self moveOverTime( .2 );
		if(isDefined(dir) && dir == "right") self.x-=600;
		else self.x+=600;
	}
	alpha = self.alpha;
	self.alpha = 0;
	self fadeovertime(time);
	self.alpha = alpha;
}

Blur(start,end)
{
	self notify("newblur");
	self endon("newblur");
	start = start * 10;
	end = end * 10;
	self endon("disconnect");
	if(start <= end)
	{
		for(i=start;i<end;i++)
		{
			self setClientDvar("r_blur", i / 10);
			wait .05;
		}
	}
	else for(i=start;i>=end;i--)
	{
		self setClientDvar("r_blur", i / 10);
		wait .05;
	}
}