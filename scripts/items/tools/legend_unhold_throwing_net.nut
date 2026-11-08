this.legend_unhold_throwing_net <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		AllowsDoubleGrip = false
	},

	function create() {
		this.weapon.create();
		this.m.ID = "tool.legend_unhold_throwing_net";
		this.m.Name = "Unhold bindings";
		this.m.Description = "A net provided by barbarian tribe infused with a special poison, used to bind unholds.";
		this.m.IconLarge = "tools/inventory_throwing_net_unhold.png";
		this.m.Icon = "tools/throwing_net_unhold_70x70.png";
		this.m.ArmamentIcon = "icon_throwing_net_02";
		this.m.SlotType = ::Const.ItemSlot.Offhand;
		this.m.ItemType = ::Const.Items.ItemType.Tool | ::Const.Items.ItemType.Defensive | ::Const.Items.ItemType.Net;
		this.m.AddGenericSkill = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_throwing_net_02";
		this.m.Value = 150;
		this.m.RangeMax = 3;
		this.m.StaminaModifier = -2;
		this.m.IsPrecious = true;
		this.m.IsSellable = false;
		this.m.IsDroppedAsLoot = false;
	}

	function getTooltip() {
		local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];

		if (this.getIconLarge() != null) {
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		} else {
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});
		result.push({
			id = 64,
			type = "text",
			text = "Worn in Offhand"
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Range of [color=%positive%]" + this.m.RangeMax + "[/color] tiles"
		});
		if (this.m.StaminaModifier < 0) {
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Fatigue Weight Penalty [color=%negative%]" + this.m.StaminaModifier + "[/color]"
			});
		}
		if (this.allowsDoubleGrip()) {
			result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Doesn't prevent Double Gripping a melee weapon"
			});
		}
		result.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Will root a [color=%effect%]Dazed[/color], [color=%effect%]Baffled[/color] or damaged below 25% Healthpoints Unhold in place and make it docile"
		});
		result.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Is destroyed on use"
		});
		local grantedSkills = this.getGrantedSkills();
		foreach (skill in grantedSkills) {
			result.push({
				id = 23,
				type = "text",
				icon = skill.m.Icon,
				text = skill.getName() + (skill.isActive() ? " (" + skill.m.ActionPointCost + ::Legends.Text.inlineIcons("action_points") + ", " + skill.m.FatigueCost + ::Legends.Text.inlineIcons("fatigue") + ")" : "")
			});
		}
		return result;
	}

	function addSkill(_skill) {
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.ThrowNet) && ::Legends.Perks.has(this.getContainer().getActor(), ::Legends.Perk.LegendNetCasting)) {
			_skill.m.MaxRange = 5;
		}

		this.weapon.addSkill(_skill);
	}

	function onEquip() {
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.ThrowNet, function (_skill) {
			_skill.makeUnholdNet();
		}.bindenv(this));
	}

	function onUpdateProperties(_properties) {
		this.weapon.onUpdateProperties(_properties);
		// Net Repair Perk negates the weight
		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendNetRepair)) {
			_properties.Stamina -= this.m.StaminaModifier;
		}
	}

	function getStaminaModifier() {
		return ((::Legends.S.isNull(this.getContainer()) || ::Legends.S.isNull(this.getContainer().getActor()) || !::Legends.Perks.has(this.getContainer().getActor(), ::Legends.Perk.LegendNetRepair)) ? this.m.StaminaModifier : 0);
	}

	function allowsDoubleGrip() {
		return this.getContainer() != null && this.getContainer().getActor().getCurrentProperties().IsSpecializedInNets;
	}
});
