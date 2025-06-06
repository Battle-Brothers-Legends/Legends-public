this.legend_summon_dawg <- this.inherit("scripts/skills/skill", {

	m = {
		Sounds0	= [ "sounds/enemies/wardog_hurt_00.wav", "sounds/enemies/wardog_hurt_01.wav", "sounds/enemies/wardog_hurt_02.wav", "sounds/enemies/wardog_hurt_03.wav", "sounds/enemies/wardog_hurt_04.wav", "sounds/enemies/wardog_hurt_05.wav" ]
		Sounds1	= [ "sounds/enemies/wardog_death_00.wav", "sounds/enemies/wardog_death_01.wav", "sounds/enemies/wardog_death_02.wav", "sounds/enemies/wardog_death_03.wav" ]
		Sounds2	= [ "sounds/enemies/wardog_flee_00.wav", "sounds/enemies/wardog_flee_01.wav", "sounds/enemies/wardog_flee_02.wav", "sounds/enemies/wardog_flee_03.wav", "sounds/enemies/wardog_flee_04.wav" ]
		Sounds3	= [ "sounds/enemies/wardog_idle_01.wav", "sounds/enemies/wardog_idle_02.wav", "sounds/enemies/wardog_idle_03.wav", "sounds/enemies/wardog_idle_04.wav", "sounds/enemies/wardog_idle_05.wav" ]
		Sounds4	= [ "sounds/enemies/wardog_charge_00.wav", "sounds/enemies/wardog_charge_01.wav", "sounds/enemies/wardog_charge_02.wav" ]
		Sounds5 = [ "sounds/enemies/wardog_bite_00.wav", "sounds/enemies/wardog_bite_01.wav", "sounds/enemies/wardog_bite_02.wav", "sounds/enemies/wardog_bite_03.wav", "sounds/enemies/wardog_bite_04.wav", "sounds/enemies/wardog_bite_05.wav", "sounds/enemies/wardog_bite_06.wav" ]
	}

	function create() {
		m.ID				= "actives.legend_summon_dawg";
		m.Name				= "Summon Dawg";
		m.Description		= "";
		m.Icon				= "skills/active_83.png";
		m.IconDisabled		= "skills/active_83_sw.png";
		m.Overlay			= "active_83";
		m.SoundOnUse		= [
			"sounds/combat/unleash_wardog_01.wav",
			"sounds/combat/unleash_wardog_02.wav",
			"sounds/combat/unleash_wardog_03.wav",
			"sounds/combat/unleash_wardog_04.wav"
		];
		m.Type				= Const.SkillType.Active;
		m.Order				= Const.SkillOrder.NonTargeted + 5;
		m.IsSerialized		= false;
		m.IsActive			= true;
		m.IsTargeted		= true;
		m.IsStacking		= false;
		m.IsAttack			= false;
		m.IsTargetingActor	= false;
		m.ActionPointCost	= 0;
		m.FatigueCost		= 0;
		m.MinRange			= 1;
		m.MaxRange			= 6;
	}

	function addResources() {
		skill.addResources();
		foreach (r in m.Sounds0) {
			Tactical.addResource(r);
		}
		foreach (r in m.Sounds1) {
			Tactical.addResource(r);
		}
		foreach(r in m.Sounds2) {
			Tactical.addResource(r);
		}
		foreach (r in m.Sounds3) {
			Tactical.addResource(r);
		}
		foreach (r in m.Sounds4) {
			Tactical.addResource(r);
		}
		foreach (r in m.Sounds5) {
			Tactical.addResource(r);
		}
	}

	function getTooltip() {
		local ret =
			[
				{ id = 1, type = "title", text = getName() },
				{ id = 2, type = "description", text = getDescription() },
				{ id = 3, type = "text", text = getCostString() }
			];
		return ret;
	}

	function isUsable() {
		return true;
	}

	function onVerifyTarget(_originTile, _targetTile) {
		local actor = getContainer().getActor();
		return skill.onVerifyTarget(_originTile, _targetTile) && _targetTile.IsEmpty;
	}

	function onUpdate(_properties) {
	}

	function onUse(_user, _targetTile) {
		::logInfo("Summon Dawg: onUse: _user=" + _user + ", _targetTile=" + _targetTile);
		local entity = Tactical.spawnEntity("scripts/entity/tactical/legend_dawg", _targetTile.Coords.X, _targetTile.Coords.Y);
		entity.setFaction(this.Const.Faction.PlayerAnimals);
		entity.setName("Dawg");
		entity.setVariant(Math.rand(1, 2));
		if (Math.rand(1, 2) == 1) {
			local armor = new("scripts/items/armor/legend_dawg_armor");
			entity.getItems().equip(armor);
		}
		return true;
	}
});
