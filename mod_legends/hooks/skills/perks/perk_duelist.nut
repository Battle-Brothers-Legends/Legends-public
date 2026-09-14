::mods_hookExactClass("skills/perks/perk_duelist", function(o) {
	o.m.AllowedWeapons <-
	[
		"_parrying_dagger",
		// "_hand_crossbow",
		"buckler",
		"legend_mummy_shield"
	];
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Icon = "ui/perks/perk_41.png";
		this.m.Type = this.Const.SkillType.Perk;
	}

	// o.getDescription <- function ()
	// {
	// 	return "Become one with your weapon and go for the weak spots!";
	// }

	// o.getTooltip <- function ()
	// {
	// 	local tooltip = this.skill.getTooltip();
	// 	local bonus = this.getBonus() * 100;
	// 	if (bonus == 0)
	// 	{
	// 		tooltip.push({
	// 			id = 6,
	// 			type = "text",
	// 			icon = "ui/tooltips/warning.png",
	// 			text = "[color=%negative%]You do not have the right equipment to receive Duelist's effect[/color]"
	// 		});
	// 		return tooltip;
	// 	}
	// 	tooltip.push({
	// 		id = 6,
	// 		type = "text",
	// 		icon = "ui/icons/direct_damage.png",
	// 		text = "[color=%positive%]"+ bonus + "%[/color] of any damage ignores armor"
	// 	});

	// 	return tooltip;
	// }

	o.onAdded <- function ()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendFlourish))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendFlourish);
		}
	}

	o.onRemoved <- function ()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendFlourish);
	}

	o.isValid <- function ( _mainhand, _offhand )
	{
		if (_mainhand == null && _offhand == null)
			return false;

		return true;
	}

	o.isValidOffhand <- function ( _mainhand, _offhand )
	{
		if (_offhand == null)
			return false;

		foreach( valid in m.AllowedWeapons )
		{
			if (::MSU.String.endsWith(_offhand.getID(), valid))
				return true;
		}

		return false;
	}

	// you can just hook this or isValid/isFullEffect/isPartialEffect and the tooltip will auto calculate without needing to replace anything
	o.getBonus <- function()
	{
		local main = getContainer().getActor().getMainhandItem();
		local off = getContainer().getActor().getOffhandItem();
		if (!isValid(main, off))
			return 0;

		if (isValidOffhand(main, off))
			return 0.25;

		return 0;
	}

	o.onAnySkillUsed <- function ( _skill, _targetEntity, _properties )
	{
		if (_skill.isRanged())
			return;
		_properties.DamageDirectAdd += this.getBonus();
	}

	o.onUpdate = function ( _properties )
	{
	}
});
