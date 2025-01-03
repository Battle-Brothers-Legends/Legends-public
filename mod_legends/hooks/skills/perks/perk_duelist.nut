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

	o.isHidden <- function ()
	{
		return ::Tactical.isActive();
	}

	o.getTooltip <- function ()
	{
		local main = getContainer().getActor().getMainhandItem();
		local off = getContainer().getActor().getOffhandItem();
		local tooltip = this.skill.getTooltip();

		if (!isValid(main, off))
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]You do not have the right equipment to receive Duelist's effect[/color]"
			});
		else if (isFullEffect(main, off))
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+25%[/color] of any damage ignores armor"
			});
		else if (isPartialEffect(main, off))
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+13%[/color] of any damage ignores armor"
			});
		else
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]You do not have the right equipment to receive Duelist's effect[/color]"
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

	o.onUpdate = function ( _properties )
	{
		local main = getContainer().getActor().getMainhandItem();
		local off = getContainer().getActor().getOffhandItem();

		if (!isValid(main, off))
			return;

		if (isFullEffect(main, off))
			_properties.DamageDirectAdd += 0.25;
		else if (isPartialEffect(main, off))
			_properties.DamageDirectAdd += 0.13;
	}
});
