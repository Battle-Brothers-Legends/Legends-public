# 19.3.0 - Left & Right

## Dual Wielding

Any one-handed weapon can be equipped in the offhand slot when the mainhand already holds a one-handed weapon.

This activates Dual Wield:

- Automatically triggers a free **follow-up offhand attack** after every mainhand attack
- Applies a **fatigue and hit chance penalty** based on the offhand weapon's weight
- Grants the **Double Swing** active skill (an AoE attack hitting up to 3 adjacent tiles, using both weapons)

## Traits
- `Hesitant` now acts last in turn order
- `Impatient` acts first in turn order but cannot wait and loses 10% of melee defense
> Both of the above can still be manipulated by effects like adrenaline, the exact math is that Adrenaline increases turn order number by 2000, Hesitant and Impatient subtract/add 1000 respectively
> A character with Adrenaline and Hesitant will act before every other character but will act after a character with Adrenaline who does not have Hesitant
> A character with Impatient will act before everyone else but will act after a character with Adrenaline unless they also have Adrenaline, in which case they will always be first
- `Greedy` will now increase wage by 25% but also gain 1 to every attribute for every 10 gold paid in wages
- `Eagle Eyes` now increases vision by 2
- `Team Player` now gets 5% melee skill and ranged skill when adjacent to an ally

## Perks

- `Sword Mastery` -  Riposte can trigger from both weapons when dual wielding swords
- `Axe Mastery` - Split Shield uses combined shield damage from both weapons when dual wielding axes
- `Flail Mastery` - Both attacks apply Bleed when dual wielding flails
- `Double Strike` - Offhand successful hits grant -1 AP and +10% damage on next mainhand attack when dual wielding daggers
- `Ambidextrous` - Now also reduces weight penalty by 33% when dual wielding other weapons
- `Onslaught` - now increases melee damage by your 2% for every 100 armor you have
- `Immovable Object` now also counts accessory slot
- `Battlefield Control` now additionally `Knock Back`, `Repel` and `Hook` skills have 100% chance to hit when targeting an allied character and will not apply negative effects or damage when used on an ally
- `Ballistics` now also increases range of handgonne
- `Stick Fighting` now gives 16 matk, mdef and rdef when wielding a staff or a magic staff and 8 when wielding a hybrid staff or musical instrument
- `Muscularity` now has no lower bound.
- `Thrust Master` tooltip fixes
- `Barrage` tooltip fixes
- `Battle Forged` maximum reduction capped at 80%

### One Handed Tree
- no longer exists in short
- `Duelist` is in the Sword Tree
- `Push The Advantage` is in the Polearm Tree
- `Versatile` is in the Throwing Tree

### Two Handed Tree
- no longer exists as well
- `Push The Advantage` is in the Mace Tree
- `Slaughterer` and `Bloody Harvest` are in the Axe Tree 

### Specialist Perks
- spec perks are now disabled from this version onwards
- because recent legends perk work focused on making a lot more recruits viable and interesting to play we decided that spec perks aren't as worthwhile anymore
- they also pigeonhole players into certain builds and make lowborn backgrounds disproportionately better than expensive recruits
- they're still in legends so we don't break compatibility and some of their effects will make their way on other perks
- you also might see it in a submod ;)

### Favoured enemy rework

Perks were condensed into a few:
Favoured Enemy - Beasts
Favoured Enemy - Occult
Favoured Enemy - Greenskin
Favoured Enemy - Undead
Favoured Enemy - Civilization
Favoured Enemy - Outlaw
Favoured Enemy - Sword Master

## Backgrounds
- `Belly Dancer` receives 20% scouting modifier for camping purposes
- `Berserker` can no longer roll `Sureshot` and `Steady Hands` traits
- `Gladiator Prizefighter` added new icon
- `Pilgrim` added new icon

## Origins
- ranger origin's druid rebalanced to use the regular druid background with extra talents and melee skill

## New enemies

- Orc Tyrant - elite orc warlord, his warcry can cascade on other warlords
- Orc Mad Berserker - elite version of the orc berserker, has nimble and nudist
- Wicht - armored ghost enemies who cannot be killed until you destroy their armor
> very resistant to status effects

## Enemy Changes

- Bandit Warlord is renamed to Robber Baron
- Webknechts lose 10 rdef and 10 mdef on Legendary, but retain Dodge
- Bandit Rabble should start being phased out by Bandit Thugs much quicker
- Normalized Bandit Thug outfits by removing the highest one
- Zombies will now have increased action points but will move slower on all terrains (like a reverse pathfinder)
> Wiederganger 6 to 8;
> Armored Wiederganger 6 to 8;
> Fallen Hero 7 to 9;
> players turned Wiederganger 6 to 8;
- Nomad Slingers will now more likely to spawn with a Sturdy Sling before day 30 and gain a chance for more armor after day 40
- Lindwurm and Stollwurms
> health decreased to 950 and 1500 respectively
> lose resilient so they are more succeptable to bleeding
> gain 25% damage reduction from cutting and blunt attacks but damage is increased by 30% from piercing
> Stollwurm tail now spends AP on head's long moves
> fixed stagger effect desynchronizing head and tail turn order
> wurms no longer get Baffled, Dazed, Withered, Stupefied, Swarm of Insects and Staggered when an appropriate attack hits the tail
> both parts of the wurm now get Baffled, Dazed, Withered, Stupefied, Swarm of Insects and Staggered when an appropriate attack hits the head
> tails cannot be Choked anymore

## New Runes

- Weapon Fire rune - sets tile on fire on hit
- Helmet Patience rune - initiative bonus, hit chance on wait
- Shield Durability rune - additional durability to shields, a chance to ignore shield damage

## Integrated mods

- Integrated Better Obituary v3, thanks to Allania
- layer logger from Merc - check mod options under misc

## Item Changes

### Helmets
- merged the two fencer hats
- removed duplicate aventail (chain scarf)
- added named Rotten Great Helm, Facemask, Horsetail, Norman Helm, Aventail, Full Chain Hoods
- added a number of recolors and new variants to a number of helmets
- differentiated sounds for upgrades and composites
- description fixes and changes
- named items naming fixes and changes
- fixed beard/hair hiding while covering items are set to invisible
- modified layering so some L2's go under L1
- all tail items moved to lower vanity
- allowed layering and unlayering on combat result and town shop screens
- added sound effect while removing layers

### Shields
- added a few missing shield paints
- fixed towershield paint to only the wooden part
	
### Armors
- added Studded Aketon
- differentiated sounds for upgrades, composites and attachments
- description fixes and changes
- named items naming fixes and changes
- hyena fur, white wolf pelt, direwolf pelt upgrades reformed into cloaks
- regular cloaks now displayed over upgrades
- allowed layering and unlayering on combat result and town shop screens
- added sound effect while removing layers

### Weapons

#### New Weapons
- `Rusty Warcleaver` - named cleaver with very high shield damage, will appear on Runechosen
- `Horn Decorated Mace` - named mace, will appear on Runechosen
- `Named Longsword` - named version of the longsword
- `Blooddrinker` - Legendary Cleaver which will drop from the Mastaba
- `Golden Cestus` - named version of the cestus

#### New Weapon Abilities

* Named Cleaver and sword riposte effects will no longer roll on named items

**Infantry Axes**
- `Chop` is replaced with `Hack`
> 40% armor penetration and 25% better chance to hit the head

**Throwing**
- `Throw Backup Spear` - each one handed spear has 1 stack of a throwable ability
- `Throw Backup Axe` - each one handed axe has 1 stack of a throwable ability
- `Throw Backup Daggers` - each puncture dagger (daggers that don't have deathblow innately) has 8 stacks of a throwable ability
> attacks twice if you have a free offhand, 4 ap cost, 12 fatigue, 3 maximum range
> headshots will apply Distracted

**Warbrand and Rhompaias**
- `Breach` - `Slash`
> will deal an additional 15% damage vs enemies armed with polearms and melee weapons with range
- `Swing` - unchanged
- `Split` - unchanged
- `Into The Fray` - 2 tile charge and attack with `Breach`

**One Handed Straight Swords**
* Ancient sword, Arming Sword, Gladius, Short Sword, Named Sword, Noble Sword
* `Slash` - unchanged
* `Riposte` - unchanged
* `Halfsword` - puncture
> 5 ap cost and requires double grip to be usable
* `Mordhau` - batter (hammer)
> 5 ap cost, more armor piercing damage, 50% more armor damage with this skill and always deals at least 10 hp, hits to the head will daze

**Longsword**
- `Slash` - unchanged
- `Riposte` - unchanged
- `Halfsword`
- `Mordhau`

**Greatsword**
- `Overhead Strike` - unchanged
- `Swing` - unchanged
- `Halfsword` - 7 ap cost, -80% hitchance instead of -65%
- `Mordhau` - 7 ap cost, hits to the head will stagger

**Falchions**
- `Breach` - `Slash`
> will deal an additional 15% damage vs enemies armed with polearms and melee weapons with range
- `Gash` - unchanged
- `Riposte` - unchanged

**2h Axes**
* `Split Man` - unchanged
* `Round Swing` - unchanged
* `Split Shield` - unchanged
* `Haftstrike` - a weak but quick attack with the haft 
> costs 4 ap, 12 fatigue and does 30% damage, the ap cost reduces by 1 with each successful attack this turn by **other** skills 

**2h Hammers**
* `Smite` - unchanged
* `Shatter` - unchanged
* `Split Shield` - unchanged
* `Obliterate` - exceptionally strong slow hammer attack - added to 2h hammer
> 6 ap, 30 fatigue, 150% damage and 33% lower threshold to inflict injury
> -75% chance to hit increased, +25% from mastery and +50% against targets being rooted
> staggers on hit and hitting already staggered enemies will stun them

**Handgonnes**
* `Fire Handgonne` - unchanged
* `Reload`
* `Line Them Up`
> 3 (4 with mastery) tile shot in a straight line, does 25% more damage

**Sword Cleavers**
* Two Handed Saif, Scimitars and Khopesh are now all purely cleaver weapons
* `Hew` - split attack which does 50% of it's damage to both the body and the head, regardless of chance to hit head
> 35% base penetration, 6 ap, 20 fatigue
* `Harvest` - two tile swing which applies 5-10 bleeding damage, deals an additional 20% damage when the target is bleeding
> 25% penetration, 6 ap, 30 fatigue cost
* `Decapitate`
> 6 ap, 30% armor penetration, 30 fatigue cost
* all of these weapons have had their durability, price and damage bumped (damage by ~20 points)

**Crossbows**
* gain `Piercing Shot` by default
* `Strafing Shot` gains a new icon

**Shortbows**
* gain `Cascade`
> the Initiative difference between you and the target will be added as additional damage

**Bolas**
* `Throw Bola` can now `Constrain` your target
> `Constrained` - additional 2 ap and 5 fatigue per tile traveled (we know you think goblins are easy)

**Firelance**
* `Thrust`
* `Heartseeker`
* `Ignite Firelance`
* `Spearwall`

**Goblin Pike**
* `Rupture`
* `Repel`
* `Skewer`

**Goblin Spear**
* `Breach`
* `Rupture`
> 1 tile range, 5 ap - can be reduced to 4 ap with mastery, 13 fatigue cost, 25% armor penetration
* `Skewer`

**Glaives (not militia)**
* `Great Slash`
* `Rupture`
> 1 tile range, 5 ap - can be reduced to 4 ap with mastery, 13 fatigue cost, 25% armor penetration
* `Skewer`

### New recipes

- new silk blueprint
- 3 new gold ingot blueprints
- 3 new silver ingot blueprints

## Various

- additional info is now provided on support skill including if the skill is considered an attack, it's range and the maximum level difference
- african male heads have been updated and adjusted to start showing up on brothers
- bros in training hall with no training options are now hidden from the list
- training hall now shows the current veteran trait while Merciless Regimen trait reroll option is on the list

## Bug Fixes

- possible fix for ai rotation crashes
- fixed an error giving higher scaling to starts that have less than 3 characters
- fixed an error with gear scaling using sell price instead of value
- fixed incorrect time and item count tooltips on the camp screen
- fixed rerolling trait into the same trait during merciless regimen
- fixed crafting window not updating components properly
- fixed white wolf scaling
- fixed white wolf pet spawning as hostile
- fixed bandit army contract incorrectly assuming raiding party on load
- fixed bandit army contract reveal on killing instead of sparing
- fixed vala fury incorrectly affecting brothers at distance of over 3 with full effect of fury chant
- fixed shop named item sell warning dialog (icon layering, runed items)
- fixed female bodies generating with non-matching combinations of body and head colors

### For modders:

> deleted `legend_haunted_01_trait`, `legend_haunted_02_trait`, `legend_haunted_03_trait`, `legend_haunted_04_trait`, `legend_haunted_05_trait`, `legend_haunted_06_trait`

- you can assign scaling on the origin itself with the `BrotherScaling` property
> look at `militia_scenario` and `lone_wolf_scenario`

- `LegendKnifeplay`, `perk_legend_knifeplay` perk has been deleted
- `LegendCascade`, `perk_legend_cascade` perk has been deleted
- `LegendPiercingShot`, `perk_legend_piercing_shot` perk has been deleted
- Bandit Warlord renamed to Robber Baron
> `LegendBanditWarlord` -> `LegendRobberBaron`
> `legend_bandit_warlord` -> `legend_robber_baron`

- `longsword` now refers to longsword instead of greatsword
- `greatsword` and `named_greatsword` now refers to greatsword instead of zweihander
- `legend_zweihander` and `legend_named_zweihander` are now the zweihander
- `legend_named_longsword` is the newly added named longsword
- hopefully this clears up the confusions about 2h swords with minimal confusion to the player

```
legend_bandit_warlord.nut -> legend_robber_baron.nut
this.Const.EntityType.LegendBanditWarlord -> this.Const.EntityType.LegendRobberBaron

```

Item refactors:

```

Added a new way of defining outfit variants: for example [1, "vanity/legend_helmet_southern_noble_crown", [1,2,3]], where variants can be now defined as an array.

A number of armor name refactors and normalization to use the same value in the name field and the .pngs, removing the brush field and separating
items that used the same brush name into standalone definitions. Note that items marked as 'separated' have their variant numbering restarted from 1.
The .pngs have also gone necessary changes, see the link below for more details (includes removal of bust_ prefix).
For clarity, legend_armor is prefixed at make_legends_armor level and should be referenced as such while building outfits.
Description changes for both armors and helmets.
Added named helmet bases support.
Refactored vanity_lower -> vanity in outfits and lowervanity defs field to lower, IsLower to Lower, created IsLower() helper function.
Lower layers are now available for helms and masks.
The display ordering is as follows:
VanityLower -> VanityLower2 -> Head -> Helmet -> HelmLower -> TopLower -> Helm -> Top -> Vanity -> Vanity2
Chain, Plate, Tabard and Cloak layers are now displayed on bodies.
Base, Chain, Helm, Vanity layers are now displayed on bodies.
Added template definition for armor's brush_only_layers to define armors with custom size via front/back sprites.
Changed named helmet and armor fields to an object for better readability (for armor min and max CON have been reversed, so both helmets and armor work the same way).

Armor refactors in legend_armor defs.py: 
https://github.com/Battle-Brothers-Legends/Legends-public/commit/7e2a567abdfc71395283994a488e3150d47b53a0

legend_ancient_cloth -> ancient_cloth
legend_ancient_cloth_restored -> ancient_cloth_restored
legend_apron_butcher -> apron_butcher / separated from legend_apron
legend_gladiator_harness -> southern_gladiator_harness / moved over from vanilla
legend_gambeson -> gambeson / normalized the numbering to 1-40 from 0-39
legend_gambeson_plain -> removed / defined in the new way in outfits as [weight, gambeson, [1,2,3]]
legend_gambeson_named -> gambeson_named
legend_padded_surcoat -> quilted_aketon / separated from legend_gambeson, renamed to better fit it's role as L0
legend_padded_surcoat_plain -> removed, see legend_gambeson_plain
legend_peasant_dress -> peasant_dress
legend_robes -> robes / separated from legend_robes
legend_vala_dress -> vala_dress
legend_vala_robe -> vala_robe
legend_armor_rabble_fur -> fur_rabble
legend_robe_magic -> robes_magic
legend_robes_wizard -> robes_wizard
anatomist_robe -> robe_anatomist
legend_robes_nun -> robes_nun / separated from legend_robes
legend_sackcloth_tattered -> sackcloth_tattered / separated from legend_sackcloth
legend_sackcloth -> sackcloth / separated from legend_sackcloth
legend_sackcloth_patched -> sackcloth-patched / separated from legend_sackcloth
legend_bandages -> bandages
legend_tunic -> tunic
legend_tunic_wrap -> tunic wrap
legend_tunic_collar_thin -> tunic_collar_thin
legend_tunic_collar_deep -> tunic_collar_deep
legend_dark_tunic -> dark_tunic
legend_tunic_noble -> tunic_noble
legend_tunic_noble_named -> tunic_noble_named
legend_southern_robe -> southern_robe
legend_knightly_robe -> knightly_robe
legend_southern_gambeson -> southern_gambeson
legend_southern_split_gambeson -> southern_split_gambeson
legend_southern_tunic -> soutern_tunic
legend_southern_noble_surcoat -> southern_noble_aketon
legend_fleshcultist_tunic -> fleshcultist_tunic
legend_armor_ancient_double_mail -> ancient_double_mail
legend_armor_ancient_mail -> ancient_mail
legend_armor_basic_mail -> basic_mail
legend_armor_hauberk -> hauberk
legend_armor_hauberk_full -> hauberk_full
legend_armor_hauberk_full_named -> hauberk_full_named
legend_armor_hauberk_sleevless -> hauberk_sleeveless
legend_armor_mail_shirt -> mail_shirt
legend_armor_mail_shirt_simple -> mail_shirt_simple
legend_armor_reinforced_mail -> reinforced_mail
legend_armor_reinforced_mail_shirt -> reinforced_mail_shirt
legend_armor_reinforced_rotten_mail_shirt -> reinforced_rotten_mail_shirt
legend_armor_reinforced_worn_mail -> reinforced_worn_mail
legend_armor_reinforced_worn_mail_shirt -> reinforced_worn_mail_shirt
legend_armor_rusty_mail_shirt -> rusty_mail_shirt
legend_armor_short_mail -> short_mail
legend_southern_cloth -> southern_cloth
legend_southern_padded_chest -> southern_padded_chest
legend_southern_mail -> southern_mail
legend_armor_leather_brigandine -> leather_brigandine
legend_armor_leather_brigandine_hardened -> leather_brigandine_hardened
legend_armor_leather_brigandine_hardened_full -> leather_brigandine_hardened_full
legend_armor_leather_brigandine_named -> leather_brigandine->named
legend_armor_leather_jacket -> leather_jacket
legend_armor_leather_jacket_named -> leather_jacket_named
legend_armor_leather_studded_jacket_named -> leather_studded_jacket_named
undertakers_apron -> apron_undertakers
legend_armor_leather_jacket_simple -> leather_jacket_simple
legend_armor_leather_lamellar -> leather_lamellar
legend_armor_cult_armor -> cult_armor
legend_armor_leather_lamellar_harness_heavy -> leather_lamellar_harness_heavy
legend_armor_leather_lamellar_harness_reinforced -> leather_lamellar_harness_reinforced
legend_armor_leather_lamellar_heavy -> leather_lamellar_heavy
legend_armor_leather_lamellar_heavy_named -> leather_lamellar_heavy_named
legend_armor_leather_lamellar_reinforced -> leather_lamellar_reinforced
legend_armor_leather_noble -> leather_jacket_fine
legend_armor_leather_padded -> leather_padded
legend_armor_leather_riveted -> leather_riveted
legend_armor_leather_riveted_light -> leather_riveted_light
legend_armor_leather_scale -> leather_scale
legend_armor_plate_ancient_chest -> plate_ancient_chest
legend_armor_plate_ancient_chest_restored -> plate_ancient_chest_restored
legend_armor_plate_ancient_gladiator -> plate_ancient_gladiator
legend_armor_plate_ancient_harness -> plate_ancient_harness
legend_armor_plate_ancient_mail -> plate_ancient_mail
legend_armor_plate_ancient_scale -> plate_ancient_scale
legend_armor_plate_ancient_scale_coat -> plate_ancient_scale_coat
legend_armor_plate_ancient_scale_harness -> plate_ancient_scale_harness
legend_armor_plate_ancient_scale_coat_restored -> plate_ancient_scale_coat_restored
legend_armor_plate_ancient_scale_harness_restored -> plate_ancient_scale_harness_restored
legend_armor_plate_chest -> plate_chest
legend_armor_plate_chest_rotten -> rotten_plate_chest
legend_armor_plate_cuirass -> plate_cuirass
legend_armor_plate_milanese, legend_armor_plate_triangle, legend_armor_plate_krastenburst -> merged into legend_armor_plate_full_greaves as variants
legend_armor_plate_full -> plate_full
legend_armor_plate_full_greaves -> plate_full_greaves
legend_armor_plate_full_greaves_named -> plate_full_greaves_named
legend_armor_plate_full_greaves_painted -> plate_full_greaves_painted
legend_armor_scale -> scale
legend_armor_scale_coat -> scale_coat
legend_noble_scale -> noble_scale
legend_armor_scale_coat_named -> scale_coat_named
legend_armor_scale_coat_rotten -> rotten_scale_coat
legend_armor_scale_shirt -> scale_shirt
legend_animal_hide_armor -> animal_hide_armor / note: barb armors are still using vanilla graphics for the time being
legend_heavy_iron_armor -> heavy_iron_armor
legend_hide_and_bone_armor -> hide_and_bone_armor
legend_reinforced_animal_hide_armor -> animal_hide_armor_reinforced
legend_rugged_scale_armor -> rugged_scale_armor
legend_scrap_metal_armor -> scrap_metal_armor
legend_thick_furs_armor -> thick_furs_armor
legend_thick_plated_barbarian_armor -> thick_plated_barbarian_armor
legend_thick_plated_barbarian_armor_named -> thick_plated_barbarian_armor_named
legend_bronze_armor_named -> unused
legend_southern_named_golden_plates -> unused
legend_southern_named_plates -> southern_named_plate / in place of above legend_southern_named_golden_plates
named_emperors_armor -> unused
davkul -> unused
legend_southern_plate_full -> southern_plate / it had the stats and description of southern plate
legend_southern_plate -> southern_plate_full / it had the stats and description of full southern plate
legend_southern_padded -> southern_padded
legend_southern_arm_guards -> southern_arm_guards
legend_southern_strips -> southern_strips
legend_southern_leather_jacket -> southern_leather_jacket
legend_southern_leather_plates -> southern_leather_plates
legend_southern_leather_scale -> southern_leather_scale
legend_southern_scale -> southern_scale
legend_diviner_jacket_named -> diviner_jacket
legend_fleshcultist_jacket -> fleshcultist_jacket
legend_shoulder_cloth -> shoulder_cloth
legend_noble_shawl -> noble_shawl
legend_dark_wooly_cloak -> cloak_wooly_dark
fur_cloak -> cloak_fur
legend_armor_cloak_common -> cloak / separated from legend_armor_cloak_common
cursed_cloak -> cursed_cloak
legend_armor_cloak_crusader -> cloak_crusader / separated from cloak
legend_armor_cloak_heavy -> cloak_heavy / separated from cloak
legend_armor_cloak_noble -> cloak_noble / separated from cloak
dukes_cloak -> cloak_duke
legend_sash -> sash
legend_southern_scarf -> southern_scarf
legend_religious_scarf -> religious_scarf
legend_animal_pelt -> animal_pelt
legend_southern_scarf_wrap -> southern_scarf_wrap
legend_common_tabard -> tabard / separated from legend_tabard
legend_noble_tabard -> tabard_noble / separated from legend_tabard
legend_southern_wrap_right -> southern_wrap_right
legend_southern_wrap_left -> southern_wrap_left
legend_southern_wide_belt -> southern_wide_belt
legend_noble_vest -> noble_vest
legend_southern_wrap -> southern_wrap
legend_southern_shoulder_cloth -> southern_shoulder_cloth
legend_southern_overcloth -> southern_overcloth
legend_southern_tabard -> southern_tabard
legend_diviner_tabard -> diviner_tabard
legend_fleshcultist_tabard -> fleshcultist_tabard
named_emperors_cloak -> cloak_emperors_named
named_emperors_armor -> armor_emperors_named

Armors defined via manual scripts:
cloak_spider -> removed
cloak_lindwurm (added to defs)
cloak_stollwurm (added to defs)
cloak_serpent (added to defs)
cloak_basilisk (added to defs)
cloak_hexe (standardized for defs)
cloak_redback (added to defs)
cloak_cursed (warlock item, added to defs, reformed into a cloak)
armor_davkul_named (added to defs)
pauldrons (added to defs)
pauldrons_belt_shield (added to defs)
pauldrons_bone_platings (added to defs)
pauldrons_chain_and_mail (added to defs)
pauldrons_double_mail (added to defs)
pauldrons_gladiator_light (added to defs)
pauldrons_gladiator_heavy (added to defs)
pauldrons_heavy (added to defs)
pauldrons_heraldic_plates (added to defs)
pauldrons_joint_cover (added to defs)
pauldrons_leather (added to defs)
pauldrons_leather_neck (added to defs)
pauldrons_mail_patch (added to defs)
pauldrons_metal (added to defs)
pauldrons_metal_plates (added to defs)
pauldrons_named (added to defs)
pauldrons_padding_light (added to defs)
pauldrons_protective_runes", "min" : 1 (added to defs)
pauldrons_skull_chain (added to defs)
pauldrons_spiked_chain (added to defs)
pauldrons_stag" (added to defs)
pauldrons_strong" (added to defs)
pauldrons_swan (added to defs)


Old and unlayered armored scripts removed:
legend_named_warlock_cloak
legend_redback_cloak_upgrade
legend_named_warlock_hood
legend_armor_hexe_leader_cloak_upgrade
legend_armor_redback_cloak_upgrade
legend_lindwurm_armor
legend_black_leather_armor
legend_brown_coat_of_plates_armor
legend_golden_scale_armor
legend_green_coat_of_plates_armor
legend_heraldic_mail_armor
legend_named_bronze_armor
legend_named_golden_lamellar_armor
legend_named_noble_mail_armor
legend_named_plated_fur_armor
legend_named_sellswords_armor
legend_named_skull_and_chain_armor

Helmet refactors:
basinet -> bascinet
bronze_helm -> unused
legend_armet -> armet
legend_frogmouth -> frogmouth
legend_frogmouth_close -> frogmouth_named
southern_named_conic -> southern_conic_named
southern_cap_dark -> merged into southern_cap
legend_ancient_gladiator -> ancient_gladiator
legend_ancient_legionaire -> ancient_legionary_helm
legend_ancient_legionaire_restored -> ancient_legionary_helm_restored
dentist_helmet -> unused
legend_armet_01_named -> armet_named
leather_hood_barb -> barb_hood_leather
helm_adornment_rotten -> rotten_helm_adornment
faceplate_winged -> separated into faceplate_winged, faceplate_winged_full and faceplate_winged_long
faceplate_full_01_named -> faceplate_winged_full_named
faceplate_gold, faceplate_full_gold -> integrated into winged faceplates
added -> rotten_great_helm_named
added -> facemask_named
noble_southern_crown -> southern_noble_crown
noble_southern_hat -> southern_noble_hat
faction_decayed_helmet -> rotten_faction_helmet
thick_braid_rotten -> rotten_thick_braid
wallace_sallet -> cervelliere / renamed to better fit the graphics
deep_sallet -> deep cervelliere / renamed to better fit the graphics
enclave_great_bascinet -> enclave_peaked_bascinet / renamed to fit the name used in game
enclave_great_bascinet_visor -> enclave_peaked_bascinet_visor / renamed to fit the name used in game
enclave_venitian_bascinet -> enclave_great_bascinet / renamed to fit the name used in game + typo
enclave_venitian_bascinet_visor -> enclave_great_bascinet_visor / renamed to fit the name used in game + typo
flat_top_helm_low -> flat_top_helm_rusted
flat_top_helm_polished -> removed / removing well-maintained version that only existed for 3 helms in the game
kettle_helm_low -> kettle_helm_rusted
kettle_helm_med -> kettle_helm 
kettle_helm -> removed (unused)
warlock_skull -> removed (item from defs, unused)
fencerhat and fencer_hat -> merged into fencer_hat

Helmet added via manual script:
warlock_skull (added to defs)

Old unlayered helmet scripts removed:
legend_demonalp_helmet
legend_mountain_helmet
legend_redback_helmet
legend_skin_helmet
legend_stollwurm_helmet
legend_white_wolf_helmet
```

Following trees were removed, refer to `z_perks_tree_enemy.nut` for replacements:

```
::Const.Perks.GhoulTree
::Const.Perks.DirewolfTree
::Const.Perks.SpiderTree
::Const.Perks.LindwurmTree
::Const.Perks.SchratTree
::Const.Perks.HexenTree
::Const.Perks.AlpTree
::Const.Perks.SkeletonTree
::Const.Perks.ZombieTree
::Const.Perks.VampireTree
::Const.Perks.OrcsTree
::Const.Perks.OrcTree
::Const.Perks.GoblinTree
::Const.Perks.UnholdTree
::Const.Perks.CaravanTree
::Const.Perks.MercenaryTree
::Const.Perks.NoblesTree
::Const.Perks.OutlandersTree
::Const.Perks.BanditTree
::Const.Perks.BarbarianTree
::Const.Perks.ArchersTree
::Const.Perks.ArcherTree
::Const.Perks.SouthernersTree
::Const.Perks.NomadsTree
::Const.Perks.MysticTree
```
