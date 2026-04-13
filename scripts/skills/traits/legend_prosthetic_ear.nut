this.legend_prosthetic_ear <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		IsUpgraded = false
	},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendProstheticEar);
		this.m.Name = "Prosthetic Ear";
		this.m.Icon = "ui/traits/legend_prosthetic_ear.png";
		this.m.Description = "A wax ear stitched into one\'s head. Hardly a proper replacement, but some sense of balance is returned and very faint noises can be heard.";
		if (this.m.IsUpgraded)
		{
			this.m.Name = "Enhanced Prosthetic Ear";
			this.m.Description = "Until you look closely this prosthetic is hard to distinguish from a real ear and seems to convey sound as good as a real ear. An otherworldly scream is a lot less frightening when one can choose if they want to hear it at all, so against your better judgement, a gate is installed to filter out noise. Sadly your orders also fall on deaf ears.";
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
			ret.push(
			{
				id = 7,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-5%[/color] Initiative"
			});
		}
		else
		{
			result.push({
				id = 14,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=%positive%]+10[/color] Resolve at morale checks against fear, panic or mind control effects"
			});
		}


		return ret;
	}

	function onUpdate( _properties )
	{
		if (!this.m.IsUpgraded)
		{
			_properties.InitiativeMult *= 0.95;
		}
		else
		{
			_properties.MoraleCheckBravery[1] += 10;
		}
	}

	function onApplyAppearance()
	{
		local sprite = this.getContainer().getActor().getSprite("permanent_injury_2");
		sprite.setBrush("permanent_injury_02");
		sprite.Visible = false;
	}

});
