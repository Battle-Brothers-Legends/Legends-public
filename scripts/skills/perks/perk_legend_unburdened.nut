this.perk_legend_unburdened <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendUnburdened);
		this.m.IconMini = "mini_meek";
		this.m.Order = this.Const.SkillOrder.Perk | this.Const.SkillOrder.Any;
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
			addPerk(this.Const.Perks.PerkDefs.Footwork, 5);
	}
});
