::mods_hookBaseClass("skills/skill", function ( o )
{
	while(!("m" in o && "ID" in o.m)) o=o[o.SuperName];

	o.m.IsForPerkTooltip <- false; // Indicate whether the Perk is a dummy that is being used only to generate unactivated perk tooltip hints
	o.m.Sound <- [];

	o.getDescription = function()
	{
		local gender = -1;
		local vars = [];
		if (this.getContainer() == null || (typeof this.getContainer() == "instance" && this.getContainer().isNull()) || this.getContainer().getActor() == null)
		{
			this.logError("Skill: " + this.getName() + " is missing a" + (this.getContainer() == null ? " Container" : "n Actor") + " when getting description");
			this.MSU.Log.printStackTrace();
		}
		else
		{
			local actor = this.getContainer().getActor();
			gender = actor.getGender();
			vars.extend([
				[
					"name",
					actor.getNameOnly()
				],
				[
					"fullname",
					actor.getName()
				],
				[
					"title",
					actor.getTitle()
				]
			]);
		}
		this.Const.LegendMod.extendVarsWithPronouns(vars, gender);
		return this.buildTextFromTemplate(this.m.Description, vars);
	}

	o.getActionPointCost = function()
	{
		if (this.m.Container.getActor().getCurrentProperties().IsSkillUseFree)
		{
			return 0;
		}
		else if (this.m.Container.getActor().getCurrentProperties().IsSkillUseHalfCost && this.m.ActionPointCost != 0)
		{
			return this.Math.max(1, this.Math.floor(this.m.ActionPointCost / 2));
		}
		else
		{
			return this.m.ActionPointCost;
		}
	}

	// Allow Perks to push Tooltip elements that will be displayed when the user views the Tooltips of unactivated Perks in the Perk screen
	o.getUnactivatedPerkTooltipHints <- function()
	{
		return [];
	}

	o.getDefaultTooltip = function()
	{
		local p = this.factoringOffhand(this.m.Container.buildPropertiesForUse(this, null));
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
			}
		];
		local damage_regular_min = this.Math.floor(p.DamageRegularMin * p.DamageRegularMult * p.DamageTotalMult * (this.m.IsRanged ? p.RangedDamageMult : p.MeleeDamageMult) * p.DamageTooltipMinMult);
		local damage_regular_max = this.Math.floor(p.DamageRegularMax * p.DamageRegularMult * p.DamageTotalMult * (this.m.IsRanged ? p.RangedDamageMult : p.MeleeDamageMult) * p.DamageTooltipMaxMult);
		local damage_direct_min = this.Math.floor(damage_regular_min * this.Math.minf(1.0, p.DamageDirectMult * (this.m.DirectDamageMult + p.DamageDirectAdd + (this.m.IsRanged ? p.DamageDirectRangedAdd : p.DamageDirectMeleeAdd))));
		local damage_direct_max = this.Math.floor(damage_regular_max * this.Math.minf(1.0, p.DamageDirectMult * (this.m.DirectDamageMult + p.DamageDirectAdd + (this.m.IsRanged ? p.DamageDirectRangedAdd : p.DamageDirectMeleeAdd))));
		local damage_armor_min = this.Math.floor(p.DamageRegularMin * p.DamageArmorMult * p.DamageTotalMult * (this.m.IsRanged ? p.RangedDamageMult : p.MeleeDamageMult) * p.DamageTooltipMinMult);
		local damage_armor_max = this.Math.floor(p.DamageRegularMax * p.DamageArmorMult * p.DamageTotalMult * (this.m.IsRanged ? p.RangedDamageMult : p.MeleeDamageMult) * p.DamageTooltipMaxMult);

		if (this.m.DirectDamageMult == 1.0)
		{
			ret.push({
				id = 4,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + damage_direct_min + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_direct_max + "[/color] damage that ignores armor"
			});
		}
		else if (this.m.DirectDamageMult > 0.0)
		{
			ret.push({
				id = 4,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + damage_regular_min + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_regular_max + "[/color] damage to hitpoints, of which [color=" + this.Const.UI.Color.DamageValue + "]0[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_direct_max + "[/color] can ignore armor"
			});
		}
		else
		{
			ret.push({
				id = 4,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + damage_regular_min + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_regular_max + "[/color] damage to hitpoints"
			});
		}

		if (damage_armor_max > 0)
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + damage_armor_min + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_armor_max + "[/color] damage to armor"
			});
		}

		if (this.m.Container.getActor().getSkills().hasSkill("trait.oath_of_honor") && (this.m.IsWeaponSkill && this.m.IsRanged || this.m.IsOffensiveToolSkill))
		{
			ret.push({
				id = 9,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used because this character has taken an oath precluding the use of ranged weapons or tools[/color]"
			});
		}
		if (this.m.ChanceSmash > 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + this.Math.min(100, this.m.ChanceSmash * p.FatalityChanceMult) + "%[/color] chance to smash the target on hits to the head that are killing blows"
			});
		}
		if (this.m.ChanceDecapitate > 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + this.Math.min(100, this.m.ChanceDecapitate * p.FatalityChanceMult) + "%[/color] chance to decapitate the target on hits to the head that are killing blows"
			});
		}
		if (this.m.ChanceDisembowel > 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + this.Math.min(100, this.m.ChanceDisembowel * p.FatalityChanceMult) + "%[/color] chance to disembowel the target on hits to the body that are killing blows"
			});
		}

		return ret;
	}

	o.getExpectedDamage = function( _target )
	{
		local actor = this.m.Container.getActor();
		local p = this.factoringOffhand(this.m.Container.buildPropertiesForUse(this, _target));
		local d = _target.getSkills().buildPropertiesForDefense(actor, this);
		local critical = 1.0 + p.getHitchance(this.Const.BodyPart.Head) / 100.0 * (p.DamageAgainstMult[this.Const.BodyPart.Head] - 1.0);
		local armor = _target.getArmor(this.Const.BodyPart.Head) * (p.getHitchance(this.Const.BodyPart.Head) / 100.0) + _target.getArmor(this.Const.BodyPart.Body) * (this.Math.max(0, p.getHitchance(this.Const.BodyPart.Body)) / 100.0);
		local armorDamage = this.Math.min(armor, p.getArmorDamageAverage());
		local directDamage = this.Math.max(0, p.getRegularDamageAverage() * (p.DamageDirectMult * (this.m.DirectDamageMult + p.DamageDirectAdd + (this.m.IsRanged ? p.DamageDirectRangedAdd : p.DamageDirectMeleeAdd))) * critical - (p.DamageDirectMult * (this.m.DirectDamageMult + p.DamageDirectAdd + (this.m.IsRanged ? p.DamageDirectRangedAdd : p.DamageDirectMeleeAdd)) < 1.0 ? (armor - armorDamage) * this.Const.Combat.ArmorDirectDamageMitigationMult : 0));
		local hitpointDamage = this.Math.max(0, p.getRegularDamageAverage() * critical - directDamage - armorDamage);
		armorDamage = armorDamage * (d.DamageReceivedArmorMult * d.DamageReceivedTotalMult);
		directDamage = directDamage * (d.DamageReceivedDirectMult * d.DamageReceivedTotalMult);
		hitpointDamage = hitpointDamage * (d.DamageReceivedRegularMult * d.DamageReceivedTotalMult);

		if (this.m.IsRanged)
		{
			armorDamage = armorDamage * (p.RangedDamageMult * d.DamageReceivedRangedMult);
			directDamage = directDamage * (p.RangedDamageMult * d.DamageReceivedRangedMult);
			hitpointDamage = hitpointDamage * (p.RangedDamageMult * d.DamageReceivedRangedMult);
		}
		else
		{
			armorDamage = armorDamage * (p.MeleeDamageMult * d.DamageReceivedMeleeMult);
			directDamage = directDamage * (p.MeleeDamageMult * d.DamageReceivedMeleeMult);
			hitpointDamage = hitpointDamage * (p.MeleeDamageMult * d.DamageReceivedMeleeMult);
		}

		local ret = {
			ArmorDamage = armorDamage,
			DirectDamage = directDamage,
			HitpointDamage = hitpointDamage,
			TotalDamage = hitpointDamage + armorDamage + directDamage
		};
		return ret;
	}

	o.onUnlocked <- function()
	{
	}

	o.onMovementCompleted <- function( _tile )
	{
	}

	o.factoringOffhand <- function( _properties )
	{
		if (this.m.Item == null || this.m.Item.isNull()) return _properties;

		if (this.m.Item.getCurrentSlotType() != this.Const.ItemSlot.Offhand) return _properties;

		if (!this.m.Item.isItemType(this.Const.Items.ItemType.Weapon)) return _properties;

		this.removeMainhandBonuses(_properties);
		this.addOffhandBonuses(this.m.Item, _properties);
		return _properties;
	}

	o.removeMainhandBonuses <- function( _properties )
	{
		local mainhand = this.getContainer().getActor().getMainhandItem();

		if (mainhand == null) return;

		_properties.DamageRegularMin -= mainhand.m.RegularDamage;
		_properties.DamageRegularMax -= mainhand.m.RegularDamageMax;
		_properties.DamageArmorMult /= mainhand.m.ArmorDamageMult;
		_properties.DamageDirectAdd -= mainhand.m.DirectDamageAdd;
		_properties.HitChance[this.Const.BodyPart.Head] -= mainhand.m.ChanceToHitHead;
	}

	o.addOffhandBonuses <- function( _offhand, _properties )
	{
		_properties.DamageRegularMin += _offhand.m.RegularDamage;
		_properties.DamageRegularMax += _offhand.m.RegularDamageMax;
		_properties.DamageArmorMult *= _offhand.m.ArmorDamageMult;
		_properties.DamageDirectAdd += _offhand.m.DirectDamageAdd;
		_properties.HitChance[this.Const.BodyPart.Head] += _offhand.m.ChanceToHitHead;
	}

	o.onVerifyTarget = function( _originTile, _targetTile )
	{
		if (this.m.IsTargetingActor && (_targetTile.IsEmpty || !_targetTile.getEntity().isAttackable() || !_targetTile.getEntity().isAlive() || _targetTile.getEntity().isDying()))
		{
			return false;
		}

		// if (_targetTile.getEntity().isSupplies() && _originTile.getEntity().isPlayerControlled())
		// {
		// 	if (!this.m.IsRanged)
		// 		return true;
		// 	else
		// 		return false;
		// }


		if (this.m.IsAttack && this.m.IsTargetingActor && this.m.Container.getActor().isAlliedWith(_targetTile.getEntity()))
		{
			return false;
		}

		if (this.Math.abs(_targetTile.Level - _originTile.Level) > this.m.MaxLevelDifference)
		{
			return false;
		}

		if (!this.m.IsRanged && this.m.IsVisibleTileNeeded && this.m.MaxRange > 1 && _originTile.getDistanceTo(_targetTile) > 1)
		{
			local myPos = _originTile.Pos;
			local targetPos = _targetTile.Pos;
			local Dx = (targetPos.X - myPos.X) / 2;
			local Dy = (targetPos.Y - myPos.Y) / 2;
			local x = myPos.X + Dx;
			local y = myPos.Y + Dy;
			local tileCoords = this.Tactical.worldToTile(this.createVec(x, y));
			local tile = this.Tactical.getTile(tileCoords);

			if (tile.Level > _originTile.Level && (_originTile.Level - tile.Level < -1 || _targetTile.Level - tile.Level < -1))
			{
				return false;
			}
		}

		return true;
	}

	o.getHitFactors = function( _targetTile )
	{
		local ret = [];
		local user = this.m.Container.getActor();
		local myTile = user.getTile();
		local targetEntity = _targetTile.IsOccupiedByActor ? _targetTile.getEntity() : null;

		if (this.m.HitChanceBonus > 0)
		{
			ret.push({
				icon = "ui/tooltips/positive.png",
				text = this.getName()
			});
		}

		if (!this.m.IsRanged && targetEntity != null && targetEntity.getSurroundedCount() != 0)
		{
			ret.push({
				icon = "ui/tooltips/positive.png",
				text = "Surrounded"
			});
		}

		if (_targetTile.Level < this.m.Container.getActor().getTile().Level)
		{
			ret.push({
				icon = "ui/tooltips/positive.png",
				text = "Height advantage"
			});
		}

		if (_targetTile.IsBadTerrain)
		{
			ret.push({
				icon = "ui/tooltips/positive.png",
				text = "Target on bad terrain"
			});
		}

		if (this.m.IsAttack)
		{
			local fast_adaption = this.m.Container.getSkillByID("perk.fast_adaption");

			if (fast_adaption != null && fast_adaption.isBonusActive())
			{
				ret.push({
					icon = "ui/tooltips/positive.png",
					text = "Fast Adaption"
				});
			}

			local oath = this.m.Container.getSkillByID("trait.oath_of_wrath");

			if (oath != null)
			{
				local items = user.getItems();
				local main = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);

				if (main != null && main.isItemType(this.Const.Items.ItemType.MeleeWeapon) && (main.isItemType(this.Const.Items.ItemType.TwoHanded) || items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null && !items.hasBlockedSlot(this.Const.ItemSlot.Offhand)))
				{
					ret.push({
						icon = "ui/tooltips/positive.png",
						text = "Oath of Wrath"
					});
				}
			}
		}

		if (this.m.IsTooCloseShown && this.m.HitChanceBonus < 0)
		{
			ret.push({
				icon = "ui/tooltips/negative.png",
				text = "Too close"
			});
		}
		else if (this.m.HitChanceBonus < 0)
		{
			ret.push({
				icon = "ui/tooltips/negative.png",
				text = this.getName()
			});
		}

		if (_targetTile.Level > myTile.Level)
		{
			ret.push({
				icon = "ui/tooltips/negative.png",
				text = "Height disadvantage"
			});
		}

		if (myTile.IsBadTerrain)
		{
			ret.push({
				icon = "ui/tooltips/negative.png",
				text = "On bad terrain"
			});
		}

		if (this.m.IsShieldRelevant)
		{
			if (_targetTile.IsOccupiedByActor && targetEntity.isArmedWithShield())
			{
				ret.push({
					icon = "ui/tooltips/negative.png",
					text = "Armed with shield"
				});
			}
		}

		if (this.m.IsShieldwallRelevant)
		{
			if (_targetTile.IsOccupiedByActor && targetEntity.getSkills().hasSkill("effects.shieldwall"))
			{
				ret.push({
					icon = "ui/tooltips/negative.png",
					text = "Shieldwall"
				});
			}
		}

		if (_targetTile.IsOccupiedByActor && myTile.getDistanceTo(_targetTile) <= 1 && targetEntity.getSkills().hasSkill("effects.riposte"))
		{
			ret.push({
				icon = "ui/tooltips/negative.png",
				text = "Riposte"
			});
		}

		// if (this.m.IsRanged && myTile.getDistanceTo(_targetTile) > 1)
		if (this.m.IsRanged && myTile.getDistanceTo(_targetTile) > this.m.MinRange)
		{
			if (_targetTile.IsOccupiedByActor && ("AdditionalHitChance" in this.m))
			{
				ret.push({
					icon = this.m.AdditionalHitChance > 0 ? "ui/tooltips/positive.png" : "ui/tooltips/negative.png",
					text = "Distance of " + _targetTile.getDistanceTo(user.getTile())
				});
			}

			if (this.m.IsUsingHitchance)
			{
				local blockedTiles = this.Const.Tactical.Common.getBlockedTiles(myTile, _targetTile, user.getFaction(), true);

				if (blockedTiles.len() != 0)
				{
					ret.push({
						icon = "ui/tooltips/negative.png",
						text = "Line of fire blocked"
					});
				}
			}
		}

		if (this.m.IsAttack && _targetTile.IsOccupiedByActor && targetEntity.getFlags().has("skeleton"))
		{
			if (this.m.IsRanged)
			{
				ret.push({
					icon = "ui/tooltips/negative.png",
					text = "Resistance against ranged weapons"
				});
			}
			else if (this.m.ID == "actives.puncture" || this.m.ID == "actives.thrust" || this.m.ID == "actives.stab" || this.m.ID == "actives.deathblow" || this.m.ID == "actives.impale" || this.m.ID == "actives.rupture" || this.m.ID == "actives.prong" || this.m.ID == "actives.lunge")
			{
				ret.push({
					icon = "ui/tooltips/negative.png",
					text = "Resistance against piercing attacks"
				});
			}
		}

		if (_targetTile.IsOccupiedByActor && targetEntity.getCurrentProperties().IsImmuneToStun && (this.m.ID == "actives.knock_out" || this.m.ID == "actives.knock_over" || this.m.ID == "actives.strike_down"))
		{
			ret.push({
				icon = "ui/tooltips/negative.png",
				text = "Immune to stun"
			});
		}

		if (_targetTile.IsOccupiedByActor && targetEntity.getCurrentProperties().IsImmuneToRoot && this.m.ID == "actives.throw_net")
		{
			ret.push({
				icon = "ui/tooltips/negative.png",
				text = "Immune to being rooted"
			});
		}

		if (_targetTile.IsOccupiedByActor && (targetEntity.getCurrentProperties().IsImmuneToDisarm || targetEntity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) == null) && this.m.ID == "actives.disarm")
		{
			ret.push({
				icon = "ui/tooltips/negative.png",
				text = "Immune to being disarmed"
			});
		}

		if (_targetTile.IsOccupiedByActor && targetEntity.getCurrentProperties().IsImmuneToKnockBackAndGrab && (this.m.ID == "actives.knock_back" || this.m.ID == "actives.hook" || this.m.ID == "actives.repel"))
		{
			ret.push({
				icon = "ui/tooltips/negative.png",
				text = "Immune to being knocked back or hooked"
			});
		}

		if (this.m.IsRanged && user.getCurrentProperties().IsAffectedByNight && user.getSkills().hasSkill("special.night"))
		{
			ret.push({
				icon = "ui/tooltips/negative.png",
				text = "Nighttime"
			});
		}

		return this.modGetHitFactors(ret, _targetTile)
	}

	o.modGetHitFactors <- function( ret, _targetTile )
	{
		if (!ret)
		{
			return ret;
		}

		local retCount = ret.len();
		local green = function ( text )
		{
			if (!text)
			{
				return "";
			}

			return "[color=" + this.Const.UI.Color.PositiveValue + "]" + text + "[/color]";
		};
		local red = function ( text )
		{
			if (!text)
			{
				return "";
			}

			return "[color=" + this.Const.UI.Color.NegativeValue + "]" + text + "[/color]";
		};
		local isIn = function ( pattern, text )
		{
			if (!pattern || !text)
			{
				return false;
			}

			return this.regexp(pattern).search(text);
		};
		local user = this.m.Container.getActor();
		local myTile = user.getTile();
		local targetEntity = _targetTile.IsOccupiedByActor ? _targetTile.getEntity() : null;
		local getBadTerrainFactor = function ( attributeIcon ) {

			if (!attributeIcon)
			{
				return false;
			}

			local badTerrains = [
				"terrain.swamp"
			];

			for( local i = 0; i < badTerrains.len(); i++ )
			{
				local terrainEffect = targetEntity.getSkills().getSkillByID(badTerrains[i]);

				if (!(terrainEffect && "getTooltip" in terrainEffect))
				{
				}
				else
				{
					local tooltip = terrainEffect.getTooltip();

					foreach( i, r in tooltip )
					{
						if (("type" in r) && r.type == "text" && ("icon" in r) && "text" in r)
						{
							if (isIn(attributeIcon, r.icon))
							{
								return r.text;
							}
						}
					}
				}
			}

			return null;
		};
		local attackingEntity = user;
		local thisSkill = this;
		local modifier = {};
		local skillName = this.getName();
		local skillHitChanceBonus = this.m.HitChanceBonus;
		modifier[skillName] <- function ( row, description )
		{
			if (!("icon" in row))
			{
				return;
			}

			local icon = row.icon;

			if (icon == "ui/tooltips/positive.png")
			{
				row.text = green("" + skillHitChanceBonus + "%") + " " + description;
			}
			else if (icon == "ui/tooltips/negative.png")
			{
				row.text = red(-skillHitChanceBonus + "%") + " " + description;
			}
		};
		modifier.Surrounded <- function ( row, description )
		{
			if (targetEntity.m.CurrentProperties.IsImmuneToSurrounding)
			{
				return;
			}

			local malus = this.Math.max(0, attackingEntity.getCurrentProperties().SurroundedBonus - targetEntity.getCurrentProperties().SurroundedDefense) * targetEntity.getSurroundedCount();

			if (malus)
			{
				row.text = green(malus + "%") + " " + description;
			}
		};
		modifier["Height advantage"] <- function ( row, description )
		{
			row.text = green(this.Const.Combat.LevelDifferenceToHitBonus + "%") + " " + description;
		};
		modifier["Height disadvantage"] <- function ( row, description )
		{
			local levelDifference = myTile.Level - _targetTile.Level;
			local malus = this.Const.Combat.LevelDifferenceToHitMalus * levelDifference;
			row.text = red(malus + "%") + " " + description;
		};

		modifier["Target on bad terrain"] <- function ( row, description )
		{
			local defenseIcon = thisSkill.m.IsRanged ? "ranged_defense" : "melee_defense";
			local terrainFactor = getBadTerrainFactor(defenseIcon);

			if (terrainFactor)
			{
				// row.text = green(terrainFactor + "%") + " " + description;
				row.text = description + " (" + terrainFactor + ")";
			}
		};
		modifier["On bad terrain"] <- function ( row, description )
		{
			local attackIcon = thisSkill.m.IsRanged ? "ranged_skill" : "melee_skill";
			local terrainFactor = getBadTerrainFactor(attackIcon);

			if (terrainFactor)
			{
				// row.text = red(terrainFactor + "%") + " " + description;
				row.text = description + " (" + terrainFactor + ")";
			}
		};
		modifier["Fast Adaption"] <- function ( row, description )
		{
			local fast_adaption = thisSkill.m.Container.getSkillByID("perk.fast_adaption");
			local bonus = 10 * fast_adaption.m.Stacks;
			row.text = green(bonus + "%") + " " + description;
		};
		modifier["Too close"] <- function ( row, description )
		{
			row.text = red(-skillHitChanceBonus + "%") + " " + description;
		};
		local getShieldBonus = function ()
		{
			local shield = targetEntity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
			local shieldBonus = (thisSkill.m.IsRanged ? shield.getRangedDefense() : shield.getMeleeDefense()) * (targetEntity.getCurrentProperties().IsSpecializedInShields ? 1.25 : 1.0);
			return this.Math.floor(shieldBonus);
		};
		modifier["Armed with shield"] <- function ( row, description )
		{
			row.text = red(getShieldBonus() + "%") + " " + description;
		};
		modifier.Shieldwall <- function ( row, description )
		{
			local shieldwallEffect = targetEntity.getSkills().getSkillByID("effects.shieldwall");
			local adjacencyBonus = shieldwallEffect.getBonus();
			row.text = red(getShieldBonus() + adjacencyBonus + "%") + " " + description;
		};
		local isRangedRelevant = function ()
		{
			// return thisSkill.m.IsRanged && myTile.getDistanceTo(_targetTile) > 1 && _targetTile.IsOccupiedByActor;
			return thisSkill.m.IsRanged && myTile.getDistanceTo(_targetTile) > this.m.MinRange && _targetTile.IsOccupiedByActor;
		};

		if (isRangedRelevant())
		{
			local distanceToTarget = _targetTile.getDistanceTo(user.getTile());
			local propertiesWithSkill = this.factoringOffhand(thisSkill.m.Container.buildPropertiesForUse(thisSkill, targetEntity));
			modifier["Distance of " + distanceToTarget] <- function ( row, description )
			{
				local hitDistancePenalty = (distanceToTarget - thisSkill.m.MinRange) * propertiesWithSkill.HitChanceAdditionalWithEachTile * propertiesWithSkill.HitChanceWithEachTileMult;
				row.text = (hitDistancePenalty > 0 ? green(hitDistancePenalty + "%") : red(-hitDistancePenalty + "%")) + " " + description;
			};
			modifier["Line of fire blocked"] <- function ( row, description )
			{
				local blockChance = this.Const.Combat.RangedAttackBlockedChance * propertiesWithSkill.RangedAttackBlockedChanceMult;
				blockChance = this.Math.ceil(blockChance * 100);
				row.text = description + "\n(" + red("-" + blockChance + "%") + " Total hit chance)";
			};
			// [080]  OP_CLOSE          0     17    0    0
		}

		modifier.Nighttime <- function ( row, description )
		{
			local night = user.getSkills().getSkillByID("special.night");
			local attributeIcon = "ranged_skill";

			if (!(night && "getTooltip" in night))
			{
				return;
			}

			local tooltip = night.getTooltip();

			foreach( _, r in tooltip )
			{
				if (("type" in r) && r.type == "text" && ("icon" in r) && "text" in r)
				{
					if (isIn(attributeIcon, r.icon))
					{
						row.text = description + "\n(" + r.text + ")";
						return;
					}
				}
			}
		};
		local getDamageResistance = function ()
		{
			if (!targetEntity)
			{
				return null;
			}

			local racialSkills = [
				"racial.skeleton",
				"racial.golem",
				"racial.serpent",
				"racial.alp",
				"racial.schrat"
			];
			local racialSkill;

			for( local i = 0; i < racialSkills.len(); i++ )
			{
				racialSkill = targetEntity.getSkills().getSkillByID(racialSkills[i]);

				if (racialSkill)
				{
					break;
				}
			}

			if (!racialSkill)
			{
				return null;
			}

			local propertiesBefore = targetEntity.getCurrentProperties();

			if (!("DamageReceivedRegularMult" in propertiesBefore))
			{
				return null;
			}

			local hitInfo = clone this.Const.Tactical.HitInfo;
			local propertiesAfter = propertiesBefore.getClone();
			racialSkill.onBeforeDamageReceived(attackingEntity, thisSkill, hitInfo, propertiesAfter);
			local diff = propertiesBefore.DamageReceivedRegularMult - propertiesAfter.DamageReceivedRegularMult;
			return this.Math.ceil(diff * 100);
		};
		local flagResistanceExists = false;
		modifier["Resistance against ranged weapons"] <- function ( row, description )
		{
			flagResistanceExists = true;
			local damageResistance = getDamageResistance();

			if (damageResistance == null)
			{
				return;
			}

			row.text = description + "\n(" + red("-" + damageResistance + "%") + " Total HP damage using " + thisSkill.getName() + ")";
		};
		modifier["Resistance against piercing attacks"] <- function ( row, description )
		{
			flagResistanceExists = true;
			local damageResistance = getDamageResistance();

			if (damageResistance == null)
			{
				return;
			}

			row.text = description + "\n(" + red("-" + damageResistance + "%") + " Total HP damage using " + thisSkill.getName() + ")";
		};

		for( local i = 0; i < retCount; i++ )
		{
			local row = ret[i];

			if ("text" in row)
			{
				local description = row.text;

				if (description in modifier)
				{
					modifier[description](row, description);
				}
			}
		}

		local getDifferenceInProperty = function ( _property, _targetEntity )
		{
			local props = user.getCurrentProperties();

			if (!(_property in props))
			{
				return null;
			}

			local propsWithSkill = props.getClone();
			thisSkill.onAnySkillUsed(thisSkill, _targetEntity, propsWithSkill);
			return propsWithSkill[_property] - props[_property];
		};

		if (!thisSkill.m.HitChanceBonus && isRangedRelevant())
		{
			local diff = getDifferenceInProperty("RangedSkill", targetEntity);

			if (diff != null)
			{
				if (diff > 0)
				{
					ret.insert(0, {
						icon = "ui/tooltips/positive.png",
						text = green(diff + "%") + " " + thisSkill.getName()
					});
				}
				else if (diff < 0)
				{
					ret.insert(0, {
						icon = "ui/tooltips/negative.png",
						text = red(diff + "%") + " " + thisSkill.getName()
					});
				}
			}
		}

		local addDamageResistanceRow = function ()
		{
			if (!flagResistanceExists && thisSkill.m.IsAttack && _targetTile.IsOccupiedByActor)
			{
				local damageResistance = getDamageResistance();

				if (!damageResistance)
				{
					return;
				}

				local icon = damageResistance > 0 ? "ui/tooltips/negative.png" : "ui/tooltips/positive.png";
				local desc = damageResistance > 0 ? "Resistance against" : "Susceptible to";
				local sign = damageResistance > 0 ? "-" : "+";
				local colorize = damageResistance > 0 ? red : green;

				if (damageResistance < 0)
				{
					damageResistance = damageResistance * -1;
				}

				ret.push({
					icon = icon,
					text = desc + " " + thisSkill.getName() + "\n(" + colorize(sign + damageResistance + "%") + " Total HP damage)"
				});
			}
		};
		local addLungeDamageRow = function ()
		{
			if (!thisSkill.m.IsAttack || thisSkill.m.ID != "actives.lunge" || !_targetTile.IsOccupiedByActor)
			{
				return;
			}

			local diff = getDifferenceInProperty("DamageTotalMult", null);

			if (!diff)
			{
				return;
			}

			local icon = diff > 0 ? "ui/tooltips/positive.png" : "ui/tooltips/negative.png";
			local desc = diff > 0 ? "High initiative" : "Low initiative";
			local sign = diff > 0 ? "+" : "-";
			local colorize = diff > 0 ? green : red;

			if (diff < 0)
			{
				diff = diff * -1;
			}

			diff = this.Math.floor(diff * 100);
			ret.push({
				icon = icon,
				text = desc + " " + "\n(" + colorize(sign + diff + "%") + " Lunge damage)"
			});
		};
		addDamageResistanceRow();
		addLungeDamageRow();
		return ret;
	}

	o.getHitchance = function( _targetEntity )
	{
		if (!_targetEntity.isAttackable() && !_targetEntity.isRock() && !_targetEntity.isTree() && !_targetEntity.isBush() && !_targetEntity.isSupplies())
		{
			return 0;
		}

		local user = this.m.Container.getActor();
		local properties = this.factoringOffhand(this.m.Container.buildPropertiesForUse(this, _targetEntity));

		if (!this.isUsingHitchance())
		{
			return 100;
		}

		local allowDiversion = this.m.IsRanged && this.m.MaxRangeBonus > 1;
		local defenderProperties = _targetEntity.getSkills().buildPropertiesForDefense(user, this);
		local skill = this.m.IsRanged ? properties.RangedSkill * properties.RangedSkillMult : properties.MeleeSkill * properties.MeleeSkillMult;
		local defense = _targetEntity.getDefense(user, this, defenderProperties);
		local levelDifference = _targetEntity.getTile().Level - user.getTile().Level;
		local distanceToTarget = user.getTile().getDistanceTo(_targetEntity.getTile());
		local toHit = skill - defense;

		local minimumHitChance = ::Legends.Mod.ModSettings.getSetting("MinimumChanceToHit").getValue();
		local maximumHitChance = ::Legends.Mod.ModSettings.getSetting("MaximumChanceToHit").getValue();

		if (this.m.IsRanged)
		{
			toHit = toHit + (distanceToTarget - this.m.MinRange) * properties.HitChanceAdditionalWithEachTile * properties.HitChanceWithEachTileMult;
		}

		if (levelDifference < 0)
		{
			toHit = toHit + this.Const.Combat.LevelDifferenceToHitBonus;
		}
		else
		{
			toHit = toHit + this.Const.Combat.LevelDifferenceToHitMalus * levelDifference;
		}

		if (!this.m.IsShieldRelevant)
		{
			local shield = _targetEntity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

			if (shield != null && shield.isItemType(this.Const.Items.ItemType.Shield))
			{
				local shieldBonus = (this.m.IsRanged ? shield.getRangedDefense() : shield.getMeleeDefense()) * (_targetEntity.getCurrentProperties().IsSpecializedInShields ? 1.25 : 1.0);
				toHit = toHit + shieldBonus;

				if (!this.m.IsShieldwallRelevant && _targetEntity.getSkills().hasSkill("effects.shieldwall"))
				{
					toHit = toHit + shieldBonus;
				}
			}
		}

		toHit = toHit * properties.TotalAttackToHitMult;
		toHit = toHit + this.Math.max(0, 100 - toHit) * (1.0 - defenderProperties.TotalDefenseToHitMult);
		local userTile = user.getTile();

		if (allowDiversion && this.m.IsRanged && userTile.getDistanceTo(_targetEntity.getTile()) > 1)
		{
			local blockedTiles = this.Const.Tactical.Common.getBlockedTiles(userTile, _targetEntity.getTile(), user.getFaction(), true);

			if (blockedTiles.len() != 0)
			{
				local blockChance = this.Const.Combat.RangedAttackBlockedChance * properties.RangedAttackBlockedChanceMult;
				toHit = this.Math.floor(toHit * (1.0 - blockChance));
			}
		}

		return this.Math.max(minimumHitChance, this.Math.min(maximumHitChance, toHit));
	}

	o.attackEntity = function( _user, _targetEntity, _allowDiversion = true )
	{
		// if (_targetEntity.isRock())
		// {
		// 	if (_user.getSkills().hasSkill("perk.legend_specialist_pickaxe_damage"))
		// 	{
		// 		local r = this.Math.rand(0, 99);
		// 		if (r == 99)
		// 		{
		// 			local loot = this.new("scripts/items/trade/uncut_gems_item");
		// 			loot.drop(_targetEntity().getTile());
		// 		}

		// 		else if (r <= 5 )
		// 		{
		// 			local loot = this.new("scripts/items/trade/salt_item");
		// 			loot.drop(_targetEntity().getTile());
		// 		}

		// 		else if (r <= 15 && r > 5 )
		// 		{
		// 			local loot = this.new("scripts/items/trade/peat_bricks_item");
		// 			loot.drop(_targetEntity().getTile());
		// 		}

		// 	}
		// 	// _targetEntity.getTile().removeObject()
		// 	if (this.m.SoundOnHit.len() != 0)
		// 	{
		// 		this.Time.scheduleEvent(this.TimeUnit.Virtual, this.m.SoundOnHitDelay, this.onPlayHitSound.bindenv(this), {
		// 			Sound = this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)],
		// 			Pos = _targetEntity.getPos()
		// 		});
		// 	}
		// 	local tile = _targetEntity.getTile();
		// 	local x = tile.X;
		// 	local y = tile.Y;
		// 	this.Tactical.getTile(x,y).removeObject();
		// 	return true;
		// }

		// if (_targetEntity.isSticks())
		// {
		// 	local r = this.Math.rand(0, 4);
		// 	if (r == 1 && _user.getSkills().hasSkill("perk.legend_specialist_woodaxe_damage"))
		// 	{
		// 		local loot = this.new("scripts/items/trade/legend_raw_wood_item");
		// 		loot.drop(_targetEntity.getTile());
		// 	}
		// 	if (this.m.SoundOnHit.len() != 0)
		// 	{
		// 		this.Time.scheduleEvent(this.TimeUnit.Virtual, this.m.SoundOnHitDelay, this.onPlayHitSound.bindenv(this), {
		// 			Sound = this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)],
		// 			Pos = _targetEntity.getPos()
		// 		});
		// 	}
		// 	local tile = _targetEntity.getTile();
		// 	local x = tile.X;
		// 	local y = tile.Y;
		// 	this.Tactical.getTile(x,y).removeObject();
		// 	return true;
		// }

		if (_targetEntity.isSupplies())
		{
			local r = this.Math.rand(1, 100);
			if (r == 1)
			{
				local loot = this.new("scripts/items/supplies/legend_ammo_small_item");
				loot.drop(_targetEntity.getTile());
			}
			if (r == 2)
			{
				local loot = this.new("scripts/items/supplies/legend_armor_parts_small_item");
				loot.drop(_targetEntity.getTile());
			}
			if (r == 3)
			{
				local loot = this.new("scripts/items/supplies/legend_medicine_small_item");
				loot.drop(_targetEntity.getTile());
			}
			if (r >= 4 && r < 6)
			{
				local loot = this.new("scripts/items/supplies/ground_grains_item");
				loot.drop(_targetEntity.getTile());
			}
			if (r >= 7 && r < 9)
			{
				if (this.Math.rand(1, 8) == 8)
				{
					local loot = this.new("scripts/items/trade/legend_cooking_spices_trade_item");
					loot.drop(_targetEntity.getTile());
				}
			}
			if (r == 10)
			{
				local loot = this.new("scripts/items/supplies/legend_fresh_fruit_item");
				loot.drop(_targetEntity.getTile());
			}
			if (r == 11)
			{
				local loot = this.new("scripts/items/supplies/strange_meat_item");
				loot.drop(_targetEntity.getTile());
			}
			if (r == 12)
			{
				local loot = this.new("scripts/items/supplies/legend_human_parts");
				loot.drop(_targetEntity.getTile());
			}
			if (r == 13)
			{
				local loot = this.new("scripts/items/supplies/legend_fresh_meat_item");
				loot.drop(_targetEntity.getTile());
			}
			if (r == 14)
			{
				local loot = this.new("scripts/items/supplies/beer_item");
				loot.drop(_targetEntity.getTile());
			}
			if (r == 15)
			{
				local loot = this.new("scripts/items/supplies/bandage_item");
				loot.drop(_targetEntity.getTile());
			}
			if (this.m.SoundOnHit.len() != 0)
			{
				this.Time.scheduleEvent(this.TimeUnit.Virtual, this.m.SoundOnHitDelay, this.onPlayHitSound.bindenv(this), {
					Sound = this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)],
					Pos = _targetEntity.getPos()
				});
			}
			local tile = _targetEntity.getTile();
			local x = tile.X;
			local y = tile.Y;
			this.Tactical.getTile(x,y).removeObject();
			return false; //if we don't return false it counts as a success for skills like cleave which try to apply bleed etc afterwards ->
		}

		// if (_targetEntity.isTree())
		// {
		// 	if (this.m.SoundOnHit.len() != 0)
		// 	{
		// 		this.Time.scheduleEvent(this.TimeUnit.Virtual, this.m.SoundOnHitDelay, this.onPlayHitSound.bindenv(this), {
		// 			Sound = this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)],
		// 			Pos = _targetEntity.getPos()
		// 		});
		// 	}
		// 	local tile = _targetEntity.getTile();
		// 	local x = tile.X;
		// 	local y = tile.Y;
		// 	this.Tactical.getTile(x,y).removeObject();
		// 	this.Tactical.getTile(x,y).spawnObject("entity/tactical/objects/tree_sticks");
		// 	return true;
		// }

		// if (_targetEntity.isBush() )
		// {
		// 	local r = this.Math.rand(0, 99);
		// 	if (r <= 25 && _user.getSkills().hasSkill("perk.legend_specialist_sickle_damage"))
		// 	{
		// 		local loot = this.new("scripts/items/supplies/roots_and_berries_item");
		// 		loot.drop(_targetEntity.getTile());
		// 	}
		// 	if (r == 99 && _user.getSkills().hasSkill("perk.legend_specialist_sickle_damage"))
		// 	{
		// 		local loot = this.new("scripts/items/misc/mysterious_herbs_item");
		// 		loot.drop(_targetEntity.getTile());
		// 	}
		// 	// _targetEntity.getTile().removeObject()

		// 	if (this.m.SoundOnHit.len() != 0)
		// 	{
		// 		this.Time.scheduleEvent(this.TimeUnit.Virtual, this.m.SoundOnHitDelay, this.onPlayHitSound.bindenv(this), {
		// 			Sound = this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)],
		// 			Pos = _targetEntity.getPos()
		// 		});
		// 	}
		// 	local tile = _targetEntity.getTile();
		// 	local x = tile.X;
		// 	local y = tile.Y;
		// 	this.Tactical.getTile(x,y).removeObject();
		// 	return false;
		// }

		//lets get on with the rest of the attack

		if (_targetEntity != null && !_targetEntity.isAlive())
		{
			return false;
		}

		local properties = this.factoringOffhand(this.m.Container.buildPropertiesForUse(this, _targetEntity));
		local userTile = _user.getTile();
		local astray = false;

		if (_allowDiversion && this.m.IsRanged && userTile.getDistanceTo(_targetEntity.getTile()) > 1)
		{
			local blockedTiles = this.Const.Tactical.Common.getBlockedTiles(userTile, _targetEntity.getTile(), _user.getFaction());

			if (blockedTiles.len() != 0 && this.Math.rand(1, 100) <= this.Math.ceil(this.Const.Combat.RangedAttackBlockedChance * properties.RangedAttackBlockedChanceMult * 100))
			{
				_allowDiversion = false;
				astray = true;
				_targetEntity = blockedTiles[this.Math.rand(0, blockedTiles.len() - 1)].getEntity();
			}
		}

		if (!_targetEntity.isAttackable())
		{
			if (this.m.IsShowingProjectile && this.m.ProjectileType != 0)
			{
				local flip = !this.m.IsProjectileRotated && _targetEntity.getPos().X > _user.getPos().X;

				if (_user.getTile().getDistanceTo(_targetEntity.getTile()) >= this.Const.Combat.SpawnProjectileMinDist)
				{
					this.Tactical.spawnProjectileEffect(this.Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), _targetEntity.getTile(), 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
				}
			}

			return false;
		}

		local defenderProperties = _targetEntity.getSkills().buildPropertiesForDefense(_user, this);
		local defense = _targetEntity.getDefense(_user, this, defenderProperties);
		local levelDifference = _targetEntity.getTile().Level - _user.getTile().Level;
		local distanceToTarget = _user.getTile().getDistanceTo(_targetEntity.getTile());
		local toHit = 0;
		local skill = this.m.IsRanged ? properties.RangedSkill * properties.RangedSkillMult : properties.MeleeSkill * properties.MeleeSkillMult;
		local minimumHitChance = ::Legends.Mod.ModSettings.getSetting("MinimumChanceToHit").getValue();
		local maximumHitChance = ::Legends.Mod.ModSettings.getSetting("MaximumChanceToHit").getValue();

		toHit = toHit + skill;
		toHit = toHit - defense;

		if (this.m.IsRanged)
		{
			toHit = toHit + (distanceToTarget - this.m.MinRange) * properties.HitChanceAdditionalWithEachTile * properties.HitChanceWithEachTileMult;
		}

		if (levelDifference < 0)
		{
			toHit = toHit + this.Const.Combat.LevelDifferenceToHitBonus;
		}
		else
		{
			toHit = toHit + this.Const.Combat.LevelDifferenceToHitMalus * levelDifference;
		}

		local shieldBonus = 0;
		local shield = _targetEntity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (shield != null && shield.isItemType(this.Const.Items.ItemType.Shield))
		{
			shieldBonus = (this.m.IsRanged ? shield.getRangedDefense() : shield.getMeleeDefense()) * (_targetEntity.getCurrentProperties().IsSpecializedInShields ? 1.25 : 1.0);

			if (!this.m.IsShieldRelevant)
			{
				toHit = toHit + shieldBonus;
			}

			if (_targetEntity.getSkills().hasSkill("effects.shieldwall"))
			{
				if (!this.m.IsShieldwallRelevant)
				{
					toHit = toHit + shieldBonus;
				}

				shieldBonus = shieldBonus * 2;
			}
		}

		toHit = toHit * properties.TotalAttackToHitMult;
		toHit = toHit + this.Math.max(0, 100 - toHit) * (1.0 - defenderProperties.TotalDefenseToHitMult);

		if (this.m.IsRanged && !_allowDiversion && this.m.IsShowingProjectile)
		{
			toHit = toHit - 15;
			properties.DamageTotalMult *= 0.75;
		}

		if (defense > -100 && skill > -100)
		{
			toHit = this.Math.max(minimumHitChance, this.Math.min(maximumHitChance, toHit));
		}

		_targetEntity.onAttacked(_user);

		if (this.m.IsDoingAttackMove && !_user.isHiddenToPlayer() && !_targetEntity.isHiddenToPlayer())
		{
			this.Tactical.getShaker().cancel(_user);

			if (this.m.IsDoingForwardMove)
			{
				this.Tactical.getShaker().shake(_user, _targetEntity.getTile(), 5);
			}
			else
			{
				local otherDir = _targetEntity.getTile().getDirectionTo(_user.getTile());

				if (_user.getTile().hasNextTile(otherDir))
				{
					this.Tactical.getShaker().shake(_user, _user.getTile().getNextTile(otherDir), 6);
				}
			}
		}

		if (!_targetEntity.isAbleToDie() && _targetEntity.getHitpoints() == 1)
		{
			toHit = 0;
		}

		if (!this.isUsingHitchance())
		{
			toHit = 100;
		}

		local r = this.Math.rand(1, 100);

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == 0)
		{
			if (_user.isPlayerControlled())
			{
				r = this.Math.max(1, r - 5);
			}
			else if (_targetEntity.isPlayerControlled())
			{
				r = this.Math.min(100, r + 5);
			}
		}

		local isHit = r <= toHit;
		if (defenderProperties.IsEvadingAllAttacks)
		{
			isHit = false;
		}

		if (!_user.isHiddenToPlayer() && !_targetEntity.isHiddenToPlayer())
		{
			if (defenderProperties.IsEvadingAllAttacks)
			{
				::Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " uses " + this.getName() + " and " + this.Const.UI.getColorizedEntityName(_targetEntity) + " evades the attack");
			}
			else
			{
				local rolled = r;
				this.Tactical.EventLog.log_newline();

				if (astray)
				{
					if (this.isUsingHitchance())
					{
						if (isHit)
						{
							this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(_user) + " uses " + this.getName() + " and the shot goes astray and hits " + this.Const.UI.getColorizedEntityName(_targetEntity) + " (Chance: " + this.Math.min(maximumHitChance, this.Math.max(minimumHitChance, toHit)) + ", Rolled: " + rolled + ")");
						}
						else
						{
							this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(_user) + " uses " + this.getName() + " and the shot goes astray and misses " + this.Const.UI.getColorizedEntityName(_targetEntity) + " (Chance: " + this.Math.min(maximumHitChance, this.Math.max(minimumHitChance, toHit)) + ", Rolled: " + rolled + ")");
						}
					}
					else
					{
						this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(_user) + " uses " + this.getName() + " and the shot goes astray and hits " + this.Const.UI.getColorizedEntityName(_targetEntity));
					}
				}
				else if (this.isUsingHitchance())
				{
					if (isHit)
					{
						this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(_user) + " uses " + this.getName() + " and hits " + this.Const.UI.getColorizedEntityName(_targetEntity) + " (Chance: " + this.Math.min(maximumHitChance, this.Math.max(minimumHitChance, toHit)) + ", Rolled: " + rolled + ")");
					}
					else
					{
						this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(_user) + " uses " + this.getName() + " and misses " + this.Const.UI.getColorizedEntityName(_targetEntity) + " (Chance: " + this.Math.min(maximumHitChance, this.Math.max(minimumHitChance, toHit)) + ", Rolled: " + rolled + ")");
					}
				}
				else
				{
					this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(_user) + " uses " + this.getName() + " and hits " + this.Const.UI.getColorizedEntityName(_targetEntity));
				}
			}
		}

		if (isHit && this.Math.rand(1, 100) <= _targetEntity.getCurrentProperties().RerollDefenseChance)
		{
			r = this.Math.rand(1, 100);
			isHit = r <= toHit;
			if(!isHit) {
				this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(_targetEntity) + " got lucky.");
			} else {
				this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(_targetEntity) + " wasn\'t lucky enough.");
			}
		}

		if (isHit)
		{
			this.getContainer().setBusy(true);
			local info = {
				Skill = this,
				Container = this.getContainer(),
				User = _user,
				TargetEntity = _targetEntity,
				Properties = properties,
				DistanceToTarget = distanceToTarget
			};

			if (this.m.IsShowingProjectile && this.m.ProjectileType != 0 && _user.getTile().getDistanceTo(_targetEntity.getTile()) >= this.Const.Combat.SpawnProjectileMinDist && (!_user.isHiddenToPlayer() || !_targetEntity.isHiddenToPlayer()))
			{
				local flip = !this.m.IsProjectileRotated && _targetEntity.getPos().X > _user.getPos().X;
				local time = this.Tactical.spawnProjectileEffect(this.Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), _targetEntity.getTile(), 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
				this.Time.scheduleEvent(this.TimeUnit.Virtual, time, this.onScheduledTargetHit, info);

				if (this.m.SoundOnHit.len() != 0)
				{
					this.Time.scheduleEvent(this.TimeUnit.Virtual, time + this.m.SoundOnHitDelay, this.onPlayHitSound.bindenv(this), {
						Sound = this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)],
						Pos = _targetEntity.getPos()
					});
				}
			}
			else
			{
				if (this.m.SoundOnHit.len() != 0)
				{
					this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill * this.m.SoundVolume, _targetEntity.getPos());
				}

				if (this.Tactical.State.getStrategicProperties() != null && this.Tactical.State.getStrategicProperties().IsArenaMode && toHit <= 15)
				{
					this.Sound.play(this.Const.Sound.ArenaShock[this.Math.rand(0, this.Const.Sound.ArenaShock.len() - 1)], this.Const.Sound.Volume.Tactical * this.Const.Sound.Volume.Arena);
				}

				this.onScheduledTargetHit(info);
			}

			return true;
		}
		else
		{
			local distanceToTarget = _user.getTile().getDistanceTo(_targetEntity.getTile());
			_targetEntity.onMissed(_user, this, this.m.IsShieldRelevant && shield != null && r <= toHit + shieldBonus * 2);
			this.m.Container.onTargetMissed(this, _targetEntity);
			local prohibitDiversion = false;

			if (_allowDiversion && this.m.IsRanged && !_user.isPlayerControlled() && this.Math.rand(1, 100) <= 25 && distanceToTarget > 2)
			{
				local targetTile = _targetEntity.getTile();

				for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
				{
					if (!targetTile.hasNextTile(i))
					{
					}
					else
					{
						local tile = targetTile.getNextTile(i);

						if (tile.IsEmpty)
						{
						}
						else if (tile.IsOccupiedByActor && tile.getEntity().isAlliedWith(_user))
						{
							prohibitDiversion = true;
							break;
						}
					}
				}
			}

			if (_allowDiversion && this.m.IsRanged && !(this.m.IsShieldRelevant && shield != null && r <= toHit + shieldBonus * 2) && !prohibitDiversion && distanceToTarget > 2)
			{
				this.divertAttack(_user, _targetEntity);
			}
			else if (this.m.IsShieldRelevant && shield != null && r <= toHit + shieldBonus * 2)
			{
				local info = {
					Skill = this,
					User = _user,
					TargetEntity = _targetEntity,
					Shield = shield
				};

				if (this.m.IsShowingProjectile && this.m.ProjectileType != 0)
				{
					local divertTile = _targetEntity.getTile();
					local flip = !this.m.IsProjectileRotated && _targetEntity.getPos().X > _user.getPos().X;
					local time = 0;

					if (_user.getTile().getDistanceTo(divertTile) >= this.Const.Combat.SpawnProjectileMinDist)
					{
						time = this.Tactical.spawnProjectileEffect(this.Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), divertTile, 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
					}

					this.Time.scheduleEvent(this.TimeUnit.Virtual, time, this.onShieldHit, info);
				}
				else
				{
					this.onShieldHit(info);
				}
			}
			else
			{
				if (this.m.SoundOnMiss.len() != 0)
				{
					this.Sound.play(this.m.SoundOnMiss[this.Math.rand(0, this.m.SoundOnMiss.len() - 1)], this.Const.Sound.Volume.Skill * this.m.SoundVolume, _targetEntity.getPos());
				}

				if (this.m.IsShowingProjectile && this.m.ProjectileType != 0)
				{
					local divertTile = _targetEntity.getTile();
					local flip = !this.m.IsProjectileRotated && _targetEntity.getPos().X > _user.getPos().X;

					if (_user.getTile().getDistanceTo(divertTile) >= this.Const.Combat.SpawnProjectileMinDist)
					{
						this.Tactical.spawnProjectileEffect(this.Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), divertTile, 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
					}
				}

				if (this.Tactical.State.getStrategicProperties() != null && this.Tactical.State.getStrategicProperties().IsArenaMode)
				{
					if (toHit >= 90 || _targetEntity.getHitpointsPct() <= 0.1)
					{
						this.Sound.play(this.Const.Sound.ArenaMiss[this.Math.rand(0, this.Const.Sound.ArenaBigMiss.len() - 1)], this.Const.Sound.Volume.Tactical * this.Const.Sound.Volume.Arena);
					}
					else if (this.Math.rand(1, 100) <= 20)
					{
						this.Sound.play(this.Const.Sound.ArenaMiss[this.Math.rand(0, this.Const.Sound.ArenaMiss.len() - 1)], this.Const.Sound.Volume.Tactical * this.Const.Sound.Volume.Arena);
					}
				}
			}

			return false;
		}
	}

	o.onScheduledTargetHit = function( _info )
	{
		_info.Container.setBusy(false);

		if (!_info.TargetEntity.isAlive())
		{
			return;
		}

		local partHit = this.Math.rand(1, 100);
		local bodyPart = this.Const.BodyPart.Body;
		local bodyPartDamageMult = 1.0;

		if (partHit <= _info.Properties.getHitchance(this.Const.BodyPart.Head))
		{
			bodyPart = this.Const.BodyPart.Head;
		}
		else
		{
			bodyPart = this.Const.BodyPart.Body;
		}

		bodyPartDamageMult = bodyPartDamageMult * _info.Properties.DamageAgainstMult[bodyPart];
		local damageMult = this.m.IsRanged ? _info.Properties.RangedDamageMult : _info.Properties.MeleeDamageMult;
		damageMult = damageMult * _info.Properties.DamageTotalMult;
		local damageRegular = this.Math.rand(_info.Properties.DamageRegularMin, _info.Properties.DamageRegularMax) * _info.Properties.DamageRegularMult;
		local damageArmor = this.Math.rand(_info.Properties.DamageRegularMin, _info.Properties.DamageRegularMax) * _info.Properties.DamageArmorMult;
		damageRegular = this.Math.max(0, damageRegular + _info.DistanceToTarget * _info.Properties.DamageAdditionalWithEachTile);
		damageArmor = this.Math.max(0, damageArmor + _info.DistanceToTarget * _info.Properties.DamageAdditionalWithEachTile);
		local damageDirect = this.Math.minf(1.0, _info.Properties.DamageDirectMult * (this.m.DirectDamageMult + _info.Properties.DamageDirectAdd + (this.m.IsRanged ? _info.Properties.DamageDirectRangedAdd : _info.Properties.DamageDirectMeleeAdd)));
		local injuries;

		if (this.m.InjuriesOnBody != null && bodyPart == this.Const.BodyPart.Body)
		{
			if (_info.TargetEntity.getFlags().has("skeleton"))
			{
				injuries = this.Const.Injury.SkeletonBody;
			}
			else
			{
				injuries = this.m.InjuriesOnBody;
			}
		}
		else if (this.m.InjuriesOnHead != null && bodyPart == this.Const.BodyPart.Head)
		{
			if (_info.TargetEntity.getFlags().has("skeleton"))
			{
				injuries = this.Const.Injury.SkeletonHead;
			}
			else
			{
				injuries = this.m.InjuriesOnHead;
			}
		}

		local hitInfo = clone this.Const.Tactical.HitInfo;
		hitInfo.DamageRegular = damageRegular * damageMult;
		hitInfo.DamageArmor = damageArmor * damageMult;
		hitInfo.DamageDirect = damageDirect;
		hitInfo.DamageFatigue = this.Const.Combat.FatigueReceivedPerHit * _info.Properties.FatigueDealtPerHitMult;
		hitInfo.DamageMinimum = _info.Properties.DamageMinimum;
		hitInfo.BodyPart = bodyPart;
		hitInfo.BodyDamageMult = bodyPartDamageMult;
		hitInfo.FatalityChanceMult = _info.Properties.FatalityChanceMult;
		hitInfo.Injuries = injuries;
		hitInfo.InjuryThresholdMult = _info.Properties.ThresholdToInflictInjuryMult;
		hitInfo.Tile = _info.TargetEntity.getTile();
		_info.Container.onBeforeTargetHit(_info.Skill, _info.TargetEntity, hitInfo);
		local pos = _info.TargetEntity.getPos();
		local hasArmorHitSound = _info.TargetEntity.getItems().getAppearance().ImpactSound[bodyPart].len() != 0;
		_info.TargetEntity.onDamageReceived(_info.User, _info.Skill, hitInfo);

		if (hitInfo.DamageInflictedHitpoints >= this.Const.Combat.PlayHitSoundMinDamage)
		{
			if (this.m.SoundOnHitHitpoints.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHitHitpoints[this.Math.rand(0, this.m.SoundOnHitHitpoints.len() - 1)], this.Const.Sound.Volume.Skill * this.m.SoundVolume, pos);
			}
		}

		if (hitInfo.DamageInflictedHitpoints == 0 && hitInfo.DamageInflictedArmor >= this.Const.Combat.PlayHitSoundMinDamage)
		{
			if (this.m.SoundOnHitArmor.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHitArmor[this.Math.rand(0, this.m.SoundOnHitArmor.len() - 1)], this.Const.Sound.Volume.Skill * this.m.SoundVolume, pos);
			}
		}

		if (typeof _info.User == "instance" && _info.User.isNull() || !_info.User.isAlive() || _info.User.isDying())
		{
			return;
		}

		_info.Container.onTargetHit(_info.Skill, _info.TargetEntity, hitInfo.BodyPart, hitInfo.DamageInflictedHitpoints, hitInfo.DamageInflictedArmor);
		_info.User.getItems().onDamageDealt(_info.TargetEntity, this, hitInfo);

		if (hitInfo.DamageInflictedHitpoints >= this.Const.Combat.SpawnBloodMinDamage && !_info.Skill.isRanged() && (_info.TargetEntity.getBloodType() == this.Const.BloodType.Red || _info.TargetEntity.getBloodType() == this.Const.BloodType.Dark))
		{
			_info.User.addBloodied();
			local item = _info.User.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

			if (item != null && item.isItemType(this.Const.Items.ItemType.MeleeWeapon))
			{
				item.setBloodied(true);
			}
		}
	}

	o.playSound <- function()
	{
		local sound = this.m.Sound[this.Math.rand(0, this.m.Sound.len() - 1)];
		this.Sound.play(sound, this.Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
	}

	local setItem = o.setItem;
	o.setItem = function (_i) {
		setItem(_i);

		if (this.m.Item != null)
			this.m.IsSerialized = false;
	}

	o.onDeserialize = function( _in )
	{
		this.m.IsNew = _in.readBool();
	}
});
