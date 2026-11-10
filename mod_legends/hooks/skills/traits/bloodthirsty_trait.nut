::mods_hookExactClass("skills/traits/bloodthirsty_trait", function(o) {	
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "This character is prone to excessive violence and cruelty towards enemies. An opponent isn\'t good enough dead, his head needs to be on a spike!";
		this.m.Excluded.push(::Legends.Traits.getID(::Legends.Trait.LegendFearNobles));
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function () {
		local ret = getTooltip();
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/health.png",
			text = "Restore [color=%positive%]2[/color] Hitpoints when you kill an enemy with a fatality"
		});

		return ret;
	}

	o.onOtherActorDeath <- function( _killer, _victim, _skill, _deathTile, _corpseTile, _fatalityType ) {
		local actor = this.getContainer().getActor();
		if (::Legends.S.isEntityNullOrDead(actor)) {
			return;
		}

		if (_killer != actor ) {
			return;
		}

		if (_fatalityType == this.Const.FatalityType.None) {
			return;
		}
		actor.setHitpoints(::Math.max(actor.getHitpointsMax(), actor.getHitpoints() + 2));
	}
});
