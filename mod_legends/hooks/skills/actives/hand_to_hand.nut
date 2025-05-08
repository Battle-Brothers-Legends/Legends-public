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

		return tooltip;
	}

	o.isUsable = function () // If ambidextrous & offhand free, or mainhand free, or disarmed
	{
		local items = this.getContainer().getActor().getItems();
		local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
		local main = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (this.m.Container.hasPerk(::Legends.Perk.LegendAmbidextrous) && off == null && !items.hasBlockedSlot(this.Const.ItemSlot.Offhand) && this.skill.isUsable)
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
		if (this.m.Container.hasPerk(::Legends.Perk.LegendAmbidextrous) && off == null && !items.hasBlockedSlot(this.Const.ItemSlot.Offhand)) // if ambidextrous && offhand free, then NOT hidden
		{
			return false;
		}

		return (main != null && !this.getContainer().hasEffect(::Legends.Effect.Disarmed)) || this.skill.isHidden() || this.m.Container.getActor().isStabled();
	}

	o.onAfterUpdate <- function ( _properties )
	{
		if(_properties.IsSpecializedInFists)
		{
			this.m.FatigueCostMult = _properties.IsSpecializedInFists ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
			if (this.m.Container.hasPerk(::Legends.Perk.LegendAmbidextrous)) //ambidextrous & specialzed
			{
				this.m.ActionPointCost = 3
			}
		}
		if (this.m.Container.hasPerk(::Legends.Perk.LegendAmbidextrous))
		{
			// If ambidextrous & you have a mainhand use that as your AOO.
			if (this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
			{
				this.m.IsIgnoredAsAOO = true;
			}
			else
			{
				this.m.IsIgnoredAsAOO = false;
			}
		}
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill != this)
		{
			return;
		}

		local actor = this.getContainer().getActor();
		_properties.DamageRegularMin += 5;
		_properties.DamageRegularMax += 10;
		_properties.DamageArmorMult = 0.5;

		if (this.m.Container.hasEffect(::Legends.Effect.Disarmed) || this.m.Container.hasPerk(::Legends.Perk.LegendAmbidextrous))
		{
			local mhand = actor.getMainhandItem();

			if (mhand != null)
			{
				_properties.DamageRegularMin -= mhand.m.RegularDamage;
				_properties.DamageRegularMax -= mhand.m.RegularDamageMax;
			}
		}
		_properties.FatigueDealtPerHitMult += 1.0; // Increase fatigue damage from 5 to 10

		if (this.m.Container.hasPerk(::Legends.Perk.LegendAmbidextrous))
		{
			if (actor.getMainhandItem() != null)
			{
				_properties.MeleeDamageMult/=1.25; // Attempt to undo double grip damage bonus for just this skill. Might not work for missing hand.
			}
		}

		if (("IsSpecializedInFists" in _properties) && _properties.IsSpecializedInFists)
		{
			_properties.FatigueDealtPerHitMult += 1.0; // If you have mastery, increase from 10 to 15 fat damage.
		}

		local items = actor.getItems().getAllItems();
		local hasCestus = false;
		local hasWraps = false;
		local hasGauntlets = false;
		foreach (item in items)
		{
			if (item.getID() == "accessory.legend_hand_wraps")
				hasWraps = true;
			if (item.getID() == "accessory.legend_cestus")
				hasCestus = true;
			if (item.getID() == "accessory.legend_spiked_gauntlets")
				hasGauntlets = true;
		}

		if (_skill != this)
			return;

		if (hasGauntlets)
		{
			_properties.DamageRegularMin += 6;
			_properties.DamageRegularMax += 12;
			_properties.DamageArmorMult += 0.3;
		}
		else if (hasCestus)
		{
			_properties.DamageRegularMin += 6;
			_properties.DamageRegularMax += 12;
			_properties.DamageArmorMult *= 1.1;
		}
		else if (hasWraps)
		{
			_properties.DamageRegularMin += 2;
			_properties.DamageRegularMax += 6;
		}
	}

	o.onUpdate = function ( _properties )
	{
	}
});
