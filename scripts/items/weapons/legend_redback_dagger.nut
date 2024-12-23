this.legend_redback_dagger <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.SoundOnUse <- [
			"sounds/combat/puncture_01.wav",
			"sounds/combat/puncture_02.wav",
			"sounds/combat/puncture_03.wav"
		];
		this.m.SoundOnHit <- [
			"sounds/combat/puncture_hit_01.wav",
			"sounds/combat/puncture_hit_02.wav",
			"sounds/combat/puncture_hit_03.wav"
		];
		this.m.ID = "weapon.legend_redback_dagger";
		this.m.Name = "Redback Dagger";
		this.m.Description = "A dagger made from the fang and poison gland of a redback spider, it can inject redback poison into a target";
		this.m.IconLarge = "weapons/melee/legend_redback_dagger.png";
		this.m.Icon = "weapons/melee/legend_redback_dagger_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Dagger;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_redback_dagger";
		this.m.Condition = 70.0;
		this.m.ConditionMax = 70.0;
		this.m.Value = 3800;
		this.m.RegularDamage = 26;
		this.m.RegularDamageMax = 52;
		this.m.ArmorDamageMult = 0.7;
		this.m.DirectDamageMult = 0.36;
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Applies redback poison to the target on any successful attack, dealing 55 damage over 10 turns."
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Puncture damage is increased by [color=" + this.Const.UI.Color.PositiveValue + "]33%[/color] vs rooted targets"
		});
		return result;
	}


	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/stab"));
		this.addSkill(this.new("scripts/skills/actives/puncture"));
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill != null && _skill.getID() == "actives.puncture" && _targetEntity != null && _targetEntity.getCurrentProperties().IsRooted)
		{
			_properties.DamageRegularMult *= 1.33;
		}
	}

	function spawnIcon( _brush, _tile )
	{
		if (!_tile.IsVisibleForPlayer)
		{
			return;
		}

		this.Tactical.spawnIconEffect(_brush, _tile, this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
	}

	function onDamageDealt( _target, _skill, _hitInfo )
	{
		if (_target.getCurrentProperties().IsImmuneToPoison || _hitInfo.DamageInflictedHitpoints <= this.Const.Combat.PoisonEffectMinDamage || _target.getHitpoints() <= 0)
			return;

		if (!_target.isAlive())
			return;

		if (_target.getFlags().has("undead"))
			return;

		if (!_target.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.5, _target.getPos());
			}

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_target) + " is poisoned");
		}

		this.spawnIcon("status_effect_54", _target.getTile());
		local poison = _target.getSkills().getSkillByID("effects.legend_redback_spider_poison");
		local effect = this.new("scripts/skills/effects/legend_redback_spider_poison_effect");
		local actor = this.getContainer().getActor();
		if (actor.getFaction() == this.Const.Faction.Player )
		{
			effect.setActor(actor);
			if (poison != null)
			{
				poison.setActor(actor);
			}
		}

		if (poison == null)
		{
			_target.getSkills().add(effect);
		}
		else
		{
			poison.resetTime();
		}
	}

});

