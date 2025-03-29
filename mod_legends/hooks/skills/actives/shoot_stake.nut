::mods_hookExactClass("skills/actives/shoot_stake", function(o)
{
	o.m.AdditionalAccuracy = 10;
	o.m.AdditionalHitChance = -3;

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "A quick pull of the trigger to loose a heavy bolt. Must be reloaded after each shot to be able to fire again. Knocks targets back. Deals +100 damage to vampires";
	}

	o.getTooltip = function ()
	{
		local tooltip = this.getRangedTooltip(this.getDefaultTooltip());

		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color] bolts left"
			});
		}
		else
		{
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Needs a non-empty quiver of bolts equipped[/color]"
			});
		}

		if (!this.getItem().isLoaded())
		{
			tooltip.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Must be reloaded before firing again[/color]"
			});
		}

		return tooltip;
	}

	o.onAfterUpdate = function ( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInCrossbows ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.DirectDamageMult = _properties.IsSpecializedInCrossbows ? 0.7 : 0.5;
		this.m.AdditionalAccuracy = 10 + this.m.Item.getAdditionalAccuracy();
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill != this)
		{
			return;
		}

		if (_targetEntity == null)
		{
			return;
		}

		_properties.RangedSkill += this.m.AdditionalAccuracy;
		_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;

		if (_targetEntity.getType() == this.Const.EntityType.Vampire || _targetEntity.getType() == this.Const.EntityType.LegendVampireLord)
		{
			_properties.DamageRegularMin += 100;
			_properties.DamageRegularMax += 105;
		}

		if (_properties.IsSharpshooter)
		{
			_properties.DamageDirectMult += 0.05;
		}
	}

});
