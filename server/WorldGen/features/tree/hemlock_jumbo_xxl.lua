local hemlock_jumbo_xxl = {
    main = {
        {
          {"$any",     "$subbiome", "$subbiome", "$subbiome", "$any"     },
          {"$subbiome", "$subbiome", "$subbiome", "$subbiome", "$subbiome" },
          {"$subbiome", "$subbiome", "e_canadianhemlockJUMBOXXL_1_0", "$subbiome", "$subbiome"},
          {"$subbiome", "$subbiome", "$subbiome", "$subbiome", "$subbiome" },
          {"$any",     "$subbiome", "$subbiome", "$subbiome", "$any"     },
        },
    }
}
worldgen.features.TREE["hemlock_jumbo_xxl"] = hemlock_jumbo_xxl
