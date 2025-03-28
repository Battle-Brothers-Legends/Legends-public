this.perk_legend_unarmed_training <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendUnarmedTraining);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.First + 2;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		local actor = this.getContainer().getActor();

		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.HandToHand))
		{
			if (_properties.IsSpecializedInFists)
				_properties.DamageArmorMult *= 1.2;
			if (this.getContainer().hasPerk(::Legends.Perk.SunderingStrikes) || this.getContainer().hasPerk(::Legends.Perk.LegendSmackdown))
				_properties.DamageArmorMult *= 1.2;

			local damage = (actor.getHitpointsMax()) / 15;

			if (actor.getOffhandItem() != null)
				damage = damage * 0.5;

			if (actor.getMainhandItem() != null)
				damage = damage * 0.2;

			_properties.DamageRegularMin += this.Math.floor(damage);
			_properties.DamageRegularMax += this.Math.floor(damage);
		}

		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.LegendChoke))
		{
			_properties.DamageTotalMult *= 1.5;
			_properties.MeleeSkill += 10;
		}

		foreach (tier in ::Const.Perks.FistsTree.Tree)
		{
			foreach (perk in tier)
			{
				if (!this.getContainer().hasPerk(perk))
				{
					return; // we don't have a perk in the tree
				}
			}
		}
		if (_skill.getID() == "actives.legend_choke" || _skill.getID() == "actives.hand_to_hand")
		{
			_properties.DamageTotalMult *= 1.25;
		}
	}

	function onAdded()
	{
		if (!this.getContainer().hasActive(::Legends.Active.LegendTackle) && this.getContainer().getActor().isPlayerControlled())
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendTackle);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendTackle);
	}

});

