this.legend_kick_skill <- this.inherit("scripts/skills/skill", {
	m = {
			DazeChance = 25
		},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendKick);
		this.m.Description = "Kick a target to break their balance. The blow will inflict additional fatigue, stagger the target, and has a chance to inflict daze as well. Shieldwall, Spearwall, Return Favor, and Riposte will be canceled for a target that is successfully hit.";
		this.m.Icon = "skills/kick_square.png";
		this.m.IconDisabled = "skills/kick_square_bw.png";
		this.m.Overlay = "active_kick";
		this.m.SoundOnUse = [
			"sounds/combat/knockback_01.wav",
			"sounds/combat/knockback_02.wav",
			"sounds/combat/knockback_03.wav"
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
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 14;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local actor = this.getContainer().getActor();
		local p = this.getContainer().getActor().getCurrentProperties();
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

		if (p.IsSpecializedInFists)
		{

			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+40%[/color] chance to hit"
			});
			// New
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] chance to stagger on a hit"
			});
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] chance to daze on a hit"
			});
		}
		else
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+25%[/color] chance to hit"
			});
			// New
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] chance to stagger on a hit"
			});
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]25%[/color] chance to daze on a hit"
			});
		}
		ret.push({
			id = 9,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + this.Const.Combat.FatigueReceivedPerHit * 2 + "[/color] fatigue on hit"
		});
		return ret;
		}


	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local hasFistMastery = _user.getSkills().hasPerk(::Legends.Perk.LegendSpecUnarmed);
		local skills = target.getSkills();

		if (this.m.SoundOnUse.len() != 0)
		{
			this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
		}

		if (this.Math.rand(1, 100) > this.getHitchance(target))
		{
			target.onMissed(this.getContainer().getActor(), this);
			return false;
		}

		this.applyFatigueDamage(target, 10);
		this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " inflicted 10 fatigue on " + this.Const.UI.getColorizedEntityName(target) + " with a kick");

		// Remove enemy stances
		::Const.Tactical.Common.removeStances(target);

		if (this.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
		}

		if (hasFistMastery)
		{
			this.m.DazeChance = 50;
		}

		::Legends.Effects.grant(target, ::Legends.Effect.Staggered); // Always stagger, sometimes daze
		this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has staggered " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
		if (this.Math.rand(1, 100) <= this.m.DazeChance && !target.getCurrentProperties().IsImmuneToDaze)
		{
			::Legends.Effects.grant(target, ::Legends.Effect.Dazed);
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " struck a blow that leaves " + this.Const.UI.getColorizedEntityName(target) + " dazed");
		}
		return true;
	}

	function onAfterUpdate( _properties )
	{
		if ("IsSpecializedInFists" in _properties)
		{
			this.m.FatigueCostMult = _properties.IsSpecializedInFists ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.MeleeSkill += 25;

			if (_properties.IsSpecializedInFists)
			{
				_properties.MeleeSkill += 15;
			}
		}
	}

});

