::mods_hookExactClass("ui/screens/menu/modules/main_menu_module", function(o)
{
	o.m.OnModOptionsPressedListener <- null;

	o.setOnModOptionsPressedListener <- function( _listener )
	{
		this.m.OnModOptionsPressedListener = _listener;
	}

	o.onModOptionsButtonPressed <- function()
	{
		this.m.OnModOptionsPressedListener();
	}
});
