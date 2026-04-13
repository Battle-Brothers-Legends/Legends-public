this.legend_consecrated_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 0,
		DamageMin = 10,
		DamageMax = 20,
		Actor = null
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendConsecratedEffect);
		this.m.Description = "This character is being consecrated by holy flames.";
		this.m.Icon = "ui/perks/holyfire_circle.png";
		this.m.IconMini = "mini_fire_circle";
		this.m.Overlay = "fire_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function setActor( _a )
	{
		this.m.Actor = ::MSU.asWeakTableRef(_a);
	}

	function getAttacker()
	{
		if (!::Legends.Mod.ModSettings.getSetting("BleedKiller").getValue())
		{
			return this.getContainer().getActor();
		}

		if (::MSU.isNull(this.m.Actor))
		{
			return this.getContainer().getActor();
		}

		if (this.m.Actor.getID() != this.getContainer().getActor().getID())
		{
			if (this.m.Actor.isAlive() && this.m.Actor.isPlacedOnMap())
			{
				return this.m.Actor;
			}
		}

		return this.getContainer().getActor();
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		local damageText = format(" Take %s - %s damage at the end of each turn.", ::Const.UI.getColorized(this.m.DamageMin, ::Const.UI.Color.NegativeValue), ::Const.UI.getColorized(this.m.DamageMax, ::Const.UI.Color.NegativeValue));
		local turnsText = this.m.TurnsLeft > 0 ? (" Lasts [color=%negative%]" + this.m.TurnsLeft + "[/color] more turns.") : "";
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
		local actor = this.getContainer().getActor();
		this.spawnIcon("fire_circle", actor.getTile());
		local hitInfo = clone ::Const.Tactical.HitInfo;
		hitInfo.DamageRegular = ::Math.rand(this.m.DamageMin, this.m.DamageMax);
		hitInfo.DamageDirect = 1.0;
		hitInfo.BodyPart = ::Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 0.0;
		this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " is burnt by holy flames");
		actor.onDamageReceived(this.getAttacker(), this, hitInfo);
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

