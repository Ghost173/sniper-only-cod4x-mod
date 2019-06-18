/*
 
^1 = red
^2 = green
^3 = yellow
^4 = blue
^5 = cyan(light blue)
^6 = pink
^7 = white
^8 = Axis killfeed colour
^9 = Allies killfeed colour
^0 = Black
 
*/
 
 
 
init( modVersion )
{
	////add new precachestrings here when you change the text/////
	precachestring( &"" );
	precachestring( &"" );
 
 
 
	if(isDefined(level.rulesText))
		level.rulesText destroy();
 
	level.rulesText = newHudElem();
	level.rulesText.x = 150;
	level.rulesText.y = 16;            //470 
	level.rulesText.alignX = "CENTER";
	level.rulesText.alignY = "Middle";
	level.rulesText.horzAlign = "CENTER";
	level.rulesText.vertAlign = "TOP";
	level.rulesText.alpha = 5;
	level.rulesText.sort = 10;
	level.rulesText.fontScale = 1.4;
 
	if(isDefined(level.rulesTitle))
		level.rulesTitle destroy();
 
	level.rulesTitle = newHudElem();
	level.rulesTitle.x = 130;
	level.rulesTitle.y = 10;          //110
	level.rulesTitle.alignX = "CENTER";
	level.rulesTitle.alignY = "Middle";
	level.rulesTitle.horzAlign = "CENTER";
	level.rulesTitle.vertAlign = "TOP";
	level.rulesTitle.alpha = 10;
	level.rulesTitle.sort = 10;
    level.rulesTitle.fontScale = 1.4;
	level.rulesTitle setText("");
	for(;;)
	{       
		level.rulesText setText("^7We are ^3ZenTrO_^3Gaming eSports");
		wait 20;
		level.rulesText setText(" ");
		wait 10;
		level.rulesText setText("Admins :ZGS | regulaR, ZGS | franK, ZGS | caskY");
		wait 10;
		level.rulesText setText(" ");
		wait 10;
		level.rulesText setText("^1hosted by ^5eSports Gaming Community");  
		level.rulesText setText(" ");
		wait 10;
		level.rulesText setText("Respect players and Admins");
		wait 10;
		level.rulesText setText(" ");
		wait 10;
		level.rulesText setText("^1Do not Ask for Admin");
		wait 10;
		level.rulesText setText(" ");
		wait 10;
		level.rulesText setText("Like us On fb : fb.com/ZentrO-GaminG-Solutions");
		wait 10;
		level.rulesText setText(" ");
		wait 10;
		level.rulesText setText("^1Do not Cheat & Hack ! Admins Watching You ");
		wait 10;
		level.rulesText setText("Welcome To ^2ZenTrO ^3Gaming  ^3PROMOD^2 LIVE !");
		wait 5;
	}
}
