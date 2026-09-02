 19.5.0 - Name Pending

## Blazing Desert Plus
- added a patch for BD+ by Sato

## Origins
### Legion
- Removed camera pan to monolith at the start of a legion run after the opening event
- Legate now has background text
- Legion now all have background art, thanks to the squishy and cute Narkh
- Implemented a unique weapon for legion via an event
- Rebalanced the terrain movement modifiers of all possible hires
- Fixes an issue for the Legate in the legion origin where the 'command' skill was capping AP at 4, rather than giving +4 AP
- Fixed an issue where if the player interacted or destroyed the black monolith as legion, the game would hang
- Fixed an issue where the legendary ram hammer for legion had its graphic occasionally apply to random named 2h hammers
 
**New camp contracts for Legion:**
- Hunt: nobles (medium-hard)
- Hunt: barbarians (medium-hard)
- Raid: farmstead (low-hard, depending on choices made mid-contract)
- Siege: nobles (very hard)
- Sack & destroy (hard-very hard)

### Necro Trio & Solo
- Shuffled possible backgrounds that could spawn as undead for the purposes of several events
- Most, if not all, necromancer events now decrease relationships with potential employers if the player accepts the rewards of said event(s)
- Summoner loses 1 melee defence talent, gets 2 hitpoint defence talents.
- Puppets shifted in behavior, now require 1 medicine per day to maintain and no food.
> Not maintaining your puppets (and by extension, all zombies in your roster) with medicine will cause them to take 5-20 nonlethal damage per day until medicine is replenished. This alert will show up in their mood tooltip.
- Starting puppet in necro trio now starts at level 2 as opposed to level 1.
- Master necromancer: +20% additional recruit/upkeep cost on most recruits removed.
- Master necromancer: relationship with nobles, peasant and city state factions increased from -50 to -20 on start.
- Master necromancer: starts with `Raise Undead`
> Partly a quick solution until we get more camp contracts made to fill in that early game isolation phase.
- Necro trio: +50% additional recruit/upkeep cost on most recruits lowered to +20%.

### Nomads
- You now earn 0.1 relationship with the nomad faction per day per southern fighter under your command
- Nomads can no longer get the following ambitions: make city states aware, win x arena fights, defeat holy war.
- Indebted are now factored into the southern roster for this origin, and earn the 'anchor' perk for free
- Indebted are now also pushed to Steppe towns as other nomads are
- (Roughly) doubled Nomad spawns in steppe towns
- City states are permanently hostile
- Nomads now start with 2 sturdy slings in their stash
- Nomads can now convert a slave into a Nomad, Muladi, or Blade Dancer via an event
- Nomads can now recruit nomads via a repeating event while in the desert
- New camp contract: Nomads raid caravan

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

- Anatomists can no longer be scared of the dark
- Anatomist origin has an additional chance of finding anatomists (~1 in 4 chance per refresh)

## Backgrounds

### Background stats
- Randomization has been restored
- Regular Brothers roll between:
> Hitpoints 50 - 60
> Bravery 30 - 40
> Stamina 90 - 100
> MeleeSkill 47 - 57
> RangedSkill 32 - 42
> MeleeDefense 0 - 5
> RangedDefense 0 - 5
> Initiative 100 - 110
- Legion brothers roll between:
> Hitpoints 40 - 50
> Bravery 90 - 100
> Stamina 30 - 40
> MeleeSkill 47 - 57
> RangedSkill 32 - 42
> MeleeDefense 3 - 8
> RangedDefense 5 - 10
> Initiative 95 - 105
- Puppet brothers roll between
> Hitpoints 65 - 75
> Bravery 90 - 100
> Stamina 90 - 100
> MeleeSkill 47 - 57
> RangedSkill 20 - 30
> MeleeDefense -5 - 0
> RangedDefense -6 - -1
> Initiative 65 - 75

### Oathtakers
- oathtakers stats aligned with vanilla with a bumped up initiative
- cannot roll hitpoints and ranged skill
- oathtakers get medium armour tree
- oathtakers can have up to 9 weapon trees
- gain Polearm, Shield, Mace, Hammer, Sword, Crossbow trees
- Hiring cost dropped from 350 to 150 in line with vanilla
- old oathtaker gets faith class tree

### Lindwurm Slayer
- stats aligned with vanilla with the exception of higher matk and ratk
- can roll up to 8 trait trees
- can roll up to 3 defensive trees


### Sellswords
- sellswords stats aligned with vanilla
- sellswords can have up to 9 weapon trees

### Adventurous Noble & Disowned Noble
- both backgrounds now has a ranged and melee version which can be both male and female

### Cannibal:
- Abridged some of the cannibal recruitment event
- New blueprint for sausages - 3 strange meat and 1 cooking spice
- Tweaked cannibal eats part of brother event to be much more forgiving

### Donkey
- donkey appetite and donkey body integrated into the background (no functional changes)

### Vala:
- can no longer roll ranged skill stars

## Perks

### New Perks
- `Manipulative` - grants `Entice` and `Revolt`, replaces the perks as a single one
- `Near Death Experience` - Martyr Trait Tree
> Confers an experience point bonus based on Hitpoints lost and Injuries gained during combat. Gain 1 XP per Hitpoint and 10 per Injuries. Experience gain is reduced by 90% at level 12 and above.
> Hitpoint damage taken is reduced by 5% and Resolve is increased by 3 for each Injury you have up to a maximum of 30% and [color=%positive%]15 achieved at 6 Injuries. Counts both regular and permanent Injuries.
- `Wide Swings` - Large Trait Tree
> Gain a 50% chance upon missing an attack execute the skill again on the target you missed.
> The follow up will deal 50% less damage and gain 30% hitchance.
- `Hammer the Gap` - Grants a stacking +5% to hit as long as you attack the same tile. The bonus is capped at 10%.

### Perk Changes
> the bonus is now additive multiplier
- `Carnage` - no longer grants `Prepare Graze` and `Prepare Bleed`
- `Heightened Reflexes` - the damage bonus is an additive multiplier
- `Muscularity` - bonus from fatigue dropped to 10% and the bonus is now an additive multiplier
- `Backswing` - new gfx to differentiate from feint
- `Anticipation` - removed for now
- `Ballistics` - no longer reduces hitchance penalty with tile traveled, instead deals an additional 2 damage per tile traveled
- `Wind Reader` - reduces hitchance penalty with tile traveled by 2%, gains the vanilla `Anticipation` effect, moved to tier 3
- `Night Raider` - will now also appear in the Devious trait tree
- `Prepared` - crossbows and firearms in your bags will be loaded at combat start; bombs and poisons cost 0 at the first turn of combat
- `Anticipation` - reduce damage taken by 1% for each point of Ranged Defense you have for the first few hits you take in combat
- `Return Favor` - If you're armed with a ranged weapon and a ranged attack misses you, gain a chance to fire back at your attacker. The chance is based on Ranged Defense.
- `Versatile` - now grants stacks which will increase damage by 10% damage for the opposite attack type, up to 3 stacks that can gradually be reduced
- `Rebound` - moved to tier 6
- `Overwhelm` - moved to tier 3
- `Lookout` - removed from Slings tree
- `Anchor` - moved to Slings from Bow to replace `Lookout`

## Professions
- introduced a new system connecting the camping system to brothers - profession tree
- the tree is accessible via character screen, next to the perk tree
- uses separate points, independent to regular perks and conveys bonuses for the whole company

## Traits
- `Lucky` - now additionally gives 10% chance to reroll a missed attack
- `Mad` - now has a chance to shift his morale up or down at the start of each turn in combat, cannot become fleeing from this effect but can rally from fleeing

## Items
- weight and maximum fatigue uniformly renamed as "Fatigue Weight Penalty" across different wearable items; no functional changes

### Armors
- added Segmented Breastplate
- added Nomad Mail
- separated Horn Plate Upgrade (L5) into Kraken Shoulderplates (L5) and Horn Plate (L1)
- fixes and recolors of existing armor
- plate_full_greaves_named and plate_full_greaves_painted merged into a single item
- Vala Cloak changed into L4, Vala now always starts with Vala Dress and Vala Cloak equipped

### Helmets
- added 5 more variations of Face Mask, art by Ivan

### Weapons
**War Bow, Named War Bow, Hunting Bow**
- gain `Full Draw` and `Mark Target`
> Full draw has a base 50% armor penetration, 9 max range and 3 min range, an extra 30% damage but costs 9 ap without mastery and 8 with mastery
> additionally it's a delayed fire skill that will only do damage on the start of your next turn or after wait with mastery
- art adjustments for war bow because the vanilla one was too small

**Wonky Bow, Composite Bow, Short Bow**
- are now 6 range weapons
- they gain `Volley` in their toolkit
- art adjustments for composite bow because the vanilla one was too big

**Masterwork Bow**
- now has 8 range
- gains `Volley`, `Full Draw` and `Mark Target`


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
> has a 10 (20 with mastery) % to reroll the attack
- `Gash` - unchanged
- `Debilitate`

**1h ancient swords**
- `Slash`
- `Gut`
> replaces riposte
- `Halfsword`

**1h maces**
- `Bash`
- `Knock Out`
- `Return Favor`

### Shields
- Shields now have an innate new block system which works as follows: After damage calculations on attacker side (ie Killing Frenzy) and before damage calculations on defender side (Battleforged, Nimble, Lithe) subtract the damage done based on the block value of the shield, relevant perks, effects and items.
- Shields now also have an innate minimum and maximum value which is applied to skills like `Buckler Bash` and `Knock Back`
- `Fortify` - removed
- `Safeguard` - now transfers your block value to an ally until the start of your next turn
- `Buckler Effect` - now grants 5% of Initiative as Defense and Block

### Regular Shields
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

### Special Shields
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

### Named Shield Changes
- shields can now roll damage and block
- because the amount of rollable attributes has been increased, named shields now always roll fatigue

### Consumables
- `Berserker Mushrooms` - if the character has berserker rage it'll grant 5 points of rage at turn start
- poisons are now refillable and use the ammo system
- added redback poison vials and blueprints

### Runes
- rune effect values were redone slightly, so they all follow the same rules now
- this means that upgraded tent produces up to 1.5 more powerful effects than not upgraded uniformly (rounded)
- affected runes are: endurance, radiance, durability, blazing (slight changes)

### Blueprints
- new `Sipar Shield` blueprint from 1 iron ingot
- `Tower Shield` blueprint now costs 2 quality wood and 1 iron ingot

### Misc
- `Balanced Rucksack` - usable item sold around marketplaces which adds 2 extra bag slots to a mercenary
- Masterwork tools cost from 750 to 1250.
- Masterwork metal cost from 1450 to 2900.
- Masterwork fabric cost from 950 to 1140.

## Enemies
### Dynamic Troops Day To Skip
- `Dynamic Troops Day To Skip` in the start campaign settings has now been disabled, enemies of varying difficulty will naturally appear as your company becomes stronger

### Goblins
- `Goblin Berserkers` are now called `Goblin Fiends` and have new art from Ivan

### Beasts
- revamped art for `Demon Alp` from Misha

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
- Estoc removed from `Robber Barron` and `Bandit Leader`
- Added dagger mastery to `Sswordmasters` and `Fencers` for the purposes of vanilla estoc compatibility

### Nomads
- `Escaped Gladiator` - new enemy that will appear in nomad comps, more or less will feel familiar to regular Gladiators you meet in arena, but they aren't dressed like they're putting on a show
> `Lithe` will replace `Nimble` vs regular gladiators

### City States
- `Gladiators` - gain `Net Casting`, `Net Mastery`, additionally gain `Alert` and `Lone Wolf` on Legendary

## Ambitions
- New ambition: make city states aware (triggers at 800 renown or more).
- Updated the 'allied nobles' ambition to give the player a randomly chosen named weapon (11 possibilities) upon ambition completion.
- Updated 'roster of six' ambition to give an item payout of food supplies to ease that sharp shift more difficult origins experience from this milestone expansion.

## Events
- Implemented a game-wide check that prohibits donkeys, undead ('untalkables') and skeletons ('origin-locked') from interacting in events unless SPECIFICALLY mentioned.
- added a new town encounter during drought
- added a new event requiring a well read person
- Added an event involving a sighthound
- Added an event involving a northern warhound
- Removed moral rep. hit from children crusade event
- Two brave and/or fearless trait bros can now cure another bro of their fear of the dark trait
- Added puppet interacting with anatomist
- Added an event to necro both origins to convert a cultist to a puppet
- Added event between anatomist and alchemist
- Added an event between surgeon and anatomist
- Resurrect stronger variant of undead (cyclical) - necro origins only
- Resurrect a knight as undead (semi-unique, rare) - necro origins only
- Puppets in a town cause trouble - necro origins only
- Necromancer(s) run into a witchhunter patrol - necro origins only
- Visit nomad tents location(s) with detailed interactions - Nomads origin only
- Deathspiral (generic) - legion only
- Trenches (generic) - legion only
- Training (cyclical) - legion only
- Crypt (unique) - legion only

## Retinue
- removed all current retinues
- purchasable camp upgrades became the new retinues with gorgeous art by Misha
- no renown requirements anymore, just a bunch of gold

## Camping
- made most dialogs shorter
- hunters tent removed
- crafting system has been overhauled
- cooking tent (station) added
- cleaned up cooking and enchanting ui
- cooking and enchanting now work similarly to regular crafting (allows crafting forever and preselecting recipes)
- all crafting and cooking recipes now require professions
- professions affect the crafting process
- crafted item types reassigned in some cases to make it more intuitive
- small visual reorganization to make the stations easier to click
- right click tents to open the correct list in commander's tent
- painter tent allows painting the shoulder layer
- upgraded scouting has been improved and allows the party to scout for locations while camping
- gathering and scouting requires healthy bros and can injure/exhaust bros similarly to training
- healing tent gains intensive treatment of hitpoints at the cost of medicine when upgraded
- scout tent now always produces a scouting message

## New Campaign
- changed the labels so the functions are easier to understand
- replaced the water connectivity and landmass settings with a unified water slider
- generated maps should be more consistent with the chosen setting and generate much quicker in some cases
- added a bridging function to map generation to ensure connections between bigger islands and continents and the mainland
- cleaned up the option dialogs

## Gender settings and changes
- added a mod setting allowing the player to choose the gender of the commander avatar
- added a mod setting allowing the player to choose % of female characters
- added a mod setting allowing the player to choose % of enemy female characters
- some backgrounds received female counterparts: Fisher, Shepherd, Vagabond, Inventor, Brawler, Widow, Caravan Hand, Miner, Servant (southern), Juggler
- fixed a bunch of remaining gender issues

## Noble Houses
- introduced 40 new traits into the noble house trait system
- expanded the number of mottos available to noble houses
- added noble house traits to units and towns belonging to noble houses
- modified the faction window to include traits
- added short description to noble house traits available upon mouseover in faction window

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
- Lone wolf equipment will now self-equip on game start as opposed to being in the stash
- clarified rotten flesh tooltip
- clarified the tools usage tooltip.
- background details can now be found in the projects github wiki (https://github.com/Battle-Brothers-Legends/Legends-public/wiki/Backgrounds)
- world economy campaign option is now always on; option removed from new campaign settings
- damage over time effects now always give xp on kills; option removed from new campaign settings
- distance scaling is now always on; option removed from new campaign settings
- distance scaling now affects aggressive groups in a reduced manner in early game (defender groups remain unchanged)
- recruit scaling now always off; option removed from new campaign settings - recruitment progression now reflected in professions

## Bug Fixes
- black market in town screens can now be highlighted on mouseover
- various text fixes
- graphical/ui fixes
- bros can now use the basic training options until level 12 in town training halls instead of 11
- fixed settlement situations applying twice
- improved stability
- assassinate no longer grants more damage than the tooltip indicates
- dog and bag item functionality and tooltip fixes
- fixed hover boxes on camp objects
- fixed travelling bard
- fixed tips button in camp screen overflowing the log
- fixed encounter event issues
- donkeys can no longer use tools
- fixed daze bomb stun
- fixed window opening related ui bugs
- various scenario fixes
- players aren't required to have a brother on the first two rows anymore
- brothers will be deployed on three rows properly during edge deployment
- fixed intensive training preferring ranged defense as a trained stat
- fixed hurt brothers being counted towards training modifier
- fixed encounters in towns sometimes being inconsistent
- Meistersanger now states it needs an instrument equipped to use in the perk desc
- fixed the spawning mechanism (dogs, bears, zombies, etc.) to always be 'animals' for the purposes of preserving lone wolf activation and not absorbing xp in battle.
- fixed gauntlets penetration stat not being used
- fixed hand to hand not being  modified by damage
- fixed a few issues with moving weapons in and out of bags in combat
- fixed Lorekeeper's headpiece
- Swapped graveyard & crypts to mass graves and sunken castles for legion 'defend x' camp contracts as crypts & graveyards could shuffle zombies in which caused the player to get attacked by a sally or scout force
- fixed holy flame sometimes not awarding kills properly
- fixed prepare to bleed bugs
- fixed grazes not awarding kills for kills properly
- fixed rounding errors making too many settlements appear on the map under certain campaign settings
- getting attacked while camping now shows the finished camping dialog before combat
- white wolves can now sometimes roam the steppes
- stollwurms can now sometimes roam the plains
- greenwood schrats can now sometimes roam the farmland
- fixed a bug with undead ambushers and roamers clogging actions in the inquisition scenario
- fixed distance scaling erroneously not affecting orc defender parties
- fixed distance scaling erroneously not affecting undead roamer parties
- fixed serpents erroneously preferring snowy areas 
- fixed goblin ambushers not getting the sufficient boost during greenskin invasion on legendary difficulty

### For modders:
- it is now possible to use [i][/i] and [size=18px][/size] to customize ui text size easily with xbbcode
- added color templates to event lists, instead of vanilla way, you can specify colors as `[color=%positive%]` now
- defs created for backgrounds
- new `RerollAttackChance` property in `CharacterProperties`, allows you to reroll a miss
- background_stats created for background stat rolls and migrated them from bgs
- bro sprite setting per background moved to bg's setGender; uses setBodyCharacteristics which accepts an object with fields to overwrite default sprites with (default are norther, all)
- changed background.legend_peddler_commander -> background.legend_commander_peddler
- legend_mage_background and legend_mage_commander_mage removed
- human gender now randomized using randomizeHumanGender (separately on bgs and humans), which respects the new mod setting
- enemy gender now randomized using randomizeEnemyGender, which respects the new mod setting
- Tabbard -> Tabard | tabbard -> tabard
- Hesistant -> Hesitant
- LegendExtendendAura -> LegendExtendedAura
- legend_dilapitated_sling -> legend_dilapidated sling
- camp buildings: getModifierToolip -> getModifierTooltip
- Barter -> Haggle
- removed delayed event fix (Vanilla already fixed it in a better place in the chain, possibly fixes event bugs)
- moved `player_party` bro and equipment strength calculations to difficulty helper
- camp screen and building changes
- camp flags are now indexed by building
- camp buildings moved to ::Legends.Camp
- `LegendExtendendAura` -> `LegendExtendedAura`
- `LegendTattos` -> `LegendTattoos`
- `LegendFortify` -> deleted
- `LegendDoubleStrike` -> `LegendFlux`
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
- `legend_qiyan_background` -> deleted
- `legend_bear_bite_skill` -> deleted
- `legend_staff_lunge_skill` -> deleted
- `legend_unarmed_lunge_skill` -> deleted
- `legend_staffwall_skill` -> deleted
- `legend_staff_thrust_skill` -> deleted
- `legend_staffwall_effect` -> deleted
- `legend_witch_commander_background` renamed to `legend_seer_background`
- `legend_noble_ranged` renamed to `legend_arbalester_background`
- `legend_noble_shield` renamed to `legend_foot_soldier_background`
- `legend_noble_2h` renamed to `legend_house_guard_background`
- `perk_legend_double_strike` renamed to `perk_legend_flux`
- `perk_legend_albedo` -> deleted
- `perk_legend_nigredo` -> deleted
- `perk_legend_citrinitas` -> deleted
- `perk_legend_boondock_blade` -> deleted
- `legend_nigredo_skill` -> deleted
- `legend_albedo_skill` -> deleted
- `legend_citrinitas_trance_skill` -> deleted
- `legend_cascade_skill` -> `legend_volley_skill`
- `legend_puncture_parry_dagger_skill` -> deleted
- `legend_goblin_berserker` -> `legend_goblin_fiend
- `LegendGoblinBerserker` -> `LegendGoblinFiend`
- `legend_charge_skill` -> deleted
- `legend_boar_gore_skill` -> deleted
- `legend_rat_bite_skill` -> deleted
- `legend_rat_claws_skill` -> deleted
- `legend_darkflight_skill` -> deleted
- `legend_transform_into_boar_skill` -> deleted
- `legend_transform_into_bear_skill` -> deleted
- `legend_transform_into_rat_skill` -> deleted
- `legend_transform_into_wolf_skill` -> deleted
- `legend_transform_into_tree_skill` -> deleted
- `perk_legend_bearform` -> deleted
- `perk_legend_wolfform` -> deleted
- `perk_legend_trueform` -> deleted
- `perk_legend_surpress_urges` -> deleted
- `perk_legend_master_anger` -> deleted
- `perk_legend_control_instincts` -> deleted
- `legend_demon_shadows_skill` -> deleted
- `legend_dog_handling_skill` -> deleted
- `legend_dog_master_skill` -> deleted
- `legend_drink_cat_skill` -> deleted
- `legend_drink_ironwill_skill` -> deleted
- `legend_drink_lionheart_skill` -> deleted
- `legend_drink_night_vision_skill` -> deleted
- `legend_drink_recovery_potion_skill` -> deleted
- `perk_legend_enthrall` -> deleted
- `legend_enthrall_skill` -> deleted
- `perk_legend_entice` -> deleted
- `perk_legend_revolt` -> deleted
- `legend_field_repairs_skill` -> deleted
- `perk_legend_field_repairs` -> deleted
- `perk_legend_bribe` -> deleted
- `perk_legend_danger_pay` -> deleted
- `perk_legend_field_treats` -> deleted
- `legend_field_treats_skill` -> deleted
- `legend_bribe_skill` -> deleted
- `legend_danger_pay_skill` -> deleted
- `legend_harvest_tree_skill` -> deleted
- `legend_harvest_rock_skill` -> deleted
- `legend_harvest_bush_skill` -> deleted
- `legend_hex_skill` -> deleted
- `perk_legend_hex` -> deleted
- `legend_horrific_scream` -> deleted
- `legend_horrify_old_skill` -> deleted
- `perk_legend_magic_burning_hands` -> deleted
- `legend_magic_burning_hands` -> deleted
- `perk_legend_levitation` -> deleted
- `legend_levitate_person_skill` -> deleted
- `legend_magic_chain_lightning_skill` -> deleted
- `perk_legend_magic_chain_lightning` -> deleted
- `legend_magic_circle_of_protection_skill` -> deleted
- `perk_legend_magic_circle_of_protection` -> deleted
- `perk_legend_magic_hailstone` -> deleted
- `legend_magic_hailstone_skill` -> deleted
- `legend_magic_healing_wind_skill` -> deleted
- `perk_legend_magic_healing_wind` -> deleted
- `legend_magic_imbue_skill` -> deleted
- `perk_legend_magic_imbue` -> deleted
- `legend_magic_levitate_skill` -> deleted
- `perk_legend_magic_levitate` -> deleted
- `perk_legend_prepare_bleed` -> deleted
- `perk_legend_prepare_graze` -> deleted
- `legend_prepare_bleed_skill` -> deleted
- `legend_prepare_bleed_skill` -> deleted
- `legend_ranged_lash_skill` -> deleted
- `legend_ranged_flail_skill` -> deleted
- `legend_blowgun` -> deleted
- `legend_attack_target_skill` -> deleted
- `legend_protect_target_skill` -> deleted
- `legend_raise_undead_skill` -> deleted
- `legend_redback_puncture_skill` -> deleted
- `legend_relax_skill` -> deleted
- `legend_ritual_abstract_skill` -> deleted
- `legend_shadow_alp_teleport_skill` -> deleted
- `legend_shadows_skill` -> deleted
- `legend_shoot_dart_skill` -> deleted
- `legend_sleep_skill` -> deleted
- `legend_slingstaff_bash_skill` -> deleted
- `legend_spawn_skeleton_high_archer_skill` -> deleted
- `legend_spawn_skeleton_high_skill` -> deleted
- `legend_spawn_skeleton_low_archer_skill` -> deleted
- `legend_spawn_skeleton_low_skill` -> deleted
- `legend_spawn_skeleton_med_archer_skill` -> deleted
- `legend_spawn_skeleton_med_skill` -> deleted
- `legend_sprint_skill` -> deleted
- `legend_sprint_skill_4` -> deleted
- `legend_sprint_skill_5` -> deleted
- `legend_necro_background` -> deleted
- `perk_legend_relax` -> deleted
- `perk_legend_sleep` -> deleted
- `perk_legend_spawn_skeleton_high` -> deleted
- `perk_legend_spawn_skeleton_low` -> deleted
- `perk_legend_spawn_skeleton_med` -> deleted
- `legends_skeleton_high`
- `legends_skeleton_high_archer`
- `legends_skeleton_low`
- `legends_skeleton_low_archer`
- `legends_skeleton_med`
- `legends_skeleton_med_archer`
- `legend_read_omens_trance_skill`
- `legend_scry_trance_skill`
- `legend_spawn_skill`
- `legend_staff_riposte_skill`
- `legend_stealth_skill`
- `legend_teleport_skill`
- `legend_trance_abstract_skill`
- `legend_wake_ally_aoe_skill`
- `legend_wither_skill`
- `legend_wooden_stake_stab_skill`
- `perk_legend_infectious_rage`
- `perk_legend_read_omens_trance`
- `perk_legend_scry_trance`
- `perk_legend_teleport`
