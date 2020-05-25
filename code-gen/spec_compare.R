
s1 <- jsonlite::fromJSON("code-gen/specs/spec_1.3.4.json", simplifyVector = FALSE)
s2 <- jsonlite::fromJSON("code-gen/specs/spec_1.4.0.json", simplifyVector = FALSE)

sort(sapply(s1$HoverTool$props, "[[", "name"))
sort(sapply(s2$HoverTool$props, "[[", "name"))

digest::digest(sort(sapply(s1$HoverTool$props, "[[", "name")))
digest::digest(sort(sapply(s2$HoverTool$props, "[[", "name")))

setdiff(names(s1), names(s2))

setdiff(names(s2), names(s1))
#  [1] "HTMLBox"                  "DataCube"                
#  [3] "WebSource"                "GroupingInfo"            
#  [5] "FileInput"                "MaxAggregator"           
#  [7] "HArea"                    "Texture"                 
#  [9] "AvgAggregator"            "ImageURLTexture"         
# [11] "Spinner"                  "GridBox"                 
# [13] "SumAggregator"            "MinAggregator"           
# [15] "CategoricalPatternMapper" "VArea"                   
# [17] "TextAreaInput"            "ColorPicker"             
# [19] "CanvasTexture"            "ServerSentDataSource"    
# [21] "RowAggregator" 

library(digest)

for (nm in names(s1)) {
  if(digest(s1[[nm]]$bases) != digest(s2[[nm]]$bases))
    message(nm, ": bases do not match")
}

# Panel: bases do not match
# AbstractIcon: bases do not match
# Tabs: bases do not match
# WidgetBox: bases do not match
# RemoteSource: bases do not match

for (nm in names(s1)) {
  s1d <- digest(sort(sapply(s1[[nm]]$props, "[[", "name")))
  s2d <- digest(sort(sapply(s2[[nm]]$props, "[[", "name")))
  if(s1d != s2d)
    message(nm, ": prop names do not match")
}

# GMapPlot: prop names do not match
# MercatorAxis: prop names do not match
# Annotation: prop names do not match
# Title: prop names do not match
# Plot: prop names do not match
# LinearAxis: prop names do not match
# MapPlot: prop names do not match
# Grid: prop names do not match
# BoxAnnotation: prop names do not match


## should be using:
# Patches: prop names do not match
# Slope: prop names do not match
# LayoutDOM: prop names do not match
# Quad: prop names do not match


# ToolbarBox: prop names do not match
# AbstractSlider: prop names do not match
# Slider: prop names do not match
# DateSlider: prop names do not match
# VeeHead: prop names do not match
# ToolbarPanel: prop names do not match
# DatePicker: prop names do not match
# Tooltip: prop names do not match
# Button: prop names do not match
# Panel: prop names do not match
# Column: prop names do not match
# CheckboxButtonGroup: prop names do not match
# RadioGroup: prop names do not match
# GuideRenderer: prop names do not match
# Select: prop names do not match
# TextInput: prop names do not match
# OpenURL: prop names do not match
# AutocompleteInput: prop names do not match
# AbstractIcon: prop names do not match
# TeeHead: prop names do not match
# Markup: prop names do not match
# Paragraph: prop names do not match
# ButtonGroup: prop names do not match
# CategoricalAxis: prop names do not match
# PasswordInput: prop names do not match
# Whisker: prop names do not match
# Tabs: prop names do not match
# ColorBar: prop names do not match
# LogAxis: prop names do not match
# RangeSlider: prop names do not match
# Patch: prop names do not match
# AbstractButton: prop names do not match
# Group: prop names do not match
# ArrowHead: prop names do not match
# DatetimeAxis: prop names do not match
# VBar: prop names do not match
# PolyAnnotation: prop names do not match
# Span: prop names do not match
# LabelSet: prop names do not match
# WidgetBox: prop names do not match
# PreText: prop names do not match
# Toggle: prop names do not match
# OpenHead: prop names do not match
# MultiSelect: prop names do not match
# DataRenderer: prop names do not match
# HBar: prop names do not match
# RadioButtonGroup: prop names do not match
# TextAnnotation: prop names do not match
# Axis: prop names do not match
# InputWidget: prop names do not match
# Widget: prop names do not match
# MultiPolygons: prop names do not match
# RemoteSource: prop names do not match
# Band: prop names do not match
# Div: prop names do not match
# Row: prop names do not match
# DateRangeSlider: prop names do not match
# Spacer: prop names do not match
# Dropdown: prop names do not match
# CheckboxGroup: prop names do not match
# TableWidget: prop names do not match
# Label: prop names do not match
# DataTable: prop names do not match
# Box: prop names do not match
# AbstractGroup: prop names do not match
# ContinuousAxis: prop names do not match
# Legend: prop names do not match
# NormalHead: prop names do not match
# Arrow: prop names do not match

nm <- "ToolbarBox"
sort(sapply(s1[[nm]]$props, "[[", "name"))
#  [1] "css_classes"           "disabled"              "height"               
#  [4] "js_event_callbacks"    "js_property_callbacks" "name"                 
#  [7] "sizing_mode"           "subscribed_events"     "tags"                 
# [10] "toolbar"               "toolbar_location"      "width"                
sort(sapply(s2[[nm]]$props, "[[", "name"))
#  [1] "align"                 "aspect_ratio"          "background"           
#  [4] "css_classes"           "disabled"              "height"               
#  [7] "height_policy"         "js_event_callbacks"    "js_property_callbacks"
# [10] "margin"                "max_height"            "max_width"            
# [13] "min_height"            "min_width"             "name"                 
# [16] "sizing_mode"           "subscribed_events"     "tags"                 
# [19] "toolbar"               "toolbar_location"      "visible"              
# [22] "width" 

nm <- "BoxAnnotation"
prps1 <- sort(sapply(s1[[nm]]$props, "[[", "name"))
prps2 <- sort(sapply(s2[[nm]]$props, "[[", "name"))
setdiff(prps1, prps2)
# [1] "plot"
setdiff(prps2, prps1)
# character(0)

nm <- "Legend"
prps1 <- sort(sapply(s1[[nm]]$props, "[[", "name"))
prps2 <- sort(sapply(s2[[nm]]$props, "[[", "name"))
setdiff(prps1, prps2)
# plot
setdiff(prps2, prps1)
#  [1] "title"                  "title_standoff"         "title_text_align"      
#  [4] "title_text_alpha"       "title_text_baseline"    "title_text_color"      
#  [7] "title_text_font"        "title_text_font_size"   "title_text_font_style" 
# [10] "title_text_line_height"

## these are the ones we use
# GMapPlot$new(plot_height = height, plot_width = width,
# CustomJS$new(code = pars$callback)
# ColumnDataSource$new(
# GlyphRenderer$new(
# ColumnDataSource$new(
# LinearScale$new()
# LinearScale$new()
# Range1d$new()
# CustomJS$new(code = args$callback)
# Range1d$new(start = lims[1], end = lims[2])
# Range1d$new()
# LogScale$new()
# LinearScale$new()
# CategoricalScale$new()
# LinearScale$new()
# CustomJS$new(code = cur$mod$callback)
# Toolbar$new(
# ColumnDataSource$new()
# LegendItem$new(label = name))
# GlyphRenderer$new(glyph = glph_mod$get_instance(),
# LegendItem$new(label = labels[i],

