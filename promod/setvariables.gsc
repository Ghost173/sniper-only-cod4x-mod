main()
{
	setDvar("bg_bobMax",0);
	setDvar("player_sustainAmmo",0);
	setDvar("player_throwBackInnerRadius",0);
	setDvar("player_throwBackOuterRadius",0);
	setDvar("loc_warnings",0);
	game["allies_assault_count"]=0;
	game["allies_specops_count"]=0;
	game["allies_demolitions_count"]=0;
	game["allies_sniper_count"]=0;
	game["axis_assault_count"]=0;
	game["axis_specops_count"]=0;
	game["axis_demolitions_count"]=0;
	game["axis_sniper_count"]=0;
	game["promod_timeout_called"]=false;
	game["promod_in_timeout"]=0;
	game["allies_timeout_called"]=0;
	game["axis_timeout_called"]=0;
	game["promod_first_readyup_done"]=0;
	game["PROMOD_VERSION"]="^2|RS|^7Promod ^1LIVE ^7V2.16 EU";

	game["need"] = [];
	game["need"]["assault"] = [];
	game["need"]["specops"] = [];
	game["need"]["demolitions"] = [];
	game["need"]["sniper"] = [];
	game["need"]["assault"]["axis"] = [];
	game["need"]["specops"]["axis"] = [];
	game["need"]["demolitions"]["axis"] = [];
	game["need"]["sniper"]["axis"] = [];
	game["need"]["assault"]["allies"] = [];
	game["need"]["specops"]["allies"] = [];
	game["need"]["demolitions"]["allies"] = [];
	game["need"]["sniper"]["allies"] = [];
}