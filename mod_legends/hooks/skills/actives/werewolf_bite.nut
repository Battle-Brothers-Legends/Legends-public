::mods_hookExactClass("skills/actives/werewolf_bite", function(o)
{
	o.m.IsRestrained <- false;
	o.m.IsSpent <- false;

	o.isUsable <- function ()
	{
		return this.skill.isUsable() && !this.m.IsSpent;
	}

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Tear an enemy assunder with your teeth";
		this.m.IconDisabled = "skills/active_71_bw.png";
	}

	o.getTooltip <- function ()
	{
		local p = this.getContainer().getActor().getCurrentProperties();
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 4,
				type = "text",
				icon = "ui/icons/health.png", // fix from /ui to ui/, Abyss 6/17/23
				text = "Inflicts [color=%damage%]" + p.DamageRegularMin + "[/color] - [color=%damage%]" + p.DamageRegularMax + "[/color] damage"
			}
		];
	}

	o.onUpdate = function (_properties)
	{
		if (isUsable())
		{
			_properties.DamageRegularMin += 30;
			_properties.DamageRegularMax += 50;
			_properties.DamageArmorMult	*= 0.7;
		}
	}

	local onUse = o.onUse;
	o.onUse <- function( _user, _targetTile )
	{
		if (this.m.IsRestrained)
		{
			this.m.IsSpent = true;
		}
		return onUse(_user, _targetTile);
	}

	o.onTurnStart <- function()
	{
		this.m.IsSpent = false;
	}

	o.setRestrained <- function( _f )
	{
		this.m.IsRestrained = _f;
	}
});
