::Legends.GatheringLoot <- {
    function getGenerator(_biome) {
        local generator = {
            Biome = _biome,
            Targets = {},

            function rollTarget(_allowedProfessions, _huntLevel = 0) {
                local pool = ::MSU.Class.WeightedContainer(null);

                foreach (profID in _allowedProfessions) {
                    if (!(profID in this.Targets)) {
						continue;
					}

                    foreach (target in this.Targets[profID]) {
                        local weight = target[0];
                        local targetDef = target[1];

						// check if we are good enough to hunt the beast
                        if (profID == ::Legends.Profession.LegendHunting) {
                            if (!::Legends.GatheringLoot.hasSufficientHuntingLevelForTier(_huntLevel, targetDef.Tier)) {
                                continue;
                            }
                        }

                        pool.add({ Def = targetDef, Prof = profID }, weight);
                    }
                }

                local roll = pool.roll();
                local targetDef = roll.Def;
                local extraLoot = "ExtraLoot" in targetDef ? ::MSU.Class.WeightedContainer(targetDef.ExtraLoot).roll() : "";

                return {
                    Name = targetDef.Name,
                    Difficulty = targetDef.Difficulty,
                    Loot = targetDef.Loot,
                    ExtraLoot = extraLoot != "" ? extraLoot : null,
                    Profession = roll.Prof
                };
            }
            
        };

        foreach (profID, targetsArray in ::Legends.GatheringLoot.Biomes[_biome]) {
            generator.Targets[profID] <- targetsArray;
        }

        return generator;
    }

	function hasSufficientHuntingLevelForTier(_huntingLevel, _tier) {
		return ::Math.floor(_huntingLevel / 7) >= _tier;
	}
};

::Legends.GatheringLoot.CampGatheringMode <- {
	Foraging = true,
	Hunting = true,
	Mining = true,
	Woodcutting = true
}; // Tooltips are defined in CampGatheringMode in tooltips.nut
