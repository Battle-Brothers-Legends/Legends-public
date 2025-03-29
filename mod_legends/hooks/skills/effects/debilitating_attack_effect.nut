::mods_hookExactClass("skills/effects/debilitating_attack_effect", function(o) {
	
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Overlay = "status_effect_01";
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
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color] Damage inflicted by target hit for three turns"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]+15%[/color] Damage taken by target hit for three turns"
			}
		];
	}

});