this.legend_commander_abstract_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Commander = null
	},

	function setCommander(_v)
	{
		if (typeof _v == "instance")
		{
			this.m.Commander = _v;
		}
		else
		{
			this.m.Commander = this.WeakTableRef(_v);
		}
	}

	function getCommander()
	{
		return this.m.Commander
	}

	function create()
	{
		this.m.ID = "effects.legend_commander_abstract";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Icon = "";
		this.m.IconMini = "";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}
	


	function onUpdate( _properties )
	{
	}


	function onTurnStart()
	{
		this.removeFromAll();
	}

	function onDeath( _fatalityType )
	{
		this.removeFromAll();
	}

	function removeFromAll()
	{
		if (this.getCommander() == this.getContainer().getActor())
		{
			local actors = this.Tactical.Entities.getInstancesOfFaction(this.getContainer().getActor().getFaction());

			foreach( a in actors )
			{
				local effect = a.getSkills().getSkillByID(this.m.ID);
				if (effect != null && effect.getCommander() == this.getCommander()) //if for some god forsaken reason we have 2 commanders casting these skills it'll only remove the correct one
					a.getSkills().removeByID(this.m.ID);	
			}
		}
	}

});
