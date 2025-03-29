::mods_hookExactClass("items/weapons/named/named_handgonne", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2];
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.TwoHanded;
	}

	o.getTooltip = function ()
	{
		local result = this.named_weapon.getTooltip();

		if (!this.m.IsLoaded)
		{
			result.push({
				id = 10,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Must be reloaded before firing again[/color]"
			});
		}

		return result;
	}

	o.onCombatFinished = function ()
	{
		this.named_weapon.onCombatFinished();
		this.m.IsLoaded = true;
	}
});
