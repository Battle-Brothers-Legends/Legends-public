this.mods_hookExactClass("skills/injury_permanent/traumatized_injury", function(o)
{
	o.getTooltip = function ()
	{
		local resolveMalus = this.getContainer().getActor().getSkills().hasTrait(::Legends.Trait.Drunkard) ? 20 : 40;
		local iniMalus = this.getContainer().getActor().getSkills().hasTrait(::Legends.Trait.Drunkard) ? 10 : 30;
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
		if (::Legends.Effects.has(this, ::Legends.Effect.Drunk))
		{
			ret.push({
				id = 16,
				type = "text",
				icon = "ui/icons/special.png",
				text = "This character is intoxicated and is temporarily not affected by this injury."
			});
		}
		else
		{
			ret.extend([
				{
					id = 7,
					type = "text",
					icon = "ui/icons/bravery.png",
					text = "[color=%negative%]" + resolveMalus + "%[/color] Resolve"
				},
				{
					id = 7,
					type = "text",
					icon = "ui/icons/initiative.png",
					text = "[color=%negative%]" + iniMalus + "%[/color] Initiative"
				},
				{
					id = 16,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Is always content with being in reserve"
				}
			]);
		}

		this.addTooltipHint(ret);
		return ret;
	}

	local onUpdate = o.onUpdate;
	o.onUpdate = function ( _properties )
	{
		if (::Legends.Effects.has(this, ::Legends.Effect.Drunk))
			return;
		if (this.getContainer().getActor().getSkills().hasTrait(::Legends.Trait.Drunkard))
		{
			_properties.BraveryMult *= 0.8;
			_properties.InitiativeMult *= 0.9;
			_properties.IsContentWithBeingInReserve = true;
		}
		else
		{
			onUpdate( _properties );
		}
	}
});
