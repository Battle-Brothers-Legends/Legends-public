::mods_hookExactClass("skills/perks/perk_nine_lives", function(o) {
	o.m.MinHP <- 11;
	o.m.MaxHP <- 15;
	o.m.RemoveDamageOverTime <- true;
	o.m.DamageOverTimeSkills <- [];

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.IconMini = "perk_07_mini";
		this.m.Overlay = "perk_07";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast + 10000;
	}

	o.setSpent = function ( _f )
	{
		if (_f && !this.m.IsSpent)
		{
			this.m.IsHidden = true;
			if (this.m.MinHP != 11 || this.m.MaxHP != 15)
			{
				this.getContainer().getActor().m.Hitpoints = ::Math.rand(this.m.MinHP, this.m.MaxHP);
				this.getContainer().getActor().setDirty(true);
			}
			foreach (skill in this.m.DamageOverTimeSkills)
			{
				skill.m.SkillType += ::Const.SkillType.DamageOverTime;
			}
			this.m.DamageOverTimeSkills.clear();

			this.onProc();

			::Legends.Effects.grant(this, ::Legends.Effect.NineLives);
		}

		this.m.IsSpent = _f;
		this.m.LastFrameUsed = this.Time.getFrame();
	}

	o.onProc <- function ()
	{
	}

	local onUpdate = o.onUpdate;
	o.onUpdate = function ( _properties )
	{
		onUpdate( _properties );
		_properties.SurviveWithInjuryChanceMult *= 1.11;
	}
});
