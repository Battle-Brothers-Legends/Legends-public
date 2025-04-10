this.legend_choke_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendChoke);
		this.m.Description = "A well-placed attack at an opponent\'s neck. Ignores all armor but is harder to hit with. Hit chance is based on target's fatigue. Damage is based on the difference in fatigue. Deals 50% damage against grappled or choked enemies. Hit chance is increased against grappled, stunned, netted, dazed, parried or sleeping enemies.";
		this.m.KilledString = "Choked";
		this.m.Icon = "skills/choke_square.png";
		this.m.IconDisabled = "skills/choke_square_bw.png";
		this.m.Overlay = "active_choke";
		this.m.SoundOnUse = [
			"sounds/combat/puncture_01.wav",
			"sounds/combat/puncture_02.wav",
			"sounds/combat/puncture_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/puncture_hit_01.wav",
			"sounds/combat/puncture_hit_02.wav",
			"sounds/combat/puncture_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted+3;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.HitChanceBonus = -65;
		this.m.DirectDamageMult = 1.0;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local actor = this.getContainer().getActor();
		local tooltip = this.getDefaultTooltip();

		if (this.m.Container.getActor().getCurrentProperties().IsSpecializedInFists)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+50%[/color] damage to choked or grappled enemies due to unarmed mastery"
			});

		}

		tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] chance to hit the head"
			});
		tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Completely ignores armor"
			});
		tooltip.push({
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Adds the choked effect which reduces enemy fatigue recovery by [color=" + this.Const.UI.Color.NegativeValue + "]15[/color]"
			});
		return tooltip;
	}

	function isUsable()
	{
		local mainhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local offhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		return ((offhand == null && mainhand == null) || this.getContainer().hasEffect(::Legends.Effect.Disarmed)) && this.skill.isUsable();
	}

	function isHidden()
	{
		local mainhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local offhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		return mainhand != null || offhand != null && !this.getContainer().hasEffect(::Legends.Effect.Disarmed) || this.skill.isHidden() || this.m.Container.getActor().isStabled();
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		if (_skill == this)
		{
			local target = _targetTile.getEntity();
			local actor = this.getContainer().getActor();
			if (target != null)
			{
				local bonus = this.Math.max(0, this.Math.floor((target.getFatiguePct() - actor.getFatiguePct())*100));
				this.logInfo(bonus);
				_tooltip.push({
				icon = "ui/tooltips/positive.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + bonus + "%[/color] damage due to the difference in fatigue"
			});
			}
		}
	}

	function getHitChance( _targetEntity )
	{
		if (_targetEntity == null)
		{
			return 0;
		}
		local mod = 0;
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.LegendDazed))
		{
			mod += 10;
		}
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.LegendParried))
		{
			mod += 10;
		}
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.LegendGrappled))
		{
			mod += 50;
		}
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.Stunned))
		{
			mod += 25;
		}
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.Sleeping))
		{
			mod += 50;
		}
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.Net))
		{
			mod += 25;
		}
		if (_targetEntity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			mod += 50;
		}
		local chance = _targetEntity.getFatiguePct() * 50;
		return mod + this.Math.round(chance);
	}

	function onAfterUpdate( _properties )
	{
			this.m.FatigueCostMult = _properties.IsSpecializedInFists ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		local success = this.attackEntity(_user, _targetTile.getEntity());
		if (success && _targetTile.IsOccupiedByActor)
		{
			local target = _targetTile.getEntity();
			::Legends.Effects.grant(target, ::Legends.Effect.LegendChoked);
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " choked " + this.Const.UI.getColorizedEntityName(target) + " ");
		}
		return success;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill != this)
			return;

		this.m.HitChanceBonus += this.getHitChance(_targetEntity); // Calculates the hitchance bonus from other status effects
		local actor = this.getContainer().getActor();

		_properties.DamageRegularMin += 10; // If you change these values, change them in the tooltip above too.
		_properties.DamageRegularMax += 15;
		_properties.IsIgnoringArmorOnAttack = true;
		_properties.DamageArmorMult *= 0.0;
		_properties.MeleeSkill += this.m.HitChanceBonus;

		// Based on decapitate
		if (_targetEntity != null && actor.getFatiguePct() < _targetEntity.getFatiguePct()) {
			_properties.DamageRegularMult += _targetEntity.getFatiguePct() - actor.getFatiguePct();
		}

		if (_targetEntity != null && (_targetEntity.getSkills().hasEffect(::Legends.Effect.LegendGrappled) || _targetEntity.getSkills().hasEffect(::Legends.Effect.LegendChoked)))
		{
			_properties.DamageRegularMult *= 1.5
		}
		_properties.HitChance[this.Const.BodyPart.Head] += 90.0; // copied what was used in lash for flails.

		local items = actor.getItems().getAllItems();
		local hasCestus = false;
		local hasWraps = false;
		local hasGauntlets = false;
		foreach (item in items)
		{
			if (item.getID() == "accessory.legend_hand_wraps")
				hasWraps = true;
			if (item.getID() == "accessory.legend_cestus")
				hasCestus = true;
		}

		if (_skill != this)
			return;

		else if (hasCestus)
		{
			_properties.DamageTotalMult *= 1.1;
		}
		else if (hasWraps)
		{
			_properties.DamageTotalMult *= 1.05;
		}
	}


});

