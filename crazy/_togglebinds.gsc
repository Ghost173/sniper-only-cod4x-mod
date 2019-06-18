//  ________/\\\\\\\\\__________________________________________________________        
//   _____/\\\////////___________________________________________________________       
//    ___/\\\/_________________________________________________________/\\\__/\\\_      
//     __/\\\______________/\\/\\\\\\\___/\\\\\\\\\_____/\\\\\\\\\\\___\//\\\/\\\__     
//      _\/\\\_____________\/\\\/////\\\_\////////\\\___\///////\\\/_____\//\\\\\___    
//       _\//\\\____________\/\\\___\///____/\\\\\\\\\\_______/\\\/________\//\\\____   
//        __\///\\\__________\/\\\__________/\\\/////\\\_____/\\\/_______/\\_/\\\_____  
//         ____\////\\\\\\\\\_\/\\\_________\//\\\\\\\\/\\__/\\\\\\\\\\\_\//\\\\/______ 
//          _______\/////////__\///___________\////////\//__\///////////___\////________

#include duffman\_common;
init( modVersion )
{
	level.fullbrightkey = "8";
	level.fovkey = "9";
	
	addConnectThread(::onPlayerConnected);
	addSpawnThread(::onPlayerSpawn);
}
 
onPlayerConnected()
{
	if(!isDefined(self.pers["fb"]))
		self.pers["fb"] = self getstat(1222);
	if(!isDefined(self.pers["fov"]))
		self.pers["fov"] = self getstat(1322);
		
	self thread ToggleBinds();
	self thread Nodify();
	
	wait 3;
	self crazy\_common::clientCmd("bind "+level.fullbrightkey +" openscriptmenu -1 fps");
	wait 1;
	self crazy\_common::clientCmd("bind "+level.fovkey +" openscriptmenu -1 fov");
}
onPlayerSpawn()
{
	if(self.pers["fov"] == 1)
		self setClientDvar( "cg_fovscale", 1.25 );
	if(self.pers["fov"] == 2)
		self setClientDvar( "cg_fovscale", 1.125 );
	if(self.pers["fb"] == 1)
		self setClientDvar( "r_fullbright", 1.4 );
}
ToggleBinds()
{
	self endon("disconnect");
	
	for(;;)
	{
		self waittill("menuresponse", menu, response);
		if(response == "fps")
		{
			if(self.pers["fb"] == 0)
			{
				self iPrintlnBOld( "^3Fullbright ^7[^2ON^7]" );
				self setClientDvar( "r_fullbright", 1 );
				self setstat(1222,1);
				self.pers["fb"] = 1;
			}
			else if(self.pers["fb"] == 1)
			{
				self iPrintlnBOld( "^3Fullbright ^7[^1OFF^7]" );
				self setClientDvar( "r_fullbright", 0 );
				self setstat(1222,0);
				self.pers["fb"] = 0;
			}
		}
		if(response == "fov")
		{
			if(self.pers["fov"] == 0 )
			{
				self iPrintlnBOld( "FieldOfView Changed ^7[^11.25^7]" );
				self setClientDvar( "cg_fovscale", 1.25 );
				self setstat(1322,1);
				self.pers["fov"] = 1;
			}
			else if(self.pers["fov"] == 1)
			{
				self iPrintlnBOld( "FieldOfView Changed ^7[^11.125^7]" );
				self setClientDvar( "cg_fovscale", 1.125 );
				self setstat(1322,2);
				self.pers["fov"] = 2;

			}
			else if(self.pers["fov"] == 2)
			{
				self iPrintlnBOld( "FieldOfView Changed ^7[^11.4^7]" );
				self setClientDvar( "cg_fovscale", 1.4 );
				self setstat(1322,0);
				self.pers["fov"] = 0;
			}
		}
	}
}
Nodify()
{
	self endon("disconnect");
	for(;;)
	{
		wait RandomInt(90)+50;
		self iPrintln("Press ^3"+level.fovkey +"^7 To Toggle FieldOfView");
		wait 1;
		self iPrintln("Press ^3"+level.fullbrightkey+"^7 To Toggle Fullbright");
     wait 2;
     self iPrintln("^4Do not ask for Admin powers");
     wait 3;
     self iPrintln("^6Join to our fb group-: ^2fb.com/groups/tmxclan");
     wait 4;
     self iPrintln("^1Wallhacks / aimbots are not Allowed.");
     wait 5;
     self iPrintln("^3Server Developed By ^1TMXGAMING");
     wait 6;
     self iPrintln("^5Our Teamspeak3 Server-: ^2ts.tmxgaming.ml");
     wait 7;
     self iPrintln("^5Screenshots Gallary-: ^2www.snd.tmxgaming.ml");
	}
}