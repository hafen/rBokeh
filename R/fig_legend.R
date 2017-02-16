# to add a legend:
# - create a legend model
#   - add a model reference
#   - add a list of legend items

# individual legend items are lists with a label
# and a list of glyph_renderers that the legend
# entry refers to

## these are all internal functions called from make_glyph
## legends are specified through the various layer functions

add_legend <- function(fig, items, extra_pars) {
  leg_id <- gen_id(fig, "legend")
  leg_name <- "legend"

  litems <- list()
  for (ii in seq_along(items)) {
    it <- items[[ii]]
    legitem_id <- gen_id(fig, paste0("legenditem", it[[1]]))
    legitem <- legend_item_model(legitem_id, it[[1]], it[[2]])
    fig$x$spec$model[[legitem_id]] <- legitem$model
    litems[[ii]] <- legitem$ref
  }

  leg <- legend_model(leg_id, fig$x$spec$ref, litems, extra_pars)

  fig$x$spec$model$plot$attributes$renderers[[leg_id]] <- leg$ref
  fig$x$spec$model[[leg_name]] <- leg$model

  fig
}

legend_model <- function(id, plot_ref, items, extra_pars) {
  res <- base_model_object("Legend", id)
  res$model$attributes$plot <- plot_ref
  res$model$attributes$items <- items

  res$model$attributes <- c(res$model$attributes, extra_pars)

  res
}

legend_item_model <- function(id, label, renderers, name = NULL) {
  res <- base_model_object("LegendItem", id)
  res$model$attributes$name <- name
  res$model$attributes$label <- list(value = label)
  res$model$attributes$renderers <- renderers

  res
}

legend_par_validator_map <- list(
  "location" = "legend_orientation",
  "background_fill_alpha" = "num_data_spec",
  "background_fill_color" = "color",
  "border_line_alpha" = "num_data_spec",
  "border_line_cap" = "line_cap",
  "border_line_color" = "color",
  "border_line_dash" = "line_dash",
  "border_line_dash_offset" = "int",
  "border_line_join" = "line_join",
  "border_line_width" = "num_data_spec",
  "glyph_height" = "int",
  "glyph_width" = "int",
  "label_height" = "int",
  "label_standoff" = "int",
  "label_text_align" = "text_align",
  "label_text_alpha" = "num_data_spec",
  "label_text_baseline" = "text_baseline",
  "label_text_color" = "color",
  "label_text_font" = "string",
  "label_text_font_size" = "font_size_string",
  "label_text_font_style" = "font_style",
  "label_width" = "int",
  "legend_padding" = "int",
  "legend_spacing" = "int"
)
