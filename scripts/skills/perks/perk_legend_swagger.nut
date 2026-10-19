this.perk_legend_swagger <- this.inherit("scripts/skills/skill", {
	m = {
		ArmorAdded = 0,
		HelmetAdded = 0
	},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSwagger);
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend(this.getDynamicTooltip());
		return tooltip;
	}

	function getDynamicTooltip(_actor = null) {
		local bonus = this.getBonus(_actor);
		local ret = [];
		if (::Math.floor(bonus) > 0) {
			ret.extend([
				{
					id = 10,
					type = "text",
					icon = "ui/icons/armor_body.png",
					text = "[color=%positive%]+" + ::Math.floor(bonus) + "[/color] armor condition added at start of combat"
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/armor_head.png",
					text = "[color=%positive%]+" + ::Math.floor(bonus / 2) + "[/color] helmet condition added at start of combat"
				}
			]);
		} else {
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "This character is not wearing armor or their armor is too cheap to gain a bonus"
			});
		}

		return ret;
	}

	function onCombatStarted() {
		this.m.ArmorAdded = ::Math.floor(this.getBonus());
		this.m.HelmetAdded = ::Math.floor(this.getBonus() / 2);
	}

	function onUpdate(_properties) {
		if (("State" in ::Tactical) && ::Tactical.State != null) {
			_properties.Armor[::Const.BodyPart.Body] += this.m.ArmorAdded;
			_properties.Armor[::Const.BodyPart.Head] += this.m.HelmetAdded;
			_properties.ArmorMax[::Const.BodyPart.Body] += this.m.ArmorAdded;
			_properties.ArmorMax[::Const.BodyPart.Head] += this.m.HelmetAdded;
		}
	}

	function onCombatFinished() {
		this.m.ArmorAdded = 0;
		this.m.HelmetAdded = 0;
	}

	function getBonus(_actor = null) {
		local actor = _actor != null ? _actor : this.getContainer().getActor();
		local body = actor.getItems().getItemAtSlot(::Const.ItemSlot.Body);
		local head = actor.getItems().getItemAtSlot(::Const.ItemSlot.Head);
		local gearValue = 0;

		if (body != null) {
			gearValue += body.getValue();
		}

		if (head != null) {
			gearValue += head.getValue();
		}

		local fat = ::Math.abs(actor.getItems().getStaminaModifier([
			::Const.ItemSlot.Body,
			::Const.ItemSlot.Head,
		]));

		return gearValue * 0.002 * (1.0 + 0.01 * fat);
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		local bonus = this.getBonus();
		return (bonus > 0 ? ("[color=%positive%]+" + ::Math.floor(bonus) + "[/color] " + ::Legends.S.inlineIcon("armor_body") + ", [color=%positive%]+" + ::Math.floor(bonus / 2) + "[/color] " + ::Legends.S.inlineIcon("armor_head")) : null);
	}
});
