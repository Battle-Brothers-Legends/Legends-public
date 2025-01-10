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

		local isDonkey = false;
		if (_actor.getSkills().hasSkill("injury.legend_donkey_background")) //if we use it on a donkey
		{
			isDonkey = true;
			_actor.getSkills().removeByID("injury.legend_donkey_background"); //remove donkey skill temporarily
			if (!_actor.getSkills().hasSkillOfType(this.Const.SkillType.Injury)) //if we have no more injuries
			{
				_actor.getSkills().add(this.new("scripts/skills/injury_permanent/legend_donkey_injury"));
				return false; //re-add donkey injury and return false
			}
		}

		this.Sound.play("sounds/combat/drink_03.wav", this.Const.Sound.Volume.Inventory);
		_actor.getSkills().removeByType(this.Const.SkillType.Injury);
		_actor.getSkills().removeByID("trait.old");
		_actor.getSkills().removeByID("trait.addict");
		_actor.getSkills().removeByID("effects.hangover");
		_actor.getSkills().removeByID("effects.exhausted");
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
		_actor.getSkills().removeByID("trait.legend_prosthetic_ear");
		_actor.getSkills().removeByID("trait.legend_prosthetic_eye");
		_actor.getSkills().removeByID("trait.legend_prosthetic_finger");
		_actor.getSkills().removeByID("trait.legend_prosthetic_foot");
		_actor.getSkills().removeByID("trait.legend_prosthetic_forearm");
		_actor.getSkills().removeByID("trait.legend_prosthetic_leg");
		_actor.getSkills().removeByID("trait.legend_prosthetic_hand");
		_actor.getSkills().removeByID("trait.legend_prosthetic_nose");

		// Re-add donkey
		if (isDonkey) //if we were a donkey up top and had more perm injuries, then we re-add donkey injury here
		{
			_actor.getSkills().add(this.new("scripts/skills/injury_permanent/legend_donkey_injury"));
		}
		return true;
	}
});