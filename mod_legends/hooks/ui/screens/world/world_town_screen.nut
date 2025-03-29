::mods_hookExactClass("ui/screens/world/world_town_screen", function(o) {
	o.m.StablesDialogModule <- null;

	local isAnimating = o.isAnimating;
	o.isAnimating = function ()
	{
		if (isAnimating())
			return true;
		if (this.m.StablesDialogModule != null && this.m.StablesDialogModule.isAnimating())
			return true;
		return false;
	}

	o.getStablesDialogModule <- function ()
	{
		return this.m.StablesDialogModule;
	}

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.StablesDialogModule = this.new("scripts/ui/screens/world/modules/world_town_screen/town_stables_dialog_module");
		this.m.StablesDialogModule.setParent(this);
		this.m.StablesDialogModule.connectUI(this.m.JSHandle);
	}

	local destroy = o.destroy;
	o.destroy = function ()
	{
		this.m.StablesDialogModule.destroy();
		this.m.StablesDialogModule = null;
		destroy();
	}

	local clear = o.clear;
	o.clear = function ()
	{
		this.m.StablesDialogModule.clear();
		clear();
	}

	local showLastActiveDialog = o.showLastActiveDialog;
	o.showLastActiveDialog = function ()
	{
		if (this.m.LastActiveModule == this.m.StablesDialogModule) {
			this.showStablesDialog();
		} else {
			showLastActiveDialog();
		}
	}

	o.showStablesDialog <- function ()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = this.m.StablesDialogModule;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showStablesDialog", this.m.StablesDialogModule.queryHireInformation());
		}
	}

	o.onEncounterClicked <- function(_data){
		if (this.isAnimating()) {
			return;
		}
		if (this.m.Town != null) {
			this.m.Town.onEncounterClicked(_data, this);
		}
	}
});
