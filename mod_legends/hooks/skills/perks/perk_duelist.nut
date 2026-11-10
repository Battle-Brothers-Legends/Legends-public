::mods_hookExactClass("skills/perks/perk_duelist", function (o) {
	o.m.AllowedWeapons <- [
		"shield.buckler",
		"shield.named_buckler",
		"shield.legend_mummy_shield"
	];

	o.create = function () {
		::Legends.Perks.onCreate(this, ::Legends.Perk.Duelist);
	}

	o.getDynamicTooltip <- function (_actor = null) {
		local tooltip = [];
		local bonus = this.getBonus(_actor) * 100;
		if (bonus == 0) {
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]You do not have the right equipment to receive Duelist's passive effect[/color]"
			});
			return tooltip;
		}
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/direct_damage.png",
			text = "[color=%positive%]+" + bonus + "%[/color] of any damage ignores armor"
		});

		return tooltip;
	}

	o.onAdded <- function () {
		if (!this.m.Container.hasActive(::Legends.Active.LegendFlourish)) {
			::Legends.Actives.grant(this, ::Legends.Active.LegendFlourish);
		}
	}

	o.onRemoved <- function () {
		::Legends.Actives.remove(this, ::Legends.Active.LegendFlourish);
	}

	o.isValid <- @(_mainhand, _offhand)(_mainhand != null || _offhand != null);

	o.isValidOffhand <- @(_mainhand, _offhand)(_offhand != null && this.m.AllowedWeapons.find(_offhand.getID()) != null);

	// you can just hook this or isValid/isFullEffect/isPartialEffect and the tooltip will auto calculate without needing to replace anything
	o.getBonus <- function (_actor = null) {
		local actor = _actor != null ? _actor : this.getContainer().getActor();
		local main = actor.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);
		local off = actor.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
		return (this.isValid(main, off) && (this.isValidOffhand(main, off)) ? 0.25 : 0);
	}

	o.onAnySkillUsed <- function (_skill, _targetEntity, _properties) {
		if (!_skill.isRanged()) {
			_properties.DamageDirectAdd += this.getBonus();
		}
	}

	o.onUpdate = function (_properties) {}
});
