this.legend_intensive_training_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		HitpointsAdded = 0,
		StaminaAdded = 0,
		BraveAdded = 0,
		IniAdded = 0,
		MatkAdded = 0,
		RatkAdded = 0,
		MdefAdded = 0,
		RdefAdded = 0,
		TraitGained = "",
		BonusXP = 0.0,
		MaxSkillsCanBeAdded = 15
	},
	function create()
	{
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendIntensiveTraining);
		this.m.Name = "Training progress";
		this.m.Icon = "ui/traits/IntensiveTraining.png";
		this.m.Description = "This character has some military training but will take time to find their feet.\n Place them in the training camp to hone their skills. Training progress points will be earned over time.\n At 15 points, this character will gain a perk point and one positive trait relevant to their combat style.\n\n [color=" + this.Const.UI.Color.NegativeValue + "]You can only gain training progress points with the upgraded training tent in your stash![/color]";
		this.m.Order = this.Const.SkillOrder.Background + 1;
		this.m.Type = this.Const.SkillType.Trait;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.IsSerialized = true;
	}

	function addRandomSkills( _bro, _skillsNum )
	{
		for( local i = 0; i < _skillsNum; i++ )
		{
			local attr = this.Math.rand(0, this.Const.Attributes.COUNT-1);

			switch(attr)
			{
			case 0:
				_bro.getBaseProperties().Hitpoints += 1;
				this.addHitpoint();
				break;

			case 1:
				_bro.getBaseProperties().Bravery += 1;
				this.addBrave();
				break;

			case 2:
				_bro.getBaseProperties().Stamina += 1;
				this.addStamina();
				break;

			case 3:
				_bro.getBaseProperties().Initiative += 1;
				this.addIni();
				break;

			case 4:
				if ( _bro.getBaseProperties().MeleeSkill > _bro.getBaseProperties().RangedSkill )
				{
					_bro.getBaseProperties().MeleeSkill += 1;
					this.addMatk();
				}else
				{
					_bro.getBaseProperties().RangedSkill += 1;
					this.addRatk();
				}
				break;

			case 5:
				_bro.getBaseProperties().MeleeDefense += 1;
				this.addMdef();
				break;

			default:
				_bro.getBaseProperties().RangedDefense += 1;
				this.addRdef();
				break;

			}
		}

		_bro.getSkills().update();
	}

	function getBonusXP()
	{
		return this.m.BonusXP;
	}

	function finishedTraining( _traitGained )
	{
		this.m.Description = "This character has completed basic training.\n Experience gained from all sources has been permanently increased by [color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color].\n This character can still get perk and attribute points from training.";
		this.m.Icon = "ui/traits/IntensiveTrainingCompleted.png";
		this.m.TraitGained = _traitGained;
		this.m.BonusXP = 0.05;
	}

	function addHitpoint()
	{
		this.m.HitpointsAdded++;
	}
	function addStamina()
	{
		this.m.StaminaAdded++;
	}
	function addBrave()
	{
		this.m.BraveAdded++;
	}
	function addIni()
	{
		this.m.IniAdded++;
	}
	function addMatk()
	{
		this.m.MatkAdded++;
	}
	function addRatk()
	{
		this.m.RatkAdded++;
	}
	function addMdef()
	{
		this.m.MdefAdded++;
	}
	function addRdef()
	{
		this.m.RdefAdded++;
	}

	function getDescription()
	{
		return this.m.Description;
	}

	function getStatsIncreased()
	{
		return this.m.HitpointsAdded + this.m.StaminaAdded + this.m.BraveAdded + this.m.IniAdded + this.m.MatkAdded + this.m.RatkAdded + this.m.MdefAdded + this.m.RdefAdded;
	}

	function isMaxReached()
	{
		return this.getStatsIncreased() >= this.m.MaxSkillsCanBeAdded;
	}

	function getMaxSkillsCanBeAdded()
	{
		return this.m.MaxSkillsCanBeAdded;
	}

	function successfullyTrained( _bro )
	{

	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
			tooltip.push({
				id = 6,
				type = "text",
				icon = "",
				text = ""
				});
//		this.logInfo(this.getContainer().getActor().getBackground().getNameOnly());

		if ( this.getContainer().getActor().getBackground().getNameOnly()=="Donkey" )
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "The donkey looks at you, somewhat confused..."
			});
		}else
		if (getStatsIncreased() > 0)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "",
				text = this.isMaxReached() ? "Training results:" : "Training results so far:"
				});

			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + getStatsIncreased() + "[/color] total skill points"
				});

			if (this.m.HitpointsAdded > 0)
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/health.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.HitpointsAdded + "[/color] Hitpoints"
				});
			}

			if (this.m.StaminaAdded > 0)
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.StaminaAdded + "[/color] Fatigue"
				});
			}

			if (this.m.BraveAdded > 0)
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/bravery.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.BraveAdded + "[/color] Resolve"
				});
			}
			if (this.m.IniAdded > 0)
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/initiative.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.IniAdded + "[/color] Initiative"
				});
			}

			if (this.m.MatkAdded > 0)
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.MatkAdded + "[/color] Melee Skill"
				});
			}

			if (this.m.RatkAdded > 0)
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/ranged_skill.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.RatkAdded + "[/color] Ranged Skill"
				});
			}

			if (this.m.MdefAdded > 0)
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.MdefAdded + "[/color] Melee Defense"
				});
			}	
			
			if (this.m.RdefAdded > 0)
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/ranged_defense.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.RdefAdded + "[/color] Ranged Defense"
				});
			}

				if ( this.isMaxReached() )
				{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/special.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + 1 + "[/color] Perk point",
					divider = "top"
					});
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/special.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.TraitGained + "[/color] trait"
					});
				}
		}
		else
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "This character has not started training"
			});
		}
		return tooltip;
	}

	function isHidden()
	{
		if (this.getStatsIncreased() == 0) return true;
		return false;
	}

	function onSerialize( _out )
	{
		this.skill.onSerialize(_out);
		_out.writeU16(this.m.HitpointsAdded);
		_out.writeU16(this.m.StaminaAdded);
		_out.writeU16(this.m.BraveAdded);
		_out.writeU16(this.m.IniAdded);
		_out.writeU16(this.m.MatkAdded);
		_out.writeU16(this.m.RatkAdded);
		_out.writeU16(this.m.MdefAdded);
		_out.writeU16(this.m.RdefAdded);
		_out.writeF32(this.m.BonusXP);
		_out.writeString(this.m.TraitGained);
	}

	function onDeserialize( _in )
	{
		this.skill.onDeserialize(_in);
		this.m.HitpointsAdded = _in.readU16();
		this.m.StaminaAdded = _in.readU16();
		this.m.BraveAdded = _in.readU16();
		this.m.IniAdded = _in.readU16();
		this.m.MatkAdded = _in.readU16();
		this.m.RatkAdded = _in.readU16();
		this.m.MdefAdded = _in.readU16();
		this.m.RdefAdded = _in.readU16();
		this.m.BonusXP = _in.readF32();
		this.m.TraitGained = _in.readString();

		if(this.isMaxReached())
		{
			this.m.Name = "Training fulfilled";
		this.m.Description = "This character has completed all their training and cannot learn more from training in camp.\n Experience gained from training has been permanently increased by [color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color].\n This character won\'t get perk and attribute points from training in camp anymore.";
			this.m.Icon = "ui/traits/IntensiveTrainingCompletedFull.png";
		}
	}

});

