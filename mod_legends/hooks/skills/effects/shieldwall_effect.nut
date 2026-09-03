::mods_hookExactClass("skills/effects/shieldwall_effect", function(o) {
	o.m.Stacks <- 0;

	o.onUpdate = function(_properties) {
		local actor = this.getContainer().getActor();
		local shield = actor.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
		if (shield != null &&  shield.isItemType(::Const.Items.ItemType.Shield) && shield.getCondition() > 0) { // pointless but you never know
			local mult = 1.0;
			local proficiencyBonus = 0;

			if (actor.getCurrentProperties().IsSpecializedInShields) {
				mult *= 1.25;
			}

			if (actor.getCurrentProperties().IsProficientWithShieldSkills) {
				proficiencyBonus = 5;
			}
			_properties.Block += ::Math.floor(shield.getBlock() * mult) + proficiencyBonus;
		}
	}

	o.onMissed <- function ( _attacker, _skill ) {}
});