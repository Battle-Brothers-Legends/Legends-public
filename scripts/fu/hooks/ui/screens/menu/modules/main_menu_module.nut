::mods_hookExactClass("ui/screens/menu/modules/main_menu_module", function(o)
{
	o.m.OnModOptionsPressedListener <- null;
	o.m.OnUploadCompanyPressedListener <- null;

	o.setOnModOptionsPressedListener <- function( _listener )
	{
		this.m.OnModOptionsPressedListener = _listener;
	}

	o.onModOptionsButtonPressed <- function()
	{
		this.m.OnModOptionsPressedListener();
	}

	o.setOnUploadCompanyPressedListener <- function( _listener )
	{
		this.m.OnUploadCompanyPressedListener = _listener;
	}

	o.onUploadCompanyButtonPressed <- function()
	{
		if (this.m.OnUploadCompanyPressedListener != null)
			this.m.OnUploadCompanyPressedListener();
	}
});
