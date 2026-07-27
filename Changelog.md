# 19.5.0 - Name Pending

## Blazing Desert Plus
- added patch for BD+ by Sato

## Shield Changes
- Shields now have an innate new block system which works as follows: After damage calculations on attacker side (ie Killing Frenzy) and before damage calculations on defender side (Battleforged, Nimble, Lithe) subtract the damage done based on the block value of the shield, relevant perks, effects and items.
- Shields now also have an innate minimum and maximum value which is applied to skills like `Buckler Bash` and `Knock Back`

### Regular Shield Item Changes
- Shields in general no longer reduce ranged Damage Taken
- Auxiliary Shield - now has 15 Block, 10-25 Damage
- Coffin Shield - now has 15 Mdef, 20 Rdef, 36 condition, 25 Block, 10-25 Damage
> additionally reduces ranged Damage taken by 15%
- Ancient Tower Shield - now has 25 Mdef, 20 Rdef, 48 condition, 30 Block, 10-25 Damage
- Buckler Shield - now has 10 Block, 5-10 Damage
- Heater Shield - now has 20 Block, 15-30 Damage
- Kite Shield - now has 20 Block, 10-25 Damage
> additionally reduces ranged Damage taken by 30%
- Tower Shield - now has 20 Weight, 30 Block, 10-25 Damage
- Wooden Skirmisher (Goblin) Shield - now has 4 Mdef, 8 Rdef, 14 condition, 8 Block, 5-10 Damage
> classified as a bucker and gains buckler skills and effects
- Reinforced Skirmisher (Goblin) Shield - now has 5 Mdef, 10 Rdef, 18 condition, 10 Block, 5-10 Damage
> classified as a bucker and gains buckler skills and effects
- Orc Light Shield - now has 15 Block, 10-25 Damage, 24 Condition
> additionally reduces ranged Damage taken by 15%
- Orc Heavy Shield - now has 30 Block, 100 Condition and 15-30 damage
- Sipar - now has 30 Block, 10-25 Damage
- Adarga - now has 15 Block, 10-25 Damage
> additionally reduces ranged Damage taken by 15%
- Wooden Shield - now has 20 Block, 10-25 Damage
- Old Wooden Shield - now has 20 Block, 10-25 Damage
- Ancient Southern Tower (Mummy) Shield - now has 20 Weight, 25 Block, 10-25 Damage
> additionally reduces ranged Damage taken by 30%
- Ancient Southern (Mummy) Shield - 12 Block, 5-10 Damage, 18 Condition
- Schrat Shield - now has 20 Mdef, 17 Rdef, 8 Weight, 48 Condition, 25 Block, 10-25 Damage
> once per battle regrow itself to full upon destruction
- Greenwood Schrat Shield - now has 30 Mdef, 25 Rdef, 10 Weight, 72 Condition, 25 Block, 10-25 Damage
> twice per battle regrow itself to full upon destruction

### Special Shield Item Changes
- Gilder's Embrace - now has 50 block and 15-30 Damage
- Named Bandit Heater/Named Undead Heater - now has 20 block, 15-30 Damage
- Named Bandit Kite/Named Dragon Shield/Named Undead Kite - now has 20 Block, 10-25 Damage
> additionally reduces ranged Damage taken by 30%
- Named Buckler - now has 10 Block, 5-10 Damage
- Named Fullmetal Heater - now has 25 Block, 20-35 Damage
- Named Golden Round shield/Named Sipar - now has 30 Block, 10-25 Damage
- Named Lindwurm Shield - now has 25 Mdef, 25 Rdef, 25 Block, 10-25 Damage
> on enemy striking the shield will apply lindwurm acid to attacker
- Named Orc Heavy Shield - now has 30 Block, 100 Condition and 15-30 damage
- Named Wing Shield/Named Rider on Horse Shield - now has 50 Condition, 25 Block, 15-30 Damage
- Named Pavise Shield - now has 25 Mdef, 25 Rdef, 20 weight, 96 Condition, 30 Block, 10-25 Damage

### Shield Ability Changes
- `Fortify` - deleted
- `Buckler Effect` - now grants 5% of Initiative as Defense and Block

## Noble House Changes
- introduced 40 new traits into the noble house trait system
- expanded the number of mottos available to noble houses
- added noble house traits to units and towns belonging to noble houses
- modified the faction window to include traits
- added short description to noble house traits available upon mouseover in faction window

## Profession system
- introduced a new system connecting camping system to brothers - profession tree
- the tree is accessible via character screen, next to the perk tree
- uses separate points, independent to regular perks

## Scenarios

### Anatomists
- new conqueror potion
- new demon alp potion
- new demon hound potion
- new fallen betrayer potion
- new greenwood schrat potion
- new hexe leader potion
- new necrosavant lord potion
- new orc behemoth potion
- new orc elite potion
- new redback potion
- new rock unhold potion
- new stollwurm potion
- new skinghoul potion
- new white direwolf potion

## Perks

### New Perks
- `Near Death Experience` - Martyr Trait Tree
> Confers an experience point bonus based on Hitpoints lost and Injuries gained during combat. Gain 1 XP per Hitpoint and 10 per Injuries. Experience gain is reduced by 90% at level 12 and above.
> Hitpoint damage taken is reduced by 5% and Resolve is increased by 3 for each Injury you have up to a maximum of 30% and [color=%positive%]15 achieved at 6 Injuries. Counts both regular and permanent Injuries.
- `Wide Swings` - Large Trait Tree
> Gain a 50% chance upon missing an attack execute the skill again on the target you missed.
> The follow up will deal 50% less damage and gain 30% hitchance.
- `Hammer the Gap` - Grants a stacking +5% to hit as long as you attack the same tile. The bonus is capped at 10%.

### Perk Changes
> the bonus is now additive multiplier
- `Heightened Reflexes` - the damage bonus is an additive multiplier
- `Muscularity` - bonus from fatigue dropped to 10% and the bonus is now an additive multiplier
- `Backswing` - new gfx to differentiate from feint
- `Anticipation` - removed for now
- `Ballistics` - no longer reduces hitchance penalty with tile traveled, instead deals an additional 2 damage per tile traveled
- `Wind Reader` - reduces hitchance penalty with tile traveled by 2%, gains the vanilla `Anticipation` effect, moved to tier 3
- `Night Raider` - will now also appear in the Devious trait tree
- `Prepared` - crossbows and firearms in your bags will be loaded at combat start
- `Anticipation` - reduce damage taken by 1% for each point of Ranged Defense you have for the first few hits you take in combat
- `Return Favor` - If you're armed with a ranged weapon and a ranged attack misses you, gain a chance to fire back at your attacker. The chance is based on Ranged Defense.
- `Versatile` - now grants stacks which will increase damage by 10% damage for the opposite attack type


## Items
- weight and maximum fatigue uniformly renamed as "Fatigue Weight Penalty" across different wearable items; no functional changes

### Armors
- added Segmented Breastplate
- added Nomad Mail
- separated Horn Plate Upgrade (L5) into Kraken Shoulderplates (L5) and Horn Plate (L1)
- fixes and recolors of existing armor
- plate_full_greaves_named and plate_full_greaves_painted merged into a single item
- Vala Cloak changed into L4, Vala now always starts with Vala Dress and Vala Cloak equipped

### Weapon

**Backup throwing skills**
- now separated from throw javelin/throw axe in the code to avoid errors when dual wielding thrown weapon and item of the same type

**New Weapons**
- Heavy Rusty Battleaxe - new barbarian bardiche
- Named Heavy Rusty Battleaxe - named version

**Daze Bomb**
- will now stun if the target is already dazed

**Throwing**
- `Piercing Javelin` - if the attack is successful also attack the target behind them for 75% damage
> 5 ap, 20 fat

**Puncture Daggers**
- `Backstab` - replaces `Stab` on puncture daggers
> additional 5% damage and 3% armor penetration based on surround count
- `Puncture` - unchanged
- `Throw Dagger` - unchanged

**Qatal Daggers**
- `Stab` - will attack an additional time if under the effect of smoke
- `Deathblow` - unchanged
- `Gut`
> attacks repeatedly the body of the enemy depending on how many injuries they have

**Obsidian Dagger**
- `Backstab`
> additional 5% damage and 3% armor penetration based on surround count
> will attack an additional time if under the effect of smoke
- `Deathblow` - unchanged
- `Gut`
> attacks repeatedly the body of the enemy depending on how many injuries they have

**2h Swordcleavers**
- `Hew` - 60% base for each attack, +20% if the target is bleeding or injured
- `Harvest` - 10% bonus damage down from 20% with mastery when target is bleeding
- `Decapitate` - additionally increases head hit chance depending on how wounded the target is

**1h Cleavers**
- `Cleave` - unchanged
- `Decapitate` - unchanged
- `Debilitate` - a successful strike will apply `Debilitated`
> 4 ap, 20 fat, 50% damage

**Whips**
- `Whip` - ap cost is reduced to 3
- `Disarm` - unchanged
- `Debilitate` - a successful strike will apply `Debilitated`
> 4 ap, 20 fat, 50% damage, 3 range

**Bardiche**
- no longer has `Swing`

**Estoc**
- `Perforate` - You have a chance to attack up to 1(3 with mastery) additional times based on the initiative difference between you and your target. The chance for each attack to be executed is rolled independently in increments of 100.

**1h Shamshir and 1h scimitar**
- `Slash` is now `Flowing Slash`
> will attack again for 50% damage on a miss with mastery
- `Gash` - unchanged
- `Debilitate`

**1h ancient swords**
- `Bash`
- `Knock Out`
- `Return Favor`

**1h maces**
- `Slash` is now `Flowing Slash`
> will attack again for 50% damage on a miss with mastery
- `Gash` - unchanged
- `Debilitate`

### Blueprints
- new `Sipar Shield` blueprint from 1 iron ingot
- `Tower Shield` blueprint now costs 2 quality wood and 1 iron ingot

### Misc
- `Balanced Rucksack` - usable item sold around marketplaces which adds 2 extra bag slots to a mercenary

## Enemies

### Bandits
- `Bandit Executioner` - new enemy that will appear in bandit comps, dressed to impress and armed with cleavers - including the new executioner sword
- `Peasant Blacksmith` - removed from comps
- `Peasant Butcher` - removed from comps
- `Peasant Woodsman` - removed from comps
- `Peasant Miner` - removed from comps
- `Peasant Farmhand` - removed from comps
- `Peasant Poacher` - removed from comps
- `Peasant Squire` - removed from comps
- `Peasant Witchhunter` - removed from comps

### Nomads
- `Escaped Gladiator` - new enemy that will appear in nomad comps, more or less will feel familiar to regular Gladiators you meet in arena, but they aren't dressed like they're putting on a show
> `Lithe` will replace `Nimble` vs regular gladiators

### City States
- `Gladiators` - gain `Net Casting`, `Net Mastery`, additionally gain `Alert` and `Lone Wolf` on Legendary

## Quality of life
- added speed settings to combat and world expanding on vanilla systems
> use 1-4 in the World, F1-F4 in combat to change the speed
> alternatively use the buttons on the top of the respective screens
> buttons are fully functional during caravan and camp activities
- added expanded settlement situation tooltips to support new situations natively
> settlement situations displayed similarly to a popular mod
> new modifiers are supported
- added pause options in Legends General mod settings tab
> pause on events, ambitions and encounters
> pause on new dawn while camping (when town buildings become usable after a night)
> pause on new day (when contracts etc. reset)
> pause on entity discovered
> pause on movement stop
> resume on setting new destination / path
- added an option to show the average stat potential directly on statistic bars
> shows average values at a glance (min/max ranges are still visible on mouseovering the bros background)
- added an option to show the named item enhanced stat potential on tooltips
> shows the value range for enhanced rolls only
- added inventory management toggle on items
> allows setting the item type to be marked for sale, autorepair and sale, autorepair, autosalvage
> the setting is completely optional
> marked items can be sold with a single click in shops and new items acquired will respect these flags
> newly acquired items with flags will automatically start be added to repair/salvage queue
> flags are now visible in shop and loot screens
> quickly loot items based on value (new button; ignores legendary, named, quest, food)
> combine items to save inventory space with a single click with respect to automation state
- sped up inventory load times by loading items in batches
- recruitment window now shows some extra information about the recruit
> ability to change between vague immersive text version and numerical values
> improvements tied into the profession system
- added a simple perk planning system
> 3 states
> shows the level needed to acquire the build
> shows the number of optional perks picked
- added a visual to display the number of books and scrolls read/available
- books/scrolls will now show a tooltip in shops and other screens based on last selected bro (with name)


## Camping changes
- made most dialogs shorter
- crafting system has been overhauled
- crafted items types reassigned in some cases to make it more intuitive

## Events
- added a new town encounter during drought
- added a new event requiring a well read person

## Gender settings and changes
- added a mod setting allowing the player to choose the gender of the commander avatar
- added a mod setting allowing the player to choose % of female characters
- added a mod setting allowing the player to choose % of enemy female characters
- some backgrounds received female counterparts: Fisher, Shepherd, Vagabond, Inventor, Brawler, Widow, Caravan Hand, Miner, Servant (southern), Juggler

## Other
- donkey appetite and donkey body integrated into the background
- painter tent allows painting the shoulder layer

## Bug Fixes
- black market in town screens can now be highlighted on mouseover
- text fixes
- graphical/ui fixes
- bros can now use the basic training options until level 12 in town training halls instead of 11
- fixed settlement situations applying twice
- improved stability
- assassinate no longer grants more damage than the tooltip indicates
- dog and bag item functionality and tooltip fixes

### For modders:
- it is now possible to use [i][/i] and [size=18px][/size] to customize ui text size easily with xbbcode
- added color templates to event lists, instead of vanilla way, you can specify colors as `[color=%positive%]` now
- defs created for backgrounds
- background_stats created for background stat rolls and migrated them from bgs
- changed background.legend_peddler_commander -> background.legend_commander_peddler
- legend_mage_background and legend_mage_commander_mage removed
- human gender now randomized using randomizeHumanGender (separately on bgs and humans), which respects the new mod setting
- enemy gender now randomized using randomizeEnemyGender, which respects the new mod setting
- Tabbard -> Tabard | tabbard -> tabard
- Hesistant -> Hesitant
- legend_dilapitated_sling -> legend_dilapidated sling
- camp buildings: getModifierToolip -> getModifierTooltip
- `LegendExtendendAura` -> `LegendExtendedAura`
- `LegendTattos` -> `LegendTattoos`
- `LegendFortify` -> deleted
- `legend_fortify_skill` -> deleted
- `legend_fortify_effect` -> deleted
- `legend_ancient_summoner_background` -> deleted
- `legend_astrologist_background` -> deleted
- `legend_cannibal_background` -> deleted
- `legend_conjurer_background` -> deleted
- `legend_death_sumoner_background` -> deleted
- `legend_diviner_background` -> deleted
- `legend_druid_commander_background` -> deleted
- `legend_enchanter_background` -> deleted
- `legend_entrancer_background` -> deleted
- `legend_healer_background` -> deleted
- `legend_noble_background` -> deleted
- `legend_philosopher_background` -> deleted
- `legend_premonitionist_background` -> deleted
- `legend_runesmith_background` -> deleted
- `legend_spiritualist_background` -> deleted
- `legend_trader_background` -> deleted
- `legend_spiritualist_background` -> deleted
- `legend_trader_background` -> deleted
- `legend_trader_commander_background` -> deleted
- `legend_transmuter_background` -> deleted
- `legend_witch_background` -> deleted
- `legend_bear_bite_skill` -> deleted
- `legend_staff_lunge_skill` -> deleted
- `legend_unarmed_lunge_skill` -> deleted