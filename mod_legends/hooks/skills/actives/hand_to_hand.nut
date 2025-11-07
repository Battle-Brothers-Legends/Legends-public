::mods_hookExactClass("skills/actives/hand_to_hand", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Description = "Let them fly! Use your limbs to inflict damage on your enemy.";
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted+3;
	}

	o.getTooltip = function ()
	{
		local tooltip = this.getDefaultTooltip();
		local actor = this.getContainer().getActor();
		local fatigueMultiplier = 1;
		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInFists)
			fatigueMultiplier = 2;
		local fatPerHit = (this.getContainer().getActor().getCurrentProperties().FatigueDealtPerHitMult + fatigueMultiplier) * this.Const.Combat.FatigueReceivedPerHit;
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + fatPerHit + "[/color] extra fatigue on hit"
		});

		local grappler = ::Legends.Perks.get(this, ::Legends.Perk.LegendGrappler);
		if (grappler != null)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Each attack has a " + grappler.m.GrappleChance + "% chance to apply Grappled"
			});
		}

		return tooltip;
	}

	o.isUsable = function () // If ambidextrous & offhand free, or mainhand free, or disarmed
	{
		local items = this.getContainer().getActor().getItems();
		local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
		local main = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (::Legends.Perks.has(this, ::Legends.Perk.LegendAmbidextrous) && off == null && !items.hasBlockedSlot(this.Const.ItemSlot.Offhand) && this.skill.isUsable)
		{
			return true;
		}

		return (main == null || this.getContainer().hasEffect(::Legends.Effect.Disarmed)) && this.skill.isUsable();
	}

	o.isHidden = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
		local main = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (::Legends.Perks.has(this, ::Legends.Perk.LegendAmbidextrous) && off == null && !items.hasBlockedSlot(this.Const.ItemSlot.Offhand)) // if ambidextrous && offhand free, then NOT hidden
		{
			return false;
		}

		return (main != null && !this.getContainer().hasEffect(::Legends.Effect.Disarmed)) || this.skill.isHidden() || this.m.Container.getActor().isStabled();
	}

	o.onUpdate = function ( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInFists ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;

		if(_properties.IsSpecializedInFists)
			this.m.ActionPointCost -= 1;
	}

	o.onAfterUpdate <- function (_properties)
	{
		// If ambidextrous & you have a mainhand use that as your AOO.
		this.m.IsIgnoredAsAOO = ::Legends.Perks.has(this, ::Legends.Perk.LegendAmbidextrous) &&
			this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null;
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill != this)
			return;

		_properties.DamageRegularMin = 5;
		_properties.DamageRegularMax = 10;
		_properties.DamageArmorMult = 0.5;

		local actor = this.getContainer().getActor();
		_properties.FatigueDealtPerHitMult += 1.0; // Increase fatigue damage from 5 to 10

		if (::Legends.Perks.has(this, ::Legends.Perk.LegendAmbidextrous))
		{
			if (actor.getMainhandItem() != null)
			{
				_properties.MeleeDamageMult /= 1.25; // Attempt to undo double grip damage bonus for just this skill. Might not work for missing hand.
			}
		}

		if (("IsSpecializedInFists" in _properties) && _properties.IsSpecializedInFists)
		{
			_properties.FatigueDealtPerHitMult += 1.0; // If you have mastery, increase from 10 to 15 fat damage.
		}

		local accessory = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);
		if (accessory != null && accessory.isItemType(this.Const.Items.ItemType.Brawler))
		{
			_properties.DamageRegularMin += accessory.m.RegularDamage;
			_properties.DamageRegularMax += accessory.m.RegularDamageMax;
			_properties.DamageArmorMult += accessory.m.ArmorDamageMult;
		}
	}
});
