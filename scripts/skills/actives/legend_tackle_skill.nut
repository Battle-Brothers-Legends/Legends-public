this.legend_tackle_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendTackle);
		this.m.Description = "Tackle an enemy to the ground. On a hit, decrease their melee defence by 50%, their initiative by 70%, and increases the damage they take by 25%. The more fatigued your target, the more likely the tackle is to succeed.";
		this.m.Icon = "skills/tackle_square.png";
		this.m.IconDisabled = "skills/tackle_square_bw.png";
		this.m.Overlay = "active_32";
		this.m.SoundOnUse = [
			"sounds/combat/hand_01.wav",
			"sounds/combat/hand_02.wav",
			"sounds/combat/hand_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/hand_hit_01.wav",
			"sounds/combat/hand_hit_02.wav",
			"sounds/combat/hand_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 30;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
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
		if (this.m.Container.getActor().getCurrentProperties().IsSpecializedInFists)
		{
			ret.push({
				id = 4,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=%positive%]+10%[/color] chance to hit due to unarmed mastery"
			});
		}
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=%positive%]100%[/color] chance to knock the opponent over"
		});

		return ret;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		if (this.m.SoundOnUse.len() != 0)
		{
			this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
		}

		if (this.Math.rand(1, 100) > this.getHitchance(_targetTile.getEntity()))
		{
			target.onMissed(this.getContainer().getActor(), this);
			return false;
		}
		if (_targetTile.IsOccupiedByActor)
		{
			local target = _targetTile.getEntity();
			::Legends.Effects.grant(target, ::Legends.Effect.LegendTackled);
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has tackled " + this.Const.UI.getColorizedEntityName(target) + " to the ground for two turns");
		}

		return true;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInFists ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill != this)
		{
			return;
		}
		local bonus = this.Math.floor(_targetEntity.getFatiguePct() * 30); // This means that you'll get a +30% boost against an enemy with max fatigue
		_properties.MeleeSkill += bonus;
		_properties.DamageTotalMult = 0;
		if (_properties.IsSpecializedInFists) //Not sure if this is the best way to do it, but this is how it was done in kick
		{
			_properties.MeleeSkill += 10;
		}
	}

});

