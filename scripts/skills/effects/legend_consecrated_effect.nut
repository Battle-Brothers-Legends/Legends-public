this.legend_consecrated_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 0,
		DamageMin = 10,
		DamageMax = 20,
	},
	function create()
	{
		this.m.ID = "effects.legend_consecrated_effect";
		this.m.Name = "Consecrated";
		this.m.Description = "This character is being consecrated by holy flames";
		this.m.Icon = "ui/perks/holyfire_circle.png";
		this.m.IconMini = "mini_fire_circle";
		this.m.Overlay = "fire_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		local damageText = format(" Take %s - %s damage at the end of each turn.", ::Const.UI.getColorized(this.m.DamageMin, ::Const.UI.Color.NegativeValue), ::Const.UI.getColorized(this.m.DamageMax, ::Const.UI.Color.NegativeValue))
		local turnsText = this.m.TurnsLeft > 0 ? (" Lasts [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turns.") : "";
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Lose any immunity to injuries, bleeding, and poison." + damageText + turnsText,
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
		// this.m.TurnsLeft = this.Math.max(1, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
	}

	function onRefresh()
	{
		this.m.TurnsLeft = this.Math.max(1, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
	}

	function applyDamage()
	{
		this.spawnIcon("fire_circle", this.getContainer().getActor().getTile());
		local hitInfo = clone ::Const.Tactical.HitInfo;
		hitInfo.DamageRegular = ::Math.rand(this.m.DamageMin, this.m.DamageMax);
		hitInfo.DamageDirect = 1.0;
		hitInfo.BodyPart = ::Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 0.0;
		this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " is burnt by holy flames");
		this.getContainer().getActor().onDamageReceived(this.getContainer().getActor(), null, hitInfo);
	}

	function onTurnEnd()
	{
		this.applyDamage();		
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
			_properties.IsAffectedByLosingHitpoints = true;
			_properties.IsAffectedByInjuries = true;
			_properties.IsAffectedByFreshInjuries = true;
			_properties.IsImmuneToBleeding = false;
			_properties.IsImmuneToPoison = false;
		}
	}

});

