# heatmap function for zscores
draw_zheatmap <- function(data, markers, cluster_column, column_order = NULL) {
  data_long <- data[, c(markers, cluster_column)] %>%
    pivot_longer(cols = -c(!!sym(cluster_column)), names_to = 'marker', values_to = 'value') %>%
    group_by(marker, !!sym(cluster_column)) %>%
    summarise(mu = mean(value))
  
  data_mean <- data[, c(markers, cluster_column)] %>%
    pivot_longer(cols = -c(!!sym(cluster_column)), names_to = 'marker', values_to = 'value') %>%
    group_by(marker) %>%
    summarise(pop_mean = mean(value),
              pop_sd = sd(value))
  
  data_long <- data_long %>%
    ungroup() %>%
    mutate(pop_mean = data_mean$pop_mean[match(data_long$marker, data_mean$marker)],
           pop_sd = data_mean$pop_sd[match(data_long$marker, data_mean$marker)]) %>%
    mutate(z = (mu - pop_mean) / pop_sd)
  
  data_heatmap <- data_long %>%
    dplyr::select(z, !!sym(cluster_column), marker) %>%
    pivot_wider(names_from = 'marker', values_from = 'z')
  
  data_mat <- t(as.matrix(data_heatmap[, -1]))
  
  colnames(data_mat) <- data_heatmap %>% pull(!!sym(cluster_column))
  
  col_fun = colorRamp2(c(-2, 0, 2), c('#4575b4', "white", '#d73027'))
  
  df_bar_vec <- data %>%
    group_by(!!sym(cluster_column)) %>%
    dplyr::count()
  
  df_column_ha <- HeatmapAnnotation(count = anno_barplot(df_bar_vec$n))
  
  p <- Heatmap(data_mat, cluster_rows = FALSE, col = col_fun, name = 'Z Score', clustering_method_columns = 'complete',
               row_names_side = 'left', top_annotation = df_column_ha, cluster_columns = FALSE, column_order = column_order)
  
  return(p)
}

# function for mean expression heatmap
draw_muheatmap <- function(data, markers, cluster_column) {
  data_long <- data[, c(markers, cluster_column)] %>%
    pivot_longer(cols = -c(!!sym(cluster_column)), names_to = 'marker', values_to = 'value') %>%
    group_by(marker, !!sym(cluster_column)) %>%
    summarise(mu = mean(value))
  
  data_heatmap <- data_long %>%
    dplyr::select(mu, !!sym(cluster_column), marker) %>%
    pivot_wider(names_from = 'marker', values_from = 'mu')
  
  data_mat <- t(as.matrix(data_heatmap[, -1]))
  
  colnames(data_mat) <- data_heatmap %>% pull(!!sym(cluster_column))
  
  col_fun = colorRamp2(c(0, 1), c("white", muted('red')))
  
  df_bar_vec <- data %>%
    group_by(!!sym(cluster_column)) %>%
    dplyr::count()
  
  df_column_ha <- HeatmapAnnotation(count = anno_barplot(df_bar_vec$n))
  
  p <- Heatmap(data_mat, cluster_rows = FALSE, col = col_fun, name = 'Mu', clustering_method_columns = 'complete',
               row_names_side = 'left', top_annotation = df_column_ha, cluster_columns = FALSE)
  
  return(p)
}

# function for violin boxplot of cluster expression
draw_violin <- function(data, markers, celltype) {
  data %>% 
    dplyr::filter(cellType == celltype) %>%
    dplyr::select(all_of(c("cellType", all_markers))) %>%
    pivot_longer(!cellType, names_to = "marker", values_to = "value") %>%
    ggplot(aes(x = marker, y = value)) +
    geom_violin()
}


# function to write csvs for qupath boxscripts
write_qupathCSV <- function(data, cluster_column, filepath) {
  csv <- data %>%
    dplyr::select(c(X_cent, Y_cent, !!sym(cluster_column))) %>%
    mutate(pointNum = 1) %>% # only one point number
    mutate_if(is.factor, as.numeric)
  write.csv(csv, filepath)
}

write_mantisCSV <- function(data, col, filepath) {
  csv <- data %>%
    dplyr::select(c(path, cellLabel, !!sym(col)))
  write.table(csv, file = filepath, sep=",",  col.names=FALSE, row.names = F)
}

# func for pulling out region/cell count for each cluster
### i.e. pull_counts(all_data, "FSOM1", 1)
pull_counts <- function(df, cluster_column, cluster_number) {
  df %>%
    filter(!!sym(cluster_column) == cluster_number) %>%
    group_by(RegionID) %>%
    summarise(count = n()) %>%
    left_join(., codex_mdata[, c("RegionID", "Type")], by = "RegionID") %>%
    ggplot(aes(x = reorder(RegionID, count, decreasing = TRUE), y = count, fill = Type)) +
    geom_col() +
    labs(x = "RegionID", title = paste0("PG Cluster ", cluster_number)) +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
}