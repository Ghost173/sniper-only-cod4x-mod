//###   ###   ####    ###    ###  #### ®
//## # # ##  ##  ##   ## #   ##  ##  ##
//##  #  ##  ######   ##  #  ##  ######
//##     ##  ##  ##   ##   # ##  ##  ##
//##     ## ###  ### ###    ### ###  ###
//-------------------------------------------------------
//Cod4 Server @ 139.59.63.208:28960
//Developer/-Manthila Mallawa-
//Thanks For MALAYA
//Include Some Functions of Duffy.

#include duffman\_common;
init()
{
	
	addConnectThread(::WelcomeMessage);
}

//Welcome message
WelcomeMessage() {
	self endon ( "disconnect" );
	self waittill( "spawned_player" );
	hud[0] = self schnitzel( "center", 0.1, 800, -115 );
	hud[1] = self schnitzel( "center", 0.1, -800, -95 );
	hud[0] setText("^2 Visit : ^1www.snd.tmxgaming.ml");
	hud[1] SetPlayerNameString( self );
	hud[0] moveOverTime( 1 );
	hud[1] moveOverTime( 1 );
	hud[0].x = 0;
	hud[1].x = 0;
	wait 4;
	hud[0] moveOverTime( 1 );
	hud[1] moveOverTime( 1 );
	hud[0].x = -800;
	hud[1].x = 800;
	wait 1;
	hud[0] destroy();
	hud[1] destroy();
	
}

schnitzel( align, fade_in_time, x_off, y_off ) {
	hud = newClientHudElem(self);
    hud.foreground = true;
	hud.x = x_off;
	hud.y = y_off;
	hud.alignX = align;
	hud.alignY = "middle";
	hud.horzAlign = align;
	hud.vertAlign = "middle";
 	hud.fontScale = 2;
	hud.color = (1, 1, 1);
	hud.font = "objective";
	hud.glowColor = ( 0.00, 0.50, 0.00 );
	hud.glowAlpha = 1;
	hud.alpha = 1;
	hud fadeovertime( fade_in_time );
	hud.alpha = 1;
	hud.hidewheninmenu = true;
	hud.sort = 10;
	return hud;
}