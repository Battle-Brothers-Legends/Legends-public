
this.camp_scout_dialog_module <- this.inherit("scripts/ui/screens/ui_module", {
	m = {},
	function create()
	{
		this.m.ID = "CampScoutDialogModule";
		this.ui_module.create();
	}

	function destroy()
	{
		this.ui_module.destroy();
	}

	function onLeaveButtonPressed()
	{
		this.m.Parent.onModuleClosed();
	}

});
