this.legend_magic_hailstone_skill <- this.inherit("scripts/skills/actives/legend_magic_attack_skill", {
	m = {
		AdditionalAccuracy = 0,
		AdditionalHitChance = 0
	},

	function create() {
		this.legend_magic_attack.create();

		::Legends.Actives.onCreate(this, ::Legends.Active.LegendMagicHailstone);
		this.m.Description = "Conjure a heavy ball of ice to crush your enemies.";
		this.m.KilledString = "Crushed under ice";
		this.m.Icon = "skills/mage_legend_magic_hailstone_square.png";
		this.m.IconDisabled = "mage_skills/legend_magic_hailstone_square_bw.png";
		this.m.Overlay = "mage_legend_magic_hailstone_square";
		this.m.SoundOnUse = [
			"sounds/combat/magic_missile_01.wav",
			"sounds/combat/magic_missile_02.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/dlc4/sling_hit_01.wav",
			"sounds/combat/dlc4/sling_hit_02.wav",
			"sounds/combat/dlc4/sling_hit_03.wav",
			"sounds/combat/dlc4/sling_hit_04.wav"
		];
		this.m.SoundOnHitShield = [
			"sounds/combat/dlc4/sling_shield_hit_01.wav",
			"sounds/combat/dlc4/sling_shield_hit_02.wav",
			"sounds/combat/dlc4/sling_shield_hit_03.wav",
			"sounds/combat/dlc4/sling_shield_hit_04.wav",
			"sounds/combat/dlc4/sling_shield_hit_05.wav"
		];
		this.m.SoundOnMiss = [
			"sounds/combat/dlc4/sling_miss_01.wav",
			"sounds/combat/dlc4/sling_miss_02.wav",
			"sounds/combat/dlc4/sling_miss_03.wav",
			"sounds/combat/dlc4/sling_miss_04.wav",
			"sounds/combat/dlc4/sling_miss_05.wav",
			"sounds/combat/dlc4/sling_miss_06.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted+1;
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
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.ActionPointCost = 8;
		this.m.FatigueCost = 70;
		this.m.MinRange = 1;
		this.m.MaxRange = 4;
		this.m.MaxLevelDifference = 6;
		this.m.ProjectileType = this.Const.ProjectileType.Missile;
		this.m.ChanceSmash = 25;

		this.m.DirectDamageMult = 0.5;
		this.m.DamageArmorMult = 1.1;
		this.m.ResolveScaling = 1;
		this.m.BaseDamageRegularMin = 15;
		this.m.BaseDamageRegularMax = 25;
	}

	function onUpdate( _properties )
	{
		this.applyPerks();
	}

	function applyPerks() {
		if (this.m.Container.hasPerk(::Legends.Perk.LegendMasteryHailstone))
		{
			this.m.DirectDamageMult = 0.65;
			this.m.DamageArmorMult = 1.25;
		}
	}

	function getTooltip()
	{
		local actor = this.getContainer().getActor();
		local p = actor.getCurrentProperties();
		local mult = p.DamageTotalMult;

		this.setDamage();
		local damages = this.getDamageRange();

		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			}
		];
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "Inflicts [color=%damage%]" + damages[0] + "[/color] - [color=%damage%]" + damages[1] + "[/color] damage, up to [color=%damage%]" + damages[4] + "[/color] damage can ignore armor"
		});

		if (damages[3] > 0)
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "Inflicts [color=%damage%]" + damages[2] + "[/color] - [color=%damage%]" + damages[3] + "[/color] armor damage"
			});
		}

		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has [color=%negative%]" + (-2 + this.m.AdditionalHitChance) + "%[/color] chance to hit per tile of distance"
		});

		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of [color=%positive%]" + this.m.MaxRange + "[/color] tiles on even ground, more if shooting downhill. Damage based on current resolve."
			}
		]);
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/ranged_skill.png",
			text = "Accuracy based on ranged skill, damage based on resolve. Requires a magic staff"
		});
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			this.setDamage();
			_properties.DamageRegularMin = this.m.DamageRegularMin;
			_properties.DamageRegularMax = this.m.DamageRegularMax;
			_properties.DamageArmorMult = this.m.DamageArmorMult;
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += -2 + this.m.AdditionalHitChance;
		}
	}
});
