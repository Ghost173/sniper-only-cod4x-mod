/*===================================================================||
||/|¯¯¯¯¯¯¯\///|¯¯|/////|¯¯|//|¯¯¯¯¯¯¯¯¯|//|¯¯¯¯¯¯¯¯¯|//\¯¯\/////¯¯//||
||/|  |//\  \//|  |/////|  |//|  |/////////|  |//////////\  \///  ///||
||/|  |///\  \/|  |/////|  |//|  |/////////|  |///////////\  \/  ////||
||/|  |///|  |/|  |/////|  |//|   _____|///|   _____|//////\    /////||
||/|  |////  //|  \/////|  |//|  |/////////|  |/////////////|  |/////||
||/|  |///  ////\  \////  ////|  |/////////|  |/////////////|  |/////||
||/|______ //////\_______/////|__|/////////|__|/////////////|__|/////||
||===================================================================*/

init() {
	//game["menu_autofav"] = "addfav";
	//PrecacheMenu(game["menu_autofav"]);
	thread onPlayerConnect();
}

onPlayerConnect() {
	for(;;) {
		level waittill("connected",player);
		if(player getStat(720) != 1) {
			player setStat(720,1);
			player thread addFavs();
		}
	}
}

addFavs() {
	self endon("disconnect");
	ip[0] = "45.32.113.186:28960";
	ip[1] = "45.32.113.186:28961";

	for(i=0;i<ip.size;i++) {
		self setClientDvar("ui_favoriteaddress",ip[i]);
		self OpenMenuNoMouse(game["menu_autofav"]);
		wait .15;
	}
}
