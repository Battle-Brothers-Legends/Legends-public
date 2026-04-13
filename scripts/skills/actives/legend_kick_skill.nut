this.legend_kick_skill <- this.inherit("scripts/skills/skill", {
	m = {
		DazeChance = 25,
		HasLeg = false,
		FatigueDamage = 5
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
		this.m.HitChanceBonus = 25;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 14;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local actor = this.getContainer().getActor();
		local p = this.getContainer().getActor().getCurrentProperties();
		local ret = ::Legends.Perks.has(this, ::Legends.Perk.LegendPugilist) ? this.getDefaultTooltip() : this.getDefaultUtilityTooltip();

		if (p.IsSpecializedInFists)
		{

			// if (!this.m.HasLeg)
			// {
			// 	ret.push({
			// 		id = 6,
			// 		type = "text",
			// 		icon = "ui/icons/hitchance.png",
			// 		text = "Has [color=%positive%]+40%[/color] chance to hit"
			// 	});
			// }
			// New
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]100%[/color] chance to stagger on a hit"
			});
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]50%[/color] chance to daze on a hit"
			});
		}
		else
		{
			// if (!hasLeg)
			// {
			// 	ret.push({
			// 		id = 6,
			// 		type = "text",
			// 		icon = "ui/icons/hitchance.png",
			// 		text = "Has [color=%positive%]+25%[/color] chance to hit"
			// 	});
			// }
			// New
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]100%[/color] chance to stagger on a hit"
			});
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]25%[/color] chance to daze on a hit"
			});
		}
		ret.push({
			id = 9,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts [color=%damage%]" + this.m.FatigueDamage + "[/color] fatigue on hit"
		});
		return ret;
	}

	function isUsable()
	{
		if (::Legends.Perks.has(this, ::Legends.Perk.LegendPugilist))
			return true;
		local mainhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local offhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		return ((offhand == null || mainhand == null) || this.getContainer().hasEffect(::Legends.Effect.Disarmed)) && this.skill.isUsable();
	}

	function isHidden()
	{
		if (::Legends.Perks.has(this, ::Legends.Perk.LegendPugilist))
			return false;
		local mainhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local offhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		return mainhand != null && offhand != null && !this.getContainer().hasEffect(::Legends.Effect.Disarmed) || this.getContainer().getActor().getItems().hasBlockedSlot(this.Const.ItemSlot.Offhand) || this.skill.isHidden() || this.m.Container.getActor().isStabled();
	}


	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local skills = target.getSkills();

		if (this.m.SoundOnUse.len() != 0)
		{
			this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
		}

		local success = this.attackEntity(_user, target);

		if (::Legends.S.skillEntityAliveCheck(_user, target))
			return success;

		if (!success)
			return success;

		this.applyFatigueDamage(target, this.m.FatigueDamage);

		// Remove enemy stances
		::Const.Tactical.Common.removeStances(target);

		::Legends.Effects.grant(target, ::Legends.Effect.Staggered); // Always stagger, sometimes daze
		this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has staggered " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
		if (this.Math.rand(1, 100) <= this.m.DazeChance && !target.getCurrentProperties().IsImmuneToDaze)
		{
			::Legends.Effects.grant(target, ::Legends.Effect.Dazed);
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " struck a blow that leaves " + this.Const.UI.getColorizedEntityName(target) + " dazed");
		}
		return success;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInFists ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.DazeChance = _properties.IsSpecializedInFists ? 50 : 25;
		this.m.FatigueDamage = _properties.IsSpecializedInFists ? 10 : 5;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.MeleeSkill += 25;
			_properties.DamageRegularMin = 0;
			_properties.DamageRegularMax = 0;
			_properties.DamageArmorMult = 0.0;

			if (_properties.IsSpecializedInFists)
			{
				_properties.MeleeSkill += 15;
				this.m.HitChanceBonus += 15;
			}

			if (::Legends.Perks.has(this, ::Legends.Perk.LegendPugilist))
			{
				local actor = this.getContainer().getActor();
				_properties.DamageRegularMin = 10;
				_properties.DamageRegularMax = 15;
				_properties.DamageArmorMult = 0.6;
			}
		}
	}

});

