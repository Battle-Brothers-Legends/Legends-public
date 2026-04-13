::mods_hookExactClass("skills/actives/throw_axe", function(o)
{
	o.m.IsBackupAxe <- false;
	o.m.AdditionalAccuracy = 20;
	o.m.AdditionalHitChance = -10;

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.MinRange = 1;
		this.m.Delay = 150;
	}

	o.setItem <- function(_item) {
		this.skill.setItem(_item);
		if (this.m.IsBackupAxe) {
			this.m.Name = "Throw Backup Axe";
			this.m.Description = "Hurl your backup axe at a target. Can not be used while engaged in melee.";
			this.m.ActionPointCost = 5;
			this.m.FatigueCost = 20;
		}
	}

	o.getTooltip = function ()
	{
		local tooltip = this.getRangedTooltip(this.getDefaultTooltip());

		local ammo = this.getAmmo();
		local itemName = this.m.IsBackupAxe ? "backup axe" : "axes";
		if (ammo > 0)
		{
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=%positive%]%_ammo%[/color] %_itemName% left",
				param = [["_itemName", itemName], ["_ammo", ammo]]
			});
		}
		else
		{
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]No %_itemName% left[/color]",
				param = [["_itemName", itemName]]
			});
		}

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			tooltip.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return tooltip;
	}

	o.getAmmo = function ()
	{
		local item = this.getItem();

		if (item == null)
		{
			return 0;
		}

		return item.getAmmo();
	}

	o.consumeAmmo = function ()
	{
		local item = this.getItem();

		if (item != null)
		{
			item.consumeAmmo();
		}
	}

	o.isUsable = function ()
	{
		local isUsable = !this.Tactical.isActive() || this.skill.isUsable() && this.getAmmo() > 0;
		if (this.getContainer().hasPerk(::Legends.Perk.LegendPointBlank))
			return isUsable;

		return isUsable && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	o.onAfterUpdate = function ( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInThrowing ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.AdditionalAccuracy = 20 + this.m.Item.getAdditionalAccuracy();
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
		}
	}
});
