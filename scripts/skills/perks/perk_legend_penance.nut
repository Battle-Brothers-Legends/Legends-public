this.perk_legend_penance <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPenance);
		this.m.Description = "This character is gaining increased Maximum Damage because of adjacent opponents.";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
	}

	function isHidden() {
		return this.getDamageBonus() == 0 && this.getResolveBonus() == 0;
	}

	function getTooltip() {
		local ret = this.skill.getTooltip();
		if (!::Tactical.isActive()) {
			return ret;
		}
		local damageBonus = this.getDamageBonus();
		if (damageBonus != 0) {
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=%positive%]" + (damageBonus * 100) + "%[/color] of equipped weapon's Maximum Damage as additional Maximum Damage"
			});
		}

		local resolveBonus = this.getResolveBonus();
		if (resolveBonus != 0) {
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+" + resolveBonus + "[/color] Resolve due to missing health and wearing cultist items"
			});
		}

		return ret;
	}

	function getDamageBonus() {
		return this.getContainer().getActor().getOpponentsInRange(1) * 0.05;
	}

	function getResolveBonus() {
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(::Const.ItemSlot.Body);
		local cultItems = [];
		if (item != null) {
			if (item.isItemType(::Const.Items.ItemType.Cultist)) {
				cultItems.push(item);
			}
			foreach (upgrade in item.m.Upgrades) {
				if (upgrade != null && upgrade.isItemType(::Const.Items.ItemType.Cultist)) {
					cultItems.push(upgrade);
				}
			}
		}

		if (cultItems.len() > 0) {
			return ::Math.floor((actor.getHitpointsMax() - actor.getHitpoints()) * 0.75);
		}

		return 0;
	}

	function onAfterUpdate(_properties) {
		_properties.Bravery += this.getResolveBonus();

		local damageBonus = this.getDamageBonus();
		if (damageBonus != 0) {
			local item = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);
			if (item != null) {
				_properties.DamageRegularMax += item.m.RegularDamageMax * damageBonus;
			}
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + (this.getDamageBonus() * 100) + "%[/color] Maximum " + ::Legends.Text.inlineIcons("regular_damage") + ", [color=%positive%]+" + this.getResolveBonus() + "[/color] " + ::Legends.Text.inlineIcons("bravery");
	}
});
