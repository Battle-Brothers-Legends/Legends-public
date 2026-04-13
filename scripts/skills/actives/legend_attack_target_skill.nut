this.legend_attack_target_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Pet = [],
		LastTarget = null
	},

	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendAttackTarget);
		this.m.Description = "Orders your pet to prioritize attacking a specific target.";
		this.m.Icon = "skills/houndattack.png";
		this.m.IconDisabled = "skills/houndattack_bw.png";
		this.m.Overlay = "perk_38_active";
		this.m.SoundOnUse = [
			"sounds/enemies/wardog_charge_00.wav",
			"sounds/enemies/wardog_charge_01.wav",
			"sounds/enemies/wardog_charge_02.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any + 1;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingHitchance = false;
		this.m.ActionPointCost = 2;
		this.m.FatigueCost = 3;
		this.m.MinRange = 1;
		this.m.MaxRange = 9;
		this.m.MaxLevelDifference = 4;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = [
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
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Set a target for your unleased animals"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Pet(s) still on guarding will ignore this command[/color]"
			},
		];

		return ret;
	}


	function addPet( _petID )
	{
		this.m.Pet.push(_petID);
	}

	function removePet( _petID )
	{
		local i = this.m.Pet.find(_petID);

		if (i != null)
		{
			this.m.Pet.remove(_petID);
		}
	}

	function onUpdate( _properties )
	{
		if (this.m.Pet.len() != 0)
		{
			local pets = [];

			foreach (id in this.m.Pet)
			{
				local e = this.Tactical.getEntityByID(id);

				if (e != null)
				{
					pets.push(id);
				}
			}

			this.m.Pet = pets;
		}
	}

	function isUsable()
	{
		return this.m.Pet.len() != 0 && this.skill.isUsable();
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (this.m.Container.getActor().isAlliedWith(_targetTile.getEntity()))
		{
			return false;
		}

		return true;
	}

	function setTarget(_t)
	{
		if (this.m.LastTarget != null)
		{
			local e = this.Tactical.getEntityByID(this.m.LastTarget);
			if (e != null)
			{
				::Legends.Effects.remove(e, ::Legends.Effect.LegendMarkedTarget);
			}
		}
		this.m.LastTarget = null;


		foreach (id in this.m.Pet)
		{
			local pet = this.Tactical.getEntityByID(id);
			if (pet == null)
			{
				continue;
			}

			pet.getAIAgent().setForcedOpponent(_t);
			if (_t == null)
			{
				continue;
			}

			if (pet.getMoraleState() == this.Const.MoraleState.Fleeing)
			{
				pet.setMoraleState(1);
			}
			this.spawnIcon("status_effect_106", pet.getTile());
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(pet) + " has a new prey,  " + this.Const.UI.getColorizedEntityName(_t));
		}

		if (_t == null)
		{
			return;
		}
		::Legends.Effects.grant(_t, ::Legends.Effect.LegendMarked);
		this.m.LastTarget = _t.getID();
	}

	function onUse( _user, _targetTile )
	{
		if (_user.getSkills().hasActive(::Legends.Active.LegendProtectTarget))
		{
			local skill = ::Legends.Actives.get(_user, ::Legends.Active.LegendProtectTarget);
			skill.setTarget(null);
		}

		local target = _targetTile.getEntity();
		this.setTarget(target);
		return true;
	}

});

