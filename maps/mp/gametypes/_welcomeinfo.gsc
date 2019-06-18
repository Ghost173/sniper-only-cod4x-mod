init()
{
	level thread onPlayerConnect();
}

onPlayerConnect()
{
	for( ;; )
	{
		level waittill( "connecting", player );
		
		if( isdefined( player.pers["player_welcomed"] ) )
			return;
		player.pers["player_welcomed"] = true;
		
		player thread onSpawnPlayer();
		
	}
}

onSpawnPlayer()
{
	self endon ( "disconnect" );
	self waittill( "spawned_player" );
	self.msgactive = 1;
	self thread madebyduff( 800, 1, -1, "^5Welcome " );
	self thread madebyduffName( 900, 1, -1, self.name );
	self playLocalSound("welcome");
	
}


madebyduff( start_offset, movetime, mult, text )
{
	
	start_offset *= mult;
	hud = schnitzel( "right", 0.1, start_offset, -130 );
	hud setText( text );
	hud moveOverTime( movetime );
	hud.x = 0;
	wait( movetime );
	wait( 3 );
	self.msgactive = 0;
	hud moveOverTime( movetime );
	hud.x = start_offset * -1;
	wait movetime;
	hud destroy();
}

schnitzel( align, fade_in_time, x_off, y_off )
{
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
	hud fadeovertime( fade_in_time );
	hud.alpha = 1;
	hud.hidewheninmenu = true;
	hud.sort = 10;
	return hud;
}
madebyduffName( start_offset, movetime, mult, text )
{
	
	start_offset *= mult;
	hud2 = schnitzelName( "right", 0.1, start_offset, -107 );
	hud2 setText( text );
	hud2 moveOverTime( movetime );
	hud2.x = 0;
	wait( movetime );
	wait( 3 );
	self.msgactive = 0;
	hud2 moveOverTime( movetime );
	hud2.x = start_offset * -1;
	wait movetime;
	hud2 destroy();
}

schnitzelName( align, fade_in_time, x_off, y_off )
{
	hud2 = newClientHudElem(self);
    hud2.foreground = true;
	hud2.x = x_off;
	hud2.y = y_off;
	hud2.alignX = align;
	hud2.alignY = "middle";
	hud2.horzAlign = align;
	hud2.vertAlign = "middle";
 	hud2.fontScale = 3;
	hud2.color = (1, 1, 0);
	hud2 fadeovertime( fade_in_time );
	hud2.glowColor = ( 0.023, 0.253, 1 );
	hud2.glowAlpha = 1;
	hud2.alpha = 1;
	hud2.hidewheninmenu = true;
	hud2.sort = 10;
	return hud2;
}