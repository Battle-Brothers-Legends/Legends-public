::mods_hookExactClass("entity/tactical/enemies/greater_flesh_golem", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBoneBreaker);
		::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBattleheart);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendAmbidextrous);
		if (::Legends.isLegendaryDifficulty()) {
			::Legends.Perks.grant(this, ::Legends.Perk.LegendLacerate);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendTerrifyingVisage);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendPugilist);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendMuscularity);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendGrappler);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendPummelIntoSubmission);
			b.Hitpoints *= 1.5;
		}
		::Legends.S.scaleBaseProperties(b);
	}

	o.onDeath = function ( _killer, _skill, _tile, _fatalityType ) {
		this.legend_flesh_golem.onDeath( _killer, _skill, _tile, _fatalityType );
	}

	o.makeMiniboss <- function () {
		if (!this.actor.makeMiniboss()) {
			return false;
		}
		this.getSprite("miniboss").setBrush("bust_miniboss_undead");
		::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
		return true;
	}
});
