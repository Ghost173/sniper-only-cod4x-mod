r700()
{
	self takeallweapons();
	self giveWeapon("remington700_mp");
	self givemaxammo("remington700_mp");
	self switchtoweapon( "remington700_mp" );
	self iPrintln("^1Weapon Remington700 Given");
}

m60e4()
{
	self takeallweapons();
	self giveWeapon("m60e4_mp");
	self givemaxammo("m60e4_mp");
	self switchtoweapon( "m60e4_mp" );
	self iPrintln("^1Weapon M60E4 Given");
}

barrett()
{
	self takeallweapons();
	self giveWeapon("barrett_mp");
	self givemaxammo("barrett_mp");
	self switchtoweapon( "barrett_mp" );
	self iPrintln("^1Weapon BARRETT Given");
}

m21()
{
	self takeallweapons();
	self giveWeapon("m21_mp");
	self givemaxammo("m21_mp");
	self switchtoweapon( "m21_mp" );
	self iPrintln("^1Weapon M21 Given");
}


knife()
{
	self giveWeapon("knife_mp");
	self givemaxammo("knife_mp");
	self switchtoweapon( "knife_mp" );
	self iPrintln("^1knife_mp");
}

m40a3()
{
	self takeallweapons();
	self giveWeapon("m40a3_mp");
	self givemaxammo("m40a3_mp");
	self switchtoweapon( "m40a3_mp" );
	self iPrintln("^1Weapon M40a3 Given");
}

ak47()
{
	self takeallweapons();
	self giveWeapon( "ak47_mp" );
	self GiveMaxAmmo( "ak47_mp" );
	self SwitchToWeapon( "ak47_mp" );
	self iPrintln("^1Weapon Ak47 Given");
}

m4()
{
	self takeallweapons();
	self giveWeapon("m4_mp");
	self givemaxammo("m4_mp");
	self switchtoweapon( "m4_mp" );
	self iPrintln("^1Weapon M4 Given");
}

p90()
{
	self takeallweapons();
	self giveWeapon("p90_mp");
	self givemaxammo("p90_mp");
	self switchtoweapon( "p90_mp" );
	self iPrintln("^1Weapon P90 Given");
}

ak74u()
{
	self takeallweapons();
	self giveWeapon("ak74u_mp");
	self givemaxammo("ak74u_mp");
	self switchtoweapon( "ak74u_mp" );
	self iPrintln("^1Weapon Ak74u Given");
}

mp5()
{
	self takeallweapons();
	self giveWeapon("mp5_mp");
	self givemaxammo("mp5_mp");
	self switchtoweapon( "mp5_mp" );
	self iPrintln("^1Weapon Mp5 Given");
}

g3()
{
	self takeallweapons();
	self giveWeapon ("g3_mp");
	self givemaxammo ("g3_mp");
	self switchtoweapon( "g3_mp" );
	self iPrintln("^1Weapon G3 Given");
}


weappack()
{
	self giveWeapon("ak74u_mp");
	self givemaxammo("ak74u_mp");
	self giveWeapon("m40a3_mp");
	self givemaxammo("m40a4_mp");
	self giveWeapon("mp5_mp",6);
	self givemaxammo("mp5_mp");
	self giveWeapon("remington700_mp");
	self givemaxammo("remington700_mp");
	self giveWeapon("p90_mp",6);
	self givemaxammo("p90_mp");
	self giveWeapon("m1014_mp",6);
	self givemaxammo("m1014_mp");
	self giveWeapon("uzi_mp",6);
	self givemaxammo("uzi_mp");
	self giveWeapon("ak47_mp",6);
	self givemaxammo("ak47_mp");
	self giveweapon("m60e4_mp",6);
	self givemaxammo("m60e4_mp");
	self giveWeapon("deserteaglegold_mp");
	self givemaxammo("deserteaglegold_mp");
	self iPrintln("^1Weapon Pack Given");
}