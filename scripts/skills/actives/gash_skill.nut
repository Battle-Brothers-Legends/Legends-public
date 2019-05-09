this.gash_skill <- this.inherit("scripts/skills/skill", {
	m = {
		SoundsA = [
			"sounds/combat/cleave_hit_hitpoints_01.wav",
			"sounds/combat/cleave_hit_hitpoints_02.wav",
			"sounds/combat/cleave_hit_hitpoints_03.wav"
		]
	},
	function create()
	{
		this.m.ID = "actives.gash";
		this.m.Name = "Gash";
		this.m.Description = "A powerful slashing attack that is likely to inflict debilitating injuries.";
		this.m.KilledString = "Cut down";
		this.m.Icon = "skills/active_189.png";
		this.m.IconDisabled = "skills/active_189_sw.png";
		this.m.Overlay = "active_189";
		this.m.SoundOnUse = [
			"sounds/combat/slash_01.wav",
			"sounds/combat/slash_02.wav",
			"sounds/combat/slash_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/slash_hit_01.wav",
			"sounds/combat/slash_hit_02.wav",
			"sounds/combat/slash_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.HitChanceBonus = 10;
		this.m.DirectDamageMult = 0.2;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 75;
		this.m.ChanceDisembowel = 33;
		this.m.ChanceSmash = 0;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has a [color=" + this.Const.UI.Color.NegativeValue + "]33%[/color] lower threshold to inflict injuries"
			}
		]);
		return ret;
	}

	function addResources()
	{
		foreach( r in this.m.SoundsA )
		{
			this.Tactical.addResource(r);
		}
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInSwords ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSlash);
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (_skill == this)
		{
			_hitInfo.InjuryThresholdMult *= 0.66;

			if (_targetEntity.isAlive() && !_targetEntity.getCurrentProperties().IsImmuneToBleeding)
			{
				this.Sound.play(this.m.SoundsA[this.Math.rand(0, this.m.SoundsA.len() - 1)], this.Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
			}
		}
	}

});

