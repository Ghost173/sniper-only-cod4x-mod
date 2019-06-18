burn()
{
	self iprintlnbold ("^1You Are On ^5F^1ire."); 
        while(isAlive(self))
	{
		playFx( level.dist , self.origin );
		wait .1;
	}
}

burning()
{
	wait 6.0;
	while(isAlive(self))
	{
		playFx( level.dist , self.origin );
		wait 0.1;
	}
}