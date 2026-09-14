::mods_hookExactClass("items/special/fountain_of_youth_item", function(o) {
	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local result = getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Will remove all temporary, permanent and prosthetic injuries, as well as the Old, Addicted, Exhausted and Hangover traits and status effects."
		});
		return result;
	}

	o.onUse = function ( _actor, _item = null )
	{
		if (!_actor.getSkills().hasSkillOfType(this.Const.SkillType.Injury) && !_actor.getSkills().hasTrait(::Legends.Trait.Old))
		{
			return false;
		}

		this.Sound.play("sounds/combat/drink_03.wav", this.Const.Sound.Volume.Inventory);
		_actor.getSkills().removeByType(this.Const.SkillType.Injury);
		::Legends.Traits.remove(_actor, ::Legends.Trait.Old);
		::Legends.Traits.remove(_actor, ::Legends.Trait.Addict);
		::Legends.Effects.remove(_actor, ::Legends.Effect.Hangover);
		::Legends.Effects.remove(_actor, ::Legends.Effect.Exhausted);
		_actor.setHitpoints(_actor.getHitpointsMax());
		_actor.getFlags().set("PotionsUsed", 0);
		_actor.getFlags().set("IsRejuvinated", true);
		_actor.getSprite("permanent_injury_1").Visible = false;
		_actor.getSprite("permanent_injury_2").Visible = false;
		_actor.getSprite("permanent_injury_3").Visible = false;
		_actor.getSprite("permanent_injury_4").Visible = false;
		_actor.getSprite("permanent_injury_scarred").Visible = false;
		_actor.getSprite("permanent_injury_burned").Visible = false;
		_actor.getSprite("permanent_injury_1").resetBrush();
		_actor.getSprite("permanent_injury_2").resetBrush();
		_actor.getSprite("permanent_injury_3").resetBrush();
		_actor.getSprite("permanent_injury_4").resetBrush();
		_actor.getSprite("permanent_injury_scarred").resetBrush();
		_actor.getSprite("permanent_injury_burned").resetBrush();

		// Inventor 'injuries'
		::Legends.Traits.remove(_actor, ::Legends.Trait.LegendProstheticEar);
		::Legends.Traits.remove(_actor, ::Legends.Trait.LegendProstheticEye);
		::Legends.Traits.remove(_actor, ::Legends.Trait.LegendProstheticFinger);
		::Legends.Traits.remove(_actor, ::Legends.Trait.LegendProstheticFoot);
		::Legends.Traits.remove(_actor, ::Legends.Trait.LegendProstheticForearm);
		::Legends.Traits.remove(_actor, ::Legends.Trait.LegendProstheticLeg);
		::Legends.Traits.remove(_actor, ::Legends.Trait.LegendProstheticHand);
		::Legends.Traits.remove(_actor, ::Legends.Trait.LegendProstheticNose);

		return true;
	}
});