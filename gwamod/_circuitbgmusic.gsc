//╔═══╗─────────╔╗─╔╗──╔════╗
//║╔═╗║─────────║║─║║──║╔╗╔╗║
//║║─╚╝╔╗╔═╗╔══╗║║─║║╔╗╚╝║║╚╝
//║║─╔╗╠╣║╔╝║╔═╝║║─║║╠╣──║║
//║╚═╝║║║║║─║╚═╗║╚═╝║║║──║║
//╚═══╝╚╝╚╝─╚══╝╚═══╝╚╝──╚╝
//Wanna Turn Off Backgroud Music ? Change This :AmbientPlay("bg_music1"); to :AmbientPlay("1");
music()
{
level endon("endmusic");
wait 2;
for(i=0;i<3;i++)
{
	iPrintlnBold("<<< ^3Now playing ^2((^1Now Playing American Dream !^2)) ^5>>>");
	}
for(;;)
{
	AmbientPlay("bg_music1");
	wait 204;
	AmbientStop();
	wait 1;
	}
}
