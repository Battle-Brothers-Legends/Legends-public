this.legend_magic_missile_skill <- this.inherit("scripts/skills/legend_magic_skill", {
	m = {
		Range = 6,
		BaseFatigueCost = 20
	},
	function create()
	{
		this.legend_magic_skill.create();
		this.m.AdditionalAccuracy = 20;
		this.m.DamageInitiativeMin = 15;
		this.m.DamageInitiativeMax = 35;
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendMagicMissile);
		this.m.Description = "A burst of force, leaping forward into a foe.";
		this.m.KilledString = "Shot";
		this.m.Icon = "skills/missile_square.png";
		this.m.IconDisabled = "skills/missile_square_bw.png";
		this.m.Overlay = "missile_square";
		this.m.SoundOnUse = [
			"sounds/combat/magic_missile_01.wav",
			"sounds/combat/magic_missile_02.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/arrow_hit_01.wav",
			"sounds/combat/arrow_hit_02.wav",
			"sounds/combat/arrow_hit_03.wav"
		];
		this.m.SoundOnHitShield = [
			"sounds/combat/shield_hit_arrow_01.wav",
			"sounds/combat/shield_hit_arrow_02.wav",
			"sounds/combat/shield_hit_arrow_03.wav"
		];
		this.m.SoundOnMiss = [
			"sounds/combat/arrow_miss_01.wav",
			"sounds/combat/arrow_miss_02.wav",
			"sounds/combat/arrow_miss_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.Delay = 1000;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = true;
		this.m.IsDoingForwardMove = false;
		this.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = this.m.BaseFatigueCost;
		this.m.MinRange = 1;
		this.m.MaxRange = 6;
		this.m.MaxLevelDifference = 6;
		this.m.ProjectileType = this.Const.ProjectileType.Missile;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of [color=%positive%]" + this.m.MaxRange + "[/color] tiles on even ground, more if shooting downhill. Damage based on current initiative."
			}
		]);
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "Accuracy based on ranged skill, damage based on current initiative. requires a magic staff"
			});

		return ret;
	}

	function isUsable()
	{
		if (!this.getContainer().getActor().isArmedWithMagicStaff())
		{
			return false
		}
		return !this.Tactical.isActive() || this.skill.isUsable() && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCost = this.m.BaseFatigueCost;
		this.m.MaxRange = this.m.Range - 1 + (_properties.IsSpecializedInStaves ? 1 : 0);
		this.m.FatigueCostMult = _properties.IsSpecializedInStaves ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.ActionPointCost = _properties.IsSpecializedInStaves ? 5 : 6;

		if (this.m.Container.hasPerk(::Legends.Perk.LegendMagicMissileFocus))
		{
			this.m.ActionPointCost -= 1;
		}
		if (this.m.Container.hasPerk(::Legends.Perk.LegendMagicMissileMastery))
		{
			this.m.ActionPointCost -= 1;
			this.m.FatigueCost -= 6;
		}
	}

});
