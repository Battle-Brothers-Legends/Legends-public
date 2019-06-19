this.hand_to_hand <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.hand_to_hand";
		this.m.Name = "Hand-to-Hand Attack";
		this.m.Description = "Let them fly!  Maximum damage is the average of your hitpoints and initiative minus 90";
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

	function getTooltip()
	{
		local actor = this.getContainer().getActor()
		local p = actor.getCurrentProperties();
		local mult = 1.0;

		if (this.getContainer().hasSkill("background.brawler"))
		{
			mult = 2.0;
		}
		local Avg = (actor.getInitiative() +  actor.getHitpointsMax()) / 2;
		local DamageMin = 5 + this.Math.floor(Avg - 90);
		local DamageMax = 5 + this.Math.floor(Avg - 80);

		local damage_regular_min = DamageMin * p.DamageRegularMult * p.DamageTotalMult * mult;
		local damage_regular_max = DamageMax * p.DamageRegularMult * p.DamageTotalMult * mult;
		local damage_Armor_min = DamageMin * p.DamageArmorMult * p.DamageTotalMult * mult;
		local damage_Armor_max = DamageMax * p.DamageArmorMult * p.DamageTotalMult * mult;
		local damage_direct_max = this.Math.floor(DamageMax * this.m.DirectDamageMult);
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
			text = "Inflicts damage based on hitpoints and initiative [color=" + this.Const.UI.Color.DamageValue + "]" + damage_regular_min + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_regular_max + "[/color] damage, of which [color=" + this.Const.UI.Color.DamageValue + "]0[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_direct_max + "[/color] can ignore armor"
		});

		if (damage_Armor_max > 0)
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + damage_Armor_min + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_Armor_max + "[/color] armor damage"
			});
		}

		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] chance to hit"
		});
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
		return mainhand != null && !this.getContainer().hasSkill("effects.disarmed") || this.skill.isHidden();
	}

	function onUpdate( _properties )
	{
		if (this.isUsable())
		{
			_properties.DamageArmorMult *= 0.5;
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local actor = this.getContainer().getActor();
			local Avg = (actor.getInitiative() +  actor.getHitpointsMax()) / 2;
			_properties.DamageRegularMin += 5 + this.Math.floor(Avg - 100);
			_properties.DamageRegularMax += 5 + this.Math.floor(Avg - 90);
			_properties.MeleeSkill -= 10;
			this.m.DirectDamageMult = _properties.IsSpecializedInFists ? 0.5 : 0.1;
		}
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInFists ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

});

