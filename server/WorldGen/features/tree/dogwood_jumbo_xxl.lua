local dogwood_jumbo_xxl = {
    main = {
        {
          {"$any",     "$subbiome", "$subbiome", "$subbiome", "$any"     },
          {"$subbiome", "$subbiome", "$subbiome", "$subbiome", "$subbiome" },
          {"$subbiome", "$subbiome", "e_dogwoodJUMBOXXL_1_0", "$subbiome", "$subbiome"},
          {"$subbiome", "$subbiome", "$subbiome", "$subbiome", "$subbiome" },
          {"$any",     "$subbiome", "$subbiome", "$subbiome", "$any"     },
        },
    }
}
worldgen.features.TREE["dogwood_jumbo_xxl"] = dogwood_jumbo_xxl
