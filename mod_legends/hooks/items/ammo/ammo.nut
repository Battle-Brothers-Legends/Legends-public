::mods_hookExactClass("items/ammo/ammo", function(o) {
	o.m.AddGenericSkill <- false;
	o.m.StaminaModifier <- 0;

	o.getStaminaModifier <- function ()
	{
		return this.m.StaminaModifier;
	}

	o.onEquip = function ()
	{
		this.item.onEquip();
		if (this.m.AddGenericSkill)
		{
			this.addGenericItemSkill();
		}

		if (this.m.ShowOnCharacter)
		{
			local app = this.getContainer().getAppearance();
			app.ShowQuiver = this.m.ShowQuiver;

			if (this.m.ShowQuiver)
			{
				app.Quiver = this.m.Sprite;
			}

			this.getContainer().updateAppearance();
		}

		if (!this.getContainer().getActor().isPlayerControlled())
		{
			this.m.Ammo = this.Math.rand(1, this.Math.max(1, this.m.AmmoMax - 1));
		}
	}

	o.onUnequip = function ()
	{
		this.item.onUnequip();

		if (this.m.ShowOnCharacter)
		{
			local app = this.getContainer().getAppearance();
			app.ShowQuiver = false;
			this.getContainer().updateAppearance();
		}
	}

	o.onUpdateProperties <- function ( _properties )
	{
		if (this.m.Ammo == 0.0)
		{
			return;
		}

		_properties.Stamina += this.m.StaminaModifier;
	}
});