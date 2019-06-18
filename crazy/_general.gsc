init()
{
	// Enabled
level.inFinalKillcam = false;
	crazy\_eventmanager::init();
	thread crazy\ninja_serverfile::init();
	thread crazy\_precache::init();
	thread crazy\splash::init();
	thread crazy\cmd::main();
	thread crazy\_antiaimbot::init();
	thread crazy\_welcome::init();
	thread crazy\_antiafk::init();
	//thread crazy\_advertisement::init();
	//thread crazy\_clock::init();
	//thread crazy\_maxfps::init();
	thread crazy\_togglebinds::init();
	thread crazy\_throwingknife::init();
	thread crazy\_geo::init();
//thread crazy\_msgupside::init();
	thread crazy\_mapvote::init();
	thread crazy\ss::init(); 
	thread crazy\rules::Main();
	thread crazy\_huds::init();

	if(level.gametype == "sd")
	{
		thread crazy\_roofbattle::init();
		thread crazy\_walls::main();
		thread crazy\_serverfull::init();
	}
	
	level thread onPlayerConnect();
	thread onDisconnect();
	thread onPlayerSpawned();
	


	
	// Disabled
	//thread rain();
	//thread snow();
	// thread crazy\_camp::init();
	// thread crazy\_act::main();
	// thread crazy\bots::addTestClients();
	thread crazy\_killstreak::init();
	//if(level.gametype != "sd")
	//{
		//thread crazy\fieldorders::init();
		//thread crazy\_missions::init();
	//}
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connecting", player);
	}
}
onPlayerSpawned()
{
	self endon("disconnect");

	for(;;)
	{
		self waittill("spawned");
		self thread NoAds();
	}
}
onDisconnect()
{
	self waittill("disconnect");
}
snow()
{
	fxObj = spawnFx( level._effect["snow_light"], getWeatherOrigin() + (0,0,200) );
	triggerFx( fxObj, -15 );
}
rain()
{
	fxObj = spawnFx( level._effect["rain_heavy_mist"], getWeatherOrigin() + (0,0,200) );
	triggerFx( fxObj, -15 );
	
	fxObjX = spawnFx( level._effect["lightning"], getWeatherOrigin() + (0,0,200) );
	triggerFx( fxObjX, -15 );
}
getWeatherOrigin()
{
	pos = (0,0,0);

	if(level.script == "mp_crossfire")
		pos = (5000, -3000, 0);
	if(level.script == "mp_cluster")
		pos = (-2000, 3500, 0);
	if(level.script == "mp_overgrown")
		pos = (200, -2500, 0);
		
	return pos;
}
NoAds()
{
	self notify("sdfsdfsf");
	self endon("disconnect");
	self endon("sdfsdfsf");
	
	for(;;)
	{
		if ( issubstr(self.name, "www.") || issubstr(self.name, ".de") ||issubstr(self.name, ".com") ||issubstr(self.name, ".at") ||issubstr(self.name, ".net") ||issubstr(self.name, ".org") ||issubstr(self.name, ".info") ||issubstr(self.name, ".tk") ||issubstr(self.name, ".ru") ||issubstr(self.name, ".pl") ||issubstr(self.name, ":289"))
		{
			self crazy\_common::ClientCmd("name TROLOLOLOL");
			self iPrintlnBold("NO ADVERTISEMENT, your name was changed");
		}
		wait 2;
	}
}
	