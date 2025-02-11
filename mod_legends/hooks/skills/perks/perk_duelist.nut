::mods_hookExactClass("skills/perks/perk_duelist", function(o) {
	o.m.AllowedWeapons <-
	[
		"_parrying_dagger",
		"_hand_crossbow",
		"buckler",
	];
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Icon = "ui/perks/perk_41.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	o.getDescription <- function ()
	{
		return "Become one with your weapon and go for the weak spots!";
	}

	o.isHidden <- function ()
	{
		return ::Tactical.isActive();
	}

	o.getTooltip <- function ()
	{
		local tooltip = this.skill.getTooltip();
		local bonus = this.getBonus() * 100;
		if (bonus == 0)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]You do not have the right equipment to receive Duelist's effect[/color]"
			});
			return tooltip;
		}
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/direct_damage.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]"+ bonus + "%[/color] of any damage ignores armor"
		});

		return tooltip;
	}

	o.isValid <- function ( _mainhand, _offhand )
	{
		if (_mainhand == null && _offhand == null)
			return false;

		return true;
	}

	o.isFullEffect <- function ( _mainhand, _offhand )
	{
		return getContainer().hasSkill("injury.missing_hand") || _offhand == null && !_mainhand.isItemType(::Const.Items.ItemType.TwoHanded) || _offhand != null && _offhand.isItemType(::Const.Items.ItemType.Tool);
	}

	o.isPartialEffect <- function ( _mainhand, _offhand )
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

		local bonus = 0.0;
		if (isFullEffect(main, off))
			bonus += 0.25;
		else if (isPartialEffect(main, off))
			bonus += 0.13;
		return bonus;
	}

	o.onUpdate = function ( _properties )
	{
		_properties.DamageDirectAdd += this.getBonus();
	}
});
