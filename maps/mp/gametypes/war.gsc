main ()
{
	if(getdvar("mapname")=="mp_background")
		return;
	maps\mp\gametypes\_globallogic::init ();
	maps\mp\gametypes\_callbacksetup::SetupCallbacks ();
	maps\mp\gametypes\_globallogic::SetupCallbacks ();
	level.teamBased=true;
	level.onStartGameType=::onStartGameType;
	level.onSpawnPlayer=::onSpawnPlayer;
}

onStartGameType ()
{
	setClientNameMode("auto_change");
	maps\mp\gametypes\_globallogic::setObjectiveText("allies",&"OBJECTIVES_WAR");
	maps\mp\gametypes\_globallogic::setObjectiveText("axis",&"OBJECTIVES_WAR");
	maps\mp\gametypes\_globallogic::setObjectiveScoreText("allies",&"OBJECTIVES_WAR_SCORE");
	maps\mp\gametypes\_globallogic::setObjectiveScoreText("axis",&"OBJECTIVES_WAR_SCORE");
	maps\mp\gametypes\_globallogic::setObjectiveHintText("allies",&"OBJECTIVES_WAR_HINT");
	maps\mp\gametypes\_globallogic::setObjectiveHintText("axis",&"OBJECTIVES_WAR_HINT");
	level.spawnMins=(0,0,0);level.spawnMaxs=(0,0,0);maps\mp\gametypes\_spawnlogic::placeSpawnPoints("mp_tdm_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::placeSpawnPoints("mp_tdm_spawn_axis_start");
	maps\mp\gametypes\_spawnlogic::addSpawnPoints("allies","mp_tdm_spawn");
	maps\mp\gametypes\_spawnlogic::addSpawnPoints("axis","mp_tdm_spawn");
	level.mapCenter=maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins,level.spawnMaxs);setMapCenter(level.mapCenter);
	allowed[0]="war";
	level.displayRoundEndText=false;
	maps\mp\gametypes\_gameobjects::main(allowed);
	if(level.roundLimit!=1&&level.numLives)
	{
		level.overrideTeamScore=true;
		level.displayRoundEndText=true;
	}
}

onSpawnPlayer()
{
	self.usingObj = undefined;

	if ( level.inGracePeriod )
	{
		spawnPoints = getentarray("mp_tdm_spawn_" + self.pers["team"] + "_start", "classname");
		
		if ( !spawnPoints.size )
			spawnPoints = getentarray("mp_sab_spawn_" + self.pers["team"] + "_start", "classname");
			
		if ( !spawnPoints.size )
		{
			spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints( self.pers["team"] );
			spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeam( spawnPoints );
		}
		else
		{
			spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random( spawnPoints );
		}		
	}
	else
	{
		spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints( self.pers["team"] );
		spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeam( spawnPoints );
	}
	
	self spawn( spawnPoint.origin, spawnPoint.angles );
	self thread intoSpawn(spawnpoint.origin, spawnpoint.angles);
   level notify ("spawned_player");
}

intoSpawn(originA, anglesA)
{
	roundspl = self getStat(3132);
	if(isDefined(self.pers["gotani"]))
		return;
	self.pers["gotani"] = true;
	self playLocalSound( "ui_camera_whoosh_in" );
	wait 0.1;
	self freezeControls( true );
	zoomHeight = 6500;
	slamzoom = true;
	self.origin = originA + ( 0, 0, zoomHeight );
	ent = spawn( "script_model", self.origin );
	self thread ispawnang(ent);
	ent.angles = anglesA;
	ent setmodel( "tag_origin" );
	self linkto( ent );
	ent.angles = ( ent.angles[ 0 ] + 89, ent.angles[ 1 ], ent.angles[ 2 ] );
	ent moveto ( originA + (0,0,0), 2, 0, 2 );
	wait ( 1.00 );
	wait( 0.6 );
	ent rotateto( ( ent.angles[ 0 ] - 89, ent.angles[ 1 ], ent.angles[ 2 ]  ), 0.5, 0.3, 0.2 );
	wait ( 0.5 );
	wait( 0.1 );
	self unlink();
	ent delete();
	self freezeControls( false );
	if (roundspl==0)
	{
		//self iPrintlnbold("^2Have Fun");
		//self playLocalSound("welcome");
	}
}

ispawnang(ent){
	//self setClientDvars ("ui_hud_hardcore", 1);
	while(isDefined(ent)){
	self SetPlayerAngles( ent.angles );
	wait 0.05;
	}
	//self setClientDvars ("ui_hud_hardcore", 0);
}