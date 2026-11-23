this.mods_hookExactClass("skills/injury_permanent/brain_damage_injury", function (o) {
	o.getTooltip = function () {
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
				id = 7,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] Resolve"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color] Experience Gain"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color] Initiative"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Gets more irritated while reading"
			}
		];
		this.addTooltipHint(ret);
		return ret;
	}
});
