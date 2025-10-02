this.legend_mounted_status <- this.inherit("scripts/skills/skill", {
    m = {
        Horse = null,          // horse actor ref
        Rider = null,          // rider actor ref (owner)
        RiderBodyArmor = null, // stored to restore on dismount
        HorseBodyArmor = null, // stored to restore
        RiderXPOnStart = null, // track XP gain while mounted for sharing
        CopiedSkillIDs = [],   // track which skills were copied from horse to rider
        RiderActionPointCosts = null,  // store rider's original movement costs
        RiderFatigueCosts = null       // store rider's original fatigue costs
    },

    function create()
    {
        this.m.ID = "status.legend_mounted";
        this.m.Name = "Mounted";
        this.m.Icon = "ui/perks/perk_23.png";
        this.m.Type = this.Const.SkillType.StatusEffect;
        this.m.Order = this.Const.SkillOrder.Last;
        this.m.IsActive = false;
        this.m.IsStacking = false;
        this.m.IsHidden = false;
        this.m.IsSerialized = true;
    }

    function setMountPair( _rider, _horse )
    {
        this.m.Rider = this.WeakTableRef(_rider);
        this.m.Horse = this.WeakTableRef(_horse);
    }

    function onAdded()
    {
        local actor = this.getContainer().getActor();
        this.m.Rider = this.WeakTableRef(actor);

        if (this.m.Horse == null || this.m.Horse.isNull()) return;

        // Snapshot rider XP at mount time for XP sharing
        this.m.RiderXPOnStart = actor.getXPValue();

        // Movement uses horse movement arrays
        actor.m.ActionPointCosts = this.Const.HorseMovementAPCost;
        actor.m.FatigueCosts = clone this.Const.HorseMovementFatigueCost;

        // Do not change equipment; visuals will overlay horse armor while rider armor remains visible behind

        // Copy ALL horse skills to rider (perks, traits, effects, injuries, etc)
        // This ensures everything transfers: perks, injuries, status effects, etc.
        local allHorseSkills = [];

        // Gather all skill types
        allHorseSkills.extend(this.m.Horse.getSkills().getAllSkillsOfType(this.Const.SkillType.Perk));
        allHorseSkills.extend(this.m.Horse.getSkills().getAllSkillsOfType(this.Const.SkillType.Trait));
        allHorseSkills.extend(this.m.Horse.getSkills().getAllSkillsOfType(this.Const.SkillType.StatusEffect));
        allHorseSkills.extend(this.m.Horse.getSkills().getAllSkillsOfType(this.Const.SkillType.TemporaryInjury));
        allHorseSkills.extend(this.m.Horse.getSkills().getAllSkillsOfType(this.Const.SkillType.PermanentInjury));

        foreach (skill in allHorseSkills)
        {
            local skillID = skill.getID();

            // Skip if rider already has this skill (avoid conflicts)
            if (actor.getSkills().hasSkill(skillID))
                continue;

            // Skip background skills (those are rider-specific)
            if (skillID.find("background.") == 0)
                continue;

            // Skip racial skills (horse racial traits shouldn't transfer)
            if (skillID.find("racial.") == 0)
                continue;

            // Skip the horse trait itself (it's the horse's identity, not a transferable trait)
            if (skillID == "trait.legend_horse")
                continue;

            // Skip skills that horses can't logically have while mounted
            // (injuries to body parts horses don't have)
            local excludedSkills = [
                "injury.broken_nose",
                "injury.crushed_windpipe",
                "injury.broken_ribs",
                "injury.missing_finger",
                "injury.missing_hand",
                "injury.broken_elbow_joint",
                "injury.broken_arm",
                "injury.missing_ear"
            ];

            local shouldExclude = false;
            foreach (excluded in excludedSkills)
            {
                if (skillID == excluded)
                {
                    shouldExclude = true;
                    break;
                }
            }

            if (shouldExclude)
                continue;

            // Get the skill's script path by converting ID to script path
            // IDs are like "perk.legend_horse_bitting" -> "scripts/skills/perks/perk_legend_horse_bitting"
            local scriptPath = null;

            if (skillID.find("perk.") == 0)
            {
                // Replace dot with underscore: "perk.legend_horse_bitting" -> "perk_legend_horse_bitting"
                local fileName = "perk_" + skillID.slice(5);
                scriptPath = "scripts/skills/perks/" + fileName;
            }
            else if (skillID.find("trait.") == 0)
            {
                local traitName = skillID.slice(6);  // Remove "trait." prefix
                // Legends traits use _trait suffix: "trait.legend_fear_dark" -> "legend_fear_dark_trait"
                if (traitName.find("legend_") == 0)
                {
                    scriptPath = "scripts/skills/traits/" + traitName + "_trait";
                }
                else
                {
                    // Vanilla traits - these don't exist in Legends, skip them
                    continue;
                }
            }
            else if (skillID.find("effects.") == 0)
            {
                local fileName = skillID.slice(8);
                scriptPath = "scripts/skills/effects/" + fileName;
            }
            else if (skillID.find("effect.") == 0)
            {
                local fileName = skillID.slice(7);
                scriptPath = "scripts/skills/effects/" + fileName;
            }
            else if (skillID.find("injury.") == 0)
            {
                local fileName = skillID.slice(7);
                scriptPath = "scripts/skills/injury/" + fileName;
            }
            else if (skillID.find("special.") == 0)
            {
                local fileName = skillID.slice(8);
                scriptPath = "scripts/skills/special/" + fileName;
            }

            if (scriptPath != null)
            {
                try
                {
                    local newSkill = this.new(scriptPath);
                    actor.getSkills().add(newSkill);
                    this.m.CopiedSkillIDs.push(skillID);  // Track it
                }
                catch (e)
                {
                    // Skill script doesn't exist or can't be created, skip it
                    this.logWarning("Could not copy horse skill: " + skillID);
                }
            }
        }

        // Update movement costs based on perks now that they're applied
        if (actor.getSkills().hasPerk(::Legends.Perk.LegendHorsePassage))
        {
            // Use lighter movement arrays if passage present
            actor.m.ActionPointCosts = this.Const.HorsePassageMovementAPCost;
            actor.m.FatigueCosts = clone this.Const.HorsePassageMovementFatigueCost;
        }

        // Add dismount skill to rider
        local dismount = this.new("scripts/skills/actives/legend_dismount_horse_skill");
        dismount.setMountedStatus(this);
        actor.getSkills().add(dismount);

        // Force properties update so HP and stats are recalculated
        actor.getSkills().update();

        // If horse is on the tactical map, make it retreat to hide it
        if (this.m.Horse.getTile() != null)
        {
            this.m.Horse.retreat();
        }

        // Visual overlay: horse sprites positioned down and right to show rider's face
        local horseOffset = this.createVec(18, -10);  // Right and down (negative Y moves down in BB)
        if (!actor.hasSprite("horse_body")) actor.addSprite("horse_body");
        if (!actor.hasSprite("horse_head")) actor.addSprite("horse_head");
        if (!actor.hasSprite("injury_horse_body")) actor.addSprite("injury_horse_body");
        actor.getSprite("horse_body").setBrush(this.m.Horse.getSprite("body").getBrush().Name);
        actor.getSprite("horse_head").setBrush(this.m.Horse.getSprite("head").getBrush().Name);
        actor.getSprite("injury_horse_body").setBrush(this.m.Horse.getSprite("head").getBrush().Name);
        actor.setSpriteOffset("horse_body", horseOffset);
        actor.setSpriteOffset("horse_head", horseOffset);
        actor.setSpriteOffset("injury_horse_body", horseOffset);
        actor.getFlags().add("IsHorseRider");

        // Nudge rider base layers left so horse sits more to the right, revealing rider's face
        local riderOffset = this.createVec(-8, 0);
        local riderLayers = [
            "body","armor","head","hair","beard","helmet","helmet_damage","quiver","armor_upgrade_front","armor_upgrade_back","body_blood"
        ];
        foreach(n in riderLayers)
        {
            if (actor.hasSprite(n)) actor.setSpriteOffset(n, riderOffset);
        }

        // Move weapon to front so it's visible above horse
        // In Battle Brothers, sprites render bottom-to-top, so we need to reorder
        local weaponLayers = ["body_forearm", "wielded"];
        foreach(layer in weaponLayers)
        {
            if (actor.hasSprite(layer))
            {
                // Move weapon sprites after horse in render order by removing and re-adding
                local sprite = actor.getSprite(layer);
                actor.removeSprite(layer);
                actor.addSprite(layer);
                actor.setSprite(layer, sprite);
            }
        }
    }

    function onRemoved()
    {
        local actor = this.getContainer().getActor();
        // No equipment changes to revert
        this.m.RiderBodyArmor = null;
        this.m.HorseBodyArmor = null;

        // Restore dismounted movement costs
        actor.m.ActionPointCosts = this.Const.DismountedMovementAPCost;
        actor.m.FatigueCosts = clone this.Const.DismountedMovementFatigueCost;

        // Remove dismount skill first (before we remove copied skills)
        if (actor.getSkills().hasSkill("actives.legend_dismount_horse"))
        {
            actor.getSkills().removeByID("actives.legend_dismount_horse");
        }

        // Remove skills that were copied from horse
        // IMPORTANT: Only remove if the rider still has this exact skill
        // and it's in our copied list (meaning we added it, not the rider)
        foreach (skillID in this.m.CopiedSkillIDs)
        {
            // Verify this is actually a copied skill and not a rider's original skill
            if (actor.getSkills().hasSkill(skillID))
            {
                local skill = actor.getSkills().getSkillByID(skillID);
                // Only remove if it exists - the getSkillByID might return null in some edge cases
                if (skill != null)
                {
                    actor.getSkills().remove(skill);
                }
            }
        }

        // Copy any new effects from rider back to horse (effects gained while mounted)
        if (this.m.Horse != null && !this.m.Horse.isNull())
        {
            local riderSkills = [];
            riderSkills.extend(actor.getSkills().getAllSkillsOfType(this.Const.SkillType.StatusEffect));
            riderSkills.extend(actor.getSkills().getAllSkillsOfType(this.Const.SkillType.TemporaryInjury));
            riderSkills.extend(actor.getSkills().getAllSkillsOfType(this.Const.SkillType.PermanentInjury));

            foreach (skill in riderSkills)
            {
                local skillID = skill.getID();
                local skillType = skill.getType();

                // Only copy status effects and injuries gained during combat
                if (skillType == this.Const.SkillType.StatusEffect ||
                    skillType == this.Const.SkillType.TemporaryInjury ||
                    skillType == this.Const.SkillType.PermanentInjury)
                {
                    // If horse doesn't have it and it wasn't copied from horse originally
                    if (!this.m.Horse.getSkills().hasSkill(skillID) &&
                        this.m.CopiedSkillIDs.find(skillID) == null)
                    {
                        // Try to copy it back to horse by reconstructing script path from ID
                        local scriptPath = null;

                        if (skillID.find("effects.") == 0)
                        {
                            scriptPath = "scripts/skills/effects/" + skillID.slice(8);
                        }
                        else if (skillID.find("injury.") == 0)
                        {
                            scriptPath = "scripts/skills/injury/" + skillID.slice(7);
                        }

                        if (scriptPath != null)
                        {
                            try
                            {
                                local newSkill = this.new(scriptPath);
                                this.m.Horse.getSkills().add(newSkill);
                            }
                            catch (e)
                            {
                                // Can't copy this skill back, skip it
                            }
                        }
                    }
                }
            }
        }

        this.m.CopiedSkillIDs.clear();

        // Remove visuals
        if (actor.hasSprite("horse_body")) actor.removeSprite("horse_body");
        if (actor.hasSprite("horse_head")) actor.removeSprite("horse_head");
        if (actor.hasSprite("injury_horse_body")) actor.removeSprite("injury_horse_body");
        actor.getFlags().remove("IsHorseRider");

        // Reset rider sprite offsets
        local zero = this.createVec(0, 0);
        local allLayers = [
            "body","armor","head","hair","beard","helmet","helmet_damage","quiver","armor_upgrade_front","armor_upgrade_back","body_blood"
        ];
        foreach(n in allLayers)
        {
            if (actor.hasSprite(n)) actor.setSpriteOffset(n, zero);
        }
    }

    // Redirect body-part damage to the horse: head stays on rider
    function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
    {
        if (this.m.Horse == null || this.m.Horse.isNull()) return;
        if (_hitInfo.BodyPart != this.Const.BodyPart.Body) return;

        // Clone hit info for the horse
        local h = clone _hitInfo;
        h.BodyPart = this.Const.BodyPart.Body;

        // Prevent rider from taking this body damage
        _hitInfo.DamageRegular = 0;
        _hitInfo.DamageArmor = 0;
        // Fatigue as well is applied to horse instead
        local fatigue = h.DamageFatigue;
        _hitInfo.DamageFatigue = 0;

        // Apply to horse now using engine damage pipeline
        // Ensure horse is discovered so logs/visibility make sense
        this.m.Horse.onDamageReceived(_attacker, _skill, h);
        if (fatigue > 0)
        {
            // Minor safety: horse fatigue is applied inside onDamageReceived already via hit info
        }
    }

    function onUpdate( _properties )
    {
        if (this.m.Horse == null || this.m.Horse.isNull()) return;
        if (this.m.Rider == null || this.m.Rider.isNull()) return;
        local h = this.m.Horse;

        // Get horse's base properties to avoid infinite recursion with getCurrentProperties
        local horseProps = h.getBaseProperties();

        // Movement/AP - use horse movement
        _properties.ActionPoints = 9;

        // Merge current HP to reflect damage taken
        _properties.Hitpoints = this.Math.floor((h.getHitpoints() + _properties.Hitpoints) / 2.0);

        // Merge all combat stats - average rider's incoming properties with horse's base properties
        local bravery = (_properties.Bravery + horseProps.Bravery) / 2.0;
        if (h.getSkills().hasPerk(::Legends.Perk.LegendHorseLiberty)) bravery += _properties.Bravery * 0.25;
        _properties.Bravery = bravery;

        _properties.Stamina = (_properties.Stamina + horseProps.Stamina) / 2.0;

        local ms = (_properties.MeleeSkill + horseProps.MeleeSkill) / 2.0;
        if (h.getSkills().hasPerk(::Legends.Perk.LegendHorseDesensitization)) ms += _properties.MeleeSkill * 0.25;
        _properties.MeleeSkill = ms;

        local rs = (_properties.RangedSkill + horseProps.RangedSkill) / 2.0;
        if (h.getSkills().hasPerk(::Legends.Perk.LegendHorseParthianShot)) rs += _properties.RangedSkill * 0.25;
        _properties.RangedSkill = rs;

        local md = (_properties.MeleeDefense + horseProps.MeleeDefense) / 2.0;
        if (h.getSkills().hasPerk(::Legends.Perk.LegendHorseBitting)) md += _properties.MeleeDefense * 0.25;
        _properties.MeleeDefense = md;

        _properties.RangedDefense = (_properties.RangedDefense + horseProps.RangedDefense) / 2.0;
        _properties.Initiative = (_properties.Initiative + horseProps.Initiative) / 2.0;
    }

    function onCombatFinished()
    {
        if (this.m.Horse == null || this.m.Horse.isNull()) return;
        if (this.m.Rider == null || this.m.Rider.isNull()) return;

        local rider = this.m.Rider;
        local horse = this.m.Horse;

        // Share XP with horse
        if (this.m.RiderXPOnStart != null)
        {
            local gained = rider.getXPValue() - this.m.RiderXPOnStart;
            if (gained > 0)
            {
                // Share some XP with horse
                local share = this.Math.floor(gained * 0.5);
                horse.addXP(share);
            }
            this.m.RiderXPOnStart = null;
        }

        // Automatically dismount at end of combat - call removeSelf which properly cleans up
        this.removeSelf();
    }

    function onDeath( _fatalityType )
    {
        // If rider dies while mounted, spawn horse onto this tile
        if (this.m.Horse != null && !this.m.Horse.isNull())
        {
            local cur = this.getContainer().getActor().getTile();
            this.Tactical.addEntityToMap(this.m.Horse, cur.Coords.X, cur.Coords.Y);
        }
    }

    function getTooltip()
    {
        local ret = [
            { id = 1, type = "title", text = this.getName() },
            { id = 2, type = "description", text = "Riding a horse. Head hits affect rider, body hits affect horse."}
        ];
        if (this.m.Horse != null && !this.m.Horse.isNull())
        {
            ret.push({ id = 3, type = "text", icon = "ui/icons/armor.png", text = format("Horse Armor: %d/%d", this.m.Horse.getArmor(this.Const.BodyPart.Body), this.m.Horse.getArmorMax(this.Const.BodyPart.Body)) });
            ret.push({ id = 4, type = "text", icon = "ui/icons/health.png", text = format("Horse HP: %d/%d", this.m.Horse.getHitpoints(), this.m.Horse.getHitpointsMax()) });
        }
        return ret;
    }

    function onSerialize( _out )
    {
        this.skill.onSerialize(_out);
        _out.writeI32(this.m.Horse != null && !this.m.Horse.isNull() ? this.m.Horse.getID() : -1);
    }

    function onDeserialize( _in )
    {
        this.skill.onDeserialize(_in);
        // Horse ref will be re-bound by the mounting flow after load if needed
    }
});
