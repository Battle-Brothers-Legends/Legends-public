::mods_hookExactClass("skills/actives/riposte", function(o) {
	o.m.IsStaff <- false;

	o.setItem <- function (_item) {
		if (this.m.IsStaff) {
			this.m.IsHidden = true;
		}
		this.skill.setItem(_item);
	}

	local create = o.create;
	o.create <- function () {
		create();
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted+1;
	}

	o.getTooltip <- function () {
		local ret = [{
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
		}];

		if (!::Legends.S.isCharacterWeaponSpecialized(this.getContainer().getActor().getCurrentProperties(), this.getItem())) {
			ret.push({
				id = 4,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] chance to hit"
			});
		}

		return ret;
	}

	o.isHidden <- function () {
		if (this.getContainer().hasPerk(::Legends.Perk.ReachAdvantage) && this.m.IsStaff) {
			return false;
		}
		return this.skill.isHidden();
	}

	o.getDescription <- function () {
		return this.m.Description + " Attacks from this ability are considered attacks of opportunity."
	}

	o.isUsable = function () {
		return !this.m.IsSpent && this.skill.isUsable() && !this.getContainer().hasEffect(::Legends.Effect.Riposte);
	}

	o.onAfterUpdate = function ( _properties ) {
		this.m.FatigueCostMult = ::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem()) ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}
});
