::mods_hookExactClass("skills/actives/hand_to_hand", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "Let them fly! Use your limbs to inflict damage on your enemy.";
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted + 3;
	}

	o.getTooltip = function () {
		local tooltip = this.getDefaultTooltip();
		local actor = this.getContainer().getActor();
		local fatigueMultiplier = 1;
		if (actor.getCurrentProperties().IsSpecializedInFists) {
			fatigueMultiplier = 2;
		}
		local fatPerHit = (actor.getCurrentProperties().FatigueDealtPerHitMult + fatigueMultiplier) * ::Const.Combat.FatigueReceivedPerHit;
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts [color=%damage%]%_fat%[/color] extra fatigue on hit",
			param = [
				["_fat", fatPerHit]
			]
		});

		local grappler = ::Legends.Perks.get(this, ::Legends.Perk.LegendGrappler);
		if (grappler != null) {
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Each attack has a %_chance%% chance to apply Grappled",
				param = [
					["_chance", grappler.m.GrappleChance]
				]
			});
		}

		return tooltip;
	}

	o.isUsable = function () {
		return this.skill.isUsable();
	}

	o.isHidden = function () {
		local actor = this.getContainer().getActor();
		return (!actor.isMainhandFree() && (!actor.isOffhandFree() || !::Legends.Perks.has(actor, ::Legends.Perk.LegendAmbidextrous))) || actor.isStabled() || this.skill.isHidden();
	}

	o.onUpdate = function (_properties) {
		this.m.FatigueCostMult = _properties.IsSpecializedInFists ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;

		if (_properties.IsSpecializedInFists) {
			this.m.ActionPointCost -= 1;
		}
	}

	o.onAfterUpdate <- function (_properties) {
		// If ambidextrous & you have a mainhand use that as your AOO.
		this.m.IsIgnoredAsAOO = ::Legends.Perks.has(this, ::Legends.Perk.LegendAmbidextrous) && this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Mainhand) != null;
	}

	o.onAnySkillUsed = function (_skill, _targetEntity, _properties) {
		if (_skill != this) {
			return;
		}

		_properties.DamageRegularMin = 5;
		_properties.DamageRegularMax = 10;
		_properties.DamageArmorMult -= 0.5;

		local actor = this.getContainer().getActor();
		_properties.FatigueDealtPerHitMult += 1.0; // Increase fatigue damage from 5 to 10

		if (("IsSpecializedInFists" in _properties) && _properties.IsSpecializedInFists) {
			_properties.FatigueDealtPerHitMult += 1.0; // If you have mastery, increase from 10 to 15 fat damage.
		}

		local accessory = actor.getItems().getItemAtSlot(::Const.ItemSlot.Accessory);
		if (accessory != null && accessory.isItemType(::Const.Items.ItemType.Brawler)) {
			_properties.DamageRegularMin += accessory.m.RegularDamage;
			_properties.DamageRegularMax += accessory.m.RegularDamageMax;
			_properties.DamageArmorMult += accessory.m.ArmorDamageMult;
			_properties.DamageDirectAdd += accessory.m.DirectDamageMult;
		}
	}
});
