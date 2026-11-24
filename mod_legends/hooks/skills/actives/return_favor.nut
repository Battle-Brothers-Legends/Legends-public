::mods_hookExactClass("skills/actives/return_favor", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Icon = "skills/return_favor_square.png";
		this.m.IconDisabled = "skills/return_favor_square_bw.png";
		this.m.FatigueCost = 25;
		this.m.ActionPointCost = 2;
	}

	o.getTooltip = function () {
		local effect = this.getContainer().getActor().getCurrentProperties().IsSpecializedInMaces ? 75 : 25;
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
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Any opponent missing with a melee attack will get debuffed with either [color=%effect%]Stunned[/color] or [color=%effect%]Dazed[/color]"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]%_effect%%[/color] chance to apply [color=%effect%]Stunned[/color], else will apply [color=%effect%]Dazed[/color]",
				param = [["_effect", effect]]
			}
		];
	}

	o.onAfterUpdate <- function ( _properties ) {
		this.m.FatigueCostMult = _properties.IsSpecializedInMaces ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	o.onUse = function (_user, _targetTile) {
		if (!this.m.IsSpent) {
			::Legends.Effects.grant(this, ::Legends.Effect.LegendReturnFavor);
			this.m.IsSpent = true;
			return true;
		}

		return false;
	}
});
