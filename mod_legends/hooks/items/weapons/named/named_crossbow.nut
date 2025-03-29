::mods_hookExactClass("items/weapons/named/named_crossbow", function(o) {

	o.getTooltip <- function ()
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

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendPiercingBolt);
	}

	o.onCombatFinished = function ()
	{
		this.named_weapon.onCombatFinished();
		this.setLoaded(true);
	}
});
