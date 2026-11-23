this.legend_grapple_skill <- this.inherit("scripts/skills/skill", {
	m = {
		DisarmChance = 50
	},

	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendGrapple);
		this.m.Description = "Grab, hold, and restrain a target, reducing their melee defense by 12 and initiative by 30% for 2 turns. A particularly lucky or skilled maneuver may disarm the opponent. One hand must be free to use.";
		this.m.Icon = "skills/grapple_square.png";
		this.m.IconDisabled = "skills/grapple_square_bw.png";
		this.m.Overlay = "active_grapple";
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
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted+5;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = false;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 5; // Increased from 4. Can only be used once per turn
		this.m.FatigueCost = 20;
		this.m.HitChanceBonus = -20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
	}


	function getTooltip()
	{
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

		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=%positive%]100%[/color] chance to grapple on a hit"
		});

		if (!::Legends.Perks.has(this, ::Legends.Perk.LegendGrappler))
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has a [color=%negative%]-20%[/color] chance to hit"
			});
		}
		if (this.m.Container.getActor().getCurrentProperties().IsSpecializedInFists)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]100%[/color] chance to disarm on a hit due to unarmed mastery"
			});
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=%positive%]+10%[/color] chance to hit due to unarmed mastery"
			});

		}
		else {
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]50%[/color] chance to disarm"
			});
		}
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInFists ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
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
			// Now always grapples
			::Legends.Effects.grant(target, ::Legends.Effect.LegendGrappled);
			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has grappled " + this.Const.UI.getColorizedEntityName(target) + " for two turns");
			}
			if ((this.Math.rand(1, 100) > this.m.DisarmChance || _user.getCurrentProperties().IsSpecializedInFists) && !target.getCurrentProperties().IsImmuneToDisarm)
			{
				::Legends.Effects.grant(target, ::Legends.Effect.Disarmed);
			}
		}

		return true;
	}

	function isUsable()
	{
		local actor = this.getContainer().getActor();
		local mainhand = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local offhand = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local hasNet = actor.getCurrentProperties().IsSpecializedInNets && offhand != null && offhand.getID().find("throwing_net") != null;
		if (hasNet)
			return true;
		return ((offhand == null || mainhand == null) || this.getContainer().hasEffect(::Legends.Effect.Disarmed)) && this.skill.isUsable();
	}

	function isHidden()
	{
		local actor = this.getContainer().getActor();
		local mainhand = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local offhand = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local hasNet = actor.getCurrentProperties().IsSpecializedInNets && offhand != null && offhand.getID().find("throwing_net") != null;
		if (hasNet)
			return false;

		return mainhand != null && offhand != null && !this.getContainer().hasEffect(::Legends.Effect.Disarmed) || this.getContainer().getActor().getItems().hasBlockedSlot(this.Const.ItemSlot.Offhand) || this.skill.isHidden() || actor.isStabled();
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.MeleeSkill -= 20;
			_properties.DamageTotalMult = 0;
			if (_properties.IsSpecializedInFists)
			{
				_properties.MeleeSkill += 10;
				this.m.HitChanceBonus += 10;
			}

			if (::Legends.Perks.has(this, ::Legends.Perk.LegendGrappler))
			{
				_properties.MeleeSkill += 20;
				this.m.HitChanceBonus += 20;
			}
		}
	}

});

