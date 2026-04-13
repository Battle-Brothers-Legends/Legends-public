::mods_hookExactClass("entity/tactical/enemies/unhold_frost", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = m.BaseProperties;
		local body = this.getSprite("body");
		local head = this.getSprite("head");
		if (this.Math.rand(1, 100) < 10)
		{
			head.setBrush("bust_unhold_head_06");
		}
		else
		{
			head.setBrush("bust_unhold_head_01");
		}
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		foreach (a in this.Const.CharacterSprites.Helmets)
		{
			if (a == "helmet")
				continue;
			this.addSprite(a)
		}
		if(::Legends.isLegendaryDifficulty())
		{
			b.MeleeSkill += 10;
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBattleheart);
			this.m.Hitpoints = 2 * b.Hitpoints;
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}

	}

	o.onFactionChanged = function()
	{
		this.unhold.onFactionChanged();
	}
});
