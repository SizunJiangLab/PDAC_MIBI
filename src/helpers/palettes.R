# celltype color palette
annot_palette <- c('B' = '#E5C494', 
                   'CD4' = '#A65628', 
                   'CD8' = '#F781BF',
                   'Endothelial' = '#E41A1C', 
                   'Epithelial' = '#8DA0CB',
                   'Lymphatic' = '#FFD92F', 
                   'M1-Like Mac' = '#115D52', 
                   'M2-Like Mac' = '#FF7F00', 
                   'Monocyte' = '#984EA3', 
                   'Neuronal' = '#4DAF4A', 
                   'Neutrophil' = '#FC8D62', 
                   'NK' = '#FFFF33',
                   'Plasmablast' = '#66C2A5', 
                   'Treg' = '#A6D854', 
                   'Tumor' = '#A1DEF0',
                   'Other' = '#999999')

nbhd_palette <- c('Neuronal' = '#4f8c9d',
                  'Immune Rich' = '#bbcf7a',
                  'Immune Suppressive' = '#ca94fd',
                  'Endothelial' = '#b85d46',
                  'B Cell Enriched' = '#214d4e',
                  'Tumor' = '#f5a683',
                  'Epithelial' = '#473c85',
                  'Active Immune' = '#5be13e')

relapse_palette <- c('Y' = 'darkorange2',
                     'N' = 'lightsteelblue')

# list of study markers
all_markers <- read_delim('helpers/all_markers.txt', delim = '\n', col_names = F) %>% dplyr::pull(X1)
phenotyping_markers <- read_delim('helpers/phenotyping_markers.txt', delim = '\n', col_names = F) %>% dplyr::pull(X1)
functional_markers <- setdiff(all_markers, phenotyping_markers)
