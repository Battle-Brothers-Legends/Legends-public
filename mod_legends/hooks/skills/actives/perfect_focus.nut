::mods_hookExactClass("skills/actives/perfect_focus", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Icon = "skills/perfectfocus_square.png";
		this.m.IconDisabled = "skills/perfectfocus_square_bw.png";
		this.m.Order = this.Const.SkillOrder.BeforeLast;
	}

	o.getTooltip = function()
	{
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
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The Action Point cost for using skills is reduced by half for the remainder of this round, but at +75% fatigue cost"
			}
		];
		return ret;
	}

	o.isUsable = function ()
	{
		return this.skill.isUsable() && !this.getContainer().hasEffect(::Legends.Effect.LegendPerfectFocus);
	}

	o.onUse = function ( _user, _targetTile )
	{
		if (!this.getContainer().hasEffect(::Legends.Effect.LegendPerfectFocus))
		{
			::Legends.Effects.grant(this, ::Legends.Effect.LegendPerfectFocus);
			return true;
		}

		return false;
	}
});
