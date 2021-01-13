this.hand_to_hand <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.hand_to_hand";
		this.m.Name = "Hand-to-Hand Attack";
		this.m.Description = "Let them fly! Use your limbs to inflict damage on your enemy. Damage depends on training.";
		this.m.KilledString = "Pummeled to death";
		this.m.Icon = "skills/active_08.png";
		this.m.IconDisabled = "skills/active_08_sw.png";
		this.m.Overlay = "active_08";
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
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsSerialized = false;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.1;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 10;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getMods()
	{
		local ret = {
			Min = 5,
			Max = 10,
			HasMusc = false,
			HasBro = false,
			HasTraining = false
		}
		local actor = this.getContainer().getActor();

		if (actor.getSkills().hasSkill("perk.legend_unarmed_training"))
		{
			local average = (actor.getInitiative() + actor.getHitpoints()) * 0.25;
			ret.Min = average - 10;
			ret.Max = average + 10;
			ret.HasTraining = true;
		}

		if (actor.getSkills().hasSkill("perk.legend_muscularity"))
		{
			ret.Max += this.Math.floor(actor.getHitpoints() * 0.1);
			ret.HasMusc = true;
		}

		local backgrounds = [
			"background.legend_druid_commander",
			"background.legend_druid",
			"background.brawler",
			"background.legend_commander_berserker",
			"background.legend_berserker"
		];

		foreach (bg in backgrounds)
		{
			if (!actor.getSkills().hasSkill(bg))
			{
				continue;
			}
			ret.Min *= 1.25;
			ret.Max *= 1.25;
			ret.HasBro = true;
			break;
		}

		return ret;
	}

	function getTooltip()
	{
		local mods = this.getMods();
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

		if (mods.HasTraining)
		{
			ret.push({
				id = 4,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Unarmed Training inflicts half the average of your hitpoints and initiative. This will deal [color=" + this.Const.UI.Color.DamageValue + "]" + mods.Min + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + mods.Max + "[/color] damage"
			});

		}
		else
		{
			ret.push({
				id = 4,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + mods.Min + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + mods.Max + "[/color] damage"
			});
		}

		if (mods.HasBro)
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Includes +25% damage due to background"
			});
		}

		if (mods.HasMusc)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Includes [color=" + this.Const.UI.Color.DamageValue + "]+10%[/color] of your hitpoints as damage due to Muscularity"
			});
		}

		return ret;
	}

	function isUsable()
	{
		local mainhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		return (mainhand == null || this.getContainer().hasSkill("effects.disarmed")) && this.skill.isUsable();
	}

	function isHidden()
	{
		local mainhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		return mainhand != null && !this.getContainer().hasSkill("effects.disarmed") || this.skill.isHidden() || this.m.Container.getActor().isStabled() || this.getContainer().hasSkill("effect.legend_transformed_bear") || this.getContainer().hasSkill("effect.legend_transformed_wolf") || this.getContainer().hasSkill("effect.legend_transformed_tree");
	}

	function onUpdate( _properties )
	{
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill != this)
		{
			return;
		}

		local mods = this.getMods();
		_properties.DamageRegularMin += mods.Min;
		_properties.DamageRegularMax += mods.Max
		if (!mods.HasTraining)
		{
			_properties.DamageArmorMult = 0.5;
		}
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInFists ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.ActionPointCost = _properties.IsSpecializedInFists ? 3 : 4;

	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

});

