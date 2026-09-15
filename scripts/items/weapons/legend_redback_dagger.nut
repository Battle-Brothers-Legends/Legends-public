this.legend_redback_dagger <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.SoundOnUse <- ::Legends.S.setSounds("sounds/combat/puncture", 3);
		this.m.SoundOnHit <- ::Legends.S.setSounds("sounds/combat/puncture_hit", 3);
		this.m.ID = "weapon.legend_redback_dagger";
		this.m.Name = "Redback Dagger";
		this.m.Description = "A dagger made from the fang and poison gland of a redback spider, it can inject redback poison into a target";
		this.m.IconLarge = "weapons/melee/legend_redback_dagger.png";
		this.m.Icon = "weapons/melee/legend_redback_dagger_70x70.png";
		this.m.WeaponType = ::Const.Items.WeaponType.Dagger;
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_redback_dagger";
		this.m.Condition = 70.0;
		this.m.ConditionMax = 70.0;
		this.m.Value = 3800;
		this.m.Ammo = 8;
		this.m.AmmoMax = 8;
		this.m.AmmoCost = 1;
		this.m.ItemType = this.m.ItemType;
		this.m.RegularDamage = 26;
		this.m.RegularDamageMax = 52;
		this.m.ArmorDamageMult = 0.7;
		this.m.DirectDamageMult = 0.2;
	}

	function getAmmo() {
		return this.m.Ammo;
	}

	function getAmmoMax() {
		return this.m.AmmoMax;
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Applies redback poison to the target on any successful attack, dealing [color=%damage%]55[/color] damage over [color=%damage%]10[/color] turns."
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Puncture damage is increased by [color=%positive%]33%[/color] vs rooted targets"
		});
		return result;
	}


	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Stab);
		::Legends.Actives.grant(this, ::Legends.Active.Puncture);
		::Legends.Actives.grant(this, ::Legends.Active.Deathblow);
		::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendThrowKnife);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill != null && _skill.getID() == ::Legends.Actives.getID(::Legends.Active.Puncture) && _targetEntity != null && _targetEntity.getCurrentProperties().IsRooted)
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

		::Tactical.spawnIconEffect(_brush, _tile, ::Const.Tactical.Settings.SkillIconOffsetX, ::Const.Tactical.Settings.SkillIconOffsetY, ::Const.Tactical.Settings.SkillIconScale, ::Const.Tactical.Settings.SkillIconFadeInDuration, ::Const.Tactical.Settings.SkillIconStayDuration, ::Const.Tactical.Settings.SkillIconFadeOutDuration, ::Const.Tactical.Settings.SkillIconMovement);
	}

	function onDamageDealt( _target, _skill, _hitInfo )
	{
		this.weapon.onDamageDealt(_target, _skill, _hitInfo);
		if (_target.getCurrentProperties().IsImmuneToPoison || _hitInfo.DamageInflictedHitpoints <= ::Const.Combat.PoisonEffectMinDamage || _target.getHitpoints() <= 0)
			return;

		if (!_target.isAlive())
			return;

		if (_target.getFlags().has("undead"))
			return;

		if (!_target.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
			{
				::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * 1.5, _target.getPos());
			}

			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_target) + " is poisoned");
		}

		this.spawnIcon("status_effect_54", _target.getTile());
		local poison = ::Legends.Effects.get(_target, ::Legends.Effect.LegendRedbackSpiderPoison);
		local actor = this.getContainer().getActor();

		if (poison == null)
		{
			::Legends.Effects.grant(_target, ::Legends.Effect.LegendRedbackSpiderPoison, function(_effect) {
				if (actor.getFaction() == ::Const.Faction.Player )
					_effect.setActor(actor);
			}.bindenv(this));
		}
		else
		{
			if (actor.getFaction() == ::Const.Faction.Player )
				poison.setActor(actor);

			poison.resetTime();
		}
	}

});

