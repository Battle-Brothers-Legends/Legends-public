::mods_hookExactClass("ui/screens/loading/loading_screen", function(o) {
	o.updateProgress <- function ( _text )
	{
		this.m.JSHandle.asyncCall("updateProgress", _text );
	}
});
