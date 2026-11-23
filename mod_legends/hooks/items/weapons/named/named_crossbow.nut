::mods_hookExactClass("items/weapons/named/named_crossbow", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.RangeMax = 5;
		this.m.RangeIdeal = 5;
	}

	o.getTooltip <- function ()
	{
		local result = this.named_weapon.getTooltip();

		if (!this.m.IsLoaded)
		{
			result.push({
				id = 10,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Must be reloaded before firing again[/color]"
			});
		}

		return result;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendPiercingBolt);
		::Legends.Actives.grant(this, ::Legends.Active.LegendStrafingRun);
		::Legends.Actives.grant(this, ::Legends.Active.ReloadBolt);
		::Legends.Actives.grant(this, ::Legends.Active.KnockOut, function (_skill) {
			_skill.m.IsRangedKnockOut = true;
		}.bindenv(this));
	}

	o.onCombatFinished = function ()
	{
		this.named_weapon.onCombatFinished();
		this.setLoaded(true);
	}
});
