this.perk_legend_freedom_of_movement <- this.inherit("scripts/skills/skill", {
	m = {
		Skills = [
			::Legends.Actives.getID(::Legends.Active.Lunge),
			::Legends.Actives.getID(::Legends.Active.Footwork),
			::Legends.Actives.getID(::Legends.Active.Rotation),
			::Legends.Actives.getID(::Legends.Active.LegendLeap),
			::Legends.Actives.getID(::Legends.Active.LegendHorsePirouette),
			::Legends.Actives.getID(::Legends.Active.LegendQuickStep),
			::Legends.Actives.getID(::Legends.Active.LegendEvasion)
		]
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendFreedomOfMovement);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAfterUpdate(_properties)
	{
		local skills = this.getContainer().getAllSkillsOfType(this.Const.SkillType.Active);
		foreach (skill in skills)
		{
			if (this.m.Skills.find(skill.getID()) != null)
			{
				skill.m.FatigueCostMult *= 0.5;

				if (skill.getID() == ::Legends.Actives.getID(::Legends.Active.LegendLeap) || skill.getID() == ::Legends.Actives.getID(::Legends.Active.LegendEvasion))
				{
					skill.m.ActionPointCost /= 2;
				}
				else if (skill.getID() == ::Legends.Actives.getID(::Legends.Active.LegendQuickStep))
				{
					skill.m.ActionPointCost /= 2;
				}
				else if (skill.getID() != ::Legends.Actives.getID(::Legends.Active.Lunge) && skill.getID() != ::Legends.Actives.getID(::Legends.Active.LegendQuickStep))
				{
					skill.m.ActionPointCost -= 1; //For Footwork, Tumble, and Rotation
				}
			}
		}
	}

	function onAdded()
	{
		if (!this.m.IsNew)
			return;

		local addPerk = function ( _perk, _row = 0 )
		{
			local actor = this.getContainer().getActor();
			if (!actor.isPlayerControlled())
				return;

			local bg = actor.getBackground();
			local hasRow = false;
			local direction = -1;
			local row = _row;
			while (row >= 0 && row <= 6)
			{
				if (bg.m.CustomPerkTree[row].len() < 13)
				{
					hasRow = true;
					break;
				}

				row += direction;

				if (row == -1)
				{
					row = _row;
					direction = 1;
				}
			}

			row = hasRow ? this.Math.max(0, this.Math.min(row, 6)) : _row;
			bg.addPerk(_perk, row);
		}

		if (!this.getContainer().hasPerk(::Legends.Perk.Footwork))
			addPerk(this.Const.Perks.PerkDefs.Footwork, 4);
		if (!this.getContainer().hasPerk(::Legends.Perk.LegendQuickStep))
			addPerk(this.Const.Perks.PerkDefs.Footwork, 2);
		if (!this.getContainer().hasPerk(::Legends.Perk.Rotation))
			addPerk(this.Const.Perks.PerkDefs.Footwork, 3);
	}
});

