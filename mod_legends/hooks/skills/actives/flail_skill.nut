::mods_hookExactClass("skills/actives/flail_skill", function(o)
{
	o.m.isChain <- false;

	local create = o.create;
	o.create = function ()
	{
		create();
		if (this.m.isChain)
		{
			this.m.Name = "Chain Flail";
			this.m.MaxRange = 3;
			this.m.Icon = "skills/active_62.png";
			this.m.IconDisabled = "skills/active_62_sw.png";
			this.m.Overlay = "active_62";
		}
	}

	o.onAnySkillUsed <- function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this && this.m.isChain)
		{
			_properties.MeleeSkill -= 10;
		}
	}

});
