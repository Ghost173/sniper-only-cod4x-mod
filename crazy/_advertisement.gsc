#include duffman\_common;

init()
{
	level.delay = 10;
	level thread advertisement();
}

saytxt(txt)
{
	level hudmsg(txt);
}

advertisement()
{	
	while(1)
	{
	
		level hudmsg("Welcome To ZentrO gaminG Pr SL eSPORTS, SnD Public Server !");
	
		wait level.delay;
		
		level hudmsg("Contact ZGS | regulaR, ZGS | franK, ZGS | caskY For any Server issues !");
	
		wait level.delay;
	
		level hudmsg("like us on facebook: fb.com/ZentrO-GaminG-Solutions");
	
		wait level.delay;
		
		level hudmsg("Server hosted by To E-Sports Gaming Community Sri Lanka");
		
		wait level.delay;
		
		level hudmsg("Join With us , Follow Server Rules and Play Fair");
		
		wait level.delay;
	}
}

hudmsg(text) 
{
	msg = addTextHud( level, 750, 470, 1, "left", "middle", undefined, undefined, 1.6, 888 );
	msg SetText(text);
	msg.sort = 102;
	msg.foreground = 1;
	msg.archived = true;
	msg.alpha = 1;
	msg.fontScale = 1.4;
	msg.color = level.randomcolour;
	msg MoveHud(30,-1300);
	wait 20;
	msg destroy();
}