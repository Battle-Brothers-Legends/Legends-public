this.legend_sanctified_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 0,
	},
	function create()
	{
		this.m.ID = "effects.legend_sanctified_effect";
		this.m.Name = "Sanctified";
		this.m.Description = "This character is being cleansed by holy light";
		this.m.Icon = "ui/perks/holybluefire_circle.png";
		this.m.IconMini = "mini_bluefire_circle";
		this.m.Overlay = "bluefire_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		local turnsText = this.m.TurnsLeft > 0 ? (" Lasts [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turns.") : "";
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Immune to injuries, bleeding, poison and morale checks from taking damage." + turnsText,
		});
		return ret;
	}

	function isActorOnTileWithHolyFlame()
	{
		local tile = this.getContainer().getActor().getTile();
		if (tile.Properties.Effect != null && tile.Properties.Effect.Type == "legend_holyflame")
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	function onAdded()
	{
		// Commenting this out so that adding this effect via the Holy Flame tile effect will impact the countdown
		// If adding from any other source, you will need to manually set m.TurnsLeft
		// this.m.TurnsLeft = 2;
	}

	function onRefresh()
	{
		this.m.TurnsLeft = 2;
	}

	function onTurnEnd()
	{
		if (!this.isActorOnTileWithHolyFlame() && --this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

	function onNewRound()
	{
		if (!this.isActorOnTileWithHolyFlame() && this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

	function onUpdate( _properties )
	{
		if (!this.isActorOnTileWithHolyFlame() && this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
		else
		{
			_properties.IsAffectedByLosingHitpoints = false;
			_properties.IsAffectedByInjuries = false;
			_properties.IsAffectedByFreshInjuries = false;
			_properties.IsImmuneToBleeding = true;
			_properties.IsImmuneToPoison = true;	
		}
	}

});

