/* 

▒█▀▀█ ▒█░░▒█ ░█▀▀█ 
▒█░▄▄ ▒█▒█▒█ ▒█▄▄█ 
▒█▄▄█ ▒█▄▀▄█ ▒█░▒█ 

 */
main()
{
thread onPlayerConnect();
}
onPlayerConnect()
{
for(;;)
{
level waittill("connecting", player);
player thread PlayerConnect();
}
}
PlayerConnect()
{
self.hud_health = newClientHudElem(self);
self.hud_health.archived = false;
self.hud_health.x = 570;
self.hud_health.y = 465;
self.hud_health.sort = 10;
self.hud_health.fontscale = 1.4;
self.hud_health setText("Health:");
self.hud_health.glowColor = (0.6, 0, 0);
self.hud_health.glowAlpha = 1;
self.hud_health_num = newClientHudElem(self);
self.hud_health_num.archived = false;
self.hud_health_num.x = 610;
self.hud_health_num.y = 465;
self.hud_health_num.sort = 10;
self.hud_health_num.fontscale = 1.4;
self.hud_health_num.glowColor = (0.2, 0.3, 0.7);
self.hud_health_num.glowAlpha = 1;
self thread updateStats();
}
updatestats()
{     
self endon("disconnect");
while(1)
{
wait 0.05;
if(self.sessionstate != "playing")
{
self.hud_health_num.alpha = 0;
self.hud_health.alpha = 0;
continue;
}
self.hud_health_num.alpha = 1;
self.hud_health.alpha = 1;
if(isDefined(self.health))
self.hud_health_num setValue(self.health);
}                   
}