::mods_hookExactClass("skills/effects/shieldwall_effect", function (o) {
	o.m.Stacks <- 1;

	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "Having raised the shield to a protective stance, this character gains increased block.";
	}

	o.onUpdate = function (_properties) {
		if (this.m.Stacks <= 0) {
			this.removeSelf();
		}
		local actor = this.getContainer().getActor();
		local shield = actor.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
		if (shield != null && shield.isItemType(::Const.Items.ItemType.Shield) && shield.getCondition() > 0) {
			// pointless but you never know
			local mult = 1.0;
			local proficiencyBonus = 0;

			if (actor.getCurrentProperties().IsSpecializedInShields) {
				mult *= 1.25;
			}

			if (actor.getCurrentProperties().IsProficientWithShieldSkills) {
				proficiencyBonus = 5;
			}
			_properties.Block += ::Math.floor(actor.getBlock() * mult) + proficiencyBonus;
		}
	}

	o.getTooltip = function () {
		local bonus = this.getBonus();
		local actor = this.getContainer().getActor();
		local mult = 1.0;
		local proficiencyBonus = 0;

		if (actor.getCurrentProperties().IsSpecializedInShields) {
			mult *= 1.25;
		}

		if (actor.getCurrentProperties().IsProficientWithShieldSkills) {
			proficiencyBonus = 5;
		}

		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription() + (bonus > 0 ? " For forming a sturdy shieldwall with allies nearby, block is increased further." : "")
			},
			{
				id = 4,
				type = "text",
				icon = "ui/icons/block.png",
				text = "Grants an additional [color=%positive%]+%_block%[/color] Block against attacks",
				param = [
					["_block", ::Math.floor(actor.getBlock() * mult + bonus + proficiencyBonus)]
				]
			},
			{
				id = 5,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Block is increased for [color=%positive%]%_stacks%[/color] attacks against you",
				param = [
					["_stacks", this.m.Stacks]
				]
			}
		];
	}

	o.onDamageReceived <- function (_attacker, _skill, _hitInfo) {
		this.m.Stacks -= 1;
	}

	o.onTurnStart = function () {
		this.m.Stacks -= 1;
	}

	o.onMissed <- function (_attacker, _skill) {
		this.m.Stacks -= 1;
	}
});
