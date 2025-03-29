#########################################################
# This R script is created to generate cell type plot.
# It takes 5 mandatory arguments
# point_num: int. Point number in the TMA
# seg_list: list. A list of segmentation matrices 
# annotation: character. Cell type annotation specific for
# the point number
# cell_label: int. Cell label in image specific for the 
# point number.
# mypalette: df. Color palette should come in as a data 
# frame with two columns, celltype and color. 
# Optional arguments:
# verbose: if True, cat plot i completed.
# out: if True, output to tiff file.
# out_path: path to the tiff.
#########################################################
# modified 2023-01-20 by JY
# add tile names to plots

celltype_plot <- function(point_num, fov_name, seg_list, annotation, cell_label, legend_ncols, mypalette, verbose = FALSE, out = FALSE, format, out_path = NULL, print_fig = FALSE){
  require(reshape2)
  require(purrr)
  require(ggplot2)
  require(dplyr)
  require(tidyr)
  # Get segmentation matrix
  seg_mat <- seg_list[[point_num]]
  fov_name <- fov_name
  # Get cell types for this point. Stored as a list
  cell_type <- as.list(unique(annotation))
  # Store cell label of each cell type in a list
  type_label_LUT <- map(cell_type, function(x){
    cell_label[annotation == x]
  })
  # Name list by cell type
  names(type_label_LUT) <- unique(annotation)
  # Reshape segmentation matrix and add a column called pixel type
  mat_long <- melt(seg_mat)
  mat_long <- mat_long %>% 
    mutate(pixel_type = rep(NA, nrow(mat_long)))
  # Fill in pixel type by cell type
  for (i in 1:length(unique(annotation))){
    mat_long$pixel_type[mat_long$value %in% type_label_LUT[[i]]] <- unique(annotation)[i]
  }
  # Match cell type and color to make sure color is uniform across the board
  color <- mypalette$color[match(unique(annotation), mypalette$celltype)]
  # Plot 
  p <- ggplot()+
    geom_raster(data = mat_long, aes(x = Var2, y = Var1, fill = pixel_type)) + 
    scale_fill_manual('Cell Types', breaks = unique(annotation), values = color, na.value = 'white') +
    # guides(fill = guide_legend(ncol = legend_ncols)) +
    guides(fill = 'none') +
    # labs(title = paste0('PointNum ', point_num),
    #      subtitle = fov_name) + 
    scale_y_continuous(expand = c(0, 0)) +
    scale_x_continuous(expand = c(0, 0)) +
    theme(axis.title = element_blank(),
          axis.ticks = element_blank(),
          axis.line = element_blank(),
          axis.text = element_blank(),
          legend.title = element_text(face = 'bold'),
          legend.text = element_text(face = 'bold', size = 12),
          panel.background = element_blank(),
          panel.grid = element_blank(),
          plot.margin = margin(0, 0, 0, 0, 'mm'),
          plot.background = element_rect(color = 'white'),
          axis.ticks.length = unit(0, 'pt'),
          legend.position = 'bottom') +
    coord_fixed()
  # Show plot
  if (verbose){
    cat('Plot for PointNum ', point_num, ': ', fov_name, ' completed. \n')
  }
  if (out){
    if (format == 'tiff') {
      ggsave(filename = paste0(out_path,  fov_name, '.tiff'), plot = p, device = 'tiff', 
             height = dim(seg_mat)[1], width = dim(seg_mat)[2], units = 'px', 
             dpi = 320)
    } else if (format == 'png') {
      ggsave(filename = paste0(out_path,  fov_name, '.png'), plot = p, device = 'png', height = 10, width = 12, units = 'in', dpi = 320)
    } else if (format == 'pdf') {
      ggsave(filename = paste0(out_path,  fov_name, '.pdf'), plot = p, device = 'pdf', height = dim(seg_mat)[1], width = dim(seg_mat)[2],
             units = 'px')
    } 
  }
  if (print_fig){
    print(p)
  }
}
