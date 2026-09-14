::mods_hookExactClass("skills/traits/night_blind_trait", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "During nighttime this character has to be tied to a flock, because they won\'t be able to see even their own nose.";
	}

	o.onUpdate = function ( _properties )
	{
		if (this.getContainer().hasEffect(::Legends.Effect.Night) && _properties.IsAffectedByNight == true)
		{
			_properties.Vision -= 1;
		}
	}

});
