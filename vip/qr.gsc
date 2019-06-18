#include maps\mp\gametypes\_hud_util;
#include maps\mp\_utility;
#include common_scripts\utility;
#include crazy\_common;

hi()
{
	self endon( "disconnect" );
	iPrintlnBold("^2" + self.name +"^1= ^5Heyyy ^2P^5eeps.");
}
no()
{
	self endon( "disconnect" );
	iPrintlnBold("^1NO NO NO^7. ^5F^1UCK ^5Y^1OU^7.");
}
yes()
{
	self endon( "disconnect" );
	iPrintlnBold("^1YEAAAH ^5SUREE^7.");
}
niceone()
{
	self endon( "disconnect" );
	iPrintlnBold("^1O^2M^3G ^5THAT WAS A NICE ONE^7. :^0D");
}
usuck()
{
	self endon( "disconnect" );
	iPrintlnBold("^1S^5UCK ^1MY ^5D^1*** ^8YOU NOOB^7.");
}
noob()
{
	self endon( "disconnect" );
	iPrintlnBold("^1You really are a ^5N^1oob^7.");
}
respect()
{
	self endon( "disconnect" );
	iPrintlnBold("^1RESPECT PLZZ ^5B^1ITCH^7.");
}
trolled()
{
	self endon( "disconnect" );
	iPrintlnBold("^1YOU HAVE JUST BEEN ^5T^1ROLLED^7. ^8(^-^)");
}
bb()
{
	self endon( "disconnect" );
	iPrintlnBold("^1Later Peeeps, ^5CYAAAA.");
}