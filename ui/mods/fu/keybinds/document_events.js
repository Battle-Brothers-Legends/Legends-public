document.addEventListener('keydown', function( _event )
{
	var key = FU.Key.KeyMapJS[_event.keyCode];
	if (key === undefined || key === null)
	{
		return;
	}
	FU.Keybinds.updatePressedKeys(key, false);
});

document.addEventListener('keyup', function( _event )
{
	var key = FU.Key.KeyMapJS[_event.keyCode];
	if (key === undefined || key === null)
	{
		return;
	}
	FU.Keybinds.updatePressedKeys(key, true);
});
