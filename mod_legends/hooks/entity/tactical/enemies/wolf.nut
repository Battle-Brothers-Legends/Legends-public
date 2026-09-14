::mods_hookExactClass("entity/tactical/enemies/wolf", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Berserk);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}


	o.setVariant = function( _v, _c, _s, _hp = 1.0 )
	{
		this.m.Items.getAppearance().Body = "bust_wolf_0" + _v + "_body";
		this.m.Items.getAppearance().Armor = "bust_wolf_02_armor_01";
		local body = this.getSprite("body");
		body.setBrush("bust_wolf_0" + _v + "_body");
		body.Color = _c;
		body.Saturation = _s;
		local head = this.getSprite("head");
		head.setBrush("bust_wolf_0" + _v + "_head");
		head.Color = _c;
		head.Saturation = _s;
		this.getSprite("armor").Visible = true;

		if (_hp != 1.0)
		{
			this.m.Hitpoints = ::Math.round(this.getHitpointsMax() * _hp);
			this.onUpdateInjuryLayer();
		}
		else
		{
			this.setDirty(true);
		}
	}

});