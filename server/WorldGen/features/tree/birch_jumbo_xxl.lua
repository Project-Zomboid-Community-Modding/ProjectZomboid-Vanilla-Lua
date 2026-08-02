local birch_jumbo_xxl = {
    main = {
        {
          {"$any",     "$subbiome", "$subbiome", "$subbiome", "$any"     },
          {"$subbiome", "$subbiome", "$subbiome", "$subbiome", "$subbiome" },
          {"$subbiome", "$subbiome", "e_riverbirchJUMBOXXL_1_0", "$subbiome", "$subbiome"},
          {"$subbiome", "$subbiome", "$subbiome", "$subbiome", "$subbiome" },
          {"$any",     "$subbiome", "$subbiome", "$subbiome", "$any"     },
        },
    }
}
worldgen.features.TREE["birch_jumbo_xxl"] = birch_jumbo_xxl
