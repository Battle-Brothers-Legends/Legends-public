::mods_hookExactClass("skills/effects/shieldwall_effect", function (o) {
	o.m.Stacks <- 1;

	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "Having raised the shield to a protective stance, this character gains increased block.";
	}

	o.getTooltip = function () {
		local bonus = this.getBonus();
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
					["_block", this.calculateBlock(bonus)]
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

	o.onUpdate = function (_properties) {
		if (this.m.Stacks <= 0) {
			this.removeSelf();
		}
		local shield = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
		if (shield != null && shield.isItemType(::Const.Items.ItemType.Shield) && shield.getCondition() > 0) {
			_properties.Block += this.calculateBlock(); // no bonus in real calc since its added onBeingAttacked
		}
	}

	o.calculateBlock <- function (_bonus = 0) {
		local actor = this.getContainer().getActor();
		local mult = actor.getCurrentProperties().IsSpecializedInShields ? 1.25 : 1.0;
		local proficiencyBonus = actor.getCurrentProperties().IsProficientWithShieldSkills ? 5 : 0;
		return ::Math.floor(actor.getBlock() * mult + _bonus + proficiencyBonus);
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

	o.onBeingAttacked = function (_attacker, _skill, _properties) {
		_properties.Block += this.getBonus();
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + this.calculateBlock(this.getBonus()) + "[/color] " + ::Legends.S.inlineIcon("block");
	}
});
