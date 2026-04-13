this.legend_flagellate_skill <- this.inherit("scripts/skills/skill", {
	m = {
		SoundsA = [
			"sounds/combat/dlc4/whip_bleed_01.wav",
			"sounds/combat/dlc4/whip_bleed_02.wav",
			"sounds/combat/dlc4/whip_bleed_03.wav"
		],
		SoundsB = [
			"sounds/combat/dlc4/whip_hit_01.wav",
			"sounds/combat/dlc4/whip_hit_02.wav",
			"sounds/combat/dlc4/whip_hit_03.wav",
			"sounds/combat/dlc4/whip_hit_04.wav"
		]
	},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendFlagellate);
		this.m.Description = "Lash out to apply three stacks of bleeding damage at once. Quite ineffective against armor.";
		this.m.KilledString = "Flaggelated to death";
		this.m.Icon = "skills/flaggelate_square.png";
		this.m.IconDisabled = "skills/flaggelate_square_bw.png";
		this.m.Overlay = "active_161";
		this.m.SoundOnUse = [
			"sounds/combat/dlc4/whip_01.wav",
			"sounds/combat/dlc4/whip_02.wav",
			"sounds/combat/dlc4/whip_03.wav"
		];
		this.m.SoundOnHit = [];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.1;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function addResources()
	{
		foreach( r in this.m.SoundsA )
		{
			this.Tactical.addResource(r);
		}

		foreach( r in this.m.SoundsB )
		{
			this.Tactical.addResource(r);
		}
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		local dmg = this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5;
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=%positive%]1" + "[/color] tile"
		});
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts 3 bleeds each dealing a stacking [color=%damage%]" + dmg + "[/color] bleeding damage per turn, for 2 turns"
		});
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInCleavers ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local hp = target.getHitpoints();
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return;
		}

		if (success && !_targetTile.IsEmpty)
		{
			if (!target.isAlive() || target.isDying())
			{
				if (target.getFlags().has("tail") || !target.getCurrentProperties().IsImmuneToBleeding)
				{
					this.Sound.play(this.m.SoundsA[this.Math.rand(0, this.m.SoundsA.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
				}
				else
				{
					this.Sound.play(this.m.SoundsB[this.Math.rand(0, this.m.SoundsB.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
				}
			}
			else if (!target.getCurrentProperties().IsImmuneToBleeding && hp - target.getHitpoints() >= this.Const.Combat.MinDamageToApplyBleeding)
			{
				::Legends.Effects.grant(target, ::Legends.Effect.Bleeding, function(_effect) {
					if (_user.getFaction() == this.Const.Faction.Player )
						_effect.setActor(this.getContainer().getActor());
					_effect.setDamage(this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5);
				}.bindenv(this));
				::Legends.Effects.grant(target, ::Legends.Effect.Bleeding, function(_effect) {
					if (_user.getFaction() == this.Const.Faction.Player )
						_effect.setActor(this.getContainer().getActor());
					_effect.setDamage(this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5);
				}.bindenv(this));
				::Legends.Effects.grant(target, ::Legends.Effect.Bleeding, function(_effect) {
					if (_user.getFaction() == this.Const.Faction.Player )
						_effect.setActor(this.getContainer().getActor());
					_effect.setDamage(this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5);
				}.bindenv(this));
				this.Sound.play(this.m.SoundsA[this.Math.rand(0, this.m.SoundsA.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
			}
			else
			{
				this.Sound.play(this.m.SoundsB[this.Math.rand(0, this.m.SoundsB.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
			}
		}

		return success;
	}

});

