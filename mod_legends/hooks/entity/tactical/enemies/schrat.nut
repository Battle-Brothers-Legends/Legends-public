::mods_hookExactClass("entity/tactical/enemies/schrat", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Stalwart);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendComposure);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendPoisonImmunity);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.CripplingStrikes);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.CoupDeGrace);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.ShieldExpert);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.ShieldBash);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendLacerate);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendSpecialistShieldSkill);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendSpecialistShieldPush);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	local onDeath = o.onDeath;
	o.onDeath = function ( _killer, _skill, _tile, _fatalityType )
	{
		onDeath( _killer, _skill, _tile, _fatalityType );
		if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
		{
			local n = 1 + (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);

			for( local i = 0; i < n; i = ++i )
			{
				if (this.Math.rand(1, 100) <= 1)
				{
					local token = this.new("scripts/items/rune_sigils/legend_vala_inscription_token");
					token.setRuneVariant(this.Math.rand(31, 32));
					token.setRuneBonus(true);
					token.updateRuneSigilToken();
					token.drop(_tile);
				}
			}
		}
	}

	o.makeMiniboss <- function ()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.m.Skills.add(this.new("scripts/skills/racial/legend_greenwood_schrat_racial"));
		this.m.Skills.add(this.new("scripts/skills/actives/legend_grow_greenwood_shield_skill"));
		this.m.BaseProperties.setValues(this.Const.Tactical.Actor.LegendGreenwoodSchrat);

		this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		this.m.Items.equip(this.new("scripts/items/shields/beasts/legend_greenwood_schrat_shield"));
		local body = this.addSprite("body");
		body.setBrush("bust_schrat_green_body_01");
		body.varySaturation(0.2);
		body.varyColor(0.05, 0.05, 0.05);
		this.m.BloodColor = body.Color;
		local head = this.addSprite("head");
		head.setBrush("bust_schrat_green_head_0" + this.Math.rand(1, 2));
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_schrat_green_01_injured");


		return true;
	}
});
