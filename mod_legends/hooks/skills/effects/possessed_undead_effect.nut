::mods_hookExactClass("skills/effects/possessed_undead_effect", function(o) {
	o.m.IsControlledByPlayer <- false;

	o.setPlayerControlled <- function ( _v )
	{
		this.m.IsControlledByPlayer = _v;
	}

	o.onRemoved = function ()
	{
		if (this.m.Possessor != null && !this.m.Possessor.isNull() && this.m.Possessor.isAlive())
		{
			local skill = this.m.Possessor.getSkills().getSkillByID("effects.possessing_undead");

			if (skill != null)
			{
				skill.setPossessed(null);
				this.m.Possessor.getSkills().remove(skill);
			}
		}

		if (this.getContainer() != null)
		{
			local actor = this.getContainer().getActor();
			if (actor == null || actor.isNull() || !actor.isAlive())
				return;

			if (actor.hasSprite("status_rage"))
			{
				if (actor.isHiddenToPlayer())
				{
					actor.getSprite("status_rage").Visible = false;
				}
				else
				{
					local sprite = actor.getSprite("status_rage");
					sprite.fadeOutAndHide(1500);

					if (actor.isAlive())
					{
						this.Time.scheduleEvent(this.TimeUnit.Real, 1800, function ( _d )
						{
							if (_d != null && _d.isAlive())
							{
								_d.setDirty(true);
							}
						}, actor);
					}
				}
			}
		}
	}
});
