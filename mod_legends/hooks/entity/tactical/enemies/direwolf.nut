::mods_hookExactClass("entity/tactical/enemies/direwolf", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
			::Legends.Traits.grant(this, ::Legends.Trait.RacialLegendWerewolf);
		}
	}

	o.setVariant <- function (_v, _c, _s, _hp = 1.0)
	{
		this.m.Items.getAppearance().Body = "bust_direwolf_0" + _v;
		this.m.Items.getAppearance().Armor = "bust_wolf_02_armor_01";

		local body = this.getSprite("body");
		body.setBrush("bust_direwolf_0" + _v + "_body");
		body.Color = _c;
		body.Saturation = _s;

		local head = this.getSprite("head");
		head.setBrush("bust_direwolf_0" + _v + "_head");
		head.Color = _c;
		head.Saturation = _s;

		local armor = this.addSprite("armor");
		armor.setBrush("bust_wolf_02_armor_01");
		armor.Visible = false;

		if(_hp != 1.0)
		{
			this.m.Hitpoints = this.getHitpointsMax() * _hp;
			this.onUpdateInjuryLayer();
		}
		else
		{
			this.setDirty(true);
		}
	}
});
