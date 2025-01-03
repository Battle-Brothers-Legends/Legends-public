this.perk_legend_unarmed_training <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendUnarmedTraining);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.First + 2;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		local actor = this.getContainer().getActor();

		if (_skill.getID() == "actives.hand_to_hand")
		{
			if (_properties.IsSpecializedInFists)
				_properties.DamageArmorMult *= 1.2;
			if (this.getContainer().hasSkill("perk.sundering_strikes"))
				_properties.DamageArmorMult *= 1.2;

			local damage = (actor.getHitpointsMax()) / 15;

			if (actor.getOffhandItem() != null)
				damage = damage * 0.5;

			if (actor.getMainhandItem() != null)
				damage = damage * 0.2;

			_properties.DamageRegularMin += this.Math.floor(damage);
			_properties.DamageRegularMax += this.Math.floor(damage);
		}

		if (_skill.getID() == "actives.legend_choke")
		{
			_properties.DamageTotalMult *= 1.5;
			_properties.MeleeSkill += 10;
		}
	}

	function onAdded()
	{
		if (!this.getContainer().hasSkill("actives.legend_tackle") && this.getContainer().getActor().isPlayerControlled())
		{
			this.getContainer().add(this.new("scripts/skills/actives/legend_tackle_skill"));
		}
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.legend_tackle");
	}

});

