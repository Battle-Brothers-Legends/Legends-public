::mods_hookExactClass("skills/actives/strike_skill", function(o) {
	o.m.IsGlaiveStrike <- false;
	o.m.IsStaffStrike <- false;

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
		if (this.m.IsStaffStrike) {
			this.m.Description = "A sweeping strike that can cover the distance of 2 tiles and can be used from behind the frontline, outside the range of most other melee weapons.";
			this.m.Icon = "skills/glaive_slash.png";
			this.m.IconDisabled = "skills/glaive_slash_bw.png";
			this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
			this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		}
	}

	o.getTooltip = function ()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=%positive%]2" + "[/color] tiles"
		});

		if (!::Legends.S.isCharacterWeaponSpecialized(this.getContainer().getActor().getCurrentProperties(), this.getItem()))
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=%negative%]-15%[/color] chance to hit targets directly adjacent"
			});
		}

		return ret;
	}

	o.onAfterUpdate = function ( _properties ) {
		if (::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem())) {
			this.m.ActionPointCost -= 1;
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
		}
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			if (!this.m.ApplyAxeMastery)
			{
				_properties.MeleeSkill += 5;
				this.m.HitChanceBonus += 5;
			}

			if (this.m.IsStaffStrike && ::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem()))
			{
				_properties.MeleeSkill += 5;
				this.m.HitChanceBonus += 5;
			}

			if (_targetEntity != null && !::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem()) && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus += -5;
			}
		}
	}
});
