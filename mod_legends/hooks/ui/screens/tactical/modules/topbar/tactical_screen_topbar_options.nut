::mods_hookExactClass("ui/screens/tactical/modules/topbar/tactical_screen_topbar_options", function(o) {

	o.changeFleeButtonToAllowRetreat <- function (_bool)
	{
		this.m.JSHandle.asyncCall("changeFleeButtonToAllowRetreat", _bool);
	}
});
