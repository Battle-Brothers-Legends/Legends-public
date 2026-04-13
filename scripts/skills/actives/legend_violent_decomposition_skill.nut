this.legend_violent_decomposition_skill <- this.inherit("scripts/skills/skill", {
	m = {
		// base damage of the explosion
		MinDamage = 15,
		MaxDamage = 55,
		ArmorDamageMult = 0.65,
	},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendViolentDecomposition);
		this.m.Icon = "skills/violent_decomposition.png";
		this.m.IconDisabled = "skills/violent_decomposition_bw.png";
		this.m.Overlay = "violent_decomposition";
		this.m.SoundOnUse = [
		 	"sounds/combat/violent_decomposition.wav"
		];

		this.m.SoundOnHit = [
			"sounds/enemies/necromancer_01.wav",
			"sounds/enemies/necromancer_02.wav",
			"sounds/enemies/necromancer_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted + 105;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsVisibleTileNeeded = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.DirectDamageMult = 0.3;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 25;
		this.m.MinRange = 2;
		this.m.MaxRange = 6;
		this.m.MaxLevelDifference = 8;
	}

	function getDescription()
	{
		return "Corrupt the force sustaining one of your thralls, causing them to detonate destructively after the corruption has time to build. Affected dead explode at the end of their turn next round, dealing damage in a 1 tile radius. The less HP they have, the more damage the explosion inflicts. If they are killed before they explode, the effect no longer triggers."
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultTooltip();

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=%positive%]" + this.getMaxRange() + "[/color] tiles"
		});

		return ret;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local target = _targetTile.getEntity();

		if (!this.getContainer().getActor().isAlliedWith(target))
		{
			return false;
		}

		if (!target.getFlags().has("IsSummoned") || !target.getFlags().has("undead"))
		{
			return false;
		}

		if (!target.isAlive())
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local properties = this.getContainer().buildPropertiesForUse(this, null);
		::Legends.Effects.grant(target, ::Legends.Effect.LegendViolentDecompositionEffect, function(_effect) {
			_effect.setDamage({
				MaxDamage = this.m.MaxDamage,
				MinDamage = this.m.MinDamage,
				DirectDamageMult = this.m.DirectDamageMult,
				ArmorDamageMult = this.m.ArmorDamageMult,
				TotalDamageMult = properties.DamageTotalMult, // you can remove this line if you don't want total damage multiplier to be applied in damage calculation
			});
			_effect.setActorID(_user.getID());
		}.bindenv(this));
		this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " sets " + this.Const.UI.getColorizedEntityName(target) + "to violently explode next turn");
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageRegularMax = this.m.MaxDamage;
			_properties.DamageRegularMin = this.m.MinRange;
			_properties.DamageArmorMult = this.m.ArmorDamageMult;
			// properties.DamageTotalMult = 1.0;
			// remove comment of the line above to make this skill no longer be affected by total damage multiplier
		}
	}

});
