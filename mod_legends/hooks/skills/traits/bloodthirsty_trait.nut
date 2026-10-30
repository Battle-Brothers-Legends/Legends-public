::mods_hookExactClass("skills/traits/bloodthirsty_trait", function(o) {	
	o.m.ApplicableSkills = [
		::Legends.Effect.Poison,
		::Legends.Effect.LegendRedbackSpiderPoison,
		::Legends.Effect.LegendGrazed,
		::Legends.Effect.Bleeding
	];

	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "This character is prone to excessive violence and cruelty towards enemies. An opponent isn\'t good enough dead, his head needs to be on a spike!";
		this.m.Excluded.push(::Legends.Traits.getID(::Legends.Trait.LegendFearNobles));
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function () {
		local ret = getTooltip();
		ret.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Restore [color=%positive%]1[/color] Fatigue when an enemy dies from [color=%status%]Bleed[/color], [color=%status%]Graze[/color] or damaging [color=%status%]Poison[/color]"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				icon = "ui/icons/health.png",
				text = "Restore [color=%positive%]1[/color] Hitpoints when an enemy dies from [color=%status%]Bleed[/color], [color=%status%]Graze[/color] or damaging [color=%status%]Poison[/color]"
			}
		]);

		return ret;
	}

	o.onOtherActorDeath = function( _killer, _victim, _skill, _deathTile, _corpseTile, _fatalityType ) {
		local valid = false;
		local targetStatus = _victim.getSkills();
		foreach (skill in this.m.ApplicableSkills) {
			if (_skill != null && _skill.getID() == ::Legends.Effects.getID(skill)) {
				valid = true;
				break;
			}
		}

		if (_skill.getID() == "injury.cut_artery") {
			valid = true;
		}

		if (valid) {
			local actor = this.getContainer().getActor();
			actor.setFatigue(::Math.max(0, actor.getFatigue() - 1));
			actor.setHitpoints(::Math.max(actor.getHitpointsMax(), actor.getHitpoints() + 1));
		}
	}
});
