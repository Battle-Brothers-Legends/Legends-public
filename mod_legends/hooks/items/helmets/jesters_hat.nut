::mods_hookExactClass("items/helmets/jesters_hat", function(o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Variants = [this.Math.rand(1,65)];
		this.m.Condition = 35;
		this.m.ConditionMax = 35;
		this.updateVariant();
	}

	o.getTooltip <- function() {
		local result = this.helmet.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Adds the \'Taunt\' skill"
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Makes enemies more likely to attack you"
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "[color=%negative%]-3[/color] Melee Defense per surrounding enemy"
		});

		return result;
	}

	o.onUpdateProperties <- function ( _properties ) {
		this.helmet.onUpdateProperties(_properties);
		_properties.SurroundedDefense -= 3; // -3 defence per enemy surrounding this unit while equipped
		_properties.TargetAttractionMult *= 1.2; // 1.0 = normal aggression, 0.1 = minimal aggression
	}

	o.updateVariant <- function () {
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_jester_hat_" + variant;
		this.m.SpriteDamaged = "legendhelms_jester_hat_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_jester_hat_" + variant + "_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_jester_hat_" + variant + ".png";
	}

	o.onEquip <- function() {
		this.helmet.onEquip();
		if (!this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.Taunt))
		{
			::Legends.Actives.grant(this, ::Legends.Active.Taunt);
		}
	}

	o.onUnequip <- function() {
		this.helmet.onUnequip();
		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.Taunt))
		{
			::Legends.Actives.grant(this, ::Legends.Active.Taunt);
		}
	}
});
