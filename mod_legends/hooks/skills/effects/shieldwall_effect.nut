::mods_hookExactClass("skills/effects/shieldwall_effect", function(o) {
	o.m.Stacks <- 0;

	o.onUpdate = function(_properties) {
		local shield = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
		if (shield != null &&  shield.isItemType(this.Const.Items.ItemType.Shield) && item.getCondition() > 0) { // pointless but you never know
			local mult = 1.0;
			local proficiencyBonus = 0;

			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields) {
				mult = mult * 1.25;
			}

			if (this.getContainer().getActor().getCurrentProperties().IsProficientWithShieldSkills) {
				proficiencyBonus = 5;
			}
			_properties.Block += this.Math.floor(shield.getBlock() * mult) + proficiencyBonus;
		}
	}

	o.onTurnStart = function() {
	}

	o.onMissed <- function ( _attacker, _skill ) {
	}
});