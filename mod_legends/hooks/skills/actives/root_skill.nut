::mods_hookExactClass("skills/actives/root_skill", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Unleash roots from the ground to ensnare your targets to prevent them from moving or defending themselves effectively. Will always hit if the enemy isn\'t immune. This spell is easier to cast when it\'s raining.";
		this.m.Icon = "skills/roots_square.png";
		this.m.IconDisabled = "skills/roots_square_bw.png"
	}

	o.getTooltip <- function ()
	{
		local tooltip = this.getDefaultUtilityTooltip();
		tooltip.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "All enemies in an area of [color=" + this.Const.UI.Color.DamageValue + "]7[/color] tiles will become [color=#731f39]Trapped in Vines[/color]"
		});

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			tooltip.push({
				id = 5,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return tooltip;
	}

	o.onAfterUpdate <- function ( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInStaves ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.ActionPointCost = _properties.IsSpecializedInStaves ? 5 : 6;

		if (this.getContainer().hasEffect(::Legends.Effect.LegendRain))
		{
			this.m.FatigueCost -= 10;
			this.m.ActionPointCost -= 1;
		}

	}

	o.isUsable <- function ()
	{
		return this.skill.isUsable() && !this.getContainer().getActor().isEngagedInMelee();
	}

});
