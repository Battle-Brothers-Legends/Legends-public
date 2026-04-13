foreach( i, v in ::Const.LegendMod.ArmorObjs)
	::Const.LegendMod.Armors[v.ID] <- v;

foreach (i, v in ::Const.LegendMod.HelmObjs)
	::Const.LegendMod.Helmets[v.ID] <- v;

foreach (i, v in ::Const.LegendMod.OutfitObjs)
	::Const.LegendMod.Outfits[v.ID] <- v;
