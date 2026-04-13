this.legend_prosthetic_nose <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		IsUpgraded = false
	},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendProstheticNose);
		this.m.Name = "Prosthetic Nose";
		this.m.Icon = "ui/traits/legend_prosthetic_nose.png";
		this.m.Description = "A roughly made fake nose that does more to ensure the wearer can actually breath than actually make them look nice. Try not to lie.";
		if (this.m.IsUpgraded)
		{
			this.m.Name = "Enhanced Prosthetic Nose";
			this.m.Description = "Lovingly recrafted to both ensure the wearer can breath normally, but also has a mechanism that slowly releases vapors from berserker mushrooms that allows the user to enter a sort of combat trance. Will not feel injuries and has increased aggression.";
		}
	}

	function getTooltip()
	{
		local ret = [
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
		if (!this.m.IsUpgraded)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=%negative%]-5%[/color] Max Fatigue"
			});
		}
		else
		{
			ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=%positive%]+10%[/color] Damage in Melee"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%negative%]-5[/color] Melee Defense"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%negative%]-5[/color] Ranged Defense"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "No morale check triggered upon losing hitpoints"
			}]);
		}

		return ret;
	}

	function onUpdate( _properties )
	{
		if (this.m.IsUpgraded)
		{
			_properties.MeleeDefense -= 5;
			_properties.RangedDefense -= 5;
			_properties.IsAffectedByLosingHitpoints = false;
		}
		else
		{
			_properties.StaminaMult *= 0.95;
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && !_skill.isRanged() && this.m.IsUpgraded)
		{
			_properties.DamageTotalMult *= 1.10;
		}
	}

	function onApplyAppearance()
	{
		local sprite = this.getContainer().getActor().getSprite("permanent_injury_3");
		sprite.setBrush("permanent_injury_03");
		sprite.Visible = false;
	}

});
