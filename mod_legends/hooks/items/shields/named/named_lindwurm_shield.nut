::mods_hookExactClass("items/shields/named/named_lindwurm_shield", function (o) {
	o.create = function () {
		this.named_shield.create();
		this.m.Variants = [7];
		this.m.Variant = 7;
		this.updateVariant();
		this.m.ID = "shield.named_lindwurm";
		this.m.NameList = ::Const.Strings.ShieldNames;
		this.m.Description = "A sturdy wooden frame lays the base for a shimmering heap of rare Lindwurm scales to form a shield impenetrable.";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.Value = 1300;
		this.m.MeleeDefense = 25;
		this.m.RangedDefense = 25;
		this.m.StaminaModifier = -14;
		this.m.Condition = 64;
		this.m.ConditionMax = 64;
		this.m.Block = 13;
		this.m.RegularDamage = 10;
		this.m.RegularDamageMax = 25;
		this.randomizeValues();
	}

	o.resetStats <- function () {
		this.m.MeleeDefense = 25;
		this.m.RangedDefense = 25;
		this.m.StaminaModifier = -14;
		this.m.Condition = 64;
		this.m.ConditionMax = 64;
		this.m.Block = 13;
		this.m.RegularDamage = 10;
		this.m.RegularDamageMax = 25;
		this.m.Value = 1800;
	}

	o.onShieldHit <- function (_attacker, _skill) {
		if (::Legends.S.isEntityNullOrDead(_attacker)) {
			if (_attacker.getFlags().has("lindwurm")) {
				return;
			}

			if ((_attacker.getFlags().has("body_immune_to_acid") || _attacker.getArmor(::Const.BodyPart.Body) <= 0) && (_attacker.getFlags().has("head_immune_to_acid") || _attacker.getArmor(::Const.BodyPart.Head) <= 0)) {
				return;
			}

			local poison = ::Legends.Effects.get(_attacker, ::Legends.Effect.LindwurmAcid);

			if (poison == null) {
				::Legends.Effects.grant(_attacker, ::Legends.Effect.LindwurmAcid);
			} else {
				poison.resetTime();
			}

			this.spawnIcon("status_effect_78", _attacker.getTile());
		}
	}
});
