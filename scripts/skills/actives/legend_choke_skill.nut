this.legend_choke_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Backgrounds = [
			"background.legend_commander_druid",
			"background.legend_druid",
			"background.brawler",
			"background.legend_commander_berserker",
			"background.legend_berserker"
		]
	},
	function create()
	{
		this.m.ID = "actives.legend_choke";
		this.m.Name = "Choke";
		this.m.Description = "A well-placed attack at the opponent\'s neck. Ignores all armor but is harder to hit with. Hit chance is based on target's fatigue. Damage is based on the difference in fatigue. Deals 50% damage vs grappled or choked enemies. Hit chance is increased against grappled, stunned, netted, dazed, parried or sleeping enemies";
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
		this.m.HitChanceBonus = -15;
		this.m.DirectDamageMult = 1.0;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.Backgrounds = [
			"background.legend_commander_druid",
			"background.legend_druid",
			"background.brawler",
			"background.legend_commander_berserker",
			"background.legend_berserker"
		];
	}

	function getTooltip()
	{
		local actor = this.getContainer().getActor();
		local damage_min = 10; // Manual workaround because we're doing the math manually. Based on decapitate code
		local damage_max = 15;
		local has_unarmed_background = false;
		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_muscularity"))
			{
				local muscularity = this.Math.floor(actor.getHitpoints() * 0.1);
				damage_min = damage_min + muscularity;
				damage_max = damage_max + muscularity;
			}
		damage_min = this.Math.floor(damage_min*actor.getCurrentProperties().DamageTotalMult*actor.getCurrentProperties().MeleeDamageMult*actor.getCurrentProperties().DamageRegularMult);
		damage_max = this.Math.floor(damage_max*actor.getCurrentProperties().DamageTotalMult*2*actor.getCurrentProperties().MeleeDamageMult*actor.getCurrentProperties().DamageRegularMult);
		foreach( bg in this.m.Backgrounds ) // actually slightly wrong due to rounding errors. In practice underestimates damage by like 1-2 of max
		{
			if (actor.getSkills().hasSkill(bg)) // Hopefully there is a better way
			{
				damage_min = this.Math.floor(damage_min*1.25);
				damage_max = this.Math.floor(damage_max*1.25);
				has_unarmed_background = true;
				break;
			}
		}

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
			id = 4,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + damage_min + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_max + "[/color] damage depending on the difference in fatigue between you and the target"
		});


		foreach( bg in this.m.Backgrounds )
		{
			if (actor.getSkills().hasSkill(bg))
			{
				ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+25%[/color] damage from background"
			});
				break;
			}
		}

		if (this.m.Container.getActor().getCurrentProperties().IsSpecializedInFists)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+50%[/color] damage to choked or grappled enemies due to unarmed mastery"
			});

		}

		ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] chance to hit the head"
			});
		ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Completely ignores armor"
			});
		ret.push({
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Adds the choked effect which reduces enemy fatigue recovery by [color=" + this.Const.UI.Color.NegativeValue + "]15[/color]"
			});
		return ret;
	}

	function isUsable()
	{
		local mainhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local offhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		return ((offhand == null && mainhand == null) || this.getContainer().hasSkill("effects.disarmed")) && this.skill.isUsable();
	}

	function isHidden()
	{
		local mainhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local offhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		return mainhand != null || offhand != null && !this.getContainer().hasSkill("effects.disarmed") || this.skill.isHidden() || this.m.Container.getActor().isStabled();
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

		if (_targetEntity.getSkills().hasSkill("effects.legend_dazed"))
		{
			mod = mod + 10;
		}

		if (_targetEntity.getSkills().hasSkill("effects.legend_parried"))
		{
			mod = mod + 10;
		}

		if (_targetEntity.getSkills().hasSkill("effects.legend_grappled"))
		{
			mod = mod + 50;
		}

		if (_targetEntity.getSkills().hasSkill("effects.stunned"))
		{
			mod = mod + 25;
		}

		if (_targetEntity.getSkills().hasSkill("effects.sleeping"))
		{
			mod = mod + 50;
		}

		if (_targetEntity.getSkills().hasSkill("effects.net"))
		{
			mod = mod + 25;
		}

		if (_targetEntity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			mod = mod + 50;
		}

		local chance = (1.0 - _targetEntity.getFatiguePct()) * 50;
		return mod - this.Math.round(chance);
	}

	function onAfterUpdate( _properties )
	{
		if (_properties.IsSpecializedInFists)
		{
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
		}
	}

	function onUse( _user, _targetTile )
	{
		local success = this.attackEntity(_user, _targetTile.getEntity());
		if (success && _targetTile.IsOccupiedByActor)
		{
			local target = _targetTile.getEntity();
			target.getSkills().add(this.new("scripts/skills/effects/legend_choked_effect"));
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " choked " + this.Const.UI.getColorizedEntityName(target) + " ");
		}
		return success;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill != this)
		{
			return;
		}

		local chance = this.getHitChance(_targetEntity); // Calculates the hitchance bonus from other status effects
		local actor = this.getContainer().getActor();

		_properties.DamageRegularMin += 10; // If you change these values, change them in the tooltip above too.
		_properties.DamageRegularMax += 15;
		_properties.IsIgnoringArmorOnAttack = true;
		_properties.DamageArmorMult *= 0.0;
		_properties.MeleeSkill += chance;


		foreach( bg in this.m.Backgrounds )
		{
			if (actor.getSkills().hasSkill(bg))
			{
				_properties.DamageTotalMult *= 1.25;
				break;
			}
		}

		// Based on decapitate
		if (_targetEntity != null && actor.getFatiguePct() < _targetEntity.getFatiguePct()) {
			_properties.DamageRegularMult += _targetEntity.getFatiguePct() - actor.getFatiguePct();
		}

		if (_targetEntity != null && _targetEntity.getSkills().hasSkill("effects.legend_grappled") || _targetEntity.getSkills().hasSkill("effects.legend_choked"))
		{
			_properties.DamageRegularMult *= 1.5
		}
		_properties.HitChance[this.Const.BodyPart.Head] += 90.0; // copied what was used in lash for flails.

		local items = actor.getItems().getAllItems();
		foreach (item in items)
		{
			if (item.getID() == "accessory.legend_cestus" || item.getID() == "accessory.legend_hand_wraps")
				_properties.DamageTotalMult *= 1.1;
				return;
		}
	}


});

