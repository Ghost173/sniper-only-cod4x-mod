/*
 * Made by: Justin
 * Xfire: rumabatu
 * Made for: PromodLive
 * To make it work: Thread the init() function of this file from callback_startgametype() inside _globallogic.gsc.
 * Example: thread maps\mp\gametypes\_hostname::init();
 */
 
init(){
        level.hostnameSeperator = "-"; //Change this to whatever character you like. This can not be more then 1 character.
 
        if( level.hostnameSeperator.size > 1 )
                return;
 
        if( level.gametype  == "sd" )
                addRoundsToHostname( game["roundsplayed"], level.roundLimit );
        else
                setHostName( getOriginalHostname() );
}
 
addRoundsToHostname( currentRound, maxRounds ){
        setHostName( getOriginalHostname() + " " + level.hostnameSeperator + " Round: " + currentRound + "/" + maxRounds );
}
 
setHostName( newHostName ){
        SetDvar("sv_hostname", newHostName);
}
 
getOriginalHostname(){
        hostname = GetDvar("sv_hostname");
        if(IsSubStr(hostname, level.hostnameSeperator + " Round:" ))
                return trimRight( trimAllRightThroughSeperator( hostname, level.hostnameSeperator ));
        return hostname;
}
 
trimAllRightThroughSeperator( string, seperator ){
        i = string.size;
        for(; i && string[i-1] != seperator; i--){}
        return getSubStr( string, 0, i-1 );
}
 
trimRight( string )
{
        i = string.size;
        for(; i && string[i-1] == " "; i-- ){}
        return getSubStr( string, 0, i );
}