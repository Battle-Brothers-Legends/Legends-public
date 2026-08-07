::mods_hookExactClass("skills/actives/perfect_focus", function(o)
{
	o.m.Counter <- 0;
	local create = o.create;
	o.create = function () {
		create();
		this.m.Icon = "skills/perfectfocus_square.png";
		this.m.IconDisabled = "skills/perfectfocus_square_bw.png";
		this.m.Overlay = "perfectfocus_active";
		this.m.Order = this.Const.SkillOrder.BeforeLast;
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 30;
	}

	o.getTooltip = function()
	{
		local ret = [ {
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
				text = "Adds a stacking [color=%effect%]Perfect Focus[/color] which increases your Action Points by [color=%positive%]3[/color]"
			}
		];

		return ret;
	}

	o.isHidden <- function() {
		return this.getContainer().getActor().getFlags().has("undead");
	}

	o.onUpdateProperties <- function (_properties ) {
		local multiplier = this.m.Counter * 0.5;
		this.m.FatigueCostMult *= 1.0 + multiplier;
	}

	o.onUse = function ( _user, _targetTile ) {
		::Legends.Effects.grant(this, ::Legends.Effect.LegendPerfectFocus);
		this.m.Counter += 1;
	}

	o.onCombatStarted <- function() {
		this.m.Counter = 0;
	}

	o.onCombatFinished <- function() {
		this.m.Counter = 0;
	}
});
