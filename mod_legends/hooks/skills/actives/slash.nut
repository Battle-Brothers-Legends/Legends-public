::mods_hookExactClass("skills/actives/slash", function(o)
{
	o.m.IsGreatSlash <- false;
	o.m.IsStaffSlash <- false;

	o.setItem <- function (_item)
	{
		this.skill.setItem(_item);
		if (this.m.IsGreatSlash)
		{
			this.m.Name = "Great Slash";
			this.m.Description = "A hefty swift slashing attack dealing average damage.";
			this.m.DirectDamageMult = 0.25;
			this.m.FatigueCost = 13;
		}
		else if (this.m.IsStaffSlash)
		{
			this.m.Description = "A swift slashing attack dealing average damage that can cover the distance of 2 tiles and can be used from behind the frontline, outside the range of most melee weapons.";
			this.m.FatigueCost = 13;
			this.m.MaxRange = 2;
			this.m.ActionPointCost = 5;
		}
	}

	o.getTooltip = function ()
	{
		local tooltip = this.getDefaultTooltip();

		tooltip.push(
			{
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.HitChanceBonus	+ "%[/color] chance to hit"
			}
		);

		return tooltip;
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function( _properties )
	{
		if (!this.m.IsStaffSlash)
			return onAfterUpdate(_properties);

		this.m.ActionPointCost = _properties.IsSpecializedInPolearms ? 4 : 5;
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.MeleeSkill += 10;

			_skill.resetField("HitChanceBonus");

			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
			{
				_properties.MeleeSkill += 5;
				this.m.HitChanceBonus += 5;
			}
		}
	}

});
