::mods_hookExactClass("skills/actives/return_favor", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Icon = "skills/return_favor_square.png";
		this.m.IconDisabled = "skills/return_favor_square_bw.png";
		this.m.ActionPointCost = 3;
	}

	o.getTooltip = function ()
	{
		return [
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
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Gain a [color=%positive%]75%[/color] chance to stun any opponent missing this character with a melee attack (resistances and immunities still apply)."
			}
		];
	}

	o.onUse = function ( _user, _targetTile )
	{
		if (!this.m.IsSpent)
		{
			::Legends.Effects.grant(this, ::Legends.Effect.LegendReturnFavor);
			this.m.IsSpent = true;
			return true;
		}

		return false;
	}
});
