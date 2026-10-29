::mods_hookExactClass("skills/perks/perk_steadfast", function (o) {
	o.create = function () {
		::Legends.Perks.onCreate(this, ::Legends.Perk.Steadfast);
		this.m.Description = "Firm and resolute. The type to put trust in, if necessary.";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
	}

	o.getBonus <- function (_actor = null) {
		local actor = _actor != null ? _actor : this.getContainer().getActor();
		local fat = actor.getItems().getStaminaModifier([
			::Const.ItemSlot.Body,
			::Const.ItemSlot.Head,
			::Const.ItemSlot.Mainhand,
			::Const.ItemSlot.Offhand,
			::Const.ItemSlot.Bag
		]);
		return ::Math.abs(fat * -1 / 10);
	}

	o.onUpdate = function (_properties) {
		_properties.FatigueLossOnAnyAttackMult *= 0.1;
		_properties.MeleeDefense += ::Math.floor(this.getBonus());
	}

	o.getTooltip <- function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend(this.getDynamicTooltip());
		return tooltip;
	}

	o.getDynamicTooltip <- function (_actor = null) {
		return [
			{
				id = 6,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%positive%]+" + this.getBonus(_actor) + "[/color] Melee Defense"
			}
		];
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + this.getBonus() + "[/color] " + ::Legends.S.inlineIcon("melee_defense");
	}
});
