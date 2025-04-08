::mods_hookExactClass("skills/actives/strike_skill", function(o) {
	o.m.IsGlaiveStrike <- false;

	o.setItem <- function(_item) {
		this.skill.setItem(_item);
		if (this.m.IsGlaiveStrike) {
			this.m.Description = "A thrusting or sweeping strike that can cover the distance of 2 tiles and can be used from behind the frontline, outside the range of most other melee weapons.";
			this.m.Icon = "skills/glaive_slash.png";
			this.m.IconDisabled = "skills/glaive_slash_bw.png";
			this.m.InjuriesOnBody = this.Const.Injury.CuttingAndPiercingBody;
			this.m.InjuriesOnHead = this.Const.Injury.CuttingAndPiercingHead;
			this.m.ChanceDecapitate = 0;
		}
	}

	local onAnySkillUsed = o.onAnySkillUsed;
	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		onAnySkillUsed( _skill, _targetEntity, _properties );
		if (_skill == this)
		{
			if (!this.m.ApplyAxeMastery)
			{
				_properties.MeleeSkill += 5;
				this.m.HitChanceBonus += 5;
			}

			if (_targetEntity != null && (this.m.ApplyAxeMastery && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes || !this.m.ApplyAxeMastery && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms) && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus += -5;
			}
			else if (!this.m.ApplyAxeMastery)
			{
				this.m.HitChanceBonus += 5;
			}
		}
	}
});
