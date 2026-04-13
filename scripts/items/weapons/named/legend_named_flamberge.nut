this.legend_named_flamberge <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		StunChance = 0,
		SoundsA = [
			"sounds/combat/cleave_hit_hitpoints_01.wav",
			"sounds/combat/cleave_hit_hitpoints_02.wav",
			"sounds/combat/cleave_hit_hitpoints_03.wav"
		],
		SoundsB = [
			"sounds/combat/chop_hit_01.wav",
			"sounds/combat/chop_hit_02.wav",
			"sounds/combat/chop_hit_03.wav"
		]
	},

	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_flamberge";
		this.m.NameList = this.Const.Strings.GreatswordNames;
		this.m.Description = "This greatsword shows great craftmanship. It is of great length and strength, holding a great balance in the hands.";
		this.m.IconLarge = "weapons/melee/flamberge_01_named_01.png";
		this.m.Icon = "weapons/melee/flamberge_01_named_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_named_flamberge_01";
		this.m.Value = 5200;
		this.m.ShieldDamage = 16;
		this.m.Condition = 76.0;
		this.m.ConditionMax = 76.0;
		this.m.StaminaModifier = -12;
		this.m.RegularDamage = 90;
		this.m.RegularDamageMax = 105;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.25;
		this.m.ChanceToHitHead = 5;
		this.randomizeValues();
	}

	function getTooltip()
	{
		local result = this.named_weapon.getTooltip();
		result.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts additional stacking [color=%damage%]2[/color] bleeding damage per turn, for 2 turns"
		});
		return result;
	}

	function onDamageDealt( _target, _skill, _hitInfo )
	{
		this.named_weapon.onDamageDealt(_target, _skill, _hitInfo);
		local actor = this.getContainer().getActor();
		if (!_target.isAlive() || _target.isDying())
			return;

		_skill.spawnAttackEffect(_target.getTile(), this.Const.Tactical.AttackEffectChop);
		if (!actor.isAlive() || actor.isDying())
			return;

		if (!_target.isAlive() || _target.isDying())
		{
			if (_target.getFlags().has("tail") || !_target.getCurrentProperties().IsImmuneToBleeding)
			{
				this.Sound.play(this.m.SoundsA[this.Math.rand(0, this.m.SoundsA.len() - 1)], this.Const.Sound.Volume.Skill, actor.getPos());
			}
			else
			{
				this.Sound.play(this.m.SoundsB[this.Math.rand(0, this.m.SoundsB.len() - 1)], this.Const.Sound.Volume.Skill, actor.getPos());
			}
		}
		else if (!_target.getCurrentProperties().IsImmuneToBleeding)
		{
			::Legends.Effects.grant(_target, ::Legends.Effect.Bleeding, function(_effect) {
				if (actor.getFaction() == this.Const.Faction.Player )
					_effect.setActor(this.getContainer().getActor());
				_effect.setDamage(2);
			}.bindenv(this));
			this.Sound.play(this.m.SoundsA[this.Math.rand(0, this.m.SoundsA.len() - 1)], this.Const.Sound.Volume.Skill, actor.getPos());
		}
		else
		{
			this.Sound.play(this.m.SoundsB[this.Math.rand(0, this.m.SoundsB.len() - 1)], this.Const.Sound.Volume.Skill, actor.getPos());
		}
	}

	function onEquip() {
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.OverheadStrike, function (_skill) {
			_skill.setStunChance(this.m.StunChance);
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Split);
		::Legends.Actives.grant(this, ::Legends.Active.Swing);
		::Legends.Actives.grant(this, ::Legends.Active.SplitShield, function (_skill) {
			_skill.setFatigueCost(_skill.getFatigueCostRaw() + 5);
		}.bindenv(this));
	}

});
