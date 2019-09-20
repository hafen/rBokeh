# Base class for all objects stored in Bokeh |Document| instances.
Model <- R6::R6Class("Model",
  inherit = Base,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(id = id)
      types <- bk_prop_types[["Model"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # List of events that are subscribed to by Python callbacks. This is the
    # set of events that will be communicated from BokehJS back to Python for
    # this model.
    # > List(String)
    subscribed_events = NULL,
    # A mapping of attribute names to lists of ``CustomJS`` callbacks, to be
    # set up on BokehJS side when the document is created.
    # 
    # Typically, rather then modifying this property directly, callbacks
    # should be added using the ``Model.js_on_change`` method:
    # 
    # .. code:: python
    # 
    # callback = CustomJS(code="console.log('stuff')")
    # plot.x_range.js_on_change('start', callback)
    # > Dict(String, List(Instance(CustomJS)))
    js_property_callbacks = NULL,
    # An optional list of arbitrary, user-supplied values to attach to this
    # model.
    # 
    # This data can be useful when querying the document to retrieve specific
    # Bokeh models:
    # 
    # .. code:: python
    # 
    # >>> r = plot.circle([1,2,3], [4,5,6]) >>> r.tags = ["foo", 10] >>>
    # plot.select(tags=['foo', 10])
    # [GlyphRenderer(id='1de4c3df-a83d-480a-899b-fb263d3d5dd9', ...)]
    # 
    # Or simply a convenient way to attach any necessary metadata to a model
    # that can be accessed by ``CustomJS`` callbacks, etc.
    # 
    # .. note:: No uniqueness guarantees or other conditions are enforced on
    # any tags that are provided, nor are the tags used directly by Bokeh for
    # any reason.
    # > List(Any)
    tags = NULL,
    # An arbitrary, user-supplied name for this model.
    # 
    # This name can be useful when querying the document to retrieve specific
    # Bokeh models.
    # 
    # .. code:: python
    # 
    # >>> plot.circle([1,2,3], [4,5,6], name="temp") >>>
    # plot.select(name="temp")
    # [GlyphRenderer(id='399d53f5-73e9-44d9-9527-544b761c7705', ...)]
    # 
    # .. note:: No uniqueness guarantees or other conditions are enforced on
    # any names that are provided, nor is the name used directly by Bokeh for
    # any reason.
    # > String
    name = NULL,
    # A mapping of event names to lists of ``CustomJS`` callbacks.
    # 
    # Typically, rather then modifying this property directly, callbacks
    # should be added using the ``Model.js_on_event`` method:
    # 
    # .. code:: python
    # 
    # callback = CustomJS(code="console.log('tap event occurred')")
    # plot.js_on_event('tap', callback)
    # > Dict(String, List(Instance(CustomJS)))
    js_event_callbacks = NULL
  )
)

# Abstract base class for groups with items rendered as buttons.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
ButtonGroup <- R6::R6Class("ButtonGroup",
  inherit = AbstractGroup,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", disabled = FALSE,
      callback = NULL, background = NULL, button_type = "default",
      tags = list(), visible = TRUE, width_policy = "auto",
      height_policy = "auto", height = NULL, name = NULL, sizing_mode = NULL,
      labels = list(), default_size = 300L, max_height = NULL,
      css_classes = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), orientation = "horizontal",
      js_event_callbacks = structure(list(), .Names = character(0)),
      min_height = NULL, subscribed_events = list(), width = NULL,
      aspect_ratio = NULL, margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, callback = callback,
        background = background, tags = tags, visible = visible,
        width_policy = width_policy, height_policy = height_policy,
        height = height, name = name, sizing_mode = sizing_mode,
        labels = labels, default_size = default_size,
        max_height = max_height, css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["ButtonGroup"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A style for the button, signifying it's role.
    # > Enum('default', 'primary', 'success', 'warning', 'danger')
    button_type = NULL
  )
)

# Calendar-based date cell editor.
DateEditor <- R6::R6Class("DateEditor",
  inherit = CellEditor,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["DateEditor"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# A base class for all tick formatter types.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
TickFormatter <- R6::R6Class("TickFormatter",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["TickFormatter"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Generate ticks spaced apart even numbers of years.
YearsTicker <- R6::R6Class("YearsTicker",
  inherit = SingleIntervalTicker,
  public = list(
    specified_args = NULL,
    initialize = function(
      desired_num_ticks = 6L, interval = NULL,
      js_property_callbacks = structure(list(), .Names = character(0)),
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), name = NULL,
      num_minor_ticks = 5L, id = NULL
    ) {
      super$initialize(desired_num_ticks = desired_num_ticks,
        interval = interval, js_property_callbacks = js_property_callbacks,
        tags = tags, js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name,
        num_minor_ticks = num_minor_ticks, id = id)
      types <- bk_prop_types[["YearsTicker"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Select cell editor.
SelectEditor <- R6::R6Class("SelectEditor",
  inherit = CellEditor,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), options = list(), js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["SelectEditor"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The list of options to select from.
    # > List(String)
    options = NULL
  )
)

# A base class for Mercator tile services (e.g. ``WMTSTileSource``).
MercatorTileSource <- R6::R6Class("MercatorTileSource",
  inherit = TileSource,
  public = list(
    specified_args = NULL,
    initialize = function(
      js_property_callbacks = structure(list(), .Names = character(0)),
      tile_size = 256L, extra_url_vars = structure(list(), .Names =
      character(0)), snap_to_zoom = FALSE, url = "",
      initial_resolution = 156543.033928041, x_origin_offset = 20037508.34,
      attribution = "", y_origin_offset = 20037508.34, max_zoom = 30L,
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), name = NULL, min_zoom = 0L,
      wrap_around = TRUE, id = NULL
    ) {
      super$initialize(js_property_callbacks = js_property_callbacks,
        tile_size = tile_size, extra_url_vars = extra_url_vars,
        min_zoom = min_zoom, initial_resolution = initial_resolution,
        x_origin_offset = x_origin_offset, attribution = attribution,
        y_origin_offset = y_origin_offset, max_zoom = max_zoom, tags = tags,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name, url = url, id = id)
      types <- bk_prop_types[["MercatorTileSource"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Forces initial extents to snap to the closest larger zoom level.
    # > Bool
    snap_to_zoom = NULL,
    # Enables continuous horizontal panning by wrapping the x-axis based on
    # bounds of map.
    # 
    # ..note:: Axis coordinates are not wrapped. To toggle axis label
    # visibility, use ``plot.axis.visible = False``.
    # > Bool
    wrap_around = NULL
  )
)

# Date cell formatter.
DateFormatter <- R6::R6Class("DateFormatter",
  inherit = CellFormatter,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      format = "ISO-8601", name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["DateFormatter"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The date format can be any standard `strftime`_ format string, as well
    # as any of the following predefined format names:
    # 
    # ================================================ ==================
    # =================== Format name(s) Format string Example Output
    # ================================================ ==================
    # =================== ``ATOM`` / ``W3C`` / ``RFC-3339`` / ``ISO-8601``
    # ``"%Y-%m-%d"`` 2014-03-01 ``COOKIE`` ``"%a, %d %b %Y"`` Sat, 01 Mar
    # 2014 ``RFC-850`` ``"%A, %d-%b-%y"`` Saturday, 01-Mar-14 ``RFC-1123`` /
    # ``RFC-2822`` ``"%a, %e %b %Y"`` Sat, 1 Mar 2014 ``RSS`` / ``RFC-822`` /
    # ``RFC-1036`` ``"%a, %e %b %y"`` Sat, 1 Mar 14 ``TIMESTAMP`` (ms since
    # epoch) 1393632000000 ================================================
    # ================== ===================
    # 
    # Note that in the table some of the format names are synonymous, with
    # identical format names separated by slashes.
    # 
    # This list of supported `strftime`_ format codes is reproduced below.
    # 
    # %a The abbreviated name of the day of the week according to the current
    # locale.
    # 
    # %A The full name of the day of the week according to the current
    # locale.
    # 
    # %b The abbreviated month name according to the current locale.
    # 
    # %B The full month name according to the current locale.
    # 
    # %c The preferred date and time representation for the current locale.
    # 
    # %C The century number (year/100) as a 2-digit integer.
    # 
    # %d The day of the month as a decimal number (range 01 to 31).
    # 
    # %D Equivalent to %m/%d/%y.  (Americans should note that in many other
    # countries %d/%m/%y is rather common. This means that in international
    # context this format is ambiguous and should not be used.)
    # 
    # %e Like %d, the day of the month as a decimal number, but a leading
    # zero is replaced by a space.
    # 
    # %f Microsecond as a decimal number, zero-padded on the left (range
    # 000000-999999). This is an extension to the set of directives available
    # to `timezone`_.
    # 
    # %F Equivalent to %Y-%m-%d (the ISO 8601 date format).
    # 
    # %G The ISO 8601 week-based year with century as a decimal number.  The
    # 4-digit year corresponding to the ISO week number (see %V).  This has
    # the same format and value as %Y, except that if the ISO week number
    # belongs to the previous or next year, that year is used instead.
    # 
    # %g Like %G, but without century, that is, with a 2-digit year (00-99).
    # 
    # %h Equivalent to %b.
    # 
    # %H The hour as a decimal number using a 24-hour clock (range 00 to 23).
    # 
    # %I The hour as a decimal number using a 12-hour clock (range 01 to 12).
    # 
    # %j The day of the year as a decimal number (range 001 to 366).
    # 
    # %k The hour (24-hour clock) as a decimal number (range 0 to 23).
    # Single digits are preceded by a blank.  (See also %H.)
    # 
    # %l The hour (12-hour clock) as a decimal number (range 1 to 12).
    # Single digits are preceded by a blank.  (See also %I.)  (TZ)
    # 
    # %m The month as a decimal number (range 01 to 12).
    # 
    # %M The minute as a decimal number (range 00 to 59).
    # 
    # %n A newline character. Bokeh text does not currently support newline
    # characters.
    # 
    # %N Nanosecond as a decimal number, zero-padded on the left (range
    # 000000000-999999999). Supports a padding width specifier, i.e.  %3N
    # displays 3 leftmost digits. However, this is only accurate to the
    # millisecond level of precision due to limitations of `timezone`_.
    # 
    # %p Either "AM" or "PM" according to the given time value, or the
    # corresponding strings for the current locale.  Noon is treated as "PM"
    # and midnight as "AM".
    # 
    # %P Like %p but in lowercase: "am" or "pm" or a corresponding string for
    # the current locale.
    # 
    # %r The time in a.m. or p.m. notation.  In the POSIX locale this is
    # equivalent to %I:%M:%S %p.
    # 
    # %R The time in 24-hour notation (%H:%M). For a version including the
    # seconds, see %T below.
    # 
    # %s The number of seconds since the Epoch, 1970-01-01 00:00:00 +0000
    # (UTC).
    # 
    # %S The second as a decimal number (range 00 to 60).  (The range is up
    # to 60 to allow for occasional leap seconds.)
    # 
    # %t A tab character. Bokeh text does not currently support tab
    # characters.
    # 
    # %T The time in 24-hour notation (%H:%M:%S).
    # 
    # %u The day of the week as a decimal, range 1 to 7, Monday being 1.  See
    # also %w.
    # 
    # %U The week number of the current year as a decimal number, range 00 to
    # 53, starting with the first Sunday as the first day of week 01.  See
    # also %V and %W.
    # 
    # %V The ISO 8601 week number (see NOTES) of the current year as a
    # decimal number, range 01 to 53, where week 1 is the first week that has
    # at least 4 days in the new year.  See also %U and %W.
    # 
    # %w The day of the week as a decimal, range 0 to 6, Sunday being 0.  See
    # also %u.
    # 
    # %W The week number of the current year as a decimal number, range 00 to
    # 53, starting with the first Monday as the first day of week 01.
    # 
    # %x The preferred date representation for the current locale without the
    # time.
    # 
    # %X The preferred time representation for the current locale without the
    # date.
    # 
    # %y The year as a decimal number without a century (range 00 to 99).
    # 
    # %Y The year as a decimal number including the century.
    # 
    # %z The +hhmm or -hhmm numeric timezone (that is, the hour and minute
    # offset from UTC).
    # 
    # %Z The timezone name or abbreviation.
    # 
    # %% A literal '%' character.
    # 
    # .. warning:: The client library BokehJS uses the `timezone`_ library to
    # format datetimes. The inclusion of the list below is based on the claim
    # that `timezone`_ makes to support "the full compliment of GNU date
    # format specifiers." However, this claim has not been tested
    # exhaustively against this list. If you find formats that do not
    # function as expected, please submit a `github issue`_, so that the
    # documentation can be updated appropriately.
    # 
    # .. _strftime: http://man7.org/linux/man-pages/man3/strftime.3.html ..
    # _timezone: http://bigeasy.github.io/timezone/ .. _github issue:
    # https://github.com/bokeh/bokeh/issues
    # > Either(Enum('ATOM', 'W3C', 'RFC-3339', 'ISO-8601', 'COOKIE', 'RFC-822', 'RFC-850', 'RFC-1036', 'RFC-1123', 'RFC-2822', 'RSS', 'TIMESTAMP'), String)
    format = NULL
  )
)

# Open a URL in a new or current tab or window.
OpenURL <- R6::R6Class("OpenURL",
  inherit = Callback,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), same_tab = FALSE, js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, url = "http://", id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["OpenURL"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Open URL in a new (`False`, default) or current (`True`) tab or window.
    # For `same_tab=False`, whether tab or window will be opened is browser
    # dependent.
    # > Bool
    same_tab = NULL,
    # The URL to direct the web browser to. This can be a template string,
    # which will be formatted with data from the data source.
    # > String
    url = NULL
  )
)

# A base class for tools that respond to drag events.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
Gesture <- R6::R6Class("Gesture",
  inherit = Tool,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Gesture"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Apply either a uniform or normally sampled random jitter to data.
Jitter <- R6::R6Class("Jitter",
  inherit = Transform,
  public = list(
    specified_args = NULL,
    initialize = function(
      mean = 0L, js_property_callbacks = structure(list(), .Names =
      character(0)), distribution = "uniform", range = NULL, tags = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), width = 1L, name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Jitter"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The central value for the random sample
    # > Float
    mean = NULL,
    # The random distribution upon which to pull the random scatter
    # > Enum('uniform', 'normal')
    distribution = NULL,
    # When applying Jitter to Categorical data values, the corresponding
    # ``FactorRange`` must be supplied as the ``range`` property.
    # > Instance(Range)
    range = NULL,
    # The width (absolute for uniform distribution and sigma for the normal
    # distribution) of the random sample.
    # > Float
    width = NULL
  )
)

# A component which size is determined by its HTML content.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
HTMLBox <- R6::R6Class("HTMLBox",
  inherit = LayoutDOM,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", disabled = FALSE,
      background = NULL, tags = list(), visible = TRUE, width_policy = "auto",
      height_policy = "auto", height = NULL, name = NULL, sizing_mode = NULL,
      max_height = NULL, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      js_event_callbacks = structure(list(), .Names = character(0)),
      min_height = NULL, subscribed_events = list(), width = NULL,
      aspect_ratio = NULL, margin = list(0L, 0L, 0L, 0L), id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, background = background,
        tags = tags, visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, name = name,
        sizing_mode = sizing_mode, max_height = max_height,
        css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        js_event_callbacks = js_event_callbacks, min_height = min_height,
        subscribed_events = subscribed_events, width = width,
        aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["HTMLBox"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Base class for arrow heads.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
ArrowHead <- R6::R6Class("ArrowHead",
  inherit = Annotation,
  public = list(
    specified_args = NULL,
    initialize = function(
      level = "annotation", tags = list(), visible = TRUE,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), name = NULL, id = NULL
    ) {
      super$initialize(level = level, tags = tags, visible = visible,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["ArrowHead"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Apply a custom defined transform to data.
# 
# .. warning:: The explicit purpose of this Bokeh Model is to embed *raw
# JavaScript code* for a browser to execute. If any part of the code is
# derived from untrusted user inputs, then you must take appropriate care
# to sanitize the user input prior to passing to Bokeh.
CustomJSTransform <- R6::R6Class("CustomJSTransform",
  inherit = Transform,
  public = list(
    specified_args = NULL,
    initialize = function(
      js_property_callbacks = structure(list(), .Names = character(0)),
      v_func = "", tags = list(), use_strict = FALSE,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), func = "", name = NULL,
      args = structure(list(), .Names = character(0)), id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["CustomJSTransform"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A snippet of JavaScript code to transform an array of values. The
    # variable ``xs`` will contain the untransformed array and can be
    # expected to be present in the function namespace at render time. The
    # snippet will be into the body of a function and therefore requires a
    # return statement.
    # 
    # Example:
    # 
    # .. code-block:: javascript
    # 
    # v_func = ''' var new_xs = new Array(xs.length) for(var i = 0; i <
    # xs.length; i++) { new_xs[i] = xs[i] + 0.5 } return new_xs '''
    # 
    # .. warning:: The vectorized function, ``v_func``, must return an array
    # of the same length as the input ``xs`` array.
    # > String
    v_func = NULL,
    # Enables or disables automatic insertion of ``"use strict";`` into
    # ``func`` or ``v_func``.
    # > Bool
    use_strict = NULL,
    # A snippet of JavaScript code to transform a single value. The variable
    # ``x`` will contain the untransformed value and can be expected to be
    # present in the function namespace at render time. The snippet will be
    # into the body of a function and therefore requires a return statement.
    # 
    # Example:
    # 
    # .. code-block:: javascript
    # 
    # func = ''' return Math.floor(x) + 0.5 '''
    # > String
    func = NULL,
    # A mapping of names to Python objects. In particular those can be
    # bokeh's models.  These objects are made available to the transform'
    # code snippet as the values of named parameters to the callback.
    # > Dict(String, AnyRef)
    args = NULL
  )
)

# *toolbar icon*: |wheel_zoom_icon|
# 
# The wheel zoom tool will zoom the plot in and out, centered on the
# current mouse location.
# 
# The wheel zoom tool also activates the border regions of a Plot for
# "single axis" zooming. For instance, zooming in the vertical border or
# axis will effect a zoom in the vertical direction only, with the
# horizontal dimension kept fixed.
# 
# .. |wheel_zoom_icon| image:: /_images/icons/WheelZoom.png :height: 18pt
WheelZoomTool <- R6::R6Class("WheelZoomTool",
  inherit = Scroll,
  public = list(
    specified_args = NULL,
    initialize = function(
      zoom_on_axis = TRUE, dimensions = "both",
      js_property_callbacks = structure(list(), .Names = character(0)),
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), maintain_focus = TRUE,
      name = NULL, speed = 0.00166666666666667, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["WheelZoomTool"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Whether scrolling on an axis (outside the central plot area) should
    # zoom that dimension.
    # > Bool
    zoom_on_axis = NULL,
    # Which dimensions the wheel zoom tool is constrained to act in. By
    # default the wheel zoom tool will zoom in any dimension, but can be
    # configured to only zoom horizontally across the width of the plot, or
    # vertically across the height of the plot.
    # > Enum('width', 'height', 'both')
    dimensions = NULL,
    # Whether or not zooming tool maintains its focus position. Setting to
    # False results in a more "gliding" behavior, allowing one to zoom out
    # more smoothly, at the cost of losing the focus position.
    # > Bool
    maintain_focus = NULL,
    # Speed at which the wheel zooms. Default is 1/600. Optimal range is
    # between 0.001 and 0.09. High values will be clipped. Speed may very
    # between browsers.
    # > Float
    speed = NULL
  )
)

# Render square markers with an 'X' cross through the center.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/SquareX.py
# :source-position: below
SquareX <- R6::R6Class("SquareX",
  inherit = Marker,
  public = list(
    specified_args = NULL,
    initialize = function(
      y = NULL, size = 4L, line_join = "bevel",
      js_property_callbacks = structure(list(), .Names = character(0)),
      angle_units = "rad", name = NULL, x = NULL, fill_color = "gray",
      line_dash = list(), tags = list(), angle = 0, line_dash_offset = 0L,
      js_event_callbacks = structure(list(), .Names = character(0)),
      fill_alpha = 1, subscribed_events = list(), line_color = "black",
      line_width = 1L, line_cap = "butt", line_alpha = 1, id = NULL
    ) {
      super$initialize(y = y, size = size, line_join = line_join,
        js_property_callbacks = js_property_callbacks,
        angle_units = angle_units, name = name, x = x, fill_color = fill_color,
        line_dash = line_dash, tags = tags, angle = angle,
        line_dash_offset = line_dash_offset,
        js_event_callbacks = js_event_callbacks, fill_alpha = fill_alpha,
        subscribed_events = subscribed_events, line_color = line_color,
        line_width = line_width, line_cap = line_cap,
        line_alpha = line_alpha, id = id)
      types <- bk_prop_types[["SquareX"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Abstract base class for map options' models.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
MapOptions <- R6::R6Class("MapOptions",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      js_property_callbacks = structure(list(), .Names = character(0)),
      zoom = 12L, tags = list(), js_event_callbacks = structure(list(),
      .Names = character(0)), lat = NULL, subscribed_events = list(),
      name = NULL, lng = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["MapOptions"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The initial zoom level to use when displaying the map.
    # > Int
    zoom = NULL,
    # The latitude where the map should be centered.
    # > Float
    lat = NULL,
    # The longitude where the map should be centered.
    # > Float
    lng = NULL
  )
)

# Specialized DataTable with collapsing groups, totals, and sub-totals.
DataCube <- R6::R6Class("DataCube",
  inherit = DataTable,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, target = NULL, align = "start", selectable = TRUE,
      tags = list(), row_height = 25L, width_policy = "auto",
      reorderable = TRUE, height_policy = "auto", height = 400L,
      fit_columns = TRUE, sortable = TRUE, max_height = NULL,
      header_row = TRUE, columns = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), width = 600L, grouping = list(),
      aspect_ratio = NULL, scroll_to_selection = TRUE, margin = list(5L, 5L,
      5L, 5L), index_position = 0L, max_width = NULL, disabled = FALSE,
      background = NULL, visible = TRUE, name = NULL, sizing_mode = NULL,
      source = NULL, default_size = 300L, editable = FALSE, index_width = 40L,
      css_classes = list(), view = NULL, orientation = "horizontal",
      js_property_callbacks = structure(list(), .Names = character(0)),
      min_height = NULL, index_header = "#", id = NULL
    ) {
      super$initialize(min_width = min_width, align = align,
        selectable = selectable, tags = tags, row_height = row_height,
        width_policy = width_policy, reorderable = reorderable,
        height_policy = height_policy, height = height,
        fit_columns = fit_columns, sortable = sortable,
        max_height = max_height, header_row = header_row, columns = columns,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, width = width,
        aspect_ratio = aspect_ratio,
        scroll_to_selection = scroll_to_selection, margin = margin,
        index_position = index_position, max_width = max_width,
        disabled = disabled, background = background, visible = visible,
        name = name, sizing_mode = sizing_mode, source = source,
        default_size = default_size, editable = editable,
        index_width = index_width, css_classes = css_classes, view = view,
        orientation = orientation,
        js_property_callbacks = js_property_callbacks,
        min_height = min_height, index_header = index_header, id = id)
      types <- bk_prop_types[["DataCube"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Two column datasource (row_indices & labels) describing which rows of
    # the data cubes are expanded or collapsed
    # > Instance(DataSource)
    target = NULL,
    # Describe what aggregation operations used to define sub-totals and
    # totals
    # > List(Instance(GroupingInfo))
    grouping = NULL
  )
)

# *toolbar icon*: |wheel_pan_icon|
# 
# The wheel pan tool allows the user to pan the plot along the configured
# dimension using the scroll wheel.
# 
# .. |wheel_pan_icon| image:: /_images/icons/WheelPan.png :height: 18pt
WheelPanTool <- R6::R6Class("WheelPanTool",
  inherit = Scroll,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      dimension = "width", name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["WheelPanTool"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Which dimension the wheel pan tool is constrained to act in. By default
    # the wheel pan tool will pan the plot along the x-axis.
    # > Enum('width', 'height')
    dimension = NULL
  )
)

# Basic string cell editor with auto-completion.
StringEditor <- R6::R6Class("StringEditor",
  inherit = CellEditor,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, completions = list(), id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["StringEditor"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # An optional list of completion strings.
    # > List(String)
    completions = NULL
  )
)

# Render several lines.
# 
# The data for the ``MultiLine`` glyph is different in that the vector of
# values is not a vector of scalars. Rather, it is a "list of lists".
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/MultiLine.py
# :source-position: below
MultiLine <- R6::R6Class("MultiLine",
  inherit = Glyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      ys = NULL, xs = NULL, line_join = "bevel",
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, line_dash = list(), tags = list(), line_dash_offset = 0L,
      js_event_callbacks = structure(list(), .Names = character(0)),
      line_width = 1L, subscribed_events = list(), line_color = "black",
      line_cap = "butt", line_alpha = 1, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["MultiLine"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The y-coordinates for all the lines, given as a "list of lists".
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    ys = NULL,
    # The x-coordinates for all the lines, given as a "list of lists".
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    xs = NULL,
    # The line join values for the lines.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # The line dash values for the lines.
    # > DashPattern
    line_dash = NULL,
    # The line dash offset values for the lines.
    # > Int
    line_dash_offset = NULL,
    # The line width values for the lines.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL,
    # The line color values for the lines.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The line cap values for the lines.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line alpha values for the lines.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL
  )
)

# A base class for all numeric, non-categorical axes types.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
ContinuousAxis <- R6::R6Class("ContinuousAxis",
  inherit = Axis,
  public = list(
    specified_args = NULL,
    initialize = function(
      major_label_text_font_size = list(value = "8pt"),
      major_label_text_font_style = "normal",
      axis_label_text_color = "#444444", fixed_location = NULL,
      major_label_text_align = "center", major_tick_line_color = "black",
      axis_label_text_line_height = 1.2, major_label_standoff = 5L,
      major_label_overrides = structure(list(), .Names = character(0)),
      tags = list(), minor_tick_in = 0L, formatter = NULL,
      axis_label_text_font_style = "italic",
      major_label_orientation = "horizontal",
      minor_tick_line_join = "bevel", major_tick_line_alpha = 1,
      axis_line_width = 1L, axis_label_text_font_size = list(value =
      "10pt"), major_tick_line_dash_offset = 0L,
      axis_label_text_baseline = "bottom", major_tick_line_width = 1L,
      major_label_text_font = "helvetica",
      axis_label_text_font = "helvetica", ticker = NULL,
      major_tick_line_cap = "butt", axis_label_text_alpha = 1,
      js_event_callbacks = structure(list(), .Names = character(0)),
      minor_tick_line_cap = "butt", subscribed_events = list(),
      major_tick_line_join = "bevel", axis_label_standoff = 5L,
      axis_line_alpha = 1, axis_line_cap = "butt", level = "overlay",
      major_tick_line_dash = list(), axis_label = "",
      major_label_text_color = "#444444",
      major_label_text_baseline = "alphabetic", major_tick_out = 6L,
      axis_line_color = "black", axis_line_join = "bevel",
      major_tick_in = 2L, visible = TRUE, minor_tick_out = 4L, name = NULL,
      minor_tick_line_dash = list(), major_label_text_line_height = 1.2,
      minor_tick_line_alpha = 1, bounds = "auto", axis_line_dash = list(),
      x_range_name = "default", minor_tick_line_color = "black",
      js_property_callbacks = structure(list(), .Names = character(0)),
      axis_label_text_align = "left", y_range_name = "default",
      major_label_text_alpha = 1, minor_tick_line_dash_offset = 0L,
      axis_line_dash_offset = 0L, minor_tick_line_width = 1L, id = NULL
    ) {
      super$initialize(major_label_text_font_size = major_label_text_font_size,
        major_label_text_font_style = major_label_text_font_style,
        axis_label_text_color = axis_label_text_color,
        fixed_location = fixed_location,
        major_label_text_align = major_label_text_align,
        major_tick_line_color = major_tick_line_color,
        axis_label_text_line_height = axis_label_text_line_height,
        major_label_standoff = major_label_standoff,
        major_label_overrides = major_label_overrides, tags = tags,
        minor_tick_in = minor_tick_in, formatter = formatter,
        axis_label_text_font_style = axis_label_text_font_style,
        major_label_orientation = major_label_orientation,
        minor_tick_line_join = minor_tick_line_join,
        major_tick_line_alpha = major_tick_line_alpha,
        axis_line_width = axis_line_width,
        axis_label_text_font_size = axis_label_text_font_size,
        major_tick_line_dash_offset = major_tick_line_dash_offset,
        axis_label_text_baseline = axis_label_text_baseline,
        major_tick_line_width = major_tick_line_width,
        major_label_text_font = major_label_text_font,
        axis_label_text_font = axis_label_text_font, ticker = ticker,
        major_tick_line_cap = major_tick_line_cap,
        axis_label_text_alpha = axis_label_text_alpha,
        js_event_callbacks = js_event_callbacks,
        minor_tick_line_cap = minor_tick_line_cap,
        subscribed_events = subscribed_events,
        major_tick_line_join = major_tick_line_join,
        axis_label_standoff = axis_label_standoff,
        axis_line_alpha = axis_line_alpha, axis_line_cap = axis_line_cap,
        level = level, major_tick_line_dash = major_tick_line_dash,
        axis_label = axis_label,
        major_label_text_color = major_label_text_color,
        major_label_text_baseline = major_label_text_baseline,
        major_tick_out = major_tick_out, axis_line_color = axis_line_color,
        axis_line_join = axis_line_join, major_tick_in = major_tick_in,
        visible = visible, minor_tick_out = minor_tick_out, name = name,
        minor_tick_line_dash = minor_tick_line_dash,
        major_label_text_line_height = major_label_text_line_height,
        minor_tick_line_alpha = minor_tick_line_alpha, bounds = bounds,
        axis_line_dash = axis_line_dash, x_range_name = x_range_name,
        minor_tick_line_color = minor_tick_line_color,
        js_property_callbacks = js_property_callbacks,
        axis_label_text_align = axis_label_text_align,
        y_range_name = y_range_name,
        major_label_text_alpha = major_label_text_alpha,
        minor_tick_line_dash_offset = minor_tick_line_dash_offset,
        axis_line_dash_offset = axis_line_dash_offset,
        minor_tick_line_width = minor_tick_line_width, id = id)
      types <- bk_prop_types[["ContinuousAxis"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Base class for ``Scale`` models that represent an invertible
# computation to be carried out on the client-side.
# 
# JavaScript implementations should implement the following methods:
# 
# .. code-block:: coffeescript
# 
# compute: (x) -> # compute the transform of a single value
# 
# v_compute: (xs) -> # compute the transform of an array of values
# 
# invert: (xprime) -> # compute the inverse transform of a single value
# 
# v_invert: (xprimes) -> # compute the inverse transform of an array of
# values
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
Scale <- R6::R6Class("Scale",
  inherit = Transform,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Scale"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Base class for web column data sources that can update from data URLs.
# 
# .. note:: This base class is typically not useful to instantiate on its
# own.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
WebSource <- R6::R6Class("WebSource",
  inherit = ColumnDataSource,
  public = list(
    specified_args = NULL,
    initialize = function(
      selected = NULL, js_property_callbacks = structure(list(), .Names =
      character(0)), data = structure(list(), .Names = character(0)),
      mode = "replace", callback = NULL, max_size = NULL, name = NULL,
      adapter = NULL, tags = list(), selection_policy = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), data_url = NULL, id = NULL
    ) {
      super$initialize(selected = selected,
        js_property_callbacks = js_property_callbacks, data = data,
        callback = callback, tags = tags,
        selection_policy = selection_policy,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name, id = id)
      types <- bk_prop_types[["WebSource"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Whether to append new data to existing data (up to ``max_size``), or to
    # replace existing data entirely.
    # > Enum('replace', 'append')
    mode = NULL,
    # Maximum size of the data columns. If a new fetch would result in
    # columns larger than ``max_size``, then earlier data is dropped to make
    # room.
    # > Int
    max_size = NULL,
    # A JavaScript callback to adapt raw JSON responses to Bokeh
    # ``ColumnDataSource`` format.
    # 
    # If provided, this callback is executes immediately after the JSON data
    # is received, but before appending or replacing data in the data source.
    # The ``CustomJS`` callback will receive the ``AjaxDataSource`` as
    # ``cb_obj`` and will receive the raw JSON response as
    # ``cb_data.response``. The callback code should return a ``data`` object
    # suitable for a Bokeh ``ColumnDataSource`` (i.e.  a mapping of string
    # column names to arrays of data).
    # > Instance(CustomJS)
    adapter = NULL,
    # A URL to to fetch data from.
    # > String
    data_url = NULL
  )
)

# *toolbar icon*: |poly_select_icon|
# 
# The polygon selection tool allows users to make selections on a Plot by
# indicating a polygonal region with mouse clicks. single clicks (or
# taps) add successive points to the definition of the polygon, and a
# double click (or tap) indicates the selection region is ready.
# 
# See :ref:`userguide_styling_selected_unselected_glyphs` for information
# on styling selected and unselected glyphs.
# 
# .. note:: Selections can be comprised of multiple regions, even those
# made by different selection tools. Hold down the <<shift>> key while
# making a selection to append the new selection to any previous
# selection that might exist.
# 
# .. |poly_select_icon| image:: /_images/icons/PolygonSelect.png :height:
# 18pt
PolySelectTool <- R6::R6Class("PolySelectTool",
  inherit = Tap,
  public = list(
    specified_args = NULL,
    initialize = function(
      js_property_callbacks = structure(list(), .Names = character(0)),
      callback = NULL, tags = list(), renderers = "auto", overlay = NULL,
      names = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["PolySelectTool"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A callback to run in the browser on completion of drawing a polygon.
    # The ``cb_data`` parameter that is available to the Callback code will
    # contain one PolySelectTool-specific field:
    # 
    # :geometry: object containing the coordinates of the polygon
    # > Instance(Callback)
    callback = NULL,
    # An explicit list of renderers to hit test against. If unset, defaults
    # to all renderers on a plot.
    # > Either(Auto, List(Instance(Renderer)))
    renderers = NULL,
    # A shaded annotation drawn to indicate the selection region.
    # > Instance(PolyAnnotation)
    overlay = NULL,
    # A list of names to query for. If set, only renderers that have a
    # matching value for their ``name`` attribute will be used.
    # > List(String)
    names = NULL
  )
)

# 
CategoricalScale <- R6::R6Class("CategoricalScale",
  inherit = LinearScale,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["CategoricalScale"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Render axis-aligned quads.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/Quad.py
# :source-position: below
Quad <- R6::R6Class("Quad",
  inherit = Glyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      hatch_extra = structure(list(), .Names = character(0)),
      hatch_weight = 1, tags = list(), hatch_scale = 12, fill_alpha = 1,
      hatch_pattern = NULL, line_color = "black", line_dash = list(),
      name = NULL, fill_color = "gray", line_alpha = 1, top = NULL,
      js_property_callbacks = structure(list(), .Names = character(0)),
      hatch_color = "black", hatch_alpha = 1, left = NULL,
      line_dash_offset = 0L, bottom = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      line_join = "bevel", subscribed_events = list(), right = NULL,
      line_cap = "butt", line_width = 1L, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Quad"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The hatch extra values for the horizontal bars.
    # > Dict(String, Instance(Texture))
    hatch_extra = NULL,
    # The hatch weight values for the horizontal bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    hatch_weight = NULL,
    # The hatch scale values for the horizontal bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    hatch_scale = NULL,
    # The fill alpha values for the quads.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    fill_alpha = NULL,
    # The hatch pattern values for the horizontal bars.
    # > HatchPatternSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), HatchPatternType)), HatchPatternType)
    hatch_pattern = NULL,
    # The line color values for the quads.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The line dash values for the quads.
    # > DashPattern
    line_dash = NULL,
    # The fill color values for the quads.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    fill_color = NULL,
    # The line alpha values for the quads.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL,
    # The y-coordinates of the top edges.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    top = NULL,
    # The hatch color values for the horizontal bars.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    hatch_color = NULL,
    # The hatch alpha values for the horizontal bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    hatch_alpha = NULL,
    # The x-coordinates of the left edges.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    left = NULL,
    # The line dash offset values for the quads.
    # > Int
    line_dash_offset = NULL,
    # The y-coordinates of the bottom edges.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    bottom = NULL,
    # The line join values for the quads.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # The x-coordinates of the right edges.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    right = NULL,
    # The line cap values for the quads.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line width values for the quads.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL
  )
)

# Render several MultiPolygon.
# 
# Modeled on geoJSON - the data for the ``MultiPolygons`` glyph is
# different in that the vector of values is not a vector of scalars.
# Rather, it is a "list of lists of lists of lists".
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/MultiPolygons.py
# :source-position: below
MultiPolygons <- R6::R6Class("MultiPolygons",
  inherit = Glyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      xs = NULL, ys = NULL, hatch_extra = structure(list(), .Names =
      character(0)), hatch_weight = 1, tags = list(), hatch_scale = 12,
      fill_alpha = 1, hatch_pattern = NULL, line_color = "black",
      line_dash = list(), name = NULL, fill_color = "gray", line_alpha = 1,
      line_join = "bevel", js_property_callbacks = structure(list(), .Names
      = character(0)), hatch_color = "black", hatch_alpha = 1,
      line_dash_offset = 0L, js_event_callbacks = structure(list(), .Names
      = character(0)), line_width = 1L, subscribed_events = list(),
      line_cap = "butt", id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["MultiPolygons"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The x-coordinates for all the patches, given as a nested list.
    # 
    # .. note:: Each item in ``MultiPolygons`` represents one MultiPolygon
    # and each MultiPolygon is comprised of ``n`` Polygons. Each Polygon is
    # made of one exterior ring optionally followed by ``m`` interior rings
    # (holes).
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    xs = NULL,
    # The y-coordinates for all the patches, given as a "list of lists".
    # 
    # .. note:: Each item in ``MultiPolygons`` represents one MultiPolygon
    # and each MultiPolygon is comprised of ``n`` Polygons. Each Polygon is
    # made of one exterior ring optionally followed by ``m`` interior rings
    # (holes).
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    ys = NULL,
    # The hatch extra values for the patches.
    # > Dict(String, Instance(Texture))
    hatch_extra = NULL,
    # The hatch weight values for the patches.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    hatch_weight = NULL,
    # The hatch scale values for the patches.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    hatch_scale = NULL,
    # The fill alpha values for the multipolygons.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    fill_alpha = NULL,
    # The hatch pattern values for the patches.
    # > HatchPatternSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), HatchPatternType)), HatchPatternType)
    hatch_pattern = NULL,
    # The line color values for the multipolygons.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The line dash values for the multipolygons.
    # > DashPattern
    line_dash = NULL,
    # The fill color values for the multipolygons.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    fill_color = NULL,
    # The line alpha values for the multipolygons.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL,
    # The line join values for the multipolygons.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # The hatch color values for the patches.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    hatch_color = NULL,
    # The hatch alpha values for the patches.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    hatch_alpha = NULL,
    # The line dash offset values for the multipolygons.
    # > Int
    line_dash_offset = NULL,
    # The line width values for the multipolygons.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL,
    # The line cap values for the multipolygons.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL
  )
)

# Base class for mappers.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
Mapper <- R6::R6Class("Mapper",
  inherit = Transform,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Mapper"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Describes how to calculate totals and sub-totals
GroupingInfo <- R6::R6Class("GroupingInfo",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      aggregators = list(), collapsed = FALSE, getter = "",
      js_property_callbacks = structure(list(), .Names = character(0)),
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["GroupingInfo"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Describes how to aggregate the columns which will populate this
    # sub-total.
    # > List(Instance(RowAggregator))
    aggregators = NULL,
    # Whether the corresponding sub-total is expanded or collapsed by
    # default.
    # > Bool
    collapsed = NULL,
    # References the column which generates the unique keys of this sub-total
    # (groupby).
    # > String
    getter = NULL
  )
)

# Multi-select widget.
MultiSelect <- R6::R6Class("MultiSelect",
  inherit = InputWidget,
  public = list(
    specified_args = NULL,
    initialize = function(
      title = "", min_width = NULL, max_width = NULL, align = "start",
      disabled = FALSE, value = list(), callback = NULL, background = NULL,
      tags = list(), visible = TRUE, options = list(), width_policy = "auto",
      height_policy = "auto", height = NULL, name = NULL, sizing_mode = NULL,
      default_size = 300L, max_height = NULL, size = 4L, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      orientation = "horizontal", js_event_callbacks = structure(list(),
      .Names = character(0)), min_height = NULL,
      subscribed_events = list(), width = NULL, aspect_ratio = NULL,
      margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(title = title, min_width = min_width,
        max_width = max_width, align = align, disabled = disabled,
        background = background, tags = tags, visible = visible,
        width_policy = width_policy, height_policy = height_policy,
        height = height, name = name, sizing_mode = sizing_mode,
        default_size = default_size, max_height = max_height,
        css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["MultiSelect"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Initial or selected values.
    # > List(String)
    value = NULL,
    # A callback to run in the browser whenever the current selection value
    # changes.
    # > Instance(Callback)
    callback = NULL,
    # Available selection options. Options may be provided either as a list
    # of possible string values, or as a list of tuples, each of the form
    # ``(value, label)``. In the latter case, the visible widget text for
    # each value will be corresponding given label.
    # > List(Either(String, Tuple(String, String)))
    options = NULL,
    # The number of visible options in the dropdown list. (This uses the
    # ``select`` HTML element's ``size`` attribute. Some browsers might not
    # show less than 3 options.)
    # > Int
    size = NULL
  )
)

# Abstract base class for data table's cell editors.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
CellEditor <- R6::R6Class("CellEditor",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["CellEditor"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# *toolbar icon*: |zoom_in_icon|
# 
# The zoom-in tool allows users to click a button to zoom in by a fixed
# amount.
# 
# .. |zoom_in_icon| image:: /_images/icons/ZoomIn.png :height: 18pt
ZoomInTool <- R6::R6Class("ZoomInTool",
  inherit = Action,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), dimensions = "both",
      js_property_callbacks = structure(list(), .Names = character(0)),
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), factor = 0.1, name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["ZoomInTool"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Which dimensions the zoom-in tool is constrained to act in. By default
    # the zoom-in zoom tool will zoom in any dimension, but can be configured
    # to only zoom horizontally across the width of the plot, or vertically
    # across the height of the plot.
    # > Enum('width', 'height', 'both')
    dimensions = NULL,
    # Percentage to zoom for each click of the zoom-in tool.
    # > Percent
    factor = NULL
  )
)

# Collect tools to display for a single plot.
Toolbar <- R6::R6Class("Toolbar",
  inherit = ToolbarBase,
  public = list(
    specified_args = NULL,
    initialize = function(
      active_drag = "auto", logo = "normal", active_multi = NULL,
      active_inspect = "auto", js_property_callbacks = structure(list(),
      .Names = character(0)), active_tap = "auto", autohide = FALSE,
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), active_scroll = "auto",
      tools = list(), name = NULL, id = NULL
    ) {
      super$initialize(logo = logo,
        js_property_callbacks = js_property_callbacks, tags = tags,
        autohide = autohide, js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, tools = tools, name = name,
        id = id)
      types <- bk_prop_types[["Toolbar"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Specify a drag tool to be active when the plot is displayed.
    # > Either(Auto, Instance(Drag))
    active_drag = NULL,
    # Specify an active multi-gesture tool, for instance an edit tool or a
    # range tool.
    # 
    # Note that activating a multi-gesture tool will deactivate any other
    # gesture tools as appropriate. For example, if a pan tool is set as the
    # active drag, and this property is set to a ``BoxEditTool`` instance,
    # the pan tool will be deactivated (i.e. the multi-gesture tool will take
    # precedence).
    # > Instance(Gesture)
    active_multi = NULL,
    # Specify an inspection tool or sequence of inspection tools to be active
    # when the plot is displayed.
    # > Either(Auto, Instance(Inspection), Seq(Instance(Inspection)))
    active_inspect = NULL,
    # Specify a tap/click tool to be active when the plot is displayed.
    # > Either(Auto, Instance(Tap))
    active_tap = NULL,
    # Specify a scroll/pinch tool to be active when the plot is displayed.
    # > Either(Auto, Instance(Scroll))
    active_scroll = NULL
  )
)

# A base class for tools that are buttons in the toolbar.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
Action <- R6::R6Class("Action",
  inherit = Tool,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Action"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# A block (div) of text.
# 
# This Bokeh model corresponds to an HTML ``<div>`` element.
# 
# Example -------
# 
# .. bokeh-plot::
# ../../sphinx/source/docs/user_guide/examples/interaction_div.py
# :source-position: below
Div <- R6::R6Class("Div",
  inherit = Markup,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", disabled = FALSE,
      render_as_text = FALSE, style = structure(list(), .Names =
      character(0)), background = NULL, text = "", tags = list(),
      visible = TRUE, width_policy = "auto", height_policy = "auto",
      height = NULL, name = NULL, sizing_mode = NULL, default_size = 300L,
      max_height = NULL, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      orientation = "horizontal", js_event_callbacks = structure(list(),
      .Names = character(0)), min_height = NULL,
      subscribed_events = list(), width = NULL, aspect_ratio = NULL,
      margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, style = style,
        background = background, text = text, tags = tags, visible = visible,
        width_policy = width_policy, height_policy = height_policy,
        height = height, name = name, sizing_mode = sizing_mode,
        default_size = default_size, max_height = max_height,
        css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["Div"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Whether the contents should be rendered as raw text or as interpreted
    # HTML.  The default value is ``False``, meaning contents are rendered as
    # HTML.
    # > Bool
    render_as_text = NULL
  )
)

# Slider-based date range selection widget.
DateRangeSlider <- R6::R6Class("DateRangeSlider",
  inherit = AbstractSlider,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, align = "start", start = NULL, callback = NULL,
      tags = list(), width_policy = "auto", height_policy = "auto", step = 1L,
      height = NULL, callback_policy = "throttle", value_throttled = NULL,
      callback_throttle = 200L, max_height = NULL, show_value = TRUE,
      format = "%d %b %Y", js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), width = NULL,
      aspect_ratio = NULL, tooltips = TRUE, margin = list(5L, 5L, 5L, 5L),
      end = NULL, title = "", max_width = NULL, disabled = FALSE, value = NULL,
      bar_color = "#e6e6e6", background = NULL, visible = TRUE, name = NULL,
      sizing_mode = NULL, default_size = 300L, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      orientation = "horizontal", direction = "ltr", min_height = NULL,
      id = NULL
    ) {
      super$initialize(title = title, min_width = min_width,
        max_width = max_width, align = align, disabled = disabled,
        bar_color = bar_color, callback = callback, background = background,
        tags = tags, visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, name = name,
        sizing_mode = sizing_mode, callback_policy = callback_policy,
        default_size = default_size, callback_throttle = callback_throttle,
        max_height = max_height, show_value = show_value,
        css_classes = css_classes, format = format,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, direction = direction,
        min_height = min_height, subscribed_events = subscribed_events,
        js_event_callbacks = js_event_callbacks, width = width,
        aspect_ratio = aspect_ratio, tooltips = tooltips, margin = margin,
        id = id)
      types <- bk_prop_types[["DateRangeSlider"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The minimum allowable value.
    # > Date
    start = NULL,
    # The step between consecutive values.
    # > Int
    step = NULL,
    # Initial or selected value, throttled according to callback_policy.
    # > Tuple(Date, Date)
    value_throttled = NULL,
    # The maximum allowable value.
    # > Date
    end = NULL,
    # Initial or selected range.
    # > Tuple(Date, Date)
    value = NULL
  )
)

# Base class for interactive callback.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
Callback <- R6::R6Class("Callback",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Callback"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Render several patches.
# 
# The data for the ``Patches`` glyph is different in that the vector of
# values is not a vector of scalars. Rather, it is a "list of lists".
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/Patches.py
# :source-position: below
Patches <- R6::R6Class("Patches",
  inherit = Glyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      xs = NULL, ys = NULL, hatch_extra = structure(list(), .Names =
      character(0)), hatch_weight = 1, tags = list(), hatch_scale = 12,
      fill_alpha = 1, hatch_pattern = NULL, line_color = "black",
      line_dash = list(), name = NULL, fill_color = "gray", line_alpha = 1,
      line_join = "bevel", js_property_callbacks = structure(list(), .Names
      = character(0)), hatch_color = "black", hatch_alpha = 1,
      line_dash_offset = 0L, js_event_callbacks = structure(list(), .Names
      = character(0)), line_width = 1L, subscribed_events = list(),
      line_cap = "butt", id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Patches"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The x-coordinates for all the patches, given as a "list of lists".
    # 
    # .. note:: Individual patches may comprise multiple polygons. In this
    # case the x-coordinates for each polygon should be separated by NaN
    # values in the sublists.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    xs = NULL,
    # The y-coordinates for all the patches, given as a "list of lists".
    # 
    # .. note:: Individual patches may comprise multiple polygons. In this
    # case the y-coordinates for each polygon should be separated by NaN
    # values in the sublists.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    ys = NULL,
    # The hatch extra values for the patches.
    # > Dict(String, Instance(Texture))
    hatch_extra = NULL,
    # The hatch weight values for the patches.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    hatch_weight = NULL,
    # The hatch scale values for the patches.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    hatch_scale = NULL,
    # The fill alpha values for the patches.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    fill_alpha = NULL,
    # The hatch pattern values for the patches.
    # > HatchPatternSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), HatchPatternType)), HatchPatternType)
    hatch_pattern = NULL,
    # The line color values for the patches.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The line dash values for the patches.
    # > DashPattern
    line_dash = NULL,
    # The fill color values for the patches.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    fill_color = NULL,
    # The line alpha values for the patches.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL,
    # The line join values for the patches.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # The hatch color values for the patches.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    hatch_color = NULL,
    # The hatch alpha values for the patches.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    hatch_alpha = NULL,
    # The line dash offset values for the patches.
    # > Int
    line_dash_offset = NULL,
    # The line width values for the patches.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL,
    # The line cap values for the patches.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL
  )
)

# Generate "nice" round ticks at any magnitude.
# 
# Creates ticks that are "base" multiples of a set of given mantissas.
# For example, with ``base=10`` and ``mantissas=[1, 2, 5]``, the ticker
# will generate the sequence::
# 
# ..., 0.1, 0.2, 0.5, 1, 2, 5, 10, 20, 50, 100, ...
AdaptiveTicker <- R6::R6Class("AdaptiveTicker",
  inherit = ContinuousTicker,
  public = list(
    specified_args = NULL,
    initialize = function(
      base = 10, max_interval = NULL, desired_num_ticks = 6L,
      js_property_callbacks = structure(list(), .Names = character(0)),
      mantissas = list(1L, 2L, 5L), tags = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), name = NULL, min_interval = 0,
      num_minor_ticks = 5L, id = NULL
    ) {
      super$initialize(tags = tags, desired_num_ticks = desired_num_ticks,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name,
        num_minor_ticks = num_minor_ticks, id = id)
      types <- bk_prop_types[["AdaptiveTicker"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The multiplier to use for scaling mantissas.
    # > Float
    base = NULL,
    # The largest allowable interval between two adjacent ticks.
    # 
    # .. note:: To specify an unbounded interval, set to ``None``.
    # > Float
    max_interval = NULL,
    # The acceptable list numbers to generate multiples of.
    # > Seq(Float)
    mantissas = NULL,
    # The smallest allowable interval between two adjacent ticks.
    # > Float
    min_interval = NULL
  )
)

# Render multiple text labels as annotations.
# 
# ``LabelSet`` will render multiple text labels at given ``x`` and ``y``
# coordinates, which can be in either screen (pixel) space, or data (axis
# range) space. In this case (as opposed to the single ``Label`` model),
# ``x`` and ``y`` can also be the name of a column from a
# :class:`~bokeh.models.sources.ColumnDataSource`, in which case the
# labels will be "vectorized" using coordinate values from the specified
# columns.
# 
# The label can also be configured with a screen space offset from ``x``
# and ``y``, by using the ``x_offset`` and ``y_offset`` properties. These
# offsets may be vectorized by giving the name of a data source column.
# 
# Additionally, the label can be rotated with the ``angle`` property
# (which may also be a column name.)
# 
# There are also standard text, fill, and line properties to control the
# appearance of the text, its background, as well as the rectangular
# bounding box border.
# 
# The data source is provided by setting the ``source`` property.
LabelSet <- R6::R6Class("LabelSet",
  inherit = TextAnnotation,
  public = list(
    specified_args = NULL,
    initialize = function(
      level = "annotation", background_fill_color = NULL,
      angle_units = "rad", border_line_dash_offset = 0L, x = NULL,
      text = "text", tags = list(), text_line_height = 1.2,
      text_color = "#444444", render_mode = "canvas", visible = TRUE,
      y_units = "data", subscribed_events = list(), name = NULL,
      border_line_dash = list(), text_font_size = list(value = "12pt"),
      source = NULL, text_font_style = "normal", x_offset = 0L, y = NULL,
      text_font = "helvetica", text_baseline = "bottom",
      x_range_name = "default", border_line_width = 1L,
      js_property_callbacks = structure(list(), .Names = character(0)),
      y_range_name = "default", background_fill_alpha = 1,
      text_align = "left", x_units = "data", border_line_join = "bevel",
      border_line_cap = "butt", angle = 0L,
      js_event_callbacks = structure(list(), .Names = character(0)),
      text_alpha = 1, border_line_color = NULL, border_line_alpha = 1,
      y_offset = 0L, id = NULL
    ) {
      super$initialize(level = level,
        js_property_callbacks = js_property_callbacks, tags = tags,
        visible = visible, render_mode = render_mode,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name, id = id)
      types <- bk_prop_types[["LabelSet"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The fill color values for the text bounding box.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    background_fill_color = NULL,
    # 
    # > Enum('deg', 'rad')
    angle_units = NULL,
    # The line dash offset values for the text bounding box.
    # > Int
    border_line_dash_offset = NULL,
    # The x-coordinates to locate the text anchors.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x = NULL,
    # The text values to render.
    # > StringSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), List(String))), List(String))
    text = NULL,
    # The text line height values for the text.
    # > Float
    text_line_height = NULL,
    # The text color values for the text.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    text_color = NULL,
    # The unit type for the ``ys`` attribute. Interpreted as "data space"
    # units by default.
    # > Enum('screen', 'data')
    y_units = NULL,
    # The line dash values for the text bounding box.
    # > DashPattern
    border_line_dash = NULL,
    # The text font size values for the text.
    # > FontSizeSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), FontSize)), FontSize)
    text_font_size = NULL,
    # Local data source to use when rendering annotations on the plot.
    # > Instance(DataSource)
    source = NULL,
    # The text font style values for the text.
    # > Enum('normal', 'italic', 'bold', 'bold italic')
    text_font_style = NULL,
    # Offset values to apply to the x-coordinates.
    # 
    # This is useful, for instance, if it is desired to "float" text a fixed
    # distance in screen units from a given data position.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x_offset = NULL,
    # The y-coordinates to locate the text anchors.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y = NULL,
    # The text font values for the text.
    # > String
    text_font = NULL,
    # The text baseline values for the text.
    # > Enum('top', 'middle', 'bottom', 'alphabetic', 'hanging', 'ideographic')
    text_baseline = NULL,
    # A particular (named) x-range to use for computing screen locations when
    # rendering annotations on the plot. If unset, use the default x-range.
    # > String
    x_range_name = NULL,
    # The line width values for the text bounding box.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    border_line_width = NULL,
    # A particular (named) y-range to use for computing screen locations when
    # rendering annotations on the plot. If unset, use the default y-range.
    # > String
    y_range_name = NULL,
    # The fill alpha values for the text bounding box.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    background_fill_alpha = NULL,
    # The text align values for the text.
    # > Enum('left', 'right', 'center')
    text_align = NULL,
    # The unit type for the ``xs`` attribute. Interpreted as "data space"
    # units by default.
    # > Enum('screen', 'data')
    x_units = NULL,
    # The line join values for the text bounding box.
    # > Enum('miter', 'round', 'bevel')
    border_line_join = NULL,
    # The line cap values for the text bounding box.
    # > Enum('butt', 'round', 'square')
    border_line_cap = NULL,
    # The angles to rotate the text, as measured from the horizontal.
    # 
    # .. warning:: The center of rotation for canvas and css render_modes is
    # different.  For `render_mode="canvas"` the label is rotated from the
    # top-left corner of the annotation, while for `render_mode="css"` the
    # annotation is rotated around it's center.
    # > AngleSpec(units_default='rad')
    angle = NULL,
    # The text alpha values for the text.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    text_alpha = NULL,
    # The line color values for the text bounding box.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    border_line_color = NULL,
    # The line alpha values for the text bounding box.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    border_line_alpha = NULL,
    # Offset values to apply to the y-coordinates.
    # 
    # This is useful, for instance, if it is desired to "float" text a fixed
    # distance in screen units from a given data position.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y_offset = NULL
  )
)

# Behaves much like ``TMSTileSource`` but has its tile-origin in the
# top-left.
# 
# This is the most common used tile source for web mapping applications.
# Such companies as Google, MapQuest, Stamen, Esri, and OpenStreetMap
# provide service which use the WMTS specification e.g.
# ``http://c.tile.openstreetmap.org/{Z}/{X}/{Y}.png``.
WMTSTileSource <- R6::R6Class("WMTSTileSource",
  inherit = MercatorTileSource,
  public = list(
    specified_args = NULL,
    initialize = function(
      js_property_callbacks = structure(list(), .Names = character(0)),
      tile_size = 256L, extra_url_vars = structure(list(), .Names =
      character(0)), snap_to_zoom = FALSE, url = "",
      initial_resolution = 156543.033928041, x_origin_offset = 20037508.34,
      attribution = "", y_origin_offset = 20037508.34, max_zoom = 30L,
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), name = NULL, min_zoom = 0L,
      wrap_around = TRUE, id = NULL
    ) {
      super$initialize(js_property_callbacks = js_property_callbacks,
        tile_size = tile_size, extra_url_vars = extra_url_vars,
        snap_to_zoom = snap_to_zoom, url = url,
        initial_resolution = initial_resolution,
        x_origin_offset = x_origin_offset, attribution = attribution,
        y_origin_offset = y_origin_offset, max_zoom = max_zoom, tags = tags,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name,
        min_zoom = min_zoom, wrap_around = wrap_around, id = id)
      types <- bk_prop_types[["WMTSTileSource"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Model representing a plot, containing glyphs, guides, annotations.
Plot <- R6::R6Class("Plot",
  inherit = LayoutDOM,
  public = list(
    specified_args = NULL,
    initialize = function(
      inner_height = NULL, min_border_top = NULL, lod_factor = 10L,
      aspect_scale = 1L, min_width = NULL, align = "start",
      extra_y_ranges = structure(list(), .Names = character(0)),
      frame_height = NULL, tags = list(), match_aspect = FALSE,
      outer_height = NULL, min_border_left = NULL, toolbar_sticky = TRUE,
      width_policy = "auto", height_policy = "auto", below = list(),
      height = NULL, frame_width = NULL, outline_line_cap = "butt",
      outline_line_width = 1L, max_height = NULL, plot_width = 600L,
      above = list(), hidpi = TRUE, outer_width = NULL, left = list(),
      outline_line_color = "#e5e5e5", min_border_right = NULL,
      outline_line_dash_offset = 0L, js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(), right = list(),
      width = NULL, aspect_ratio = NULL, border_fill_color = "#ffffff",
      lod_interval = 300L, margin = list(0L, 0L, 0L, 0L), title = NULL,
      x_range = NULL, max_width = NULL, disabled = FALSE,
      background_fill_color = "#ffffff", toolbar = NULL, background = NULL,
      reset_policy = "standard", inner_width = NULL, y_scale = NULL,
      border_fill_alpha = 1, visible = TRUE, outline_line_alpha = 1,
      outline_line_join = "bevel", center = list(),
      output_backend = "canvas", extra_x_ranges = structure(list(), .Names
      = character(0)), plot_height = 600L, y_range = NULL,
      outline_line_dash = list(), sizing_mode = NULL, name = NULL,
      x_scale = NULL, lod_timeout = 500L, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      min_border_bottom = NULL, background_fill_alpha = 1,
      renderers = list(), min_height = NULL, min_border = 5L,
      lod_threshold = 2000L, title_location = "above",
      toolbar_location = "right", id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, background = background,
        tags = tags, visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, name = name,
        sizing_mode = sizing_mode, max_height = max_height,
        css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        js_event_callbacks = js_event_callbacks, min_height = min_height,
        subscribed_events = subscribed_events, width = width,
        aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["Plot"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # This is the exact height of the plotting canvas, i.e. the height of the
    # actual plot, without toolbars etc. Note this is computed in a web
    # browser, so this property will work only in backends capable of
    # bidirectional communication (server, notebook).
    # 
    # .. note:: This is an experimental feature and the API may change in
    # near future.
    # > Int
    inner_height = NULL,
    # Minimum size in pixels of the padding region above the top of the
    # central plot region.
    # 
    # .. note:: This is a *minimum*. The padding region may expand as needed
    # to accommodate titles or axes, etc.
    # > Int
    min_border_top = NULL,
    # Decimation factor to use when applying level-of-detail decimation.
    # > Int
    lod_factor = NULL,
    # A value to be given for increased aspect ratio control. This value is
    # added multiplicatively to the calculated value required for
    # ``match_aspect``.  ``aspect_scale`` is defined as the ratio of width
    # over height of the figure.
    # 
    # For example, a plot with ``aspect_scale`` value of 2 will result in a
    # square in *data units* to be drawn on the screen as a rectangle with a
    # pixel width twice as long as its pixel height.
    # 
    # .. note:: This setting only takes effect if ``match_aspect`` is set to
    # ``True``.
    # > Float
    aspect_scale = NULL,
    # Additional named ranges to make available for mapping y-coordinates.
    # 
    # This is useful for adding additional axes.
    # > Dict(String, Instance(Range))
    extra_y_ranges = NULL,
    # The height of a plot frame or the inner height of a plot, excluding any
    # axes, titles, border padding, etc.
    # > Int
    frame_height = NULL,
    # Specify the aspect ratio behavior of the plot. Aspect ratio is defined
    # as the ratio of width over height. This property controls whether Bokeh
    # should attempt the match the (width/height) of *data space* to the
    # (width/height) in pixels of *screen space*.
    # 
    # Default is ``False`` which indicates that the *data* aspect ratio and
    # the *screen* aspect ratio vary independently. ``True`` indicates that
    # the plot aspect ratio of the axes will match the aspect ratio of the
    # pixel extent the axes. The end result is that a 1x1 area in data space
    # is a square in pixels, and conversely that a 1x1 pixel is a square in
    # data units.
    # 
    # .. note:: This setting only takes effect when there are two dataranges.
    # This setting only sets the initial plot draw and subsequent resets. It
    # is possible for tools (single axis zoom, unconstrained box zoom) to
    # change the aspect ratio.
    # 
    # .. warning:: This setting is incompatible with linking dataranges
    # across multiple plots. Doing so may result in undefined behaviour.
    # > Bool
    match_aspect = NULL,
    # This is the exact height of the layout, i.e. the height of the actual
    # plot, with toolbars etc. Note this is computed in a web browser, so
    # this property will work only in backends capable of bidirectional
    # communication (server, notebook).
    # 
    # .. note:: This is an experimental feature and the API may change in
    # near future.
    # > Int
    outer_height = NULL,
    # Minimum size in pixels of the padding region to the left of the central
    # plot region.
    # 
    # .. note:: This is a *minimum*. The padding region may expand as needed
    # to accommodate titles or axes, etc.
    # > Int
    min_border_left = NULL,
    # Stick the toolbar to the edge of the plot. Default: True. If False, the
    # toolbar will be outside of the axes, titles etc.
    # > Bool
    toolbar_sticky = NULL,
    # A list of renderers to occupy the area below of the plot.
    # > List(Instance(Renderer))
    below = NULL,
    # The width of a plot frame or the inner width of a plot, excluding any
    # axes, titles, border padding, etc.
    # > Int
    frame_width = NULL,
    # The line cap for the plot border outline.
    # > Enum('butt', 'round', 'square')
    outline_line_cap = NULL,
    # The line width for the plot border outline.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    outline_line_width = NULL,
    # The outer width of a plot, including any axes, titles, border padding,
    # etc.
    # 
    # .. note:: This corresponds directly to the width of the HTML canvas.
    # > Int
    plot_width = NULL,
    # A list of renderers to occupy the area above of the plot.
    # > List(Instance(Renderer))
    above = NULL,
    # Whether to use HiDPI mode when available.
    # > Bool
    hidpi = NULL,
    # This is the exact width of the layout, i.e. the height of the actual
    # plot, with toolbars etc. Note this is computed in a web browser, so
    # this property will work only in backends capable of bidirectional
    # communication (server, notebook).
    # 
    # .. note:: This is an experimental feature and the API may change in
    # near future.
    # > Int
    outer_width = NULL,
    # A list of renderers to occupy the area to the left of the plot.
    # > List(Instance(Renderer))
    left = NULL,
    # The line color for the plot border outline.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    outline_line_color = NULL,
    # Minimum size in pixels of the padding region to the right of the
    # central plot region.
    # 
    # .. note:: This is a *minimum*. The padding region may expand as needed
    # to accommodate titles or axes, etc.
    # > Int
    min_border_right = NULL,
    # The line dash offset for the plot border outline.
    # > Int
    outline_line_dash_offset = NULL,
    # A list of renderers to occupy the area to the right of the plot.
    # > List(Instance(Renderer))
    right = NULL,
    # The fill color for the plot border style.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    border_fill_color = NULL,
    # Interval (in ms) during which an interactive tool event will enable
    # level-of-detail downsampling.
    # > Int
    lod_interval = NULL,
    # A title for the plot. Can be a text string or a Title annotation.
    # > Instance(Title)
    title = NULL,
    # The (default) data range of the horizontal dimension of the plot.
    # > Instance(Range)
    x_range = NULL,
    # The fill color for the plot background style.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    background_fill_color = NULL,
    # The toolbar associated with this plot which holds all the tools. It is
    # automatically created with the plot if necessary.
    # > Instance(Toolbar)
    toolbar = NULL,
    # How a plot should respond to being reset. By deafult, the standard
    # actions are to clear any tool state history, return plot ranges to
    # their original values, undo all selections, and emit a ``Reset`` event.
    # If customization is desired, this property may be set to
    # ``"event_only"``, which will suppress all of the actions except the
    # Reset event.
    # > Enum('standard', 'event_only')
    reset_policy = NULL,
    # This is the exact width of the plotting canvas, i.e. the width of the
    # actual plot, without toolbars etc. Note this is computed in a web
    # browser, so this property will work only in backends capable of
    # bidirectional communication (server, notebook).
    # 
    # .. note:: This is an experimental feature and the API may change in
    # near future.
    # > Int
    inner_width = NULL,
    # What kind of scale to use to convert y-coordinates in data space into
    # y-coordinates in screen space.
    # > Instance(Scale)
    y_scale = NULL,
    # The fill alpha for the plot border style.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    border_fill_alpha = NULL,
    # The line alpha for the plot border outline.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    outline_line_alpha = NULL,
    # The line join for the plot border outline.
    # > Enum('miter', 'round', 'bevel')
    outline_line_join = NULL,
    # A list of renderers to occupy the center area (frame) of the plot.
    # > List(Instance(Renderer))
    center = NULL,
    # Specify the output backend for the plot area. Default is HTML5 Canvas.
    # 
    # .. note:: When set to ``webgl``, glyphs without a WebGL rendering
    # implementation will fall back to rendering onto 2D canvas.
    # > Enum('canvas', 'svg', 'webgl')
    output_backend = NULL,
    # Additional named ranges to make available for mapping x-coordinates.
    # 
    # This is useful for adding additional axes.
    # > Dict(String, Instance(Range))
    extra_x_ranges = NULL,
    # The outer height of a plot, including any axes, titles, border padding,
    # etc.
    # 
    # .. note:: This corresponds directly to the height of the HTML canvas.
    # > Int
    plot_height = NULL,
    # The (default) data range of the vertical dimension of the plot.
    # > Instance(Range)
    y_range = NULL,
    # The line dash for the plot border outline.
    # > DashPattern
    outline_line_dash = NULL,
    # What kind of scale to use to convert x-coordinates in data space into
    # x-coordinates in screen space.
    # > Instance(Scale)
    x_scale = NULL,
    # Timeout (in ms) for checking whether interactive tool events are still
    # occurring. Once level-of-detail mode is enabled, a check is made every
    # ``lod_timeout`` ms. If no interactive tool events have happened,
    # level-of-detail mode is disabled.
    # > Int
    lod_timeout = NULL,
    # Minimum size in pixels of the padding region below the bottom of the
    # central plot region.
    # 
    # .. note:: This is a *minimum*. The padding region may expand as needed
    # to accommodate titles or axes, etc.
    # > Int
    min_border_bottom = NULL,
    # The fill alpha for the plot background style.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    background_fill_alpha = NULL,
    # A list of all renderers for this plot, including guides and annotations
    # in addition to glyphs and markers.
    # 
    # This property can be manipulated by hand, but the ``add_glyph`` and
    # ``add_layout`` methods are recommended to help make sure all necessary
    # setup is performed.
    # > List(Instance(Renderer))
    renderers = NULL,
    # A convenience property to set all all the ``min_border_X`` properties
    # to the same value. If an individual border property is explicitly set,
    # it will override ``min_border``.
    # > Int
    min_border = NULL,
    # A number of data points, above which level-of-detail downsampling may
    # be performed by glyph renderers. Set to ``None`` to disable any
    # level-of-detail downsampling.
    # > Int
    lod_threshold = NULL,
    # Where the title will be located. Titles on the left or right side will
    # be rotated.
    # > Enum('above', 'below', 'left', 'right')
    title_location = NULL,
    # Where the toolbar will be located. If set to None, no toolbar will be
    # attached to the plot.
    # > Enum('above', 'below', 'left', 'right')
    toolbar_location = NULL
  )
)

# A base class for different toolbars.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
ToolbarBase <- R6::R6Class("ToolbarBase",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      logo = "normal", js_property_callbacks = structure(list(), .Names =
      character(0)), tags = list(), autohide = FALSE,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), tools = list(), name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["ToolbarBase"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # What version of the Bokeh logo to display on the toolbar. If set to
    # None, no logo will be displayed.
    # > Enum('normal', 'grey')
    logo = NULL,
    # Whether the toolbar will be hidden by default. Default: False.  If
    # True, hides toolbar when cursor is not in canvas.
    # > Bool
    autohide = NULL,
    # A list of tools to add to the plot.
    # > List(Instance(Tool))
    tools = NULL
  )
)

# A base class for non-categorical ticker types.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
ContinuousTicker <- R6::R6Class("ContinuousTicker",
  inherit = Ticker,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), desired_num_ticks = 6L,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), name = NULL, num_minor_ticks = 5L, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["ContinuousTicker"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A desired target number of major tick positions to generate across the
    # plot range.
    # 
    # .. note: This value is a suggestion, and ticker subclasses may ignore
    # it entirely, or use it only as an ideal goal to approach as well as can
    # be, in the context of a specific ticking strategy.
    # > Int
    desired_num_ticks = NULL,
    # The number of minor tick positions to generate between adjacent major
    # tick values.
    # > Int
    num_minor_ticks = NULL
  )
)

# Generate nice lat/lon ticks form underlying WebMercator coordinates.
MercatorTicker <- R6::R6Class("MercatorTicker",
  inherit = BasicTicker,
  public = list(
    specified_args = NULL,
    initialize = function(
      base = 10, max_interval = NULL, desired_num_ticks = 6L,
      js_property_callbacks = structure(list(), .Names = character(0)),
      mantissas = list(1L, 2L, 5L), tags = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), dimension = NULL, name = NULL,
      min_interval = 0, num_minor_ticks = 5L, id = NULL
    ) {
      super$initialize(base = base, max_interval = max_interval,
        desired_num_ticks = desired_num_ticks,
        js_property_callbacks = js_property_callbacks,
        mantissas = mantissas, tags = tags,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name,
        min_interval = min_interval, num_minor_ticks = num_minor_ticks,
        id = id)
      types <- bk_prop_types[["MercatorTicker"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Specify whether to generate ticks for Latitude or Longitude.
    # 
    # Projected coordinates are not separable, computing Latitude and
    # Longitude tick locations from Web Mercator requires considering
    # coordinates from both dimensions together. Use this property to specify
    # which result should be returned.
    # 
    # Typically, if the ticker is for an x-axis, then dimension should be
    # ``"lon"`` and if the ticker is for a y-axis, then the dimension should
    # be `"lat"``.
    # 
    # In order to prevent hard to debug errors, there is no default value for
    # dimension. Using an un-configured ``MercatorTicker`` will result in a
    # validation error and a JavaScript console error.
    # > Enum('lat', 'lon')
    dimension = NULL
  )
)

# Lay out child components in a single vertical row.
# 
# Children can be specified as positional arguments, as a single argument
# that is a sequence, or using the ``children`` keyword argument.
Column <- R6::R6Class("Column",
  inherit = Box,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", disabled = FALSE,
      background = NULL, tags = list(), visible = TRUE, width_policy = "auto",
      height_policy = "auto", height = NULL, spacing = 0L, sizing_mode = NULL,
      name = NULL, max_height = NULL, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      rows = "auto", children = list(), min_height = NULL,
      subscribed_events = list(), js_event_callbacks = structure(list(),
      .Names = character(0)), width = NULL, aspect_ratio = NULL,
      margin = list(0L, 0L, 0L, 0L), id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, background = background,
        tags = tags, visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, spacing = spacing,
        sizing_mode = sizing_mode, name = name, max_height = max_height,
        css_classes = css_classes,
        js_property_callbacks = js_property_callbacks, children = children,
        min_height = min_height, subscribed_events = subscribed_events,
        js_event_callbacks = js_event_callbacks, width = width,
        aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["Column"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Describes how the component should maintain its rows' heights.
    # 
    # .. note:: This is an experimental feature and may change in future. Use
    # it at your own discretion.
    # > Either(Either(Enum('auto', 'min', 'fit', 'max'), Int), Dict(Either(Int, String), Either(Either(Enum('auto', 'min', 'fit', 'max'), Int), Struct(policy=Enum('auto', 'min'), align=Either(Auto, Enum('start', 'center', 'end'))), Struct(policy=Enum('fixed'), height=Int, align=Either(Auto, Enum('start', 'center', 'end'))), Struct(policy=Enum('fit', 'max'), align=Either(Auto, Enum('start', 'center', 'end')), flex=Float))))
    rows = NULL
  )
)

# A dropdown button.
Dropdown <- R6::R6Class("Dropdown",
  inherit = AbstractButton,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", disabled = FALSE,
      menu = list(), value = NULL, callback = NULL, background = NULL,
      button_type = "default", icon = NULL, tags = list(), visible = TRUE,
      width_policy = "auto", split = FALSE, height_policy = "auto",
      height = NULL, name = NULL, sizing_mode = NULL, default_size = 300L,
      max_height = NULL, label = "Dropdown", css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      orientation = "horizontal", js_event_callbacks = structure(list(),
      .Names = character(0)), min_height = NULL,
      subscribed_events = list(), width = NULL, aspect_ratio = NULL,
      default_value = NULL, margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, callback = callback,
        background = background, button_type = button_type, icon = icon,
        tags = tags, visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, name = name,
        sizing_mode = sizing_mode, default_size = default_size,
        max_height = max_height, label = label, css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["Dropdown"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Button's dropdown menu consisting of entries containing item's text and
    # value name. Use ``None`` as a menu separator.
    # > List(Either(String, Tuple(String, Either(String, Instance(Callback)))))
    menu = NULL,
    # A private property that used to trigger ``on_click`` event handler.
    # 
    # .. note: This property is deprecated and left for backwards
    # compatibility. Use ``dropdown.on_click()`` or
    # ``dropdown.js_on_click()`` methods in new code.
    # > String
    value = NULL,
    # 
    # > Bool
    split = NULL,
    # A default value to set when a split Dropdown's top button is clicked.
    # 
    # Setting this property will cause the Dropdown to be rendered as split.
    # 
    # .. note: This property is deprecated and left for backwards
    # compatibility. Use ``dropdown.on_click()`` or
    # ``dropdown.js_on_click()`` methods in new code.
    # > String
    default_value = NULL
  )
)

# Calendar-based date picker widget.
DatePicker <- R6::R6Class("DatePicker",
  inherit = InputWidget,
  public = list(
    specified_args = NULL,
    initialize = function(
      title = "", min_width = NULL, max_width = NULL, align = "start",
      disabled = FALSE, value = NULL, callback = NULL, background = NULL,
      tags = list(), visible = TRUE, width_policy = "auto",
      height_policy = "auto", height = NULL, name = NULL, sizing_mode = NULL,
      default_size = 300L, max_height = NULL, max_date = NULL,
      css_classes = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), orientation = "horizontal", min_date = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      min_height = NULL, subscribed_events = list(), width = NULL,
      aspect_ratio = NULL, margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(title = title, min_width = min_width,
        max_width = max_width, align = align, disabled = disabled,
        background = background, tags = tags, visible = visible,
        width_policy = width_policy, height_policy = height_policy,
        height = height, name = name, sizing_mode = sizing_mode,
        default_size = default_size, max_height = max_height,
        css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["DatePicker"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The initial or picked date.
    # > Date
    value = NULL,
    # A callback to run in the browser whenever the current date value
    # changes.
    # > Instance(Callback)
    callback = NULL,
    # Optional latest allowable date.
    # > Date
    max_date = NULL,
    # Optional earliest allowable date.
    # > Date
    min_date = NULL
  )
)

# *toolbar icon*: |box_edit_icon|
# 
# Allows drawing, dragging and deleting ``Rect`` glyphs on one or more
# renderers by editing the underlying ``ColumnDataSource`` data. Like
# other drawing tools, the renderers that are to be edited must be
# supplied explicitly as a list. When drawing a new box the data will
# always be added to the ``ColumnDataSource`` on the first supplied
# renderer.
# 
# The tool will modify the columns on the data source corresponding to
# the ``x``, ``y``, ``width`` and ``height`` values of the glyph. Any
# additional columns in the data source will be padded with
# ``empty_value``, when adding a new box.
# 
# The supported actions include:
# 
# * Add box: Hold shift then click and drag anywhere on the plot or
# double tap once to start drawing, move the mouse and double tap again
# to finish drawing.
# 
# * Move box: Click and drag an existing box, the box will be dropped
# once you let go of the mouse button.
# 
# * Delete box: Tap a box to select it then press <<backspace>> key while
# the mouse is within the plot area.
# 
# To **Move** or **Delete** multiple boxes at once:
# 
# * Move selection: Select box(es) with <<shift>>+tap (or another
# selection tool) then drag anywhere on the plot. Selecting and then
# dragging on a specific box will move both.
# 
# * Delete selection: Select box(es) with <<shift>>+tap (or another
# selection tool) then press <<backspace>> while the mouse is within the
# plot area.
# 
# .. |box_edit_icon| image:: /_images/icons/BoxEdit.png :height: 18pt
BoxEditTool <- R6::R6Class("BoxEditTool",
  inherit = EditTool,
  public = list(
    specified_args = NULL,
    initialize = function(
      custom_icon = NULL, dimensions = "both",
      js_property_callbacks = structure(list(), .Names = character(0)),
      tags = list(), renderers = list(), empty_value = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), num_objects = 0L, name = NULL,
      custom_tooltip = NULL, id = NULL
    ) {
      super$initialize(custom_icon = custom_icon,
        js_property_callbacks = js_property_callbacks, tags = tags,
        renderers = renderers, empty_value = empty_value,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name,
        custom_tooltip = custom_tooltip, id = id)
      types <- bk_prop_types[["BoxEditTool"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Which dimensions the box drawing is to be free in. By default, users
    # may freely draw boxes with any dimensions. If only "width" is set, the
    # box will be constrained to span the entire vertical space of the plot,
    # only the horizontal dimension can be controlled. If only "height" is
    # set, the box will be constrained to span the entire horizontal space of
    # the plot, and the vertical dimension can be controlled.
    # > Enum('width', 'height', 'both')
    dimensions = NULL,
    # Defines a limit on the number of boxes that can be drawn. By default
    # there is no limit on the number of objects, but if enabled the oldest
    # drawn box will be dropped to make space for the new box being added.
    # > Int
    num_objects = NULL
  )
)

# Compute a step-wise interpolation between the points provided through
# the ``x``, ``y``, and ``data`` parameters.
StepInterpolator <- R6::R6Class("StepInterpolator",
  inherit = Interpolator,
  public = list(
    specified_args = NULL,
    initialize = function(
      y = NULL, js_property_callbacks = structure(list(), .Names =
      character(0)), data = NULL, mode = "after", x = NULL, clip = TRUE,
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), name = NULL, id = NULL
    ) {
      super$initialize(y = y,
        js_property_callbacks = js_property_callbacks, data = data, x = x,
        clip = clip, tags = tags, js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name, id = id)
      types <- bk_prop_types[["StepInterpolator"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Adjust the behavior of the returned value in relation to the control
    # points.  The parameter can assume one of three values:
    # 
    # * ``after`` (default): Assume the y-value associated with the nearest
    # x-value which is less than or equal to the point to transform.  *
    # ``before``: Assume the y-value associated with the nearest x-value
    # which is greater than the point to transform.  * ``center``: Assume the
    # y-value associated with the nearest x-value to the point to transform.
    # > Enum('before', 'after', 'center')
    mode = NULL
  )
)

# Render a filled area band along a dimension.
Band <- R6::R6Class("Band",
  inherit = Annotation,
  public = list(
    specified_args = NULL,
    initialize = function(
      base = NULL, level = "annotation", upper = NULL, tags = list(),
      lower = NULL, visible = TRUE, fill_alpha = 0.4, base_units = "data",
      dimension = "height", line_dash = list(), line_color = "#cccccc",
      upper_units = "data", source = NULL, fill_color = "#fff9ba",
      line_alpha = 0.3, name = NULL, line_join = "bevel",
      x_range_name = "default", js_property_callbacks = structure(list(),
      .Names = character(0)), y_range_name = "default",
      lower_units = "data", line_dash_offset = 0L,
      js_event_callbacks = structure(list(), .Names = character(0)),
      line_width = 1L, subscribed_events = list(), line_cap = "butt", id = NULL
    ) {
      super$initialize(level = level, tags = tags, visible = visible,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["Band"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The orthogonal coordinates of the upper and lower values.
    # > UnitsSpec(units_default='data')
    base = NULL,
    # The coordinates of the upper portion of the filled area band.
    # > UnitsSpec(units_default='data')
    upper = NULL,
    # The coordinates of the lower portion of the filled area band.
    # > UnitsSpec(units_default='data')
    lower = NULL,
    # The fill alpha values for the band.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    fill_alpha = NULL,
    # 
    # > Enum('screen', 'data')
    base_units = NULL,
    # The direction of the band can be specified by setting this property to
    # "height" (``y`` direction) or "width" (``x`` direction).
    # > Enum('width', 'height')
    dimension = NULL,
    # The line dash values for the band.
    # > DashPattern
    line_dash = NULL,
    # The line color values for the band.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # 
    # > Enum('screen', 'data')
    upper_units = NULL,
    # Local data source to use when rendering annotations on the plot.
    # > Instance(DataSource)
    source = NULL,
    # The fill color values for the band.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    fill_color = NULL,
    # The line alpha values for the band.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL,
    # The line join values for the band.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # A particular (named) x-range to use for computing screen locations when
    # rendering annotations on the plot. If unset, use the default x-range.
    # > String
    x_range_name = NULL,
    # A particular (named) y-range to use for computing screen locations when
    # rendering annotations on the plot. If unset, use the default y-range.
    # > String
    y_range_name = NULL,
    # 
    # > Enum('screen', 'data')
    lower_units = NULL,
    # The line dash offset values for the band.
    # > Int
    line_dash_offset = NULL,
    # The line width values for the band.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL,
    # The line cap values for the band.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL
  )
)

# Render a tooltip.
# 
# .. note:: This model is currently managed by BokehJS and is not useful
# directly from python.
Tooltip <- R6::R6Class("Tooltip",
  inherit = Annotation,
  public = list(
    specified_args = NULL,
    initialize = function(
      level = "overlay", inner_only = TRUE,
      js_property_callbacks = structure(list(), .Names = character(0)),
      show_arrow = TRUE, tags = list(), visible = TRUE,
      attachment = "horizontal", js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(), name = NULL,
      id = NULL
    ) {
      super$initialize(level = level, tags = tags, visible = visible,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["Tooltip"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Whether to display outside a central plot frame area.
    # > Bool
    inner_only = NULL,
    # Whether tooltip's arrow should be shown.
    # > Bool
    show_arrow = NULL,
    # Whether the tooltip should be displayed to the left or right of the
    # cursor position or above or below it, or if it should be automatically
    # placed in the horizontal or vertical dimension.
    # > Enum('horizontal', 'vertical', 'left', 'right', 'above', 'below')
    attachment = NULL
  )
)

# A two-state toggle button.
Toggle <- R6::R6Class("Toggle",
  inherit = AbstractButton,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", disabled = FALSE,
      callback = NULL, background = NULL, button_type = "default", icon = NULL,
      tags = list(), visible = TRUE, width_policy = "auto",
      height_policy = "auto", height = NULL, name = NULL, sizing_mode = NULL,
      default_size = 300L, max_height = NULL, label = "Toggle",
      css_classes = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), orientation = "horizontal", active = FALSE,
      js_event_callbacks = structure(list(), .Names = character(0)),
      min_height = NULL, subscribed_events = list(), width = NULL,
      aspect_ratio = NULL, margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, callback = callback,
        background = background, button_type = button_type, icon = icon,
        tags = tags, visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, name = name,
        sizing_mode = sizing_mode, default_size = default_size,
        max_height = max_height, label = label, css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["Toggle"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The initial state of a button. Also used to trigger ``on_click`` event
    # handler.
    # > Bool
    active = NULL
  )
)

# A block (paragraph) of pre-formatted text.
# 
# This Bokeh model corresponds to an HTML ``<pre>`` element.
# 
# Example -------
# 
# .. bokeh-plot::
# ../../sphinx/source/docs/user_guide/examples/interaction_pretext.py
# :source-position: below
PreText <- R6::R6Class("PreText",
  inherit = Paragraph,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", disabled = FALSE,
      style = structure(list(), .Names = character(0)), background = NULL,
      text = "", tags = list(), visible = TRUE, width_policy = "auto",
      height_policy = "auto", height = NULL, name = NULL, sizing_mode = NULL,
      default_size = 300L, max_height = NULL, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      orientation = "horizontal", js_event_callbacks = structure(list(),
      .Names = character(0)), min_height = NULL,
      subscribed_events = list(), width = NULL, aspect_ratio = NULL,
      margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, style = style,
        background = background, text = text, tags = tags, visible = visible,
        width_policy = width_policy, height_policy = height_policy,
        height = height, name = name, sizing_mode = sizing_mode,
        default_size = default_size, max_height = max_height,
        css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["PreText"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Boolean value cell editor.
CheckboxEditor <- R6::R6Class("CheckboxEditor",
  inherit = CellEditor,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["CheckboxEditor"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# HTML formatter using a template.  This uses Underscore's `template`
# method and syntax.  http://underscorejs.org/#template The formatter has
# access other items in the row via the `dataContext` object passed to
# the formatter.  So, for example, if another column in the datasource
# was named `url`, the template could access it as:
# 
# .. code-block:: jinja
# 
# <a href="<%= url %>"><%= value %></a>
# 
# To use a different set of template delimiters, pass the appropriate
# values for `evaluate`, `interpolate', or `escape`.  See the Underscore
# `template` documentation for more information.
# http://underscorejs.org/#template
# 
# Example: Simple HTML template to format the column value as code.
# 
# .. code-block:: python
# 
# HTMLTemplateFormatter(template='<code><%= value %></code>')
# 
# Example: Use values from other columns (`manufacturer` and `model`) to
# build a hyperlink.
# 
# .. code-block:: python
# 
# HTMLTemplateFormatter(template= '<a
# href="https:/www.google.com/search?q=<%= manufacturer %>+<%= model %>"
# target="_blank"><%= value %></a>' )
HTMLTemplateFormatter <- R6::R6Class("HTMLTemplateFormatter",
  inherit = CellFormatter,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), template = "<%= value %>",
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["HTMLTemplateFormatter"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Template string to be used by Underscore's template method.
    # > String
    template = NULL
  )
)

# A base class for data source types.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
DataSource <- R6::R6Class("DataSource",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), selected = NULL, js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, callback = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["DataSource"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A Selection that indicates selected indices on this ``DataSource``.
    # > Instance(Selection)
    selected = NULL,
    # A callback to run in the browser whenever the selection is changed.
    # 
    # .. note: This property is left for backwards compatibility, but may be
    # deprecated in the future. Prefer ``source.selected.js_on_change(...)``
    # for new code.
    # > Instance(Callback)
    callback = NULL
  )
)

# A base class for all data range types.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
DataRange <- R6::R6Class("DataRange",
  inherit = Range,
  public = list(
    specified_args = NULL,
    initialize = function(
      js_property_callbacks = structure(list(), .Names = character(0)),
      callback = NULL, tags = list(), renderers = list(), names = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), name = NULL, id = NULL
    ) {
      super$initialize(tags = tags,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name,
        callback = callback, id = id)
      types <- bk_prop_types[["DataRange"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # An explicit list of renderers to autorange against. If unset, defaults
    # to all renderers on a plot.
    # > List(Instance(Renderer))
    renderers = NULL,
    # A list of names to query for. If set, only renderers that have a
    # matching value for their ``name`` attribute will be used for
    # autoranging.
    # > List(String)
    names = NULL
  )
)

# Base class for remote column data sources that can update from data
# URLs at prescribed time intervals.
# 
# .. note:: This base class is typically not useful to instantiate on its
# own.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
RemoteSource <- R6::R6Class("RemoteSource",
  inherit = WebSource,
  public = list(
    specified_args = NULL,
    initialize = function(
      selected = NULL, js_property_callbacks = structure(list(), .Names =
      character(0)), mode = "replace", data = structure(list(), .Names =
      character(0)), callback = NULL, max_size = NULL,
      polling_interval = NULL, adapter = NULL, name = NULL, tags = list(),
      selection_policy = NULL, js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(), data_url = NULL,
      id = NULL
    ) {
      super$initialize(selected = selected,
        js_property_callbacks = js_property_callbacks, data = data,
        mode = mode, callback = callback, max_size = max_size, name = name,
        adapter = adapter, tags = tags, selection_policy = selection_policy,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, data_url = data_url, id = id)
      types <- bk_prop_types[["RemoteSource"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A polling interval (in milliseconds) for updating data source.
    # > Int
    polling_interval = NULL
  )
)

# Render horizontal bars, given a center coordinate, ``height`` and
# (``left``, ``right``) coordinates.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/HBar.py
# :source-position: below
HBar <- R6::R6Class("HBar",
  inherit = Glyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      hatch_extra = structure(list(), .Names = character(0)),
      hatch_weight = 1, tags = list(), hatch_scale = 12, fill_alpha = 1,
      hatch_pattern = NULL, height = NULL, line_color = "black",
      line_dash = list(), name = NULL, fill_color = "gray", line_alpha = 1,
      y = NULL, js_property_callbacks = structure(list(), .Names =
      character(0)), hatch_alpha = 1, left = 0L, hatch_color = "black",
      line_dash_offset = 0L, js_event_callbacks = structure(list(), .Names
      = character(0)), line_join = "bevel", subscribed_events = list(),
      right = NULL, line_cap = "butt", line_width = 1L, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["HBar"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The hatch extra values for the horizontal bars.
    # > Dict(String, Instance(Texture))
    hatch_extra = NULL,
    # The hatch weight values for the horizontal bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    hatch_weight = NULL,
    # The hatch scale values for the horizontal bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    hatch_scale = NULL,
    # The fill alpha values for the horizontal bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    fill_alpha = NULL,
    # The hatch pattern values for the horizontal bars.
    # > HatchPatternSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), HatchPatternType)), HatchPatternType)
    hatch_pattern = NULL,
    # The heights of the vertical bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    height = NULL,
    # The line color values for the horizontal bars.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The line dash values for the horizontal bars.
    # > DashPattern
    line_dash = NULL,
    # The fill color values for the horizontal bars.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    fill_color = NULL,
    # The line alpha values for the horizontal bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL,
    # The y-coordinates of the centers of the horizontal bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y = NULL,
    # The hatch alpha values for the horizontal bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    hatch_alpha = NULL,
    # The x-coordinates of the left edges.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    left = NULL,
    # The hatch color values for the horizontal bars.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    hatch_color = NULL,
    # The line dash offset values for the horizontal bars.
    # > Int
    line_dash_offset = NULL,
    # The line join values for the horizontal bars.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # The x-coordinates of the right edges.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    right = NULL,
    # The line cap values for the horizontal bars.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line width values for the horizontal bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL
  )
)

# Render wedges.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/Wedge.py
# :source-position: below
Wedge <- R6::R6Class("Wedge",
  inherit = XYGlyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      start_angle_units = "rad", x = NULL, start_angle = NULL, tags = list(),
      fill_alpha = 1, radius_units = "data", line_dash = list(),
      line_color = "black", name = NULL, fill_color = "gray", line_alpha = 1,
      y = NULL, js_property_callbacks = structure(list(), .Names =
      character(0)), radius = NULL, end_angle_units = "rad",
      line_dash_offset = 0L, direction = "anticlock", line_join = "bevel",
      subscribed_events = list(), js_event_callbacks = structure(list(),
      .Names = character(0)), end_angle = NULL, line_cap = "butt",
      line_width = 1L, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Wedge"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # 
    # > Enum('deg', 'rad')
    start_angle_units = NULL,
    # The x-coordinates of the points of the wedges.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x = NULL,
    # The angles to start the wedges, as measured from the horizontal.
    # > AngleSpec(units_default='rad')
    start_angle = NULL,
    # The fill alpha values for the wedges.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    fill_alpha = NULL,
    # 
    # > Enum('screen', 'data')
    radius_units = NULL,
    # The line dash values for the wedges.
    # > DashPattern
    line_dash = NULL,
    # The line color values for the wedges.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The fill color values for the wedges.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    fill_color = NULL,
    # The line alpha values for the wedges.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL,
    # The y-coordinates of the points of the wedges.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y = NULL,
    # Radii of the wedges.
    # > DistanceSpec(units_default='data')
    radius = NULL,
    # 
    # > Enum('deg', 'rad')
    end_angle_units = NULL,
    # The line dash offset values for the wedges.
    # > Int
    line_dash_offset = NULL,
    # Which direction to stroke between the start and end angles.
    # > Enum('clock', 'anticlock')
    direction = NULL,
    # The line join values for the wedges.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # The angles to end the wedges, as measured from the horizontal.
    # > AngleSpec(units_default='rad')
    end_angle = NULL,
    # The line cap values for the wedges.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line width values for the wedges.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL
  )
)

# 
ToolbarPanel <- R6::R6Class("ToolbarPanel",
  inherit = Annotation,
  public = list(
    specified_args = NULL,
    initialize = function(
      level = "annotation", js_property_callbacks = structure(list(),
      .Names = character(0)), toolbar = NULL, tags = list(), visible = TRUE,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), name = NULL, id = NULL
    ) {
      super$initialize(level = level, tags = tags, visible = visible,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["ToolbarPanel"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A toolbar to display.
    # > Instance(Toolbar)
    toolbar = NULL
  )
)

# Base class for ``Transform`` models that represent a computation to be
# carried out on the client-side.
# 
# JavaScript implementations should implement the following methods:
# 
# .. code-block:: coffeescript
# 
# compute: (x) -> # compute the transform of a single value
# 
# v_compute: (xs) -> # compute the transform of an array of values
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
Transform <- R6::R6Class("Transform",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Transform"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Range-slider based number range selection widget.
RangeSlider <- R6::R6Class("RangeSlider",
  inherit = AbstractSlider,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, align = "start", start = NULL, callback = NULL,
      tags = list(), width_policy = "auto", height_policy = "auto", step = 1L,
      height = NULL, callback_policy = "throttle", value_throttled = NULL,
      callback_throttle = 200L, max_height = NULL, show_value = TRUE,
      format = "0[.]00", js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), width = NULL,
      aspect_ratio = NULL, tooltips = TRUE, margin = list(5L, 5L, 5L, 5L),
      end = NULL, title = "", max_width = NULL, disabled = FALSE, value = NULL,
      bar_color = "#e6e6e6", background = NULL, visible = TRUE, name = NULL,
      sizing_mode = NULL, default_size = 300L, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      orientation = "horizontal", direction = "ltr", min_height = NULL,
      id = NULL
    ) {
      super$initialize(title = title, min_width = min_width,
        max_width = max_width, align = align, disabled = disabled,
        bar_color = bar_color, callback = callback, background = background,
        tags = tags, visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, name = name,
        sizing_mode = sizing_mode, callback_policy = callback_policy,
        default_size = default_size, callback_throttle = callback_throttle,
        max_height = max_height, show_value = show_value,
        css_classes = css_classes, format = format,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, direction = direction,
        min_height = min_height, subscribed_events = subscribed_events,
        js_event_callbacks = js_event_callbacks, width = width,
        aspect_ratio = aspect_ratio, tooltips = tooltips, margin = margin,
        id = id)
      types <- bk_prop_types[["RangeSlider"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The minimum allowable value.
    # > Float
    start = NULL,
    # The step between consecutive values.
    # > Float
    step = NULL,
    # Initial or selected value, throttled according to callback_policy.
    # > Tuple(Float, Float)
    value_throttled = NULL,
    # The maximum allowable value.
    # > Float
    end = NULL,
    # Initial or selected range.
    # > Tuple(Float, Float)
    value = NULL
  )
)

# A Bokeh Plot with a `Google Map`_ displayed underneath.
# 
# Data placed on this plot should be specified in decimal lat/lon
# coordinates e.g. ``(37.123, -122.404)``. It will be automatically
# converted into the web mercator projection to display properly over
# google maps tiles.
# 
# Note that Google Maps exert explicit control over aspect ratios at all
# times, which imposes some limitations on ``GMapPlot``:
# 
# * Only ``Range1d`` ranges are supported. Attempting to use other range
# types will result in an error.
# 
# * Usage of ``BoxZoomTool`` is incompatible with ``GMapPlot``. Adding a
# ``BoxZoomTool`` will have no effect.
# 
# .. _Google Map: https://www.google.com/maps/
GMapPlot <- R6::R6Class("GMapPlot",
  inherit = MapPlot,
  public = list(
    specified_args = NULL,
    initialize = function(
      inner_height = NULL, min_border_top = NULL, lod_factor = 10L,
      aspect_scale = 1L, min_width = NULL, align = "start",
      extra_y_ranges = structure(list(), .Names = character(0)),
      tags = list(), match_aspect = FALSE, outer_height = NULL,
      min_border_left = NULL, toolbar_sticky = TRUE, min_border = 5L,
      width_policy = "auto", below = list(), height_policy = "auto",
      height = NULL, frame_width = NULL, outline_line_cap = "butt",
      outline_line_width = 1L, max_height = NULL, plot_width = 600L,
      above = list(), hidpi = TRUE, outer_width = NULL, left = list(),
      outline_line_color = "#e5e5e5", min_border_right = NULL,
      outline_line_dash_offset = 0L, js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(), right = list(),
      width = NULL, aspect_ratio = NULL, border_fill_color = "#ffffff",
      lod_interval = 300L, margin = list(0L, 0L, 0L, 0L), title = NULL,
      x_range = NULL, max_width = NULL, disabled = FALSE,
      background_fill_color = "#ffffff", toolbar = NULL, background = NULL,
      reset_policy = "standard", inner_width = NULL, y_scale = NULL,
      border_fill_alpha = 1, visible = TRUE, outline_line_alpha = 1,
      outline_line_join = "bevel", center = list(),
      output_backend = "canvas", extra_x_ranges = structure(list(), .Names
      = character(0)), plot_height = 600L, y_range = NULL,
      outline_line_dash = list(), sizing_mode = NULL, name = NULL,
      x_scale = NULL, lod_timeout = 500L, api_key = NULL, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      min_border_bottom = NULL, map_options = NULL,
      background_fill_alpha = 1, renderers = list(), min_height = NULL,
      frame_height = NULL, lod_threshold = 2000L, title_location = "above",
      toolbar_location = "right", id = NULL
    ) {
      super$initialize(inner_height = inner_height,
        min_border_top = min_border_top, lod_factor = lod_factor,
        aspect_scale = aspect_scale, min_width = min_width, align = align,
        extra_y_ranges = extra_y_ranges, frame_height = frame_height,
        tags = tags, match_aspect = match_aspect,
        outer_height = outer_height, min_border_left = min_border_left,
        toolbar_sticky = toolbar_sticky, width_policy = width_policy,
        height_policy = height_policy, below = below, height = height,
        frame_width = frame_width, outline_line_cap = outline_line_cap,
        outline_line_width = outline_line_width, max_height = max_height,
        plot_width = plot_width, above = above, hidpi = hidpi,
        outer_width = outer_width, left = left,
        outline_line_color = outline_line_color,
        min_border_right = min_border_right,
        outline_line_dash_offset = outline_line_dash_offset,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, right = right, width = width,
        aspect_ratio = aspect_ratio, border_fill_color = border_fill_color,
        lod_interval = lod_interval, margin = margin, title = title,
        x_range = x_range, max_width = max_width, disabled = disabled,
        background_fill_color = background_fill_color, toolbar = toolbar,
        background = background, reset_policy = reset_policy,
        inner_width = inner_width, y_scale = y_scale,
        border_fill_alpha = border_fill_alpha, visible = visible,
        outline_line_alpha = outline_line_alpha,
        outline_line_join = outline_line_join, center = center,
        output_backend = output_backend, extra_x_ranges = extra_x_ranges,
        plot_height = plot_height, y_range = y_range,
        outline_line_dash = outline_line_dash, sizing_mode = sizing_mode,
        name = name, x_scale = x_scale, lod_timeout = lod_timeout,
        css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        min_border_bottom = min_border_bottom,
        background_fill_alpha = background_fill_alpha,
        renderers = renderers, min_height = min_height,
        min_border = min_border, lod_threshold = lod_threshold,
        title_location = title_location,
        toolbar_location = toolbar_location, id = id)
      types <- bk_prop_types[["GMapPlot"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Google Maps API requires an API key. See
    # https://developers.google.com/maps/documentation/javascript/get-api-key
    # for more information on how to obtain your own.
    # > String
    api_key = NULL,
    # Options for displaying the plot.
    # > Instance(GMapOptions)
    map_options = NULL
  )
)

# Generate ticks for categorical ranges.
CategoricalTicker <- R6::R6Class("CategoricalTicker",
  inherit = Ticker,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["CategoricalTicker"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# 
GraphRenderer <- R6::R6Class("GraphRenderer",
  inherit = DataRenderer,
  public = list(
    specified_args = NULL,
    initialize = function(
      level = "glyph", node_renderer = NULL,
      js_property_callbacks = structure(list(), .Names = character(0)),
      x_range_name = "default", y_range_name = "default",
      edge_renderer = NULL, layout_provider = NULL, name = NULL, tags = list(),
      selection_policy = NULL, visible = TRUE,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), inspection_policy = NULL, id = NULL
    ) {
      super$initialize(level = level,
        js_property_callbacks = js_property_callbacks,
        x_range_name = x_range_name, y_range_name = y_range_name,
        tags = tags, visible = visible,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name, id = id)
      types <- bk_prop_types[["GraphRenderer"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Instance of a ``GlyphRenderer`` containing an ``XYGlyph`` that will be
    # rendered as the graph nodes.
    # > Instance(GlyphRenderer)
    node_renderer = NULL,
    # Instance of a ``GlyphRenderer`` containing an ``MultiLine`` Glyph that
    # will be rendered as the graph edges.
    # > Instance(GlyphRenderer)
    edge_renderer = NULL,
    # An instance of a ``LayoutProvider`` that supplies the layout of the
    # network graph in cartesian space.
    # > Instance(LayoutProvider)
    layout_provider = NULL,
    # An instance of a ``GraphHitTestPolicy`` that provides the logic for
    # selection of graph components.
    # > Instance(GraphHitTestPolicy)
    selection_policy = NULL,
    # An instance of a ``GraphHitTestPolicy`` that provides the logic for
    # inspection of graph components.
    # > Instance(GraphHitTestPolicy)
    inspection_policy = NULL
  )
)

# Slider-based date selection widget.
DateSlider <- R6::R6Class("DateSlider",
  inherit = AbstractSlider,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, align = "start", start = NULL, callback = NULL,
      tags = list(), width_policy = "auto", height_policy = "auto", step = 1L,
      height = NULL, callback_policy = "throttle", value_throttled = NULL,
      callback_throttle = 200L, max_height = NULL, show_value = TRUE,
      format = "%d %b %Y", js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), width = NULL,
      aspect_ratio = NULL, tooltips = TRUE, margin = list(5L, 5L, 5L, 5L),
      end = NULL, title = "", max_width = NULL, disabled = FALSE, value = NULL,
      bar_color = "#e6e6e6", background = NULL, visible = TRUE, name = NULL,
      sizing_mode = NULL, default_size = 300L, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      orientation = "horizontal", direction = "ltr", min_height = NULL,
      id = NULL
    ) {
      super$initialize(title = title, min_width = min_width,
        max_width = max_width, align = align, disabled = disabled,
        bar_color = bar_color, callback = callback, background = background,
        tags = tags, visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, name = name,
        sizing_mode = sizing_mode, callback_policy = callback_policy,
        default_size = default_size, callback_throttle = callback_throttle,
        max_height = max_height, show_value = show_value,
        css_classes = css_classes, format = format,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, direction = direction,
        min_height = min_height, subscribed_events = subscribed_events,
        js_event_callbacks = js_event_callbacks, width = width,
        aspect_ratio = aspect_ratio, tooltips = tooltips, margin = margin,
        id = id)
      types <- bk_prop_types[["DateSlider"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The minimum allowable value.
    # > Date
    start = NULL,
    # The step between consecutive values.
    # > Int
    step = NULL,
    # Initial or selected value, throttled according to callback_policy.
    # > Date
    value_throttled = NULL,
    # The maximum allowable value.
    # > Date
    end = NULL,
    # Initial or selected value.
    # > Date
    value = NULL
  )
)

# Present a file-chooser dialog to users and return the contents of a
# selected file.
FileInput <- R6::R6Class("FileInput",
  inherit = Widget,
  public = list(
    specified_args = NULL,
    initialize = function(
      accept = "", min_width = NULL, max_width = NULL, filename = "",
      align = "start", disabled = FALSE, value = "", background = NULL,
      tags = list(), visible = TRUE, width_policy = "auto",
      height_policy = "auto", height = NULL, name = NULL, sizing_mode = NULL,
      default_size = 300L, max_height = NULL, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      orientation = "horizontal", js_event_callbacks = structure(list(),
      .Names = character(0)), min_height = NULL,
      subscribed_events = list(), width = NULL, aspect_ratio = NULL,
      mime_type = "", margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, background = background,
        tags = tags, visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, name = name,
        sizing_mode = sizing_mode, default_size = default_size,
        max_height = max_height, css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["FileInput"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Comma-separated list of standard HTML file input filters that restrict
    # what files the user can pick from. Values can be:
    # 
    # `<file extension>`: Specific file extension(s) (e.g: .gif, .jpg, .png,
    # .doc) are pickable
    # 
    # `audio/*`: all sound files are pickable
    # 
    # `video/*`: all video files are pickable
    # 
    # `image/*`: all image files are pickable
    # 
    # `<media type>`: A valid `IANA Media Type`_, with no parameters.
    # 
    # .. _IANA Media Type:
    # https://www.iana.org/assignments/media-types/media-types.xhtml
    # > String
    accept = NULL,
    # The filename of the selected file.  The file path is not included as
    # browsers do not allow access to it.
    # > String
    filename = NULL,
    # A base64-encoded string of the contents of the selected file.
    # > String
    value = NULL,
    # The mime type of the selected file.
    # > String
    mime_type = NULL
  )
)

# *toolbar icon*: |freehand_draw_icon|
# 
# Allows freehand drawing of ``Patches`` and ``MultiLine`` glyphs. The
# glyph to draw may be defined via the ``renderers`` property.
# 
# The tool will modify the columns on the data source corresponding to
# the ``xs`` and ``ys`` values of the glyph. Any additional columns in
# the data source will be padded with the declared ``empty_value``, when
# adding a new point.
# 
# The supported actions include:
# 
# * Draw vertices: Click and drag to draw a line
# 
# * Delete patch/multi-line: Tap a patch/multi-line to select it then
# press <<backspace>> key while the mouse is within the plot area.
# 
# .. |freehand_draw_icon| image:: /_images/icons/FreehandDraw.png
# :height: 18pt
FreehandDrawTool <- R6::R6Class("FreehandDrawTool",
  inherit = EditTool,
  public = list(
    specified_args = NULL,
    initialize = function(
      custom_icon = NULL, js_property_callbacks = structure(list(), .Names
      = character(0)), tags = list(), renderers = list(), empty_value = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), num_objects = 0L, name = NULL,
      custom_tooltip = NULL, id = NULL
    ) {
      super$initialize(custom_icon = custom_icon,
        js_property_callbacks = js_property_callbacks, tags = tags,
        renderers = renderers, empty_value = empty_value,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name,
        custom_tooltip = custom_tooltip, id = id)
      types <- bk_prop_types[["FreehandDrawTool"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Defines a limit on the number of patches or multi-lines that can be
    # drawn.  By default there is no limit on the number of objects, but if
    # enabled the oldest drawn patch or multi-line will be overwritten when
    # the limit is reached.
    # > Int
    num_objects = NULL
  )
)

# A base class for data source types, which can be mapped onto a columnar
# format.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
ColumnarDataSource <- R6::R6Class("ColumnarDataSource",
  inherit = DataSource,
  public = list(
    specified_args = NULL,
    initialize = function(
      selected = NULL, js_property_callbacks = structure(list(), .Names =
      character(0)), callback = NULL, tags = list(), selection_policy = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), name = NULL, id = NULL
    ) {
      super$initialize(tags = tags, selected = selected,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name,
        callback = callback, id = id)
      types <- bk_prop_types[["ColumnarDataSource"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # An instance of a ``SelectionPolicy`` that determines how selections are
    # set.
    # > Instance(SelectionPolicy)
    selection_policy = NULL
  )
)

# A ``TickFormatter`` for values in WebMercator units.
# 
# Some map plot types internally use WebMercator to describe coordinates,
# plot bounds, etc. These units are not very human-friendly. This tick
# formatter will convert WebMercator units into Latitude and Longitude
# for display on axes.
MercatorTickFormatter <- R6::R6Class("MercatorTickFormatter",
  inherit = BasicTickFormatter,
  public = list(
    specified_args = NULL,
    initialize = function(
      use_scientific = TRUE, power_limit_high = 5L,
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, tags = list(), precision = "auto",
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), dimension = NULL, power_limit_low = -3L,
      id = NULL
    ) {
      super$initialize(use_scientific = use_scientific,
        power_limit_high = power_limit_high,
        js_property_callbacks = js_property_callbacks, name = name,
        tags = tags, precision = precision,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        power_limit_low = power_limit_low, id = id)
      types <- bk_prop_types[["MercatorTickFormatter"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Specify whether to format ticks for Latitude or Longitude.
    # 
    # Projected coordinates are not separable, computing Latitude and
    # Longitude tick labels from Web Mercator requires considering
    # coordinates from both dimensions together. Use this property to specify
    # which result should be used for display.
    # 
    # Typically, if the formatter is for an x-axis, then dimension should be
    # ``"lon"`` and if the formatter is for a y-axis, then the dimension
    # should be `"lat"``.
    # 
    # In order to prevent hard to debug errors, there is no default value for
    # dimension. Using an un-configured ``MercatorTickFormatter`` will result
    # in a validation error and a JavaScript console error.
    # > Enum('lat', 'lon')
    dimension = NULL
  )
)

# Render images given as scalar data together with a color mapper.
# 
# In addition to the defined model properties, ``Image`` also can accept
# a keyword argument ``palette`` in place of an explicit
# ``color_mapper``.  The value should be a list of colors, or the name of
# one of the built-in palettes in ``bokeh.palettes``. This palette will
# be used to automatically construct a ``ColorMapper`` model for the
# ``color_mapper`` property.
# 
# If both ``palette`` and ``color_mapper`` are passed, a ``ValueError``
# exception will be raised. If neither is passed, then the ``Greys9``
# palette will be used as a default.
Image <- R6::R6Class("Image",
  inherit = XYGlyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      dw = NULL, y = NULL, color_mapper = NULL,
      js_property_callbacks = structure(list(), .Names = character(0)),
      image = NULL, x = NULL, dw_units = "data", global_alpha = 1, tags = list(),
      dilate = FALSE, js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), name = NULL,
      dh_units = "data", dh = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Image"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The widths of the plot regions that the images will occupy.
    # 
    # .. note:: This is not the number of pixels that an image is wide.  That
    # number is fixed by the image itself.
    # > DistanceSpec(units_default='data')
    dw = NULL,
    # The y-coordinates to locate the image anchors.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y = NULL,
    # A ``ColorMapper`` to use to map the scalar data from ``image`` into
    # RGBA values for display.
    # 
    # .. note:: The color mapping step happens on the client.
    # > Instance(ColorMapper)
    color_mapper = NULL,
    # The arrays of scalar data for the images to be colormapped.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    image = NULL,
    # The x-coordinates to locate the image anchors.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x = NULL,
    # 
    # > Enum('screen', 'data')
    dw_units = NULL,
    # An overall opacity that each image is rendered with (in addition to any
    # alpha values applied explicitly in a color mapper).
    # > Float
    global_alpha = NULL,
    # Whether to always round fractional pixel locations in such a way as to
    # make the images bigger.
    # 
    # This setting may be useful if pixel rounding errors are causing images
    # to have a gap between them, when they should appear flush.
    # > Bool
    dilate = NULL,
    # 
    # > Enum('screen', 'data')
    dh_units = NULL,
    # The height of the plot region that the image will occupy.
    # 
    # .. note:: This is not the number of pixels that an image is tall.  That
    # number is fixed by the image itself.
    # > DistanceSpec(units_default='data')
    dh = NULL
  )
)

# 
LinearScale <- R6::R6Class("LinearScale",
  inherit = Scale,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["LinearScale"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Single-line input widget with auto-completion.
AutocompleteInput <- R6::R6Class("AutocompleteInput",
  inherit = TextInput,
  public = list(
    specified_args = NULL,
    initialize = function(
      title = "", min_width = NULL, max_width = NULL, align = "start",
      disabled = FALSE, value = "", callback = NULL, background = NULL,
      tags = list(), min_characters = 2L, value_input = "", visible = TRUE,
      width_policy = "auto", height_policy = "auto", height = NULL,
      name = NULL, sizing_mode = NULL, default_size = 300L, max_height = NULL,
      placeholder = "", css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      orientation = "horizontal", js_event_callbacks = structure(list(),
      .Names = character(0)), min_height = NULL,
      subscribed_events = list(), width = NULL, aspect_ratio = NULL,
      completions = list(), margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(title = title, min_width = min_width,
        max_width = max_width, align = align, disabled = disabled,
        value = value, callback = callback, background = background,
        tags = tags, value_input = value_input, visible = visible,
        width_policy = width_policy, height_policy = height_policy,
        height = height, name = name, sizing_mode = sizing_mode,
        default_size = default_size, max_height = max_height,
        placeholder = placeholder, css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["AutocompleteInput"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The number of characters a user must type before completions are
    # presented.
    # > PositiveInt
    min_characters = NULL,
    # A list of completion strings. This will be used to guide the user upon
    # typing the beginning of a desired value.
    # > List(String)
    completions = NULL
  )
)

# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
LayoutProvider <- R6::R6Class("LayoutProvider",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["LayoutProvider"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Render annular wedges.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/AnnularWedge.py
# :source-position: below
AnnularWedge <- R6::R6Class("AnnularWedge",
  inherit = XYGlyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      start_angle_units = "rad", inner_radius_units = "data", x = NULL,
      start_angle = NULL, tags = list(), fill_alpha = 1, line_color = "black",
      line_dash = list(), name = NULL, fill_color = "gray", line_alpha = 1,
      y = NULL, inner_radius = NULL,
      js_property_callbacks = structure(list(), .Names = character(0)),
      end_angle_units = "rad", outer_radius_units = "data",
      line_dash_offset = 0L, direction = "anticlock", line_join = "bevel",
      subscribed_events = list(), js_event_callbacks = structure(list(),
      .Names = character(0)), end_angle = NULL, outer_radius = NULL,
      line_cap = "butt", line_width = 1L, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["AnnularWedge"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # 
    # > Enum('deg', 'rad')
    start_angle_units = NULL,
    # 
    # > Enum('screen', 'data')
    inner_radius_units = NULL,
    # The x-coordinates of the center of the annular wedges.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x = NULL,
    # The angles to start the annular wedges, as measured from the
    # horizontal.
    # > AngleSpec(units_default='rad')
    start_angle = NULL,
    # The fill alpha values for the annular wedges.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    fill_alpha = NULL,
    # The line color values for the annular wedges.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The line dash values for the annular wedges.
    # > DashPattern
    line_dash = NULL,
    # The fill color values for the annular wedges.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    fill_color = NULL,
    # The line alpha values for the annular wedges.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL,
    # The y-coordinates of the center of the annular wedges.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y = NULL,
    # The inner radii of the annular wedges.
    # > DistanceSpec(units_default='data')
    inner_radius = NULL,
    # 
    # > Enum('deg', 'rad')
    end_angle_units = NULL,
    # 
    # > Enum('screen', 'data')
    outer_radius_units = NULL,
    # The line dash offset values for the annular wedges.
    # > Int
    line_dash_offset = NULL,
    # Which direction to stroke between the start and end angles.
    # > Enum('clock', 'anticlock')
    direction = NULL,
    # The line join values for the annular wedges.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # The angles to end the annular wedges, as measured from the horizontal.
    # > AngleSpec(units_default='rad')
    end_angle = NULL,
    # The outer radii of the annular wedges.
    # > DistanceSpec(units_default='data')
    outer_radius = NULL,
    # The line cap values for the annular wedges.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line width values for the annular wedges.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL
  )
)

# An auto-fitting range in a continuous scalar dimension.
# 
# By default the ``start`` and ``end`` of the range automatically assume
# min and max values of the data for associated renderers.
DataRange1d <- R6::R6Class("DataRange1d",
  inherit = DataRange,
  public = list(
    specified_args = NULL,
    initialize = function(
      flipped = FALSE, max_interval = NULL, end = NULL,
      range_padding_units = "percent", bounds = NULL, start = NULL,
      js_property_callbacks = structure(list(), .Names = character(0)),
      follow = NULL, callback = NULL, tags = list(), default_span = 2,
      renderers = list(), range_padding = 0.1, names = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), follow_interval = NULL, name = NULL,
      min_interval = NULL, id = NULL
    ) {
      super$initialize(js_property_callbacks = js_property_callbacks,
        callback = callback, tags = tags, renderers = renderers, names = names,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name, id = id)
      types <- bk_prop_types[["DataRange1d"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Whether the range should be "flipped" from its normal direction when
    # auto-ranging.
    # > Bool
    flipped = NULL,
    # The level that the range is allowed to zoom out, expressed as the
    # maximum visible interval. Note that ``bounds`` can impose an implicit
    # constraint on the maximum interval as well.
    # > Either(Float, TimeDelta)
    max_interval = NULL,
    # An explicitly supplied range end. If provided, will override
    # automatically computed end value.
    # > Either(Float, Datetime, TimeDelta)
    end = NULL,
    # Whether the ``range_padding`` should be interpreted as a percentage, or
    # as an absolute quantity. (default: ``"percent"``)
    # > Enum('percent', 'absolute')
    range_padding_units = NULL,
    # The bounds that the range is allowed to go to. Typically used to
    # prevent the user from panning/zooming/etc away from the data.
    # 
    # By default, the bounds will be None, allowing your plot to pan/zoom as
    # far as you want. If bounds are 'auto' they will be computed to be the
    # same as the start and end of the ``DataRange1d``.
    # 
    # Bounds are provided as a tuple of ``(min, max)`` so regardless of
    # whether your range is increasing or decreasing, the first item should
    # be the minimum value of the range and the second item should be the
    # maximum.  Setting ``min > max`` will result in a ``ValueError``.
    # 
    # If you only want to constrain one end of the plot, you can set ``min``
    # or ``max`` to ``None`` e.g. ``DataRange1d(bounds=(None, 12))``
    # > MinMaxBounds(Auto, Tuple(Float, Float), Tuple(TimeDelta, TimeDelta), Tuple(Datetime, Datetime))
    bounds = NULL,
    # An explicitly supplied range start. If provided, will override
    # automatically computed start value.
    # > Either(Float, Datetime, TimeDelta)
    start = NULL,
    # Configure the data to follow one or the other data extreme, with a
    # maximum range size of ``follow_interval``.
    # 
    # If set to ``"start"`` then the range will adjust so that ``start``
    # always corresponds to the minimum data value (or maximum, if
    # ``flipped`` is ``True``).
    # 
    # If set to ``"end"`` then the range will adjust so that ``end`` always
    # corresponds to the maximum data value (or minimum, if ``flipped`` is
    # ``True``).
    # 
    # If set to ``None`` (default), then auto-ranging does not follow, and
    # the range will encompass both the minimum and maximum data values.
    # 
    # ``follow`` cannot be used with bounds, and if set, bounds will be set
    # to ``None``.
    # > Enum('start', 'end')
    follow = NULL,
    # A default width for the interval, in case ``start`` is equal to ``end``
    # (if used with a log axis, default_span is in powers of 10).
    # > Either(Float, TimeDelta)
    default_span = NULL,
    # How much padding to add around the computed data bounds.
    # 
    # When ``range_padding_units`` is set to ``"percent"``, the span of the
    # range span is expanded to make the range ``range_padding`` percent
    # larger.
    # 
    # When ``range_padding_units`` is set to ``"absolute"``, the start and
    # end of the range span are extended by the amount ``range_padding``.
    # > Either(Float, TimeDelta)
    range_padding = NULL,
    # If ``follow`` is set to ``"start"`` or ``"end"`` then the range will
    # always be constrained to that::
    # 
    # abs(r.start - r.end) <= follow_interval
    # 
    # is maintained.
    # > Either(Float, TimeDelta)
    follow_interval = NULL,
    # The level that the range is allowed to zoom in, expressed as the
    # minimum visible interval. If set to ``None`` (default), the minimum
    # interval is not bound.
    # > Either(Float, TimeDelta)
    min_interval = NULL
  )
)

# A group of check boxes.
CheckboxGroup <- R6::R6Class("CheckboxGroup",
  inherit = Group,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", disabled = FALSE,
      callback = NULL, background = NULL, tags = list(), visible = TRUE,
      width_policy = "auto", height_policy = "auto", height = NULL,
      name = NULL, sizing_mode = NULL, labels = list(), default_size = 300L,
      max_height = NULL, inline = FALSE, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      orientation = "horizontal", active = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      min_height = NULL, subscribed_events = list(), width = NULL,
      aspect_ratio = NULL, margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, callback = callback,
        background = background, tags = tags, visible = visible,
        width_policy = width_policy, height_policy = height_policy,
        height = height, name = name, sizing_mode = sizing_mode,
        labels = labels, default_size = default_size,
        max_height = max_height, inline = inline, css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["CheckboxGroup"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The list of indices of selected check boxes.
    # > List(Int)
    active = NULL
  )
)

# A group of radio boxes.
RadioGroup <- R6::R6Class("RadioGroup",
  inherit = Group,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", disabled = FALSE,
      callback = NULL, background = NULL, tags = list(), visible = TRUE,
      width_policy = "auto", height_policy = "auto", height = NULL,
      name = NULL, sizing_mode = NULL, labels = list(), default_size = 300L,
      max_height = NULL, inline = FALSE, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      orientation = "horizontal", active = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      min_height = NULL, subscribed_events = list(), width = NULL,
      aspect_ratio = NULL, margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, callback = callback,
        background = background, tags = tags, visible = visible,
        width_policy = width_policy, height_policy = height_policy,
        height = height, name = name, sizing_mode = sizing_mode,
        labels = labels, default_size = default_size,
        max_height = max_height, inline = inline, css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["RadioGroup"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The index of the selected radio box, or ``None`` if nothing is
    # selected.
    # > Int
    active = NULL
  )
)

# *toolbar icon*: |range_icon|
# 
# The range tool allows the user to update range objects for either or
# both of the x- or y-dimensions by dragging a corresponding shaded
# annotation to move it or change its boundaries.
# 
# A common use case is to add this tool to a plot with a large fixed
# range, but to configure the tool range from a different plot. When the
# user manipulates the overlay, the range of the second plot will be
# updated automatically.
# 
# .. |range_icon| image:: /_images/icons/Range.png :height: 18pt
RangeTool <- R6::R6Class("RangeTool",
  inherit = Drag,
  public = list(
    specified_args = NULL,
    initialize = function(
      x_range = NULL, js_property_callbacks = structure(list(), .Names =
      character(0)), x_interaction = TRUE, tags = list(), overlay = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      y_interaction = TRUE, subscribed_events = list(), name = NULL,
      y_range = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["RangeTool"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A range synchronized to the x-dimension of the overlay. If None, the
    # overlay will span the entire x-dimension.
    # > Instance(Range1d)
    x_range = NULL,
    # Whether to respond to horizontal pan motions when an ``x_range`` is
    # present.
    # 
    # By default, when an ``x_range`` is specified, it is possible to adjust
    # the horizontal position of the range box by panning horizontally inside
    # the box, or along the top or bottom edge of the box. To disable this,
    # and fix the range box in place horizontally, set to False. (The box
    # will still update if the ``x_range`` is updated programmatically.)
    # > Bool
    x_interaction = NULL,
    # A shaded annotation drawn to indicate the configured ranges.
    # > Instance(BoxAnnotation)
    overlay = NULL,
    # Whether to respond to vertical pan motions when a ``y_range`` is
    # present.
    # 
    # By default, when a ``y_range`` is specified, it is possible to adjust
    # the vertical position of the range box by panning vertically inside the
    # box, or along the top or bottom edge of the box. To disable this, and
    # fix the range box in place vertically, set to False. (The box will
    # still update if the ``y_range`` is updated programmatically.)
    # > Bool
    y_interaction = NULL,
    # A range synchronized to the y-dimension of the overlay. If None, the
    # overlay will span the entire y-dimension.
    # > Instance(Range1d)
    y_range = NULL
  )
)

# Single-select widget.
Select <- R6::R6Class("Select",
  inherit = InputWidget,
  public = list(
    specified_args = NULL,
    initialize = function(
      title = "", min_width = NULL, max_width = NULL, align = "start",
      disabled = FALSE, value = "", callback = NULL, background = NULL,
      tags = list(), visible = TRUE, options = list(), width_policy = "auto",
      height_policy = "auto", height = NULL, name = NULL, sizing_mode = NULL,
      default_size = 300L, max_height = NULL, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      orientation = "horizontal", js_event_callbacks = structure(list(),
      .Names = character(0)), min_height = NULL,
      subscribed_events = list(), width = NULL, aspect_ratio = NULL,
      margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(title = title, min_width = min_width,
        max_width = max_width, align = align, disabled = disabled,
        background = background, tags = tags, visible = visible,
        width_policy = width_policy, height_policy = height_policy,
        height = height, name = name, sizing_mode = sizing_mode,
        default_size = default_size, max_height = max_height,
        css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["Select"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Initial or selected value.
    # > String
    value = NULL,
    # A callback to run in the browser whenever the current Select dropdown
    # value changes.
    # > Instance(Callback)
    callback = NULL,
    # Available selection options. Options may be provided either as a list
    # of possible string values, or as a list of tuples, each of the form
    # ``(value, label)``. In the latter case, the visible widget text for
    # each value will be corresponding given label. Option groupings can be
    # provided by supplying a dictionary object whose values are in the
    # aforementioned list format
    # > Either(List(Either(String, Tuple(Either(Int, String), String))), Dict(String, List(Either(String, Tuple(Either(Int, String), String)))))
    options = NULL
  )
)

# Render square markers with a '+' cross through the center.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/SquareCross.py
# :source-position: below
SquareCross <- R6::R6Class("SquareCross",
  inherit = Marker,
  public = list(
    specified_args = NULL,
    initialize = function(
      y = NULL, size = 4L, line_join = "bevel",
      js_property_callbacks = structure(list(), .Names = character(0)),
      angle_units = "rad", name = NULL, x = NULL, fill_color = "gray",
      line_dash = list(), tags = list(), angle = 0, line_dash_offset = 0L,
      js_event_callbacks = structure(list(), .Names = character(0)),
      fill_alpha = 1, subscribed_events = list(), line_color = "black",
      line_width = 1L, line_cap = "butt", line_alpha = 1, id = NULL
    ) {
      super$initialize(y = y, size = size, line_join = line_join,
        js_property_callbacks = js_property_callbacks,
        angle_units = angle_units, name = name, x = x, fill_color = fill_color,
        line_dash = line_dash, tags = tags, angle = angle,
        line_dash_offset = line_dash_offset,
        js_event_callbacks = js_event_callbacks, fill_alpha = fill_alpha,
        subscribed_events = subscribed_events, line_color = line_color,
        line_width = line_width, line_cap = line_cap,
        line_alpha = line_alpha, id = id)
      types <- bk_prop_types[["SquareCross"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# A layoutable toolbar that can accept the tools of multiple plots, and
# can merge the tools into a single button for convenience.
ToolbarBox <- R6::R6Class("ToolbarBox",
  inherit = LayoutDOM,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", disabled = FALSE,
      toolbar = NULL, background = NULL, tags = list(), visible = TRUE,
      width_policy = "auto", height_policy = "auto", height = NULL,
      name = NULL, sizing_mode = NULL, max_height = NULL, css_classes = list(),
      margin = list(0L, 0L, 0L, 0L),
      js_property_callbacks = structure(list(), .Names = character(0)),
      js_event_callbacks = structure(list(), .Names = character(0)),
      min_height = NULL, subscribed_events = list(), width = NULL,
      aspect_ratio = NULL, toolbar_location = "right", id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, background = background,
        tags = tags, visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, name = name,
        sizing_mode = sizing_mode, max_height = max_height,
        css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        js_event_callbacks = js_event_callbacks, min_height = min_height,
        subscribed_events = subscribed_events, width = width,
        aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["ToolbarBox"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A toolbar associated with a plot which holds all its tools.
    # > Instance(ToolbarBase)
    toolbar = NULL,
    # 
    # > Enum('above', 'below', 'left', 'right')
    toolbar_location = NULL
  )
)

# With the ``NodesOnly`` policy, only graph nodes are able to be selected
# and inspected. There is no selection or inspection of graph edges.
NodesOnly <- R6::R6Class("NodesOnly",
  inherit = GraphHitTestPolicy,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["NodesOnly"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
SelectionPolicy <- R6::R6Class("SelectionPolicy",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["SelectionPolicy"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Abstract base class for all kinds of groups.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
AbstractGroup <- R6::R6Class("AbstractGroup",
  inherit = Widget,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", disabled = FALSE,
      callback = NULL, background = NULL, tags = list(), visible = TRUE,
      width_policy = "auto", height_policy = "auto", height = NULL,
      name = NULL, sizing_mode = NULL, labels = list(), default_size = 300L,
      max_height = NULL, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      orientation = "horizontal", js_event_callbacks = structure(list(),
      .Names = character(0)), min_height = NULL,
      subscribed_events = list(), width = NULL, aspect_ratio = NULL,
      margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, background = background,
        tags = tags, visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, name = name,
        sizing_mode = sizing_mode, default_size = default_size,
        max_height = max_height, css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["AbstractGroup"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A callback to run in the browser whenever a button group is
    # manipulated.
    # > Instance(Callback)
    callback = NULL,
    # List of text labels contained in this group.
    # > List(String)
    labels = NULL
  )
)

# A base class that defines common properties for all button types.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
AbstractButton <- R6::R6Class("AbstractButton",
  inherit = Widget,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", disabled = FALSE,
      callback = NULL, background = NULL, button_type = "default", icon = NULL,
      tags = list(), visible = TRUE, width_policy = "auto",
      height_policy = "auto", height = NULL, name = NULL, sizing_mode = NULL,
      default_size = 300L, max_height = NULL, label = "", css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      orientation = "horizontal", js_event_callbacks = structure(list(),
      .Names = character(0)), min_height = NULL,
      subscribed_events = list(), width = NULL, aspect_ratio = NULL,
      margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, background = background,
        tags = tags, visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, name = name,
        sizing_mode = sizing_mode, default_size = default_size,
        max_height = max_height, css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["AbstractButton"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A callback to run in the browser whenever the button is activated.
    # > Instance(Callback)
    callback = NULL,
    # A style for the button, signifying it's role.
    # > Enum('default', 'primary', 'success', 'warning', 'danger')
    button_type = NULL,
    # An optional image appearing to the left of button's text.
    # > Instance(AbstractIcon)
    icon = NULL,
    # The text label for the button to display.
    # > String
    label = NULL
  )
)

# Render dash markers. Use ``angle`` to rotate and create vertically
# oriented short lines.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/Dash.py
# :source-position: below
Dash <- R6::R6Class("Dash",
  inherit = Marker,
  public = list(
    specified_args = NULL,
    initialize = function(
      y = NULL, size = 4L, line_join = "bevel",
      js_property_callbacks = structure(list(), .Names = character(0)),
      angle_units = "rad", name = NULL, x = NULL, fill_color = "gray",
      line_dash = list(), tags = list(), angle = 0, line_dash_offset = 0L,
      js_event_callbacks = structure(list(), .Names = character(0)),
      fill_alpha = 1, subscribed_events = list(), line_color = "black",
      line_width = 1L, line_cap = "butt", line_alpha = 1, id = NULL
    ) {
      super$initialize(y = y, size = size, line_join = line_join,
        js_property_callbacks = js_property_callbacks,
        angle_units = angle_units, name = name, x = x, fill_color = fill_color,
        line_dash = line_dash, tags = tags, angle = angle,
        line_dash_offset = line_dash_offset,
        js_event_callbacks = js_event_callbacks, fill_alpha = fill_alpha,
        subscribed_events = subscribed_events, line_color = line_color,
        line_width = line_width, line_cap = line_cap,
        line_alpha = line_alpha, id = id)
      types <- bk_prop_types[["Dash"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Generate ticks spaced apart by specific, even multiples of months.
MonthsTicker <- R6::R6Class("MonthsTicker",
  inherit = SingleIntervalTicker,
  public = list(
    specified_args = NULL,
    initialize = function(
      desired_num_ticks = 6L, interval = NULL,
      js_property_callbacks = structure(list(), .Names = character(0)),
      months = list(), tags = list(), js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(), name = NULL,
      num_minor_ticks = 5L, id = NULL
    ) {
      super$initialize(desired_num_ticks = desired_num_ticks,
        interval = interval, js_property_callbacks = js_property_callbacks,
        tags = tags, js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name,
        num_minor_ticks = num_minor_ticks, id = id)
      types <- bk_prop_types[["MonthsTicker"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The intervals of months to use.
    # > Seq(Int)
    months = NULL
  )
)

# Render upside-down triangle markers.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/InvertedTriangle.py
# :source-position: below
InvertedTriangle <- R6::R6Class("InvertedTriangle",
  inherit = Marker,
  public = list(
    specified_args = NULL,
    initialize = function(
      y = NULL, size = 4L, line_join = "bevel",
      js_property_callbacks = structure(list(), .Names = character(0)),
      angle_units = "rad", name = NULL, x = NULL, fill_color = "gray",
      line_dash = list(), tags = list(), angle = 0, line_dash_offset = 0L,
      js_event_callbacks = structure(list(), .Names = character(0)),
      fill_alpha = 1, subscribed_events = list(), line_color = "black",
      line_width = 1L, line_cap = "butt", line_alpha = 1, id = NULL
    ) {
      super$initialize(y = y, size = size, line_join = line_join,
        js_property_callbacks = js_property_callbacks,
        angle_units = angle_units, name = name, x = x, fill_color = fill_color,
        line_dash = line_dash, tags = tags, angle = angle,
        line_dash_offset = line_dash_offset,
        js_event_callbacks = js_event_callbacks, fill_alpha = fill_alpha,
        subscribed_events = subscribed_events, line_color = line_color,
        line_width = line_width, line_cap = line_cap,
        line_alpha = line_alpha, id = id)
      types <- bk_prop_types[["InvertedTriangle"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# An axis that displays ticks and labels for categorical ranges.
# 
# The ``CategoricalAxis`` can handle factor ranges with up to two levels
# of nesting, including drawing a separator line between top-level groups
# of factors.
CategoricalAxis <- R6::R6Class("CategoricalAxis",
  inherit = Axis,
  public = list(
    specified_args = NULL,
    initialize = function(
      major_label_text_font_style = "normal",
      axis_label_text_color = "#444444", fixed_location = NULL,
      major_label_text_align = "center", axis_label_text_line_height = 1.2,
      tags = list(), separator_line_join = "bevel", formatter = NULL,
      axis_label_text_font_style = "italic",
      major_label_orientation = "horizontal", major_tick_line_alpha = 1,
      axis_line_width = 1L, axis_label_text_font_size = list(value =
      "10pt"), major_tick_line_dash_offset = 0L,
      subgroup_text_baseline = "bottom",
      major_label_text_font = "helvetica",
      subgroup_text_font = "helvetica", axis_label_text_font = "helvetica",
      ticker = NULL, axis_label_text_alpha = 1,
      separator_line_color = "lightgrey", subscribed_events = list(),
      major_tick_line_join = "bevel", axis_label_standoff = 5L,
      axis_line_alpha = 1, group_text_baseline = "bottom",
      subgroup_text_alpha = 1, major_tick_line_dash = list(),
      separator_line_dash_offset = 0L, subgroup_text_font_size = list(value
      = "8pt"), major_label_text_color = "#444444",
      group_text_align = "left", major_label_text_baseline = "alphabetic",
      major_tick_out = 6L, axis_line_join = "bevel", major_tick_in = 2L,
      subgroup_label_orientation = "parallel", minor_tick_out = 4L,
      group_text_font_size = list(value = "8pt"),
      separator_line_dash = list(), major_label_text_line_height = 1.2,
      bounds = "auto", subgroup_text_color = "#444444",
      axis_line_dash = list(), minor_tick_line_color = "black",
      axis_label_text_align = "left", major_label_text_alpha = 1,
      group_text_font = "helvetica", minor_tick_line_dash_offset = 0L,
      axis_line_dash_offset = 0L, minor_tick_line_width = 1L,
      major_label_text_font_size = list(value = "8pt"),
      major_tick_line_color = "black", major_label_standoff = 5L,
      major_label_overrides = structure(list(), .Names = character(0)),
      group_text_color = "grey", minor_tick_in = 0L,
      separator_line_cap = "butt", minor_tick_line_join = "bevel",
      axis_label_text_baseline = "bottom", major_tick_line_width = 1L,
      major_tick_line_cap = "butt", js_event_callbacks = structure(list(),
      .Names = character(0)), minor_tick_line_cap = "butt",
      subgroup_text_font_style = "bold", separator_line_width = 2L,
      axis_line_cap = "butt", level = "overlay", axis_label = "",
      subgroup_text_align = "left", subgroup_text_line_height = 1.2,
      separator_line_alpha = 1, visible = TRUE, axis_line_color = "black",
      name = NULL, minor_tick_line_dash = list(), minor_tick_line_alpha = 1,
      js_property_callbacks = structure(list(), .Names = character(0)),
      x_range_name = "default", y_range_name = "default",
      group_label_orientation = "parallel", group_text_font_style = "bold",
      group_text_line_height = 1.2, group_text_alpha = 1, id = NULL
    ) {
      super$initialize(major_label_text_font_size = major_label_text_font_size,
        major_label_text_font_style = major_label_text_font_style,
        axis_label_text_color = axis_label_text_color,
        fixed_location = fixed_location,
        major_label_text_align = major_label_text_align,
        major_tick_line_color = major_tick_line_color,
        axis_label_text_line_height = axis_label_text_line_height,
        major_label_standoff = major_label_standoff,
        major_label_overrides = major_label_overrides, tags = tags,
        minor_tick_in = minor_tick_in, formatter = formatter,
        axis_label_text_font_style = axis_label_text_font_style,
        major_label_orientation = major_label_orientation,
        minor_tick_line_join = minor_tick_line_join,
        major_tick_line_alpha = major_tick_line_alpha,
        axis_line_width = axis_line_width,
        axis_label_text_font_size = axis_label_text_font_size,
        major_tick_line_dash_offset = major_tick_line_dash_offset,
        axis_label_text_baseline = axis_label_text_baseline,
        major_tick_line_width = major_tick_line_width,
        major_label_text_font = major_label_text_font,
        axis_label_text_font = axis_label_text_font, ticker = ticker,
        major_tick_line_cap = major_tick_line_cap,
        axis_label_text_alpha = axis_label_text_alpha,
        js_event_callbacks = js_event_callbacks,
        minor_tick_line_cap = minor_tick_line_cap,
        subscribed_events = subscribed_events,
        major_tick_line_join = major_tick_line_join,
        axis_label_standoff = axis_label_standoff,
        axis_line_alpha = axis_line_alpha, axis_line_cap = axis_line_cap,
        level = level, major_tick_line_dash = major_tick_line_dash,
        axis_label = axis_label,
        major_label_text_color = major_label_text_color,
        major_label_text_baseline = major_label_text_baseline,
        major_tick_out = major_tick_out, axis_line_color = axis_line_color,
        axis_line_join = axis_line_join, major_tick_in = major_tick_in,
        visible = visible, minor_tick_out = minor_tick_out, name = name,
        minor_tick_line_dash = minor_tick_line_dash,
        major_label_text_line_height = major_label_text_line_height,
        minor_tick_line_alpha = minor_tick_line_alpha, bounds = bounds,
        axis_line_dash = axis_line_dash, x_range_name = x_range_name,
        minor_tick_line_color = minor_tick_line_color,
        js_property_callbacks = js_property_callbacks,
        axis_label_text_align = axis_label_text_align,
        y_range_name = y_range_name,
        major_label_text_alpha = major_label_text_alpha,
        minor_tick_line_dash_offset = minor_tick_line_dash_offset,
        axis_line_dash_offset = axis_line_dash_offset,
        minor_tick_line_width = minor_tick_line_width, id = id)
      types <- bk_prop_types[["CategoricalAxis"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The line join of the separator line between top-level categorical
    # groups.
    # 
    # This property always applies to factors in the outermost level of
    # nesting.
    # > Enum('miter', 'round', 'bevel')
    separator_line_join = NULL,
    # The text baseline of the subgroup categorical labels.
    # 
    # This property always applies to factors in the middle level of nesting.
    # If the list of categorical factors is has only zero or one levels of
    # nesting, then this property has no effect.
    # > Enum('top', 'middle', 'bottom', 'alphabetic', 'hanging', 'ideographic')
    subgroup_text_baseline = NULL,
    # The text font of the subgroup categorical labels.
    # 
    # This property always applies to factors in the middle level of nesting.
    # If the list of categorical factors is has only zero or one levels of
    # nesting, then this property has no effect.
    # > String
    subgroup_text_font = NULL,
    # The line color of the separator line between top-level categorical
    # groups.
    # 
    # This property always applies to factors in the outermost level of
    # nesting.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    separator_line_color = NULL,
    # The text baseline of the group categorical labels.
    # 
    # This property always applies to factors in the outermost level of
    # nesting.  If the list of categorical factors is flat (i.e. no nesting)
    # then this property has no effect.
    # > Enum('top', 'middle', 'bottom', 'alphabetic', 'hanging', 'ideographic')
    group_text_baseline = NULL,
    # The text alpha of the subgroup categorical labels.
    # 
    # This property always applies to factors in the middle level of nesting.
    # If the list of categorical factors is has only zero or one levels of
    # nesting, then this property has no effect.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    subgroup_text_alpha = NULL,
    # The line dash offset of the separator line between top-level
    # categorical groups.
    # 
    # This property always applies to factors in the outermost level of
    # nesting.
    # > Int
    separator_line_dash_offset = NULL,
    # The text font size of the subgroup categorical labels.
    # 
    # This property always applies to factors in the middle level of nesting.
    # If the list of categorical factors is has only zero or one levels of
    # nesting, then this property has no effect.
    # > FontSizeSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), FontSize)), FontSize)
    subgroup_text_font_size = NULL,
    # The text align of the group categorical labels.
    # 
    # This property always applies to factors in the outermost level of
    # nesting.  If the list of categorical factors is flat (i.e. no nesting)
    # then this property has no effect.
    # > Enum('left', 'right', 'center')
    group_text_align = NULL,
    # What direction the subgroup label text should be oriented.
    # 
    # If a number is supplied, the angle of the text is measured from
    # horizontal.
    # 
    # This property always applies to factors in the middle level of nesting.
    # If the list of categorical factors is has only zero or one levels of
    # nesting, then this property has no effect.
    # > Either(Enum('horizontal', 'vertical', 'parallel', 'normal'), Float)
    subgroup_label_orientation = NULL,
    # The text font size of the group categorical labels.
    # 
    # This property always applies to factors in the outermost level of
    # nesting.  If the list of categorical factors is flat (i.e. no nesting)
    # then this property has no effect.
    # > FontSizeSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), FontSize)), FontSize)
    group_text_font_size = NULL,
    # The line dash of the separator line between top-level categorical
    # groups.
    # 
    # This property always applies to factors in the outermost level of
    # nesting.
    # > DashPattern
    separator_line_dash = NULL,
    # The text color of the subgroup categorical labels.
    # 
    # This property always applies to factors in the middle level of nesting.
    # If the list of categorical factors is has only zero or one levels of
    # nesting, then this property has no effect.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    subgroup_text_color = NULL,
    # The text font of the group categorical labels.
    # 
    # This property always applies to factors in the outermost level of
    # nesting.  If the list of categorical factors is flat (i.e. no nesting)
    # then this property has no effect.
    # > String
    group_text_font = NULL,
    # The text color of the group categorical labels.
    # 
    # This property always applies to factors in the outermost level of
    # nesting.  If the list of categorical factors is flat (i.e. no nesting)
    # then this property has no effect.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    group_text_color = NULL,
    # The line cap of the separator line between top-level categorical
    # groups.
    # 
    # This property always applies to factors in the outermost level of
    # nesting.
    # > Enum('butt', 'round', 'square')
    separator_line_cap = NULL,
    # The text font style of the subgroup categorical labels.
    # 
    # This property always applies to factors in the middle level of nesting.
    # If the list of categorical factors is has only zero or one levels of
    # nesting, then this property has no effect.
    # > Enum('normal', 'italic', 'bold', 'bold italic')
    subgroup_text_font_style = NULL,
    # The line width of the separator line between top-level categorical
    # groups.
    # 
    # This property always applies to factors in the outermost level of
    # nesting.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    separator_line_width = NULL,
    # The text align of the subgroup categorical labels.
    # 
    # This property always applies to factors in the middle level of nesting.
    # If the list of categorical factors is has only zero or one levels of
    # nesting, then this property has no effect.
    # > Enum('left', 'right', 'center')
    subgroup_text_align = NULL,
    # The text line height of the subgroup categorical labels.
    # 
    # This property always applies to factors in the middle level of nesting.
    # If the list of categorical factors is has only zero or one levels of
    # nesting, then this property has no effect.
    # > Float
    subgroup_text_line_height = NULL,
    # The line alpha of the separator line between top-level categorical
    # groups.
    # 
    # This property always applies to factors in the outermost level of
    # nesting.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    separator_line_alpha = NULL,
    # What direction the group label text should be oriented.
    # 
    # If a number is supplied, the angle of the text is measured from
    # horizontal.
    # 
    # This property always applies to factors in the outermost level of
    # nesting.  If the list of categorical factors is flat (i.e. no nesting)
    # then this property has no effect.
    # > Either(Enum('horizontal', 'vertical', 'parallel', 'normal'), Float)
    group_label_orientation = NULL,
    # The text font style of the group categorical labels.
    # 
    # This property always applies to factors in the outermost level of
    # nesting.  If the list of categorical factors is flat (i.e. no nesting)
    # then this property has no effect.
    # > Enum('normal', 'italic', 'bold', 'bold italic')
    group_text_font_style = NULL,
    # The text line height of the group categorical labels.
    # 
    # This property always applies to factors in the outermost level of
    # nesting.  If the list of categorical factors is flat (i.e. no nesting)
    # then this property has no effect.
    # > Float
    group_text_line_height = NULL,
    # The text alpha of the group categorical labels.
    # 
    # This property always applies to factors in the outermost level of
    # nesting.  If the list of categorical factors is flat (i.e. no nesting)
    # then this property has no effect.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    group_text_alpha = NULL
  )
)

# *toolbar icon*: |undo_icon|
# 
# Undo tool allows to restore previous state of the plot.
# 
# .. |undo_icon| image:: /_images/icons/Undo.png :height: 18pt
UndoTool <- R6::R6Class("UndoTool",
  inherit = Action,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["UndoTool"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Render vertical bars, given a center coordinate, width and (top,
# bottom) coordinates.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/VBar.py
# :source-position: below
VBar <- R6::R6Class("VBar",
  inherit = Glyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      hatch_extra = structure(list(), .Names = character(0)), x = NULL,
      hatch_weight = 1, tags = list(), hatch_scale = 12, fill_alpha = 1,
      hatch_pattern = NULL, line_color = "black", line_dash = list(),
      name = NULL, fill_color = "gray", line_alpha = 1, top = NULL,
      line_join = "bevel", js_property_callbacks = structure(list(), .Names
      = character(0)), hatch_color = "black", hatch_alpha = 1,
      line_dash_offset = 0L, bottom = 0L,
      js_event_callbacks = structure(list(), .Names = character(0)),
      line_width = 1L, subscribed_events = list(), width = NULL,
      line_cap = "butt", id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["VBar"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The hatch extra values for the vertical bars.
    # > Dict(String, Instance(Texture))
    hatch_extra = NULL,
    # The x-coordinates of the centers of the vertical bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x = NULL,
    # The hatch weight values for the vertical bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    hatch_weight = NULL,
    # The hatch scale values for the vertical bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    hatch_scale = NULL,
    # The fill alpha values for the vertical bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    fill_alpha = NULL,
    # The hatch pattern values for the vertical bars.
    # > HatchPatternSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), HatchPatternType)), HatchPatternType)
    hatch_pattern = NULL,
    # The line color values for the vertical bars.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The line dash values for the vertical bars.
    # > DashPattern
    line_dash = NULL,
    # The fill color values for the vertical bars.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    fill_color = NULL,
    # The line alpha values for the vertical bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL,
    # The y-coordinates of the top edges.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    top = NULL,
    # The line join values for the vertical bars.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # The hatch color values for the vertical bars.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    hatch_color = NULL,
    # The hatch alpha values for the vertical bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    hatch_alpha = NULL,
    # The line dash offset values for the vertical bars.
    # > Int
    line_dash_offset = NULL,
    # The y-coordinates of the bottom edges.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    bottom = NULL,
    # The line width values for the vertical bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL,
    # The widths of the vertical bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    width = NULL,
    # The line cap values for the vertical bars.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL
  )
)

# Generate ticks on a linear scale.
# 
# .. note:: This class may be renamed to ``LinearTicker`` in the future.
BasicTicker <- R6::R6Class("BasicTicker",
  inherit = AdaptiveTicker,
  public = list(
    specified_args = NULL,
    initialize = function(
      base = 10, max_interval = NULL, desired_num_ticks = 6L,
      js_property_callbacks = structure(list(), .Names = character(0)),
      mantissas = list(1L, 2L, 5L), tags = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), name = NULL, min_interval = 0,
      num_minor_ticks = 5L, id = NULL
    ) {
      super$initialize(base = base, max_interval = max_interval,
        desired_num_ticks = desired_num_ticks,
        js_property_callbacks = js_property_callbacks,
        mantissas = mantissas, tags = tags,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name,
        min_interval = min_interval, num_minor_ticks = num_minor_ticks,
        id = id)
      types <- bk_prop_types[["BasicTicker"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# When a data source is shared between multiple renderers, a row in the
# data source will only be selected if that point for each renderer is
# selected. The selection is made from the intersection of hit test
# results from all renderers.
IntersectRenderers <- R6::R6Class("IntersectRenderers",
  inherit = SelectionPolicy,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["IntersectRenderers"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# An abstract base class for icon widgets.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
AbstractIcon <- R6::R6Class("AbstractIcon",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["AbstractIcon"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Base class for all annotation models.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
Annotation <- R6::R6Class("Annotation",
  inherit = Renderer,
  public = list(
    specified_args = NULL,
    initialize = function(
      level = "annotation", tags = list(), visible = TRUE,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), name = NULL, id = NULL
    ) {
      super$initialize(level = level, tags = tags, visible = visible,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["Annotation"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# A Selection represents a portion of the data in a ``DataSource``, which
# can be visually manipulated in a plot.
# 
# Selections are typically created by selecting points in a plot with a
# ``SelectTool``, but can also be programmatically specified.
Selection <- R6::R6Class("Selection",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      multiline_indices = structure(list(), .Names = character(0)),
      js_property_callbacks = structure(list(), .Names = character(0)),
      line_indices = list(), tags = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), name = NULL, indices = list(), id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Selection"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # 
    # > Dict(String, Seq(Int))
    multiline_indices = NULL,
    # 
    # > Seq(Int)
    line_indices = NULL,
    # The indices included in a selection.
    # > Seq(Int)
    indices = NULL
  )
)

# An expression for generating arrays by cumulatively summing a single
# column from a ``ColumnDataSource``.
CumSum <- R6::R6Class("CumSum",
  inherit = Expression,
  public = list(
    specified_args = NULL,
    initialize = function(
      include_zero = FALSE, tags = list(), field = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["CumSum"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Whether to include zero at the start of the result. Note that the
    # length of the result is always the same as the input column. Therefore
    # if this property is True, then the last value of the column will not be
    # included in the sum.
    # 
    # .. code-block:: python
    # 
    # source = ColumnDataSource(data=dict(foo=[1, 2, 3, 4]))
    # 
    # CumSum(field='foo') # -> [1, 3, 6, 10]
    # 
    # CumSum(field='foo', include_zero=True) # -> [0, 1, 3, 6]
    # > Bool
    include_zero = NULL,
    # The name of a ``ColumnDataSource`` column to cumulatively sum for new
    # values.
    # > String
    field = NULL
  )
)

# Apply either fixed dodge amount to data.
Dodge <- R6::R6Class("Dodge",
  inherit = Transform,
  public = list(
    specified_args = NULL,
    initialize = function(
      range = NULL, tags = list(), js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      value = 0L, name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Dodge"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # When applying ``Dodge`` to categorical data values, the corresponding
    # ``FactorRange`` must be supplied as the ``range`` property.
    # > Instance(Range)
    range = NULL,
    # The amount to dodge the input data.
    # > Float
    value = NULL
  )
)

# *toolbar icon*: |reset_icon|
# 
# The reset tool is an action. When activated in the toolbar, the tool
# resets the data bounds of the plot to their values when the plot was
# initially created.
# 
# .. |reset_icon| image:: /_images/icons/Reset.png :height: 18pt
ResetTool <- R6::R6Class("ResetTool",
  inherit = Action,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["ResetTool"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# 
GeoJSONDataSource <- R6::R6Class("GeoJSONDataSource",
  inherit = ColumnarDataSource,
  public = list(
    specified_args = NULL,
    initialize = function(
      selected = NULL, js_property_callbacks = structure(list(), .Names =
      character(0)), callback = NULL, geojson = NULL, tags = list(),
      selection_policy = NULL, js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(), name = NULL,
      id = NULL
    ) {
      super$initialize(selected = selected,
        js_property_callbacks = js_property_callbacks, callback = callback,
        tags = tags, selection_policy = selection_policy,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name, id = id)
      types <- bk_prop_types[["GeoJSONDataSource"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # GeoJSON that contains features for plotting. Currently
    # ``GeoJSONDataSource`` can only process a ``FeatureCollection`` or
    # ``GeometryCollection``.
    # > JSON
    geojson = NULL
  )
)

# Display tick values from continuous ranges as "basic numbers", using
# scientific notation when appropriate by default.
BasicTickFormatter <- R6::R6Class("BasicTickFormatter",
  inherit = TickFormatter,
  public = list(
    specified_args = NULL,
    initialize = function(
      use_scientific = TRUE, power_limit_high = 5L,
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, tags = list(), precision = "auto",
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), power_limit_low = -3L, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["BasicTickFormatter"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Whether to ever display scientific notation. If ``True``, then when to
    # use scientific notation is controlled by ``power_limit_low`` and
    # ``power_limit_high``.
    # > Bool
    use_scientific = NULL,
    # Limit the use of scientific notation to when::
    # 
    # log(x) >= power_limit_high
    # > Int
    power_limit_high = NULL,
    # How many digits of precision to display in tick labels.
    # > Either(Auto, Int)
    precision = NULL,
    # Limit the use of scientific notation to when::
    # 
    # log(x) <= power_limit_low
    # > Int
    power_limit_low = NULL
  )
)

# Abstract base class for data table (data grid) widgets.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
TableWidget <- R6::R6Class("TableWidget",
  inherit = Widget,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", disabled = FALSE,
      background = NULL, tags = list(), visible = TRUE, width_policy = "auto",
      height_policy = "auto", height = NULL, name = NULL, sizing_mode = NULL,
      source = NULL, default_size = 300L, max_height = NULL,
      css_classes = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), view = NULL, orientation = "horizontal",
      js_event_callbacks = structure(list(), .Names = character(0)),
      min_height = NULL, subscribed_events = list(), width = NULL,
      aspect_ratio = NULL, margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, background = background,
        tags = tags, visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, name = name,
        sizing_mode = sizing_mode, default_size = default_size,
        max_height = max_height, css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["TableWidget"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The source of data for the widget.
    # > Instance(DataSource)
    source = NULL,
    # A view into the data source to use when rendering table rows. A default
    # view of the entire data source is created if a view is not passed in
    # during initialization.
    # > Instance(CDSView)
    view = NULL
  )
)

# A base class for all ticker types.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
Ticker <- R6::R6Class("Ticker",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Ticker"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Single-line password input widget.  Note: Despite ``PasswordInput``
# inheriting from ``TextInput`` the password cannot be inspected on the
# field ``value``. Also, note that this field functionally just hides the
# input on the browser, transmitting safely a password as a callback,
# e.g., to a bokeh server would require some secure connection.
PasswordInput <- R6::R6Class("PasswordInput",
  inherit = TextInput,
  public = list(
    specified_args = NULL,
    initialize = function(
      title = "", min_width = NULL, max_width = NULL, align = "start",
      disabled = FALSE, value = "", callback = NULL, background = NULL,
      tags = list(), value_input = "", visible = TRUE, width_policy = "auto",
      height_policy = "auto", height = NULL, name = NULL, sizing_mode = NULL,
      default_size = 300L, max_height = NULL, placeholder = "",
      css_classes = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), orientation = "horizontal",
      js_event_callbacks = structure(list(), .Names = character(0)),
      min_height = NULL, subscribed_events = list(), width = NULL,
      aspect_ratio = NULL, margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(title = title, min_width = min_width,
        max_width = max_width, align = align, disabled = disabled,
        value = value, callback = callback, background = background,
        tags = tags, value_input = value_input, visible = visible,
        width_policy = width_policy, height_policy = height_policy,
        height = height, name = name, sizing_mode = sizing_mode,
        default_size = default_size, max_height = max_height,
        placeholder = placeholder, css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["PasswordInput"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Largest value across multiple rows.
MaxAggregator <- R6::R6Class("MaxAggregator",
  inherit = RowAggregator,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), field_ = "", js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, id = NULL
    ) {
      super$initialize(tags = tags, field_ = field_,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["MaxAggregator"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Render an open-body arrow head.
OpenHead <- R6::R6Class("OpenHead",
  inherit = ArrowHead,
  public = list(
    specified_args = NULL,
    initialize = function(
      level = "annotation", size = 25L, line_join = "bevel",
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, line_dash = list(), tags = list(), line_dash_offset = 0L,
      visible = TRUE, js_event_callbacks = structure(list(), .Names =
      character(0)), line_width = 1L, subscribed_events = list(),
      line_color = "black", line_cap = "butt", line_alpha = 1, id = NULL
    ) {
      super$initialize(level = level, tags = tags, visible = visible,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["OpenHead"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The size, in pixels, of the arrow head.
    # > Float
    size = NULL,
    # The line join values for the arrow head outline.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # The line dash values for the arrow head outline.
    # > DashPattern
    line_dash = NULL,
    # The line dash offset values for the arrow head outline.
    # > Int
    line_dash_offset = NULL,
    # The line width values for the arrow head outline.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL,
    # The line color values for the arrow head outline.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The line cap values for the arrow head outline.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line alpha values for the arrow head outline.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL
  )
)

# Render images loaded from given URLs.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/ImageURL.py
# :source-position: below
ImageURL <- R6::R6Class("ImageURL",
  inherit = XYGlyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      y = NULL, anchor = "top_left", h = NULL,
      js_property_callbacks = structure(list(), .Names = character(0)),
      retry_attempts = 0L, w = NULL, angle_units = "rad", w_units = "data",
      x = NULL, global_alpha = 1, tags = list(), dilate = FALSE,
      retry_timeout = 0L, angle = 0L, h_units = "data",
      subscribed_events = list(), js_event_callbacks = structure(list(),
      .Names = character(0)), name = NULL, url = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["ImageURL"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The y-coordinates to locate the image anchors.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y = NULL,
    # What position of the image should be anchored at the `x`, `y`
    # coordinates.
    # > Enum('top_left', 'top_center', 'top_right', 'center_left', 'center', 'center_right', 'bottom_left', 'bottom_center', 'bottom_right')
    anchor = NULL,
    # The height of the plot region that the image will occupy in data space.
    # 
    # The default value is ``None``, in which case the image will be
    # displayed at its actual image size (regardless of the units specified
    # here).
    # > DistanceSpec(units_default='data')
    h = NULL,
    # Number of attempts to retry loading the images from the specified URL.
    # Default is zero.
    # > Int
    retry_attempts = NULL,
    # The width of the plot region that the image will occupy in data space.
    # 
    # The default value is ``None``, in which case the image will be
    # displayed at its actual image size (regardless of the units specified
    # here).
    # > DistanceSpec(units_default='data')
    w = NULL,
    # 
    # > Enum('deg', 'rad')
    angle_units = NULL,
    # 
    # > Enum('screen', 'data')
    w_units = NULL,
    # The x-coordinates to locate the image anchors.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x = NULL,
    # An overall opacity that each image is rendered with (in addition to any
    # inherent alpha values in the image itself).
    # > Float
    global_alpha = NULL,
    # Whether to always round fractional pixel locations in such a way as to
    # make the images bigger.
    # 
    # This setting may be useful if pixel rounding errors are causing images
    # to have a gap between them, when they should appear flush.
    # > Bool
    dilate = NULL,
    # Timeout (in ms) between retry attempts to load the image from the
    # specified URL. Default is zero ms.
    # > Int
    retry_timeout = NULL,
    # The angles to rotate the images, as measured from the horizontal.
    # > AngleSpec(units_default='rad')
    angle = NULL,
    # 
    # > Enum('screen', 'data')
    h_units = NULL,
    # The URLs to retrieve images from.
    # 
    # .. note:: The actual retrieving and loading of the images happens on
    # the client.
    # > StringSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), List(String))), List(String))
    url = NULL
  )
)

# Execute a custom action, e.g. ``CustomJS`` callback when a toolbar icon
# is activated.
# 
# Example:
# 
# .. code-block:: python
# 
# tool = CustomAction(icon="icon.png",
# callback=CustomJS(code='alert("foo")'))
# 
# plot.add_tools(tool)
CustomAction <- R6::R6Class("CustomAction",
  inherit = Action,
  public = list(
    specified_args = NULL,
    initialize = function(
      js_property_callbacks = structure(list(), .Names = character(0)),
      callback = NULL, icon = NULL, tags = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), action_tooltip = "Perform a Custom
      Action", name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["CustomAction"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A Bokeh callback to execute when the custom action icon is activated.
    # > Instance(Callback)
    callback = NULL,
    # An icon to display in the toolbar.
    # 
    # The icon can provided as a string filename for an image, a PIL
    # ``Image`` object, or an RGB(A) NumPy array.
    # > Image
    icon = NULL,
    # Tooltip displayed when hovering over the custom action icon.
    # > String
    action_tooltip = NULL
  )
)

# Abstract base class for Row and Column. Do not use directly.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
Box <- R6::R6Class("Box",
  inherit = LayoutDOM,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", disabled = FALSE,
      background = NULL, tags = list(), visible = TRUE, width_policy = "auto",
      height_policy = "auto", height = NULL, spacing = 0L, sizing_mode = NULL,
      name = NULL, max_height = NULL, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      children = list(), min_height = NULL, subscribed_events = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      width = NULL, aspect_ratio = NULL, margin = list(0L, 0L, 0L, 0L),
      id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, background = background,
        tags = tags, visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, name = name,
        sizing_mode = sizing_mode, max_height = max_height,
        css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        js_event_callbacks = js_event_callbacks, min_height = min_height,
        subscribed_events = subscribed_events, width = width,
        aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["Box"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The gap between children (in pixels).
    # > Int
    spacing = NULL,
    # The list of children, which can be other components including plots,
    # rows, columns, and widgets.
    # > List(Instance(LayoutDOM))
    children = NULL
  )
)

# ``IntEditor`` optimized for editing percentages.
PercentEditor <- R6::R6Class("PercentEditor",
  inherit = CellEditor,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["PercentEditor"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Base class for text annotation models such as labels and titles.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
TextAnnotation <- R6::R6Class("TextAnnotation",
  inherit = Annotation,
  public = list(
    specified_args = NULL,
    initialize = function(
      level = "annotation", js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), visible = TRUE,
      render_mode = "canvas", js_event_callbacks = structure(list(), .Names
      = character(0)), subscribed_events = list(), name = NULL, id = NULL
    ) {
      super$initialize(level = level, tags = tags, visible = visible,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["TextAnnotation"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Specifies whether the text is rendered as a canvas element or as a CSS
    # element overlaid on the canvas. The default mode is "canvas".
    # 
    # .. note:: The CSS labels won't be present in the output using the
    # "save" tool.
    # 
    # .. warning:: Not all visual styling properties are supported if the
    # render_mode is set to "css". The border_line_dash property isn't fully
    # supported and border_line_dash_offset isn't supported at all. Setting
    # text_alpha will modify the opacity of the entire background box and
    # border in addition to the text. Finally, clipping Label annotations
    # inside of the plot area isn't supported in "css" mode.
    # > Enum('canvas', 'css')
    render_mode = NULL
  )
)

# A ``BooleanFilter`` filters data by returning the subset of data
# corresponding to indices where the values of the booleans array is
# True.
BooleanFilter <- R6::R6Class("BooleanFilter",
  inherit = Filter,
  public = list(
    specified_args = NULL,
    initialize = function(
      filter = NULL, tags = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(), booleans = NULL,
      name = NULL, id = NULL
    ) {
      super$initialize(filter = filter, tags = tags,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["BooleanFilter"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A list of booleans indicating which rows of data to select.
    # > Seq(Bool)
    booleans = NULL
  )
)

# Spinner-based number cell editor.
NumberEditor <- R6::R6Class("NumberEditor",
  inherit = CellEditor,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), js_property_callbacks = structure(list(), .Names =
      character(0)), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), step = 0.01, name = NULL,
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["NumberEditor"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The major step value.
    # > Float
    step = NULL
  )
)

# Combine different tickers at different scales.
# 
# Uses the ``min_interval`` and ``max_interval`` interval attributes of
# the tickers to select the appropriate ticker at different scales.
CompositeTicker <- R6::R6Class("CompositeTicker",
  inherit = ContinuousTicker,
  public = list(
    specified_args = NULL,
    initialize = function(
      desired_num_ticks = 6L, js_property_callbacks = structure(list(),
      .Names = character(0)), tickers = list(), tags = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), name = NULL, num_minor_ticks = 5L, id = NULL
    ) {
      super$initialize(tags = tags, desired_num_ticks = desired_num_ticks,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name,
        num_minor_ticks = num_minor_ticks, id = id)
      types <- bk_prop_types[["CompositeTicker"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A list of Ticker objects to combine at different scales in order to
    # generate tick values. The supplied tickers should be in order.
    # Specifically, if S comes before T, then it should be the case that::
    # 
    # S.get_max_interval() < T.get_min_interval()
    # > Seq(Instance(Ticker))
    tickers = NULL
  )
)

# Render images given as RGBA data.
ImageRGBA <- R6::R6Class("ImageRGBA",
  inherit = XYGlyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      dw = NULL, y = NULL, js_property_callbacks = structure(list(), .Names =
      character(0)), image = NULL, x = NULL, dw_units = "data",
      global_alpha = 1, tags = list(), dilate = FALSE,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), name = NULL, dh_units = "data", dh = NULL,
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["ImageRGBA"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The widths of the plot regions that the images will occupy.
    # 
    # .. note:: This is not the number of pixels that an image is wide.  That
    # number is fixed by the image itself.
    # > DistanceSpec(units_default='data')
    dw = NULL,
    # The y-coordinates to locate the image anchors.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y = NULL,
    # The arrays of RGBA data for the images.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    image = NULL,
    # The x-coordinates to locate the image anchors.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x = NULL,
    # 
    # > Enum('screen', 'data')
    dw_units = NULL,
    # An overall opacity that each image is rendered with (in addition to any
    # inherent alpha values in the image itself).
    # > Float
    global_alpha = NULL,
    # Whether to always round fractional pixel locations in such a way as to
    # make the images bigger.
    # 
    # This setting may be useful if pixel rounding errors are causing images
    # to have a gap between them, when they should appear flush.
    # > Bool
    dilate = NULL,
    # 
    # > Enum('screen', 'data')
    dh_units = NULL,
    # The height of the plot region that the image will occupy.
    # 
    # .. note:: This is not the number of pixels that an image is tall.  That
    # number is fixed by the image itself.
    # > DistanceSpec(units_default='data')
    dh = NULL
  )
)

# Render a shaded rectangular region as an annotation.
BoxAnnotation <- R6::R6Class("BoxAnnotation",
  inherit = Annotation,
  public = list(
    specified_args = NULL,
    initialize = function(
      level = "annotation", left_units = "data", right_units = "data",
      tags = list(), render_mode = "canvas", top_units = "data",
      fill_alpha = 0.4, visible = TRUE, line_color = "#cccccc",
      line_dash = list(), name = NULL, fill_color = "#fff9ba",
      line_alpha = 0.3, bottom_units = "data", top = NULL,
      x_range_name = "default", js_property_callbacks = structure(list(),
      .Names = character(0)), y_range_name = "default", left = NULL,
      line_dash_offset = 0L, bottom = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      line_join = "bevel", subscribed_events = list(), right = NULL,
      line_cap = "butt", line_width = 1L, id = NULL
    ) {
      super$initialize(level = level, tags = tags, visible = visible,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["BoxAnnotation"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The unit type for the left attribute. Interpreted as "data space" units
    # by default.
    # > Enum('screen', 'data')
    left_units = NULL,
    # The unit type for the right attribute. Interpreted as "data space"
    # units by default.
    # > Enum('screen', 'data')
    right_units = NULL,
    # Specifies whether the box is rendered as a canvas element or as an css
    # element overlaid on the canvas. The default mode is "canvas".
    # 
    # .. warning:: The line_dash and line_dash_offset attributes aren't
    # supported if the render_mode is set to "css"
    # > Enum('canvas', 'css')
    render_mode = NULL,
    # The unit type for the top attribute. Interpreted as "data space" units
    # by default.
    # > Enum('screen', 'data')
    top_units = NULL,
    # The fill alpha values for the box.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    fill_alpha = NULL,
    # The line color values for the box.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The line dash values for the box.
    # > DashPattern
    line_dash = NULL,
    # The fill color values for the box.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    fill_color = NULL,
    # The line alpha values for the box.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL,
    # The unit type for the bottom attribute. Interpreted as "data space"
    # units by default.
    # > Enum('screen', 'data')
    bottom_units = NULL,
    # The y-coordinates of the top edge of the box annotation.
    # 
    # Datetime values are also accepted, but note that they are immediately
    # converted to milliseconds-since-epoch.
    # > Either(Auto, NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float))
    top = NULL,
    # A particular (named) x-range to use for computing screen locations when
    # rendering box annotations on the plot. If unset, use the default
    # x-range.
    # > String
    x_range_name = NULL,
    # A particular (named) y-range to use for computing screen locations when
    # rendering box annotations on the plot. If unset, use the default
    # y-range.
    # > String
    y_range_name = NULL,
    # The x-coordinates of the left edge of the box annotation.
    # 
    # Datetime values are also accepted, but note that they are immediately
    # converted to milliseconds-since-epoch.
    # > Either(Auto, NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float))
    left = NULL,
    # The line dash offset values for the box.
    # > Int
    line_dash_offset = NULL,
    # The y-coordinates of the bottom edge of the box annotation.
    # 
    # Datetime values are also accepted, but note that they are immediately
    # converted to milliseconds-since-epoch.
    # > Either(Auto, NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float))
    bottom = NULL,
    # The line join values for the box.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # The x-coordinates of the right edge of the box annotation.
    # 
    # Datetime values are also accepted, but note that they are immediately
    # converted to milliseconds-since-epoch.
    # > Either(Auto, NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float))
    right = NULL,
    # The line cap values for the box.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line width values for the box.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL
  )
)

# Map numbers in a range [*low*, *high*] linearly into a sequence of
# colors (a palette).
# 
# For example, if the range is [0, 99] and the palette is ``['red',
# 'green', 'blue']``, the values would be mapped as follows::
# 
# x < 0 : 'red' # values < low are clamped 0 >= x < 33 : 'red' 33 >= x <
# 66 : 'green' 66 >= x < 99 : 'blue' 99 >= x : 'blue' # values > high are
# clamped
LinearColorMapper <- R6::R6Class("LinearColorMapper",
  inherit = ContinuousColorMapper,
  public = list(
    specified_args = NULL,
    initialize = function(
      high = NULL, js_property_callbacks = structure(list(), .Names =
      character(0)), palette = NULL, tags = list(), low = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), low_color = NULL, name = NULL,
      high_color = NULL, nan_color = "gray", id = NULL
    ) {
      super$initialize(high = high,
        js_property_callbacks = js_property_callbacks, palette = palette,
        tags = tags, low = low, js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, low_color = low_color,
        name = name, high_color = high_color, nan_color = nan_color, id = id)
      types <- bk_prop_types[["LinearColorMapper"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# A base class for all interactive widget types.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
Widget <- R6::R6Class("Widget",
  inherit = LayoutDOM,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", disabled = FALSE,
      background = NULL, tags = list(), visible = TRUE, width_policy = "auto",
      height_policy = "auto", height = NULL, name = NULL, sizing_mode = NULL,
      default_size = 300L, max_height = NULL, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      orientation = "horizontal", js_event_callbacks = structure(list(),
      .Names = character(0)), min_height = NULL,
      subscribed_events = list(), width = NULL, aspect_ratio = NULL,
      margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, background = background,
        tags = tags, visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, name = name,
        sizing_mode = sizing_mode, max_height = max_height,
        css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        js_event_callbacks = js_event_callbacks, min_height = min_height,
        subscribed_events = subscribed_events, width = width,
        aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["Widget"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The default size (width or height) in the dominating dimension.
    # 
    # The dominating dimension is determined by widget orientation.
    # > Int
    default_size = NULL,
    # Orient the widget either horizontally (default) or vertically.
    # 
    # Note that not all widgets support vertical orientation.
    # > Enum('horizontal', 'vertical')
    orientation = NULL
  )
)

# A base class for tools that respond to scroll events.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
Scroll <- R6::R6Class("Scroll",
  inherit = Gesture,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Scroll"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Display tick values that are formatted by a user-defined function.
# 
# .. warning:: The explicit purpose of this Bokeh Model is to embed *raw
# JavaScript code* for a browser to execute. If any part of the code is
# derived from untrusted user inputs, then you must take appropriate care
# to sanitize the user input prior to passing to Bokeh.
FuncTickFormatter <- R6::R6Class("FuncTickFormatter",
  inherit = TickFormatter,
  public = list(
    specified_args = NULL,
    initialize = function(
      js_property_callbacks = structure(list(), .Names = character(0)),
      code = "", tags = list(), use_strict = FALSE,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), name = NULL, args = structure(list(),
      .Names = character(0)), id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["FuncTickFormatter"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A snippet of JavaScript code that reformats a single tick to the
    # desired format. The variable ``tick`` will contain the unformatted tick
    # value and can be expected to be present in the code snippet namespace
    # at render time.
    # 
    # Additionally available variables are:
    # 
    # * ``ticks``, an array of all axis ticks as positioned by the ticker, *
    # ``index``, the position of ``tick`` within ``ticks``, and * the keys of
    # ``args`` mapping, if any.
    # 
    # Finding yourself needing to cache an expensive ``ticks``-dependent
    # computation, you can store it on the ``this`` variable.
    # 
    # Example:
    # 
    # .. code-block:: javascript
    # 
    # code = ''' this.precision = this.precision || (ticks.length > 5 ? 1 :
    # 2); return Math.floor(tick) + " + " + (tick %
    # 1).toFixed(this.precision); '''
    # > String
    code = NULL,
    # Enables or disables automatic insertion of ``"use strict";`` into
    # ``code``.
    # > Bool
    use_strict = NULL,
    # A mapping of names to Python objects. In particular those can be
    # bokeh's models.  These objects are made available to the formatter's
    # code snippet as the values of named parameters to the callback.
    # > Dict(String, AnyRef)
    args = NULL
  )
)

# Generate nice ticks across different date and time scales.
DatetimeTicker <- R6::R6Class("DatetimeTicker",
  inherit = CompositeTicker,
  public = list(
    specified_args = NULL,
    initialize = function(
      desired_num_ticks = 6L, js_property_callbacks = structure(list(),
      .Names = character(0)), tickers = list("{\"id\": \"2702\",
      \"mantissas\": [1, 2, 5], \"max_interval\": 500.0,
      \"num_minor_ticks\": 0}", "{\"base\": 60, \"id\": \"2703\",
      \"mantissas\": [1, 2, 5, 10, 15, 20, 30], \"max_interval\":
      1800000.0, \"min_interval\": 1000.0, \"num_minor_ticks\": 0}",
      "{\"base\": 24, \"id\": \"2704\", \"mantissas\": [1, 2, 4, 6, 8,
      12], \"max_interval\": 43200000.0, \"min_interval\": 3600000.0,
      \"num_minor_ticks\": 0}", "{\"days\": [1, 2, 3, 4, 5, 6, 7, 8, 9,
      10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25,
      26, 27, 28, 29, 30, 31], \"id\": \"2705\"}", "{\"days\": [1, 4,
      7, 10, 13, 16, 19, 22, 25, 28], \"id\": \"2706\"}", "{\"days\":
      [1, 8, 15, 22], \"id\": \"2707\"}", "{\"days\": [1, 15], \"id\":
      \"2708\"}", "{\"id\": \"2709\", \"months\": [0, 1, 2, 3, 4, 5, 6,
      7, 8, 9, 10, 11]}", "{\"id\": \"2710\", \"months\": [0, 2, 4, 6,
      8, 10]}", "{\"id\": \"2711\", \"months\": [0, 4, 8]}", "{\"id\":
      \"2712\", \"months\": [0, 6]}", "{\"id\": \"2713\"}"),
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), name = NULL,
      num_minor_ticks = 0L, id = NULL
    ) {
      super$initialize(desired_num_ticks = desired_num_ticks,
        js_property_callbacks = js_property_callbacks, tickers = tickers,
        tags = tags, js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name,
        num_minor_ticks = num_minor_ticks, id = id)
      types <- bk_prop_types[["DatetimeTicker"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# *toolbar icon*: |box_zoom_icon|
# 
# The box zoom tool allows users to define a rectangular egion of a Plot
# to zoom to by dragging he mouse or a finger over the plot region. The
# end of the drag event indicates the selection region is ready.
# 
# .. |box_zoom_icon| image:: /_images/icons/BoxZoom.png :height: 18pt
# 
# .. note:: ``BoxZoomTool`` is incompatible with ``GMapPlot`` due to the
# manner in which Google Maps exert explicit control over aspect ratios.
# Adding this tool to a ``GMapPlot`` will have no effect.
BoxZoomTool <- R6::R6Class("BoxZoomTool",
  inherit = Drag,
  public = list(
    specified_args = NULL,
    initialize = function(
      dimensions = "both", js_property_callbacks = structure(list(), .Names
      = character(0)), tags = list(), overlay = NULL, match_aspect = FALSE,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), name = NULL, origin = "corner", id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["BoxZoomTool"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Which dimensions the zoom box is to be free in. By default, users may
    # freely draw zoom boxes with any dimensions. If only "width" is
    # supplied, the box will be constrained to span the entire vertical space
    # of the plot, only the horizontal dimension can be controlled. If only
    # "height" is supplied, the box will be constrained to span the entire
    # horizontal space of the plot, and the vertical dimension can be
    # controlled.
    # > Enum('width', 'height', 'both')
    dimensions = NULL,
    # A shaded annotation drawn to indicate the selection region.
    # > Instance(BoxAnnotation)
    overlay = NULL,
    # Whether the box zoom region should be restricted to have the same
    # aspect ratio as the plot region.
    # 
    # .. note:: If the tool is restricted to one dimension, this value has no
    # effect.
    # > Bool
    match_aspect = NULL,
    # Indicates whether the rectangular zoom area should originate from a
    # corner (top-left or bottom-right depending on direction) or the center
    # of the box.
    # > Enum('corner', 'center')
    origin = NULL
  )
)

# A group of check boxes rendered as toggle buttons.
CheckboxButtonGroup <- R6::R6Class("CheckboxButtonGroup",
  inherit = ButtonGroup,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", disabled = FALSE,
      callback = NULL, background = NULL, button_type = "default",
      tags = list(), visible = TRUE, width_policy = "auto",
      height_policy = "auto", height = NULL, name = NULL, sizing_mode = NULL,
      labels = list(), default_size = 300L, max_height = NULL,
      css_classes = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), orientation = "horizontal", active = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      min_height = NULL, subscribed_events = list(), width = NULL,
      aspect_ratio = NULL, margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, callback = callback,
        background = background, button_type = button_type, tags = tags,
        visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, name = name,
        sizing_mode = sizing_mode, labels = labels,
        default_size = default_size, max_height = max_height,
        css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["CheckboxButtonGroup"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The list of indices of selected check boxes.
    # > List(Int)
    active = NULL
  )
)

# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
GraphHitTestPolicy <- R6::R6Class("GraphHitTestPolicy",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["GraphHitTestPolicy"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Render circle markers.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/Circle.py
# :source-position: below
Circle <- R6::R6Class("Circle",
  inherit = Marker,
  public = list(
    specified_args = NULL,
    initialize = function(
      angle_units = "rad", x = NULL, tags = list(), fill_alpha = 1,
      radius_units = "data", line_dash = list(), line_color = "black",
      name = NULL, fill_color = "gray", line_alpha = 1, y = NULL, size = 4L,
      js_property_callbacks = structure(list(), .Names = character(0)),
      radius = NULL, radius_dimension = "x", angle = 0, line_dash_offset = 0L,
      js_event_callbacks = structure(list(), .Names = character(0)),
      line_join = "bevel", subscribed_events = list(), line_cap = "butt",
      line_width = 1L, id = NULL
    ) {
      super$initialize(y = y, size = size, line_join = line_join,
        js_property_callbacks = js_property_callbacks,
        angle_units = angle_units, name = name, x = x, fill_color = fill_color,
        line_dash = line_dash, tags = tags, angle = angle,
        line_dash_offset = line_dash_offset,
        js_event_callbacks = js_event_callbacks, fill_alpha = fill_alpha,
        subscribed_events = subscribed_events, line_color = line_color,
        line_width = line_width, line_cap = line_cap,
        line_alpha = line_alpha, id = id)
      types <- bk_prop_types[["Circle"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # 
    # > Enum('screen', 'data')
    radius_units = NULL,
    # The radius values for circle markers (in "data space" units, by
    # default).
    # 
    # .. note:: Circle markers are slightly unusual in that they support
    # specifying a radius in addition to a size. Only one of ``radius`` or
    # ``size`` should be given.
    # 
    # .. warning:: Note that ``Circle`` glyphs are always drawn as circles on
    # the screen, even in cases where the data space aspect ratio is not 1-1.
    # In all cases where radius values are specified, the "distance" for the
    # radius is measured along the dimension specified by
    # ``radius_dimension``. If the aspect ratio is very large or small, the
    # drawn circles may appear much larger or smaller than expected. See
    # :bokeh-issue:`626` for more information.
    # > DistanceSpec(units_default='data')
    radius = NULL,
    # What dimension to measure circle radii along.
    # 
    # When the data space aspect ratio is not 1-1, then the size of the drawn
    # circles depends on what direction is used to measure the "distance" of
    # the radius. This property allows that direction to be controlled.
    # 
    # Setting this dimension to 'max' will calculate the radius on both the x
    # and y dimensions and use the maximum of the two, 'min' selects the
    # minimum.
    # > Enum('x', 'y', 'max', 'min')
    radius_dimension = NULL
  )
)

# Render triangle markers.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/Triangle.py
# :source-position: below
Triangle <- R6::R6Class("Triangle",
  inherit = Marker,
  public = list(
    specified_args = NULL,
    initialize = function(
      y = NULL, size = 4L, line_join = "bevel",
      js_property_callbacks = structure(list(), .Names = character(0)),
      angle_units = "rad", name = NULL, x = NULL, fill_color = "gray",
      line_dash = list(), tags = list(), angle = 0, line_dash_offset = 0L,
      js_event_callbacks = structure(list(), .Names = character(0)),
      fill_alpha = 1, subscribed_events = list(), line_color = "black",
      line_width = 1L, line_cap = "butt", line_alpha = 1, id = NULL
    ) {
      super$initialize(y = y, size = size, line_join = line_join,
        js_property_callbacks = js_property_callbacks,
        angle_units = angle_units, name = name, x = x, fill_color = fill_color,
        line_dash = line_dash, tags = tags, angle = angle,
        line_dash_offset = line_dash_offset,
        js_event_callbacks = js_event_callbacks, fill_alpha = fill_alpha,
        subscribed_events = subscribed_events, line_color = line_color,
        line_width = line_width, line_cap = line_cap,
        line_alpha = line_alpha, id = id)
      types <- bk_prop_types[["Triangle"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# An ``IndexFilter`` filters data by returning the subset of data at a
# given set of indices.
IndexFilter <- R6::R6Class("IndexFilter",
  inherit = Filter,
  public = list(
    specified_args = NULL,
    initialize = function(
      filter = NULL, tags = list(), js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, indices = NULL, id = NULL
    ) {
      super$initialize(filter = filter, tags = tags,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["IndexFilter"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A list of integer indices representing the subset of data to select.
    # > Seq(Int)
    indices = NULL
  )
)

# Lay out child components in a single horizontal row.
# 
# Children can be specified as positional arguments, as a single argument
# that is a sequence, or using the ``children`` keyword argument.
Row <- R6::R6Class("Row",
  inherit = Box,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", disabled = FALSE,
      background = NULL, tags = list(), visible = TRUE, width_policy = "auto",
      height_policy = "auto", height = NULL, spacing = 0L, sizing_mode = NULL,
      name = NULL, cols = "auto", max_height = NULL, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      children = list(), min_height = NULL, subscribed_events = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      width = NULL, aspect_ratio = NULL, margin = list(0L, 0L, 0L, 0L),
      id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, background = background,
        tags = tags, visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, spacing = spacing,
        sizing_mode = sizing_mode, name = name, max_height = max_height,
        css_classes = css_classes,
        js_property_callbacks = js_property_callbacks, children = children,
        min_height = min_height, subscribed_events = subscribed_events,
        js_event_callbacks = js_event_callbacks, width = width,
        aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["Row"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Describes how the component should maintain its columns' widths.
    # 
    # .. note:: This is an experimental feature and may change in future. Use
    # it at your own discretion.
    # > Either(Either(Enum('auto', 'min', 'fit', 'max'), Int), Dict(Either(Int, String), Either(Either(Enum('auto', 'min', 'fit', 'max'), Int), Struct(policy=Enum('auto', 'min'), align=Either(Auto, Enum('start', 'center', 'end'))), Struct(policy=Enum('fixed'), width=Int, align=Either(Auto, Enum('start', 'center', 'end'))), Struct(policy=Enum('fit', 'max'), align=Either(Auto, Enum('start', 'center', 'end')), flex=Float))))
    cols = NULL
  )
)

# *toolbar icon*: |crosshair_icon|
# 
# The hover tool is a passive inspector tool. It is generally on at all
# times, but can be configured in the inspector's menu associated with
# the *toolbar icon* shown above.
# 
# By default, the hover tool displays informational tooltips whenever the
# cursor is directly over a glyph. The data to show comes from the
# glyph's data source, and what to display is configurable with the
# ``tooltips`` property that maps display names to columns in the data
# source, or to special known variables.
# 
# Here is an example of how to configure and use the hover tool::
# 
# # Add tooltip (name, field) pairs to the tool. See below for a #
# description of possible field values.  hover.tooltips = [ ("index",
# "$index"), ("(x,y)", "($x, $y)"), ("radius", "@radius"), ("fill color",
# "$color[hex, swatch]:fill_color"), ("foo", "@foo"), ("bar", "@bar"),
# ("baz", "@baz{safe}"), ("total", "@total{$0,0.00}" ]
# 
# You can also supply a ``Callback`` to the ``HoverTool``, to build
# custom interactions on hover. In this case you may want to turn the
# tooltips off by setting ``tooltips=None``.
# 
# .. warning:: When supplying a callback or custom template, the explicit
# intent of this Bokeh Model is to embed *raw HTML and JavaScript code*
# for a browser to execute. If any part of the code is derived from
# untrusted user inputs, then you must take appropriate care to sanitize
# the user input prior to passing to Bokeh.
# 
# Hover tool does not currently work with the following glyphs:
# 
# .. hlist:: :columns: 3
# 
# * annulus * arc * bezier * image * image_rgba * image_url * oval *
# patch * quadratic * ray * text
# 
# .. |hover_icon| image:: /_images/icons/Hover.png :height: 18pt
HoverTool <- R6::R6Class("HoverTool",
  inherit = Inspection,
  public = list(
    specified_args = NULL,
    initialize = function(
      toggleable = TRUE, anchor = "center",
      js_property_callbacks = structure(list(), .Names = character(0)),
      mode = "mouse", point_policy = "snap_to_data", callback = NULL,
      show_arrow = TRUE, tags = list(), renderers = "auto",
      attachment = "horizontal", formatters = structure(list(), .Names =
      character(0)), names = list(), subscribed_events = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      name = NULL, line_policy = "nearest", tooltips = list(list("index",
      "$index"), list("data (x, y)", "($x, $y)"), list("screen (x, y)",
      "($sx, $sy)")), id = NULL
    ) {
      super$initialize(toggleable = toggleable, tags = tags,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["HoverTool"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # If point policy is set to `"snap_to_data"`, `anchor` defines the
    # attachment point of a tooltip. The default is to attach to the center
    # of a glyph.
    # > Enum('top_left', 'top_center', 'top_right', 'center_left', 'center', 'center_right', 'bottom_left', 'bottom_center', 'bottom_right')
    anchor = NULL,
    # Whether to consider hover pointer as a point (x/y values), or a span on
    # h or v directions.
    # > Enum('mouse', 'hline', 'vline')
    mode = NULL,
    # Whether the tooltip position should snap to the "center" (or other
    # anchor) position of the associated glyph, or always follow the current
    # mouse cursor position.
    # > Enum('snap_to_data', 'follow_mouse', 'none')
    point_policy = NULL,
    # A callback to run in the browser whenever the input's value changes.
    # The ``cb_data`` parameter that is available to the Callback code will
    # contain two ``HoverTool`` specific fields:
    # 
    # :index: object containing the indices of the hovered points in the data
    # source :geometry: object containing the coordinates of the hover cursor
    # > Instance(Callback)
    callback = NULL,
    # Whether tooltip's arrow should be shown.
    # > Bool
    show_arrow = NULL,
    # An explicit list of renderers to hit test against. If unset, defaults
    # to all renderers on a plot.
    # > Either(Auto, List(Instance(Renderer)))
    renderers = NULL,
    # Whether the tooltip should be displayed to the left or right of the
    # cursor position or above or below it, or if it should be automatically
    # placed in the horizontal or vertical dimension.
    # > Enum('horizontal', 'vertical', 'left', 'right', 'above', 'below')
    attachment = NULL,
    # Specify the formatting scheme for data source columns, e.g.
    # 
    # .. code-block:: python
    # 
    # tool.formatters = dict(date="datetime")
    # 
    # will cause format specifications for the "date" column to be
    # interpreted according to the "datetime" formatting scheme. The
    # following schemes are available:
    # 
    # :``"numeral"``: Provides a wide variety of formats for numbers,
    # currency, bytes, times, and percentages. The full set of formats can be
    # found in the |NumeralTickFormatter| reference documentation.
    # 
    # :``"datetime"``: Provides formats for date and time values. The full
    # set of formats is listed in the |DatetimeTickFormatter| reference
    # documentation.
    # 
    # :``"printf"``: Provides formats similar to C-style "printf" type
    # specifiers. See the |PrintfTickFormatter| reference documentation for
    # complete details.
    # 
    # If no formatter is specified for a column name, the default
    # ``"numeral"`` formatter is assumed.
    # 
    # .. |NumeralTickFormatter| replace::
    # :class:`~bokeh.models.formatters.NumeralTickFormatter` ..
    # |DatetimeTickFormatter| replace::
    # :class:`~bokeh.models.formatters.DatetimeTickFormatter` ..
    # |PrintfTickFormatter| replace::
    # :class:`~bokeh.models.formatters.PrintfTickFormatter`
    # > Dict(String, Either(Enum('numeral', 'datetime', 'printf'), Instance(CustomJSHover)))
    formatters = NULL,
    # A list of names to query for. If set, only renderers that have a
    # matching value for their ``name`` attribute will be used.
    # > List(String)
    names = NULL,
    # When showing tooltips for lines, designates whether the tooltip
    # position should be the "previous" or "next" points on the line, the
    # "nearest" point to the current mouse position, or "interpolate" along
    # the line to the current mouse position.
    # > Enum('prev', 'next', 'nearest', 'interp', 'none')
    line_policy = NULL,
    # The (name, field) pairs describing what the hover tool should display
    # when there is a hit.
    # 
    # Field names starting with "@" are interpreted as columns on the data
    # source. For instance, "@temp" would look up values to display from the
    # "temp" column of the data source.
    # 
    # Field names starting with "$" are special, known fields:
    # 
    # :$index: index of hovered point in the data source :$name: value of the
    # ``name`` property of the hovered glyph renderer :$x: x-coordinate under
    # the cursor in data space :$y: y-coordinate under the cursor in data
    # space :$sx: x-coordinate under the cursor in screen (canvas) space
    # :$sy: y-coordinate under the cursor in screen (canvas) space :$color:
    # color data from data source, with the syntax:
    # ``$color[options]:field_name``. The available options are: 'hex' (to
    # display the color as a hex value), and 'swatch' to also display a small
    # color swatch.
    # 
    # Field names that begin with ``@`` are associated with columns in a
    # ``ColumnDataSource``. For instance the field name ``"@price"`` will
    # display values from the ``"price"`` column whenever a hover is
    # triggered.  If the hover is for the 17th glyph, then the hover tooltip
    # will correspondingly display the 17th price value.
    # 
    # Note that if a column name contains spaces, the it must be supplied by
    # surrounding it in curly braces, e.g. ``@{adjusted close}`` will display
    # values from a column named ``"adjusted close"``.
    # 
    # Sometimes (especially with stacked charts) it is desirable to allow the
    # name of the column be specified indirectly. The field name ``@$name``
    # is distinguished in that it will look up the ``name`` field on the
    # hovered glyph renderer, and use that value as the column name. For
    # instance, if a user hovers with the name ``"US East"``, then ``@$name``
    # is equivalent to ``@{US East}``.
    # 
    # By default, values for fields (e.g. ``@foo``) are displayed in a basic
    # numeric format. However it is possible to control the formatting of
    # values more precisely. Fields can be modified by appending a format
    # specified to the end in curly braces. Some examples are below.
    # 
    # .. code-block:: python
    # 
    # "@foo{0,0.000}" # formats 10000.1234 as: 10,000.123
    # 
    # "@foo{(.00)}" # formats -10000.1234 as: (10000.123)
    # 
    # "@foo{($ 0.00 a)}" # formats 1230974 as: $ 1.23 m
    # 
    # Specifying a format ``{safe}`` after a field name will override
    # automatic escaping of the tooltip data source. Any HTML tags in the
    # data tags will be rendered as HTML in the resulting HoverTool output.
    # See :ref:`custom_hover_tooltip` for a more detailed example.
    # 
    # ``None`` is also a valid value for tooltips. This turns off the
    # rendering of tooltips. This is mostly useful when supplying other
    # actions on hover via the callback property.
    # 
    # .. note:: The tooltips attribute can also be configured with a mapping
    # type, e.g. ``dict`` or ``OrderedDict``. However, if a ``dict`` is used,
    # the visual presentation order is unspecified.
    # > Either(String, List(Tuple(String, String)))
    tooltips = NULL
  )
)

# Render a whisker along a dimension.
Whisker <- R6::R6Class("Whisker",
  inherit = Annotation,
  public = list(
    specified_args = NULL,
    initialize = function(
      base = NULL, level = "underlay", upper = NULL, upper_head = NULL,
      tags = list(), lower = NULL, visible = TRUE, base_units = "data",
      dimension = "height", line_color = "black", line_dash = list(),
      upper_units = "data", source = NULL, line_alpha = 1, name = NULL,
      js_property_callbacks = structure(list(), .Names = character(0)),
      x_range_name = "default", y_range_name = "default",
      lower_units = "data", line_dash_offset = 0L, lower_head = NULL,
      line_join = "bevel", subscribed_events = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      line_cap = "butt", line_width = 1L, id = NULL
    ) {
      super$initialize(level = level, tags = tags, visible = visible,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["Whisker"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The orthogonal coordinates of the upper and lower values.
    # > UnitsSpec(units_default='data')
    base = NULL,
    # The coordinates of the upper end of the whiskers.
    # > UnitsSpec(units_default='data')
    upper = NULL,
    # Instance of ``ArrowHead``.
    # > Instance(ArrowHead)
    upper_head = NULL,
    # The coordinates of the lower end of the whiskers.
    # > UnitsSpec(units_default='data')
    lower = NULL,
    # 
    # > Enum('screen', 'data')
    base_units = NULL,
    # The direction of the whisker can be specified by setting this property
    # to "height" (``y`` direction) or "width" (``x`` direction).
    # > Enum('width', 'height')
    dimension = NULL,
    # The line color values for the whisker body.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The line dash values for the whisker body.
    # > DashPattern
    line_dash = NULL,
    # 
    # > Enum('screen', 'data')
    upper_units = NULL,
    # Local data source to use when rendering annotations on the plot.
    # > Instance(DataSource)
    source = NULL,
    # The line alpha values for the whisker body.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL,
    # A particular (named) x-range to use for computing screen locations when
    # rendering annotations on the plot. If unset, use the default x-range.
    # > String
    x_range_name = NULL,
    # A particular (named) y-range to use for computing screen locations when
    # rendering annotations on the plot. If unset, use the default y-range.
    # > String
    y_range_name = NULL,
    # 
    # > Enum('screen', 'data')
    lower_units = NULL,
    # The line dash offset values for the whisker body.
    # > Int
    line_dash_offset = NULL,
    # Instance of ``ArrowHead``.
    # > Instance(ArrowHead)
    lower_head = NULL,
    # The line join values for the whisker body.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # The line cap values for the whisker body.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line width values for the whisker body.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL
  )
)

# A base class for all guide renderer types. ``GuideRenderer`` is not
# generally useful to instantiate on its own.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
GuideRenderer <- R6::R6Class("GuideRenderer",
  inherit = Renderer,
  public = list(
    specified_args = NULL,
    initialize = function(
      level = "overlay", tags = list(), visible = TRUE,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), name = NULL, id = NULL
    ) {
      super$initialize(level = level, tags = tags, visible = visible,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["GuideRenderer"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Boolean (check mark) cell formatter.
BooleanFormatter <- R6::R6Class("BooleanFormatter",
  inherit = CellFormatter,
  public = list(
    specified_args = NULL,
    initialize = function(
      icon = "check", tags = list(), js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["BooleanFormatter"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The icon visualizing the check mark.
    # > Enum('check', 'check-circle', 'check-circle-o', 'check-square', 'check-square-o')
    icon = NULL
  )
)

# A block (paragraph) of text.
# 
# This Bokeh model corresponds to an HTML ``<p>`` element.
# 
# Example -------
# 
# .. bokeh-plot::
# ../../sphinx/source/docs/user_guide/examples/interaction_paragraph.py
# :source-position: below
Paragraph <- R6::R6Class("Paragraph",
  inherit = Markup,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", disabled = FALSE,
      style = structure(list(), .Names = character(0)), background = NULL,
      text = "", tags = list(), visible = TRUE, width_policy = "auto",
      height_policy = "auto", height = NULL, name = NULL, sizing_mode = NULL,
      default_size = 300L, max_height = NULL, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      orientation = "horizontal", js_event_callbacks = structure(list(),
      .Names = character(0)), min_height = NULL,
      subscribed_events = list(), width = NULL, aspect_ratio = NULL,
      margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, style = style,
        background = background, text = text, tags = tags, visible = visible,
        width_policy = width_policy, height_policy = height_policy,
        height = height, name = name, sizing_mode = sizing_mode,
        default_size = default_size, max_height = max_height,
        css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["Paragraph"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Display tick values from categorical ranges as string values.
CategoricalTickFormatter <- R6::R6Class("CategoricalTickFormatter",
  inherit = TickFormatter,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["CategoricalTickFormatter"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Slider-based number selection widget.
Slider <- R6::R6Class("Slider",
  inherit = AbstractSlider,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, align = "start", start = NULL, callback = NULL,
      tags = list(), width_policy = "auto", height_policy = "auto", step = 1L,
      height = NULL, callback_policy = "throttle", value_throttled = NULL,
      callback_throttle = 200L, max_height = NULL, show_value = TRUE,
      format = "0[.]00", js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), width = NULL,
      aspect_ratio = NULL, tooltips = TRUE, margin = list(5L, 5L, 5L, 5L),
      end = NULL, title = "", max_width = NULL, disabled = FALSE, value = NULL,
      bar_color = "#e6e6e6", background = NULL, visible = TRUE, name = NULL,
      sizing_mode = NULL, default_size = 300L, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      orientation = "horizontal", direction = "ltr", min_height = NULL,
      id = NULL
    ) {
      super$initialize(title = title, min_width = min_width,
        max_width = max_width, align = align, disabled = disabled,
        bar_color = bar_color, callback = callback, background = background,
        tags = tags, visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, name = name,
        sizing_mode = sizing_mode, callback_policy = callback_policy,
        default_size = default_size, callback_throttle = callback_throttle,
        max_height = max_height, show_value = show_value,
        css_classes = css_classes, format = format,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, direction = direction,
        min_height = min_height, subscribed_events = subscribed_events,
        js_event_callbacks = js_event_callbacks, width = width,
        aspect_ratio = aspect_ratio, tooltips = tooltips, margin = margin,
        id = id)
      types <- bk_prop_types[["Slider"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The minimum allowable value.
    # > Float
    start = NULL,
    # The step between consecutive values.
    # > Float
    step = NULL,
    # Initial or selected value, throttled according to callback_policy.
    # > Float
    value_throttled = NULL,
    # The maximum allowable value.
    # > Float
    end = NULL,
    # Initial or selected value.
    # > Float
    value = NULL
  )
)

# Base class for color mapper types.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
ColorMapper <- R6::R6Class("ColorMapper",
  inherit = Mapper,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), nan_color = "gray",
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), name = NULL, palette = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["ColorMapper"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Color to be used if data is NaN or otherwise not mappable. (Default:
    # 'gray')
    # > Color
    nan_color = NULL,
    # A sequence of colors to use as the target palette for mapping.
    # 
    # This property can also be set as a ``String``, to the name of any of
    # the palettes shown in :ref:`bokeh.palettes`.
    # > Seq(Color)
    palette = NULL
  )
)

# Render circle markers with an 'X' cross through the center.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/CircleX.py
# :source-position: below
CircleX <- R6::R6Class("CircleX",
  inherit = Marker,
  public = list(
    specified_args = NULL,
    initialize = function(
      y = NULL, size = 4L, line_join = "bevel",
      js_property_callbacks = structure(list(), .Names = character(0)),
      angle_units = "rad", name = NULL, x = NULL, fill_color = "gray",
      line_dash = list(), tags = list(), angle = 0, line_dash_offset = 0L,
      js_event_callbacks = structure(list(), .Names = character(0)),
      fill_alpha = 1, subscribed_events = list(), line_color = "black",
      line_width = 1L, line_cap = "butt", line_alpha = 1, id = NULL
    ) {
      super$initialize(y = y, size = size, line_join = line_join,
        js_property_callbacks = js_property_callbacks,
        angle_units = angle_units, name = name, x = x, fill_color = fill_color,
        line_dash = line_dash, tags = tags, angle = angle,
        line_dash_offset = line_dash_offset,
        js_event_callbacks = js_event_callbacks, fill_alpha = fill_alpha,
        subscribed_events = subscribed_events, line_color = line_color,
        line_width = line_width, line_cap = line_cap,
        line_alpha = line_alpha, id = id)
      types <- bk_prop_types[["CircleX"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# 
StaticLayoutProvider <- R6::R6Class("StaticLayoutProvider",
  inherit = LayoutProvider,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, graph_layout = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["StaticLayoutProvider"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The coordinates of the graph nodes in cartesian space. The dictionary
    # keys correspond to a node index and the values are a two element
    # sequence containing the x and y coordinates of the node.
    # 
    # .. code-block:: python
    # 
    # { 0 : [0.5, 0.5], 1 : [1.0, 0.86], 2 : [0.86, 1], }
    # > Dict(Either(String, Int), Seq(Any))
    graph_layout = NULL
  )
)

# Generate ticks on a log scale.
LogTicker <- R6::R6Class("LogTicker",
  inherit = AdaptiveTicker,
  public = list(
    specified_args = NULL,
    initialize = function(
      base = 10, max_interval = NULL, desired_num_ticks = 6L,
      js_property_callbacks = structure(list(), .Names = character(0)),
      mantissas = list(1L, 5L), tags = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), name = NULL, min_interval = 0,
      num_minor_ticks = 5L, id = NULL
    ) {
      super$initialize(base = base, max_interval = max_interval,
        desired_num_ticks = desired_num_ticks,
        js_property_callbacks = js_property_callbacks,
        mantissas = mantissas, tags = tags,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name,
        min_interval = min_interval, num_minor_ticks = num_minor_ticks,
        id = id)
      types <- bk_prop_types[["LogTicker"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Generate ticks at fixed, explicitly supplied locations.
# 
# .. note:: The ``desired_num_ticks`` property is ignored by this Ticker.
FixedTicker <- R6::R6Class("FixedTicker",
  inherit = ContinuousTicker,
  public = list(
    specified_args = NULL,
    initialize = function(
      minor_ticks = list(), desired_num_ticks = 6L,
      js_property_callbacks = structure(list(), .Names = character(0)),
      ticks = list(), tags = list(), js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(), name = NULL,
      num_minor_ticks = 5L, id = NULL
    ) {
      super$initialize(tags = tags, desired_num_ticks = desired_num_ticks,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name,
        num_minor_ticks = num_minor_ticks, id = id)
      types <- bk_prop_types[["FixedTicker"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # List of minor tick locations.
    # > Seq(Float)
    minor_ticks = NULL,
    # List of major tick locations.
    # > Seq(Float)
    ticks = NULL
  )
)

# Render a horizontally directed area between two equal length sequences
# of x-coordinates with the same y-coordinates.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/HArea.py
# :source-position: below
HArea <- R6::R6Class("HArea",
  inherit = Glyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      x2 = NULL, y = NULL, js_property_callbacks = structure(list(), .Names =
      character(0)), hatch_extra = structure(list(), .Names =
      character(0)), hatch_weight = 1, hatch_alpha = 1,
      hatch_color = "black", x1 = NULL, tags = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      hatch_scale = 12, hatch_pattern = NULL, subscribed_events = list(),
      name = NULL, fill_alpha = 1, fill_color = "gray", id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["HArea"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The x-coordinates for the points of the other side of the area.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x2 = NULL,
    # The y-coordinates for the points of the area.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y = NULL,
    # The hatch extra values for the horizontal bars.
    # > Dict(String, Instance(Texture))
    hatch_extra = NULL,
    # The hatch weight values for the horizontal bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    hatch_weight = NULL,
    # The hatch alpha values for the horizontal bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    hatch_alpha = NULL,
    # The hatch color values for the horizontal bars.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    hatch_color = NULL,
    # The x-coordinates for the points of one side of the area.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x1 = NULL,
    # The hatch scale values for the horizontal bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    hatch_scale = NULL,
    # The hatch pattern values for the horizontal bars.
    # > HatchPatternSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), HatchPatternType)), HatchPatternType)
    hatch_pattern = NULL,
    # The fill alpha values for the patch.
    # > Percent
    fill_alpha = NULL,
    # The fill color values for the patch.
    # > Color
    fill_color = NULL
  )
)

# With the ``NodesAndLinkedEdges`` policy, inspection or selection of
# graph nodes will result in the inspection or selection of the node and
# of the linked graph edges. There is no direct selection or inspection
# of graph edges.
NodesAndLinkedEdges <- R6::R6Class("NodesAndLinkedEdges",
  inherit = GraphHitTestPolicy,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["NodesAndLinkedEdges"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# A container for space used to fill an empty spot in a row or column.
Spacer <- R6::R6Class("Spacer",
  inherit = LayoutDOM,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", disabled = FALSE,
      background = NULL, tags = list(), visible = TRUE, width_policy = "auto",
      height_policy = "auto", height = NULL, name = NULL, sizing_mode = NULL,
      max_height = NULL, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      js_event_callbacks = structure(list(), .Names = character(0)),
      min_height = NULL, subscribed_events = list(), width = NULL,
      aspect_ratio = NULL, margin = list(0L, 0L, 0L, 0L), id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, background = background,
        tags = tags, visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, name = name,
        sizing_mode = sizing_mode, max_height = max_height,
        css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        js_event_callbacks = js_event_callbacks, min_height = min_height,
        subscribed_events = subscribed_events, width = width,
        aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["Spacer"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Options for ``GMapPlot`` objects.
GMapOptions <- R6::R6Class("GMapOptions",
  inherit = MapOptions,
  public = list(
    specified_args = NULL,
    initialize = function(
      tilt = 45L, js_property_callbacks = structure(list(), .Names =
      character(0)), styles = NULL, zoom = 12L, map_type = "roadmap",
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), lat = NULL, subscribed_events = list(),
      scale_control = FALSE, name = NULL, lng = NULL, id = NULL
    ) {
      super$initialize(js_property_callbacks = js_property_callbacks,
        zoom = zoom, tags = tags, js_event_callbacks = js_event_callbacks,
        lat = lat, subscribed_events = subscribed_events, name = name,
        lng = lng, id = id)
      types <- bk_prop_types[["GMapOptions"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # `Tilt`_ angle of the map. The only allowed values are 0 and 45.  Only
    # has an effect on 'satellite' and 'hybrid' map types.  A value of 0
    # causes the map to always use a 0 degree overhead view.  A value of 45
    # causes the tilt angle to switch to 45 imagery if available.
    # 
    # .. _Tilt:
    # https://developers.google.com/maps/documentation/javascript/reference/3/map#MapOptions.tilt
    # > Int
    tilt = NULL,
    # A JSON array of `map styles`_ to use for the ``GMapPlot``. Many example
    # styles can `be found here`_.
    # 
    # .. _map styles:
    # https://developers.google.com/maps/documentation/javascript/reference#MapTypeStyle
    # .. _be found here: https://snazzymaps.com
    # > JSON
    styles = NULL,
    # The `map type`_ to use for the ``GMapPlot``.
    # 
    # .. _map type:
    # https://developers.google.com/maps/documentation/javascript/reference#MapTypeId
    # > Enum('satellite', 'roadmap', 'terrain', 'hybrid')
    map_type = NULL,
    # Whether the Google map should display its distance scale control.
    # > Bool
    scale_control = NULL
  )
)

# Render a single line.
# 
# The ``Line`` glyph is different from most other glyphs in that the
# vector of values only produces one glyph on the Plot.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/Line.py
# :source-position: below
Line <- R6::R6Class("Line",
  inherit = XYGlyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      y = NULL, line_join = "bevel",
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, x = NULL, line_dash = list(), tags = list(),
      line_dash_offset = 0L, js_event_callbacks = structure(list(), .Names
      = character(0)), line_width = 1L, subscribed_events = list(),
      line_color = "black", line_cap = "butt", line_alpha = 1, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Line"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The y-coordinates for the points of the line.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y = NULL,
    # The line join values for the line.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # The x-coordinates for the points of the line.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x = NULL,
    # The line dash values for the line.
    # > DashPattern
    line_dash = NULL,
    # The line dash offset values for the line.
    # > Int
    line_dash_offset = NULL,
    # The line width values for the line.
    # > Float
    line_width = NULL,
    # The line color values for the line.
    # > Color
    line_color = NULL,
    # The line cap values for the line.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line alpha values for the line.
    # > Percent
    line_alpha = NULL
  )
)

# Render a sloped line as an annotation.
Slope <- R6::R6Class("Slope",
  inherit = Annotation,
  public = list(
    specified_args = NULL,
    initialize = function(
      gradient = NULL, level = "annotation", line_color = "black",
      line_join = "bevel", y_intercept = NULL, x_range_name = "default",
      js_property_callbacks = structure(list(), .Names = character(0)),
      y_range_name = "default", name = NULL, tags = list(),
      line_dash_offset = 0L, visible = TRUE,
      js_event_callbacks = structure(list(), .Names = character(0)),
      line_width = 1L, subscribed_events = list(), line_dash = list(),
      line_cap = "butt", line_alpha = 1, id = NULL
    ) {
      super$initialize(level = level, tags = tags, visible = visible,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["Slope"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The gradient of the line, in data units
    # > Float
    gradient = NULL,
    # The line color values for the line.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The line join values for the line.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # The y intercept of the line, in data units
    # > Float
    y_intercept = NULL,
    # A particular (named) x-range to use for computing screen locations when
    # rendering annotations on the plot. If unset, use the default x-range.
    # > String
    x_range_name = NULL,
    # A particular (named) y-range to use for computing screen locations when
    # rendering annotations on the plot. If unset, use the default y-range.
    # > String
    y_range_name = NULL,
    # The line dash offset values for the line.
    # > Int
    line_dash_offset = NULL,
    # The line width values for the line.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL,
    # The line dash values for the line.
    # > DashPattern
    line_dash = NULL,
    # The line cap values for the line.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line alpha values for the line.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL
  )
)

# Base class for ``Texture`` models that represent fill patterns.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
Texture <- R6::R6Class("Texture",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      repetition = "repeat", name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Texture"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # 
    # > Enum('repeat', 'repeat_x', 'repeat_y', 'no_repeat')
    repetition = NULL
  )
)

# *toolbar icon*: |pan_icon|
# 
# The pan tool allows the user to pan a Plot by left-dragging a mouse, or
# on touch devices by dragging a finger or stylus, across the plot
# region.
# 
# The pan tool also activates the border regions of a Plot for "single
# axis" panning. For instance, dragging in the vertical border or axis
# will effect a pan in the vertical direction only, with horizontal
# dimension kept fixed.
# 
# .. |pan_icon| image:: /_images/icons/Pan.png :height: 18pt
PanTool <- R6::R6Class("PanTool",
  inherit = Drag,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), dimensions = "both",
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["PanTool"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Which dimensions the pan tool is constrained to act in. By default the
    # pan tool will pan in any dimension, but can be configured to only pan
    # horizontally across the width of the plot, or vertically across the
    # height of the plot.
    # > Enum('width', 'height', 'both')
    dimensions = NULL
  )
)

# Render parabolas.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/Quadratic.py
# :source-position: below
Quadratic <- R6::R6Class("Quadratic",
  inherit = Glyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      y0 = NULL, cy = NULL, cx = NULL,
      js_property_callbacks = structure(list(), .Names = character(0)),
      x0 = NULL, name = NULL, line_dash = list(), x1 = NULL,
      line_dash_offset = 0L, tags = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      line_join = "bevel", subscribed_events = list(), y1 = NULL,
      line_color = "black", line_width = 1L, line_cap = "butt", line_alpha = 1,
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Quadratic"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The y-coordinates of the starting points.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y0 = NULL,
    # The y-coordinates of the control points.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    cy = NULL,
    # The x-coordinates of the control points.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    cx = NULL,
    # The x-coordinates of the starting points.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x0 = NULL,
    # The line dash values for the parabolas.
    # > DashPattern
    line_dash = NULL,
    # The x-coordinates of the ending points.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x1 = NULL,
    # The line dash offset values for the parabolas.
    # > Int
    line_dash_offset = NULL,
    # The line join values for the parabolas.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # The y-coordinates of the ending points.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y1 = NULL,
    # The line color values for the parabolas.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The line width values for the parabolas.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL,
    # The line cap values for the parabolas.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line alpha values for the parabolas.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL
  )
)

# Generate ticks spaced apart by specific, even multiples of days.
DaysTicker <- R6::R6Class("DaysTicker",
  inherit = SingleIntervalTicker,
  public = list(
    specified_args = NULL,
    initialize = function(
      desired_num_ticks = 6L, interval = NULL,
      js_property_callbacks = structure(list(), .Names = character(0)),
      tags = list(), days = list(), js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(), name = NULL,
      num_minor_ticks = 0L, id = NULL
    ) {
      super$initialize(desired_num_ticks = desired_num_ticks,
        interval = interval, js_property_callbacks = js_property_callbacks,
        tags = tags, js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name,
        num_minor_ticks = num_minor_ticks, id = id)
      types <- bk_prop_types[["DaysTicker"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The intervals of days to use.
    # > Seq(Int)
    days = NULL
  )
)

# A panel widget with navigation tabs.
# 
# Example -------
# 
# .. bokeh-plot::
# ../../sphinx/source/docs/user_guide/examples/interaction_tab_panes.py
# :source-position: below
Tabs <- R6::R6Class("Tabs",
  inherit = LayoutDOM,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", disabled = FALSE,
      tabs = list(), callback = NULL, background = NULL, tags = list(),
      visible = TRUE, width_policy = "auto", height_policy = "auto",
      height = NULL, name = NULL, sizing_mode = NULL, max_height = NULL,
      css_classes = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), active = 0L, tabs_location = "above",
      js_event_callbacks = structure(list(), .Names = character(0)),
      min_height = NULL, subscribed_events = list(), width = NULL,
      aspect_ratio = NULL, margin = list(0L, 0L, 0L, 0L), id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, background = background,
        tags = tags, visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, name = name,
        sizing_mode = sizing_mode, max_height = max_height,
        css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        js_event_callbacks = js_event_callbacks, min_height = min_height,
        subscribed_events = subscribed_events, width = width,
        aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["Tabs"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The list of child panel widgets.
    # > List(Instance(Panel))
    tabs = NULL,
    # A callback to run in the browser whenever the button is activated.
    # > Instance(Callback)
    callback = NULL,
    # The index of the active tab.
    # > Int
    active = NULL,
    # The location of the buttons that activate tabs.
    # > Enum('above', 'below', 'left', 'right')
    tabs_location = NULL
  )
)

# The base class for layoutable components.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
LayoutDOM <- R6::R6Class("LayoutDOM",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", disabled = FALSE,
      background = NULL, tags = list(), visible = TRUE, width_policy = "auto",
      height_policy = "auto", height = NULL, name = NULL, sizing_mode = NULL,
      max_height = NULL, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      js_event_callbacks = structure(list(), .Names = character(0)),
      min_height = NULL, subscribed_events = list(), width = NULL,
      aspect_ratio = NULL, margin = list(0L, 0L, 0L, 0L), id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["LayoutDOM"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Minimal width of the component (in pixels) if width is adjustable.
    # > NonNegativeInt
    min_width = NULL,
    # Minimal width of the component (in pixels) if width is adjustable.
    # > NonNegativeInt
    max_width = NULL,
    # The alignment point within the parent container.
    # 
    # This property is useful only if this component is a child element of a
    # layout (e.g. a grid). Self alignment can be overridden by the parent
    # container (e.g.  grid track align).
    # > Either(Enum('start', 'center', 'end'), Tuple(Enum('start', 'center', 'end'), Enum('start', 'center', 'end')))
    align = NULL,
    # Whether the widget will be disabled when rendered.
    # 
    # If ``True``, the widget will be greyed-out and not responsive to UI
    # events.
    # > Bool
    disabled = NULL,
    # Background color of the component.
    # > Color
    background = NULL,
    # Whether the component will be visible and a part of a layout.
    # > Bool
    visible = NULL,
    # Describes how the component should maintain its width.
    # 
    # ``"auto"`` Use component's preferred sizing policy.
    # 
    # ``"fixed"`` Use exactly ``width`` pixels. Component will overflow if it
    # can't fit in the available horizontal space.
    # 
    # ``"fit"`` Use component's preferred width (if set) and allow it to fit
    # into the available horizontal space within the minimum and maximum
    # width bounds (if set). Component's width neither will be aggressively
    # minimized nor maximized.
    # 
    # ``"min"`` Use as little horizontal space as possible, not less than the
    # minimum width (if set).  The starting point is the preferred width (if
    # set). The width of the component may shrink or grow depending on the
    # parent layout, aspect management and other factors.
    # 
    # ``"max"`` Use as much horizontal space as possible, not more than the
    # maximum width (if set).  The starting point is the preferred width (if
    # set). The width of the component may shrink or grow depending on the
    # parent layout, aspect management and other factors.
    # 
    # .. note:: This is an experimental feature and may change in future. Use
    # it at your own discretion. Prefer using ``sizing_mode`` if this level
    # of control isn't strictly necessary.
    # > Either(Auto, Enum('fixed', 'fit', 'min', 'max'))
    width_policy = NULL,
    # Describes how the component should maintain its height.
    # 
    # ``"auto"`` Use component's preferred sizing policy.
    # 
    # ``"fixed"`` Use exactly ``height`` pixels. Component will overflow if
    # it can't fit in the available vertical space.
    # 
    # ``"fit"`` Use component's preferred height (if set) and allow to fit
    # into the available vertical space withing the minimum and maximum
    # height bounds (if set). Component's height neither will be aggressively
    # minimized nor maximized.
    # 
    # ``"min"`` Use as little vertical space as possible, not less than the
    # minimum height (if set).  The starting point is the preferred height
    # (if set). The height of the component may shrink or grow depending on
    # the parent layout, aspect management and other factors.
    # 
    # ``"max"`` Use as much vertical space as possible, not more than the
    # maximum height (if set).  The starting point is the preferred height
    # (if set). The height of the component may shrink or grow depending on
    # the parent layout, aspect management and other factors.
    # 
    # .. note:: This is an experimental feature and may change in future. Use
    # it at your own discretion. Prefer using ``sizing_mode`` if this level
    # of control isn't strictly necessary.
    # > Either(Auto, Enum('fixed', 'fit', 'min', 'max'))
    height_policy = NULL,
    # The height of the component (in pixels).
    # 
    # This can be either fixed or preferred height, depending on height
    # sizing policy.
    # > NonNegativeInt
    height = NULL,
    # How the component should size itself.
    # 
    # This is a high-level setting for maintaining width and height of the
    # component. To gain more fine grained control over sizing, use
    # ``width_policy``, ``height_policy`` and ``aspect_ratio`` instead (those
    # take precedence over ``sizing_mode``).
    # 
    # Possible scenarios:
    # 
    # ``"fixed"`` Component is not responsive. It will retain its original
    # width and height regardless of any subsequent browser window resize
    # events.
    # 
    # ``"stretch_width"`` Component will responsively resize to stretch to
    # the available width, without maintaining any aspect ratio. The height
    # of the component depends on the type of the component and may be fixed
    # or fit to component's contents.
    # 
    # ``"stretch_height"`` Component will responsively resize to stretch to
    # the available height, without maintaining any aspect ratio. The width
    # of the component depends on the type of the component and may be fixed
    # or fit to component's contents.
    # 
    # ``"stretch_both"`` Component is completely responsive, independently in
    # width and height, and will occupy all the available horizontal and
    # vertical space, even if this changes the aspect ratio of the component.
    # 
    # ``"scale_width"`` Component will responsively resize to stretch to the
    # available width, while maintaining the original or provided aspect
    # ratio.
    # 
    # ``"scale_height"`` Component will responsively resize to stretch to the
    # available height, while maintaining the original or provided aspect
    # ratio.
    # 
    # ``"scale_both"`` Component will responsively resize to both the
    # available width and height, while maintaining the original or provided
    # aspect ratio.
    # > Enum('stretch_width', 'stretch_height', 'stretch_both', 'scale_width', 'scale_height', 'scale_both', 'fixed')
    sizing_mode = NULL,
    # Minimal height of the component (in pixels) if height is adjustable.
    # > NonNegativeInt
    max_height = NULL,
    # A list of CSS class names to add to this DOM element. Note: the class
    # names are simply added as-is, no other guarantees are provided.
    # 
    # It is also permissible to assign from tuples, however these are adapted
    # -- the property will always contain a list.
    # > List(String)
    css_classes = NULL,
    # Minimal height of the component (in pixels) if height is adjustable.
    # > NonNegativeInt
    min_height = NULL,
    # The width of the component (in pixels).
    # 
    # This can be either fixed or preferred width, depending on width sizing
    # policy.
    # > NonNegativeInt
    width = NULL,
    # Describes the proportional relationship between component's width and
    # height.
    # 
    # This works if any of component's dimensions are flexible in size. If
    # set to a number, ``width / height = aspect_ratio`` relationship will be
    # maintained.  Otherwise, if set to ``"auto"``, component's preferred
    # width and height will be used to determine the aspect (if not set, no
    # aspect will be preserved).
    # > Either(Enum('auto'), Float)
    aspect_ratio = NULL,
    # Allows to create additional space around the component.
    # > Tuple(Int, Int, Int, Int)
    margin = NULL
  )
)

# Render rectangles.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/Rect.py
# :source-position: below
Rect <- R6::R6Class("Rect",
  inherit = XYGlyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      angle_units = "rad", x = NULL, tags = list(), height_units = "data",
      fill_alpha = 1, height = NULL, subscribed_events = list(),
      line_dash = list(), line_color = "black", name = NULL,
      fill_color = "gray", line_alpha = 1, y = NULL,
      js_property_callbacks = structure(list(), .Names = character(0)),
      line_dash_offset = 0L, angle = 0, dilate = FALSE, line_join = "bevel",
      width_units = "data", js_event_callbacks = structure(list(), .Names =
      character(0)), width = NULL, line_cap = "butt", line_width = 1L,
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Rect"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # 
    # > Enum('deg', 'rad')
    angle_units = NULL,
    # The x-coordinates of the centers of the rectangles.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x = NULL,
    # 
    # > Enum('screen', 'data')
    height_units = NULL,
    # The fill alpha values for the rectangles.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    fill_alpha = NULL,
    # The overall heights of the rectangles.
    # > DistanceSpec(units_default='data')
    height = NULL,
    # The line dash values for the rectangles.
    # > DashPattern
    line_dash = NULL,
    # The line color values for the rectangles.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The fill color values for the rectangles.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    fill_color = NULL,
    # The line alpha values for the rectangles.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL,
    # The y-coordinates of the centers of the rectangles.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y = NULL,
    # The line dash offset values for the rectangles.
    # > Int
    line_dash_offset = NULL,
    # The angles to rotate the rectangles, as measured from the horizontal.
    # > AngleSpec(units_default='rad')
    angle = NULL,
    # Whether to always round fractional pixel locations in such a way as to
    # make the rectangles bigger.
    # 
    # This setting may be useful if pixel rounding errors are causing
    # rectangles to have a gap between them, when they should appear flush.
    # > Bool
    dilate = NULL,
    # The line join values for the rectangles.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # 
    # > Enum('screen', 'data')
    width_units = NULL,
    # The overall widths of the rectangles.
    # > DistanceSpec(units_default='data')
    width = NULL,
    # The line cap values for the rectangles.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line width values for the rectangles.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL
  )
)

# Abstract base class for map plot models.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
MapPlot <- R6::R6Class("MapPlot",
  inherit = Plot,
  public = list(
    specified_args = NULL,
    initialize = function(
      inner_height = NULL, min_border_top = NULL, lod_factor = 10L,
      aspect_scale = 1L, min_width = NULL, align = "start",
      extra_y_ranges = structure(list(), .Names = character(0)),
      frame_height = NULL, tags = list(), match_aspect = FALSE,
      outer_height = NULL, min_border_left = NULL, toolbar_sticky = TRUE,
      width_policy = "auto", height_policy = "auto", below = list(),
      height = NULL, frame_width = NULL, outline_line_cap = "butt",
      outline_line_width = 1L, max_height = NULL, plot_width = 600L,
      above = list(), hidpi = TRUE, outer_width = NULL, left = list(),
      outline_line_color = "#e5e5e5", min_border_right = NULL,
      outline_line_dash_offset = 0L, js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(), right = list(),
      width = NULL, aspect_ratio = NULL, border_fill_color = "#ffffff",
      lod_interval = 300L, margin = list(0L, 0L, 0L, 0L), title = NULL,
      x_range = NULL, max_width = NULL, disabled = FALSE,
      background_fill_color = "#ffffff", toolbar = NULL, background = NULL,
      reset_policy = "standard", inner_width = NULL, y_scale = NULL,
      border_fill_alpha = 1, visible = TRUE, outline_line_alpha = 1,
      outline_line_join = "bevel", center = list(),
      output_backend = "canvas", extra_x_ranges = structure(list(), .Names
      = character(0)), plot_height = 600L, y_range = NULL,
      outline_line_dash = list(), sizing_mode = NULL, name = NULL,
      x_scale = NULL, lod_timeout = 500L, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      min_border_bottom = NULL, background_fill_alpha = 1,
      renderers = list(), min_height = NULL, min_border = 5L,
      lod_threshold = 2000L, title_location = "above",
      toolbar_location = "right", id = NULL
    ) {
      super$initialize(inner_height = inner_height,
        min_border_top = min_border_top, lod_factor = lod_factor,
        aspect_scale = aspect_scale, min_width = min_width, align = align,
        extra_y_ranges = extra_y_ranges, frame_height = frame_height,
        tags = tags, match_aspect = match_aspect,
        outer_height = outer_height, min_border_left = min_border_left,
        toolbar_sticky = toolbar_sticky, width_policy = width_policy,
        height_policy = height_policy, below = below, height = height,
        frame_width = frame_width, outline_line_cap = outline_line_cap,
        outline_line_width = outline_line_width, max_height = max_height,
        plot_width = plot_width, above = above, hidpi = hidpi,
        outer_width = outer_width, left = left,
        outline_line_color = outline_line_color,
        min_border_right = min_border_right,
        outline_line_dash_offset = outline_line_dash_offset,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, right = right, width = width,
        aspect_ratio = aspect_ratio, border_fill_color = border_fill_color,
        lod_interval = lod_interval, margin = margin, title = title,
        x_range = x_range, max_width = max_width, disabled = disabled,
        background_fill_color = background_fill_color, toolbar = toolbar,
        background = background, reset_policy = reset_policy,
        inner_width = inner_width, y_scale = y_scale,
        border_fill_alpha = border_fill_alpha, visible = visible,
        outline_line_alpha = outline_line_alpha,
        outline_line_join = outline_line_join, center = center,
        output_backend = output_backend, extra_x_ranges = extra_x_ranges,
        plot_height = plot_height, y_range = y_range,
        outline_line_dash = outline_line_dash, sizing_mode = sizing_mode,
        name = name, x_scale = x_scale, lod_timeout = lod_timeout,
        css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        min_border_bottom = min_border_bottom,
        background_fill_alpha = background_fill_alpha,
        renderers = renderers, min_height = min_height,
        min_border = min_border, lod_threshold = lod_threshold,
        title_location = title_location,
        toolbar_location = toolbar_location, id = id)
      types <- bk_prop_types[["MapPlot"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
AbstractSlider <- R6::R6Class("AbstractSlider",
  inherit = Widget,
  public = list(
    specified_args = NULL,
    initialize = function(
      title = "", min_width = NULL, max_width = NULL, align = "start",
      disabled = FALSE, bar_color = "#e6e6e6", callback = NULL,
      background = NULL, tags = list(), visible = TRUE, width_policy = "auto",
      height_policy = "auto", height = NULL, name = NULL, sizing_mode = NULL,
      callback_policy = "throttle", default_size = 300L,
      callback_throttle = 200L, max_height = NULL, show_value = TRUE,
      css_classes = list(), format = NULL,
      js_property_callbacks = structure(list(), .Names = character(0)),
      orientation = "horizontal", direction = "ltr", min_height = NULL,
      subscribed_events = list(), js_event_callbacks = structure(list(),
      .Names = character(0)), width = NULL, aspect_ratio = NULL,
      tooltips = TRUE, margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, background = background,
        tags = tags, visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, name = name,
        sizing_mode = sizing_mode, default_size = default_size,
        max_height = max_height, css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["AbstractSlider"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Slider's label.
    # > String
    title = NULL,
    # 
    # > Color
    bar_color = NULL,
    # A callback to run in the browser whenever the current Slider value
    # changes.
    # 
    # DEPRECATED: use .js_on_change or .on_change with "value" or
    # "value_throttled"
    # > Instance(Callback)
    callback = NULL,
    # When the value_throttled property is updated.
    # 
    # This parameter can take on only one of three options:
    # 
    # * "continuous": the callback will be executed immediately for each
    # movement of the slider * "throttle": the callback will be executed at
    # most every ``callback_throttle`` milliseconds.  * "mouseup": the
    # callback will be executed only once when the slider is released.
    # 
    # The "mouseup" policy is intended for scenarios in which the callback is
    # expensive in time.
    # 
    # Both Python and JS callbacks on "value_throttled" will respect this
    # policy setting.
    # > Enum('continuous', 'throttle', 'mouseup')
    callback_policy = NULL,
    # Number of milliseconds to pause between callback calls as the slider is
    # moved.
    # > Float
    callback_throttle = NULL,
    # Whether or not show slider's value.
    # > Bool
    show_value = NULL,
    # 
    # > String
    format = NULL,
    # 
    # > Enum('ltr', 'rtl')
    direction = NULL,
    # 
    # > Bool
    tooltips = NULL
  )
)

# *toolbar icon*: |poly_edit_icon|
# 
# The PolyEditTool allows editing the vertices of one or more ``Patches``
# or ``MultiLine`` glyphs. Glyphs to be edited are defined via the
# ``renderers`` property and a renderer for the vertices is set via the
# ``vertex_renderer`` property (must render a point-like Glyph (a
# subclass of ``XYGlyph``).
# 
# The tool will modify the columns on the data source corresponding to
# the ``xs`` and ``ys`` values of the glyph. Any additional columns in
# the data source will be padded with the declared``empty_value``, when
# adding a new point.
# 
# The supported actions include:
# 
# * Show vertices: Double tap an existing patch or multi-line
# 
# * Add vertex: Double tap an existing vertex to select it, the tool will
# draw the next point, to add it tap in a new location. To finish editing
# and add a point double tap otherwise press the <<esc> key to cancel.
# 
# * Move vertex: Drag an existing vertex and let go of the mouse button
# to release it.
# 
# * Delete vertex: After selecting one or more vertices press
# <<backspace>> while the mouse cursor is within the plot area.
# 
# .. |poly_edit_icon| image:: /_images/icons/PolyEdit.png :height: 18pt
PolyEditTool <- R6::R6Class("PolyEditTool",
  inherit = EditTool,
  public = list(
    specified_args = NULL,
    initialize = function(
      custom_icon = NULL, js_property_callbacks = structure(list(), .Names
      = character(0)), tags = list(), renderers = list(), empty_value = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), vertex_renderer = NULL, name = NULL,
      custom_tooltip = NULL, id = NULL
    ) {
      super$initialize(custom_icon = custom_icon,
        js_property_callbacks = js_property_callbacks, tags = tags,
        renderers = renderers, empty_value = empty_value,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name,
        custom_tooltip = custom_tooltip, id = id)
      types <- bk_prop_types[["PolyEditTool"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The renderer used to render the vertices of a selected line or polygon.
    # > Instance(GlyphRenderer)
    vertex_renderer = NULL
  )
)

# Render segments.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/Segment.py
# :source-position: below
Segment <- R6::R6Class("Segment",
  inherit = Glyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      y0 = NULL, line_join = "bevel",
      js_property_callbacks = structure(list(), .Names = character(0)),
      x0 = NULL, name = NULL, tags = list(), x1 = NULL, line_dash_offset = 0L,
      line_alpha = 1, js_event_callbacks = structure(list(), .Names =
      character(0)), line_dash = list(), subscribed_events = list(),
      y1 = NULL, line_color = "black", line_cap = "butt", line_width = 1L,
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Segment"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The y-coordinates of the starting points.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y0 = NULL,
    # The line join values for the segments.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # The x-coordinates of the starting points.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x0 = NULL,
    # The x-coordinates of the ending points.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x1 = NULL,
    # The line dash offset values for the segments.
    # > Int
    line_dash_offset = NULL,
    # The line alpha values for the segments.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL,
    # The line dash values for the segments.
    # > DashPattern
    line_dash = NULL,
    # The y-coordinates of the ending points.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y1 = NULL,
    # The line color values for the segments.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The line cap values for the segments.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line width values for the segments.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL
  )
)

# Abstract base class for data table's cell formatters.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
CellFormatter <- R6::R6Class("CellFormatter",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["CellFormatter"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# An expression for generating arrays by summing different columns from a
# ``ColumnDataSource``.
# 
# This expression is useful for implementing stacked bar charts at a low
# level.
Stack <- R6::R6Class("Stack",
  inherit = Expression,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), fields = list(), subscribed_events = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Stack"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A sequence of fields from a ``ColumnDataSource`` to sum (elementwise).
    # For example:
    # 
    # .. code-block:: python
    # 
    # Stack(fields=['sales', 'marketing'])
    # 
    # Will compute an array of values (in the browser) by adding the elements
    # of the ``'sales'`` and ``'marketing'`` columns of a data source.
    # > Seq(String)
    fields = NULL
  )
)

# Render a shaded polygonal region as an annotation.
PolyAnnotation <- R6::R6Class("PolyAnnotation",
  inherit = Annotation,
  public = list(
    specified_args = NULL,
    initialize = function(
      level = "annotation", ys = list(), xs = list(), xs_units = "data",
      tags = list(), visible = TRUE, fill_alpha = 0.4, ys_units = "data",
      line_dash = list(), line_color = "#cccccc", name = NULL,
      fill_color = "#fff9ba", line_alpha = 0.3,
      js_property_callbacks = structure(list(), .Names = character(0)),
      x_range_name = "default", y_range_name = "default",
      line_dash_offset = 0L, js_event_callbacks = structure(list(), .Names
      = character(0)), line_join = "bevel", subscribed_events = list(),
      line_cap = "butt", line_width = 1L, id = NULL
    ) {
      super$initialize(level = level, tags = tags, visible = visible,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["PolyAnnotation"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The y-coordinates of the region to draw.
    # > Seq(Float)
    ys = NULL,
    # The x-coordinates of the region to draw.
    # > Seq(Float)
    xs = NULL,
    # The unit type for the ``xs`` attribute. Interpreted as "data space"
    # units by default.
    # > Enum('screen', 'data')
    xs_units = NULL,
    # The fill alpha values for the polygon.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    fill_alpha = NULL,
    # The unit type for the ``ys`` attribute. Interpreted as "data space"
    # units by default.
    # > Enum('screen', 'data')
    ys_units = NULL,
    # The line dash values for the polygon.
    # > DashPattern
    line_dash = NULL,
    # The line color values for the polygon.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The fill color values for the polygon.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    fill_color = NULL,
    # The line alpha values for the polygon.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL,
    # A particular (named) x-range to use for computing screen locations when
    # rendering box annotations on the plot. If unset, use the default
    # x-range.
    # > String
    x_range_name = NULL,
    # A particular (named) y-range to use for computing screen locations when
    # rendering box annotations on the plot. If unset, use the default
    # y-range.
    # > String
    y_range_name = NULL,
    # The line dash offset values for the polygon.
    # > Int
    line_dash_offset = NULL,
    # The line join values for the polygon.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # The line cap values for the polygon.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line width values for the polygon.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL
  )
)

# An axis that picks nice numbers for tick locations on a log scale.
# Configured with a ``LogTickFormatter`` by default.
LogAxis <- R6::R6Class("LogAxis",
  inherit = ContinuousAxis,
  public = list(
    specified_args = NULL,
    initialize = function(
      major_label_text_font_size = list(value = "8pt"),
      major_label_text_font_style = "normal",
      axis_label_text_color = "#444444", fixed_location = NULL,
      major_label_text_align = "center", major_tick_line_color = "black",
      axis_label_text_line_height = 1.2, major_label_standoff = 5L,
      major_label_overrides = structure(list(), .Names = character(0)),
      tags = list(), minor_tick_in = 0L, formatter = NULL,
      axis_label_text_font_style = "italic",
      major_label_orientation = "horizontal",
      minor_tick_line_join = "bevel", major_tick_line_alpha = 1,
      axis_line_width = 1L, axis_label_text_font_size = list(value =
      "10pt"), major_tick_line_dash_offset = 0L,
      axis_label_text_baseline = "bottom", major_tick_line_width = 1L,
      major_label_text_font = "helvetica",
      axis_label_text_font = "helvetica", ticker = NULL,
      major_tick_line_cap = "butt", axis_label_text_alpha = 1,
      js_event_callbacks = structure(list(), .Names = character(0)),
      minor_tick_line_cap = "butt", subscribed_events = list(),
      major_tick_line_join = "bevel", axis_label_standoff = 5L,
      axis_line_alpha = 1, axis_line_cap = "butt", level = "overlay",
      major_tick_line_dash = list(), axis_label = "",
      major_label_text_color = "#444444",
      major_label_text_baseline = "alphabetic", major_tick_out = 6L,
      axis_line_color = "black", axis_line_join = "bevel",
      major_tick_in = 2L, visible = TRUE, minor_tick_out = 4L, name = NULL,
      minor_tick_line_dash = list(), major_label_text_line_height = 1.2,
      minor_tick_line_alpha = 1, bounds = "auto", axis_line_dash = list(),
      x_range_name = "default", minor_tick_line_color = "black",
      js_property_callbacks = structure(list(), .Names = character(0)),
      axis_label_text_align = "left", y_range_name = "default",
      major_label_text_alpha = 1, minor_tick_line_dash_offset = 0L,
      axis_line_dash_offset = 0L, minor_tick_line_width = 1L, id = NULL
    ) {
      super$initialize(major_label_text_font_size = major_label_text_font_size,
        major_label_text_font_style = major_label_text_font_style,
        axis_label_text_color = axis_label_text_color,
        fixed_location = fixed_location,
        major_label_text_align = major_label_text_align,
        major_tick_line_color = major_tick_line_color,
        axis_label_text_line_height = axis_label_text_line_height,
        major_label_standoff = major_label_standoff,
        major_label_overrides = major_label_overrides, tags = tags,
        minor_tick_in = minor_tick_in, formatter = formatter,
        axis_label_text_font_style = axis_label_text_font_style,
        major_label_orientation = major_label_orientation,
        minor_tick_line_join = minor_tick_line_join,
        major_tick_line_alpha = major_tick_line_alpha,
        axis_line_width = axis_line_width,
        axis_label_text_font_size = axis_label_text_font_size,
        major_tick_line_dash_offset = major_tick_line_dash_offset,
        axis_label_text_baseline = axis_label_text_baseline,
        major_tick_line_width = major_tick_line_width,
        major_label_text_font = major_label_text_font,
        axis_label_text_font = axis_label_text_font, ticker = ticker,
        major_tick_line_cap = major_tick_line_cap,
        axis_label_text_alpha = axis_label_text_alpha,
        js_event_callbacks = js_event_callbacks,
        minor_tick_line_cap = minor_tick_line_cap,
        subscribed_events = subscribed_events,
        major_tick_line_join = major_tick_line_join,
        axis_label_standoff = axis_label_standoff,
        axis_line_alpha = axis_line_alpha, axis_line_cap = axis_line_cap,
        level = level, major_tick_line_dash = major_tick_line_dash,
        axis_label = axis_label,
        major_label_text_color = major_label_text_color,
        major_label_text_baseline = major_label_text_baseline,
        major_tick_out = major_tick_out, axis_line_color = axis_line_color,
        axis_line_join = axis_line_join, major_tick_in = major_tick_in,
        visible = visible, minor_tick_out = minor_tick_out, name = name,
        minor_tick_line_dash = minor_tick_line_dash,
        major_label_text_line_height = major_label_text_line_height,
        minor_tick_line_alpha = minor_tick_line_alpha, bounds = bounds,
        axis_line_dash = axis_line_dash, x_range_name = x_range_name,
        minor_tick_line_color = minor_tick_line_color,
        js_property_callbacks = js_property_callbacks,
        axis_label_text_align = axis_label_text_align,
        y_range_name = y_range_name,
        major_label_text_alpha = major_label_text_alpha,
        minor_tick_line_dash_offset = minor_tick_line_dash_offset,
        axis_line_dash_offset = axis_line_dash_offset,
        minor_tick_line_width = minor_tick_line_width, id = id)
      types <- bk_prop_types[["LogAxis"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# A Filter model represents a filtering operation that returns a row-wise
# subset of data when applied to a ``ColumnDataSource``.
Filter <- R6::R6Class("Filter",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      filter = NULL, tags = list(), js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Filter"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A list that can be either integer indices or booleans representing a
    # row-wise subset of data.
    # > Either(Seq(Int), Seq(Bool))
    filter = NULL
  )
)

# Render a color bar based on a color mapper.
ColorBar <- R6::R6Class("ColorBar",
  inherit = Annotation,
  public = list(
    specified_args = NULL,
    initialize = function(
      major_label_text_font_style = "normal",
      major_label_text_align = "center", location = "top_right",
      border_line_dash_offset = 0L, bar_line_alpha = 1, tags = list(),
      formatter = NULL, title_standoff = 2L, major_tick_line_alpha = 1,
      major_tick_line_dash_offset = 0L,
      major_label_text_font = "helvetica",
      title_text_font_style = "italic", ticker = NULL,
      border_line_join = "bevel", border_line_cap = "butt",
      subscribed_events = list(), major_tick_line_join = "bevel",
      padding = 10L, color_mapper = NULL, major_tick_line_dash = list(),
      background_fill_color = "#ffffff",
      major_label_text_color = "#444444",
      major_label_text_baseline = "middle", major_tick_out = 0L,
      major_tick_in = 5L, minor_tick_out = 0L,
      major_label_text_line_height = 1.2, title_text_font_size = list(value
      = "10pt"), minor_tick_line_color = NULL, title_text_alpha = 1,
      background_fill_alpha = 0.95, scale_alpha = 1,
      minor_tick_line_dash_offset = 0L, major_label_text_alpha = 1,
      minor_tick_line_width = 1L, border_line_alpha = 1,
      title_text_font = "helvetica", bar_line_color = NULL,
      major_label_text_font_size = list(value = "8pt"),
      major_tick_line_color = "#ffffff",
      major_label_overrides = structure(list(), .Names = character(0)),
      minor_tick_in = 0L, height = "auto", minor_tick_line_join = "bevel",
      border_line_dash = list(), bar_line_dash = list(),
      major_tick_line_width = 1L, border_line_width = 1L,
      major_tick_line_cap = "butt", js_event_callbacks = structure(list(),
      .Names = character(0)), bar_line_join = "bevel",
      minor_tick_line_cap = "butt", width = "auto", margin = 30L,
      level = "annotation", title = NULL, title_text_line_height = 1.2,
      visible = TRUE, bar_line_dash_offset = 0L, name = NULL,
      minor_tick_line_dash = list(), title_text_baseline = "bottom",
      minor_tick_line_alpha = 1, js_property_callbacks = structure(list(),
      .Names = character(0)), orientation = "vertical",
      title_text_align = "left", title_text_color = "#444444",
      label_standoff = 5L, border_line_color = NULL, bar_line_width = 1L,
      bar_line_cap = "butt", id = NULL
    ) {
      super$initialize(level = level, tags = tags, visible = visible,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["ColorBar"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The text font style of the major tick labels.
    # > Enum('normal', 'italic', 'bold', 'bold italic')
    major_label_text_font_style = NULL,
    # The text align of the major tick labels.
    # > Enum('left', 'right', 'center')
    major_label_text_align = NULL,
    # The location where the color bar should draw itself. It's either one of
    # ``bokeh.core.enums.LegendLocation``'s enumerated values, or a ``(x,
    # y)`` tuple indicating an absolute location absolute location in screen
    # coordinates (pixels from the bottom-left corner).
    # 
    # .. warning:: If the color bar is placed in a side panel, the location
    # will likely have to be set to `(0,0)`.
    # > Either(Enum('top_left', 'top_center', 'top_right', 'center_left', 'center', 'center_right', 'bottom_left', 'bottom_center', 'bottom_right'), Tuple(Float, Float))
    location = NULL,
    # The line dash offset for the color bar border outline.
    # > Int
    border_line_dash_offset = NULL,
    # The line alpha for the color scale bar outline.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    bar_line_alpha = NULL,
    # A ``TickFormatter`` to use for formatting the visual appearance of
    # ticks.
    # > Instance(TickFormatter)
    formatter = NULL,
    # The distance (in pixels) to separate the title from the color bar.
    # > Int
    title_standoff = NULL,
    # The line alpha of the major ticks.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    major_tick_line_alpha = NULL,
    # The line dash offset of the major ticks.
    # > Int
    major_tick_line_dash_offset = NULL,
    # The text font of the major tick labels.
    # > String
    major_label_text_font = NULL,
    # The text font style values for the title text.
    # > Enum('normal', 'italic', 'bold', 'bold italic')
    title_text_font_style = NULL,
    # A Ticker to use for computing locations of axis components.
    # > Instance(ContinuousTicker)
    ticker = NULL,
    # The line join for the color bar border outline.
    # > Enum('miter', 'round', 'bevel')
    border_line_join = NULL,
    # The line cap for the color bar border outline.
    # > Enum('butt', 'round', 'square')
    border_line_cap = NULL,
    # The line join of the major ticks.
    # > Enum('miter', 'round', 'bevel')
    major_tick_line_join = NULL,
    # Amount of padding (in pixels) between the color scale and color bar
    # border.
    # > Int
    padding = NULL,
    # A continuous color mapper containing a color palette to render.
    # 
    # .. warning:: If the `low` and `high` attributes of the ``ColorMapper``
    # aren't set, ticks and tick labels won't be rendered. Additionally, if a
    # ``LogTicker`` is passed to the `ticker` argument and either or both of
    # the logarithms of `low` and `high` values of the color_mapper are
    # non-numeric (i.e. `low=0`), the tick and tick labels won't be rendered.
    # > Instance(ContinuousColorMapper)
    color_mapper = NULL,
    # The line dash of the major ticks.
    # > DashPattern
    major_tick_line_dash = NULL,
    # The fill color for the color bar background style.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    background_fill_color = NULL,
    # The text color of the major tick labels.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    major_label_text_color = NULL,
    # The text baseline of the major tick labels.
    # > Enum('top', 'middle', 'bottom', 'alphabetic', 'hanging', 'ideographic')
    major_label_text_baseline = NULL,
    # The distance (in pixels) that major ticks should extend out of the main
    # plot area.
    # > Int
    major_tick_out = NULL,
    # The distance (in pixels) that major ticks should extend into the main
    # plot area.
    # > Int
    major_tick_in = NULL,
    # The distance (in pixels) that major ticks should extend out of the main
    # plot area.
    # > Int
    minor_tick_out = NULL,
    # The text line height of the major tick labels.
    # > Float
    major_label_text_line_height = NULL,
    # The text font size values for the title text.
    # > FontSizeSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), FontSize)), FontSize)
    title_text_font_size = NULL,
    # The line color of the minor ticks.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    minor_tick_line_color = NULL,
    # The text alpha values for the title text.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    title_text_alpha = NULL,
    # The fill alpha for the color bar background style.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    background_fill_alpha = NULL,
    # The alpha with which to render the color scale.
    # > Float
    scale_alpha = NULL,
    # The line dash offset of the minor ticks.
    # > Int
    minor_tick_line_dash_offset = NULL,
    # The text alpha of the major tick labels.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    major_label_text_alpha = NULL,
    # The line width of the minor ticks.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    minor_tick_line_width = NULL,
    # The line alpha for the color bar border outline.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    border_line_alpha = NULL,
    # The text font values for the title text.
    # > String
    title_text_font = NULL,
    # The line color for the color scale bar outline.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    bar_line_color = NULL,
    # The text font size of the major tick labels.
    # > FontSizeSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), FontSize)), FontSize)
    major_label_text_font_size = NULL,
    # The line color of the major ticks.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    major_tick_line_color = NULL,
    # Provide explicit tick label values for specific tick locations that
    # override normal formatting.
    # > Dict(Either(Float, String), String)
    major_label_overrides = NULL,
    # The distance (in pixels) that minor ticks should extend into the main
    # plot area.
    # > Int
    minor_tick_in = NULL,
    # The height (in pixels) that the color scale should occupy.
    # > Either(Auto, Int)
    height = NULL,
    # The line join of the minor ticks.
    # > Enum('miter', 'round', 'bevel')
    minor_tick_line_join = NULL,
    # The line dash for the color bar border outline.
    # > DashPattern
    border_line_dash = NULL,
    # The line dash for the color scale bar outline.
    # > DashPattern
    bar_line_dash = NULL,
    # The line width of the major ticks.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    major_tick_line_width = NULL,
    # The line width for the color bar border outline.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    border_line_width = NULL,
    # The line cap of the major ticks.
    # > Enum('butt', 'round', 'square')
    major_tick_line_cap = NULL,
    # The line join for the color scale bar outline.
    # > Enum('miter', 'round', 'bevel')
    bar_line_join = NULL,
    # The line cap of the minor ticks.
    # > Enum('butt', 'round', 'square')
    minor_tick_line_cap = NULL,
    # The width (in pixels) that the color scale should occupy.
    # > Either(Auto, Int)
    width = NULL,
    # Amount of margin (in pixels) around the outside of the color bar.
    # > Int
    margin = NULL,
    # The title text to render.
    # > String
    title = NULL,
    # The text line height values for the title text.
    # > Float
    title_text_line_height = NULL,
    # The line dash offset for the color scale bar outline.
    # > Int
    bar_line_dash_offset = NULL,
    # The line dash of the minor ticks.
    # > DashPattern
    minor_tick_line_dash = NULL,
    # The text baseline values for the title text.
    # > Enum('top', 'middle', 'bottom', 'alphabetic', 'hanging', 'ideographic')
    title_text_baseline = NULL,
    # The line alpha of the minor ticks.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    minor_tick_line_alpha = NULL,
    # Whether the color bar should be oriented vertically or horizontally.
    # > Enum('horizontal', 'vertical')
    orientation = NULL,
    # The text align values for the title text.
    # > Enum('left', 'right', 'center')
    title_text_align = NULL,
    # The text color values for the title text.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    title_text_color = NULL,
    # The distance (in pixels) to separate the tick labels from the color
    # bar.
    # > Int
    label_standoff = NULL,
    # The line color for the color bar border outline.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    border_line_color = NULL,
    # The line width for the color scale bar outline.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    bar_line_width = NULL,
    # The line cap for the color scale bar outline.
    # > Enum('butt', 'round', 'square')
    bar_line_cap = NULL
  )
)

# Base class for mappers that map categorical factors to other values.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
CategoricalMapper <- R6::R6Class("CategoricalMapper",
  inherit = Mapper,
  public = list(
    specified_args = NULL,
    initialize = function(
      factors = NULL, end = NULL, start = 0L,
      js_property_callbacks = structure(list(), .Names = character(0)),
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["CategoricalMapper"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A sequence of factors / categories that map to the some target range.
    # For example the following color mapper:
    # 
    # .. code-block:: python
    # 
    # mapper = CategoricalColorMapper(palette=["red", "blue"],
    # factors=["foo", "bar"])
    # 
    # will map the factor ``"foo"`` to red and the factor ``"bar"`` to blue.
    # > Either(Seq(String), Seq(Tuple(String, String)), Seq(Tuple(String, String, String)))
    factors = NULL,
    # A start index to "slice" data factors with before mapping.
    # 
    # For example, if the data to color map consists of 2-level factors such
    # as ``["2016", "sales"]`` and ``["2017", "marketing"]``, then setting
    # ``end=1`` will perform color mapping only based on the first sub-factor
    # (i.e. in this case based on the year ``"2016"`` or ``"2017"``)
    # 
    # If ``None`` then all sub-factors from ``start`` to the end of the
    # factor will be used for color mapping.
    # > Int
    end = NULL,
    # A start index to "slice" data factors with before mapping.
    # 
    # For example, if the data to color map consists of 2-level factors such
    # as ``["2016", "sales"]`` and ``["2016", "marketing"]``, then setting
    # ``start=1`` will perform color mapping only based on the second
    # sub-factor (i.e. in this case based on the department ``"sales"`` or
    # ``"marketing"``)
    # > Int
    start = NULL
  )
)

# Render an arrow as an annotation.
Arrow <- R6::R6Class("Arrow",
  inherit = Annotation,
  public = list(
    specified_args = NULL,
    initialize = function(
      level = "annotation", start_units = "data", end = NULL, start = NULL,
      x_start = NULL, tags = list(), x_end = NULL, y_start = NULL,
      visible = TRUE, line_color = "black", end_units = "data",
      line_dash = list(), source = NULL, line_alpha = 1, name = NULL,
      line_join = "bevel", x_range_name = "default",
      js_property_callbacks = structure(list(), .Names = character(0)),
      y_range_name = "default", line_dash_offset = 0L,
      js_event_callbacks = structure(list(), .Names = character(0)),
      y_end = NULL, subscribed_events = list(), line_cap = "butt",
      line_width = 1L, id = NULL
    ) {
      super$initialize(level = level, tags = tags, visible = visible,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["Arrow"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The unit type for the start_x and start_y attributes. Interpreted as
    # "data space" units by default.
    # > Enum('screen', 'data')
    start_units = NULL,
    # Instance of ``ArrowHead``.
    # > Instance(ArrowHead)
    end = NULL,
    # Instance of ``ArrowHead``.
    # > Instance(ArrowHead)
    start = NULL,
    # The x-coordinates to locate the start of the arrows.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x_start = NULL,
    # The x-coordinates to locate the end of the arrows.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x_end = NULL,
    # The y-coordinates to locate the start of the arrows.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y_start = NULL,
    # The line color values for the arrow body.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The unit type for the end_x and end_y attributes. Interpreted as "data
    # space" units by default.
    # > Enum('screen', 'data')
    end_units = NULL,
    # The line dash values for the arrow body.
    # > DashPattern
    line_dash = NULL,
    # Local data source to use when rendering annotations on the plot.
    # > Instance(DataSource)
    source = NULL,
    # The line alpha values for the arrow body.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL,
    # The line join values for the arrow body.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # A particular (named) x-range to use for computing screen locations when
    # rendering annotations on the plot. If unset, use the default x-range.
    # > String
    x_range_name = NULL,
    # A particular (named) y-range to use for computing screen locations when
    # rendering annotations on the plot. If unset, use the default y-range.
    # > String
    y_range_name = NULL,
    # The line dash offset values for the arrow body.
    # > Int
    line_dash_offset = NULL,
    # The y-coordinates to locate the end of the arrows.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y_end = NULL,
    # The line cap values for the arrow body.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line width values for the arrow body.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL
  )
)

# Render a closed-body arrow head.
NormalHead <- R6::R6Class("NormalHead",
  inherit = ArrowHead,
  public = list(
    specified_args = NULL,
    initialize = function(
      level = "annotation", size = 25L, line_join = "bevel",
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, fill_color = "black", line_dash = list(), tags = list(),
      line_dash_offset = 0L, line_alpha = 1, visible = TRUE, fill_alpha = 1,
      subscribed_events = list(), js_event_callbacks = structure(list(),
      .Names = character(0)), line_color = "black", line_cap = "butt",
      line_width = 1L, id = NULL
    ) {
      super$initialize(level = level, tags = tags, visible = visible,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["NormalHead"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The size, in pixels, of the arrow head.
    # > Float
    size = NULL,
    # The line join values for the arrow head outline.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # The fill color values for the arrow head interior.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    fill_color = NULL,
    # The line dash values for the arrow head outline.
    # > DashPattern
    line_dash = NULL,
    # The line dash offset values for the arrow head outline.
    # > Int
    line_dash_offset = NULL,
    # The line alpha values for the arrow head outline.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL,
    # The fill alpha values for the arrow head interior.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    fill_alpha = NULL,
    # The line color values for the arrow head outline.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The line cap values for the arrow head outline.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line width values for the arrow head outline.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL
  )
)

# Simple average across multiple rows.
AvgAggregator <- R6::R6Class("AvgAggregator",
  inherit = RowAggregator,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), field_ = "", js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, id = NULL
    ) {
      super$initialize(tags = tags, field_ = field_,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["AvgAggregator"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# 
LegendItem <- R6::R6Class("LegendItem",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      label = NULL, js_property_callbacks = structure(list(), .Names =
      character(0)), index = NULL, tags = list(), renderers = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["LegendItem"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A label for this legend. Can be a string, or a column of a
    # ColumnDataSource. If ``label`` is a field, then it must be in the
    # renderers' data_source.
    # > StringSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), List(String))), List(String))
    label = NULL,
    # The column data index to use for drawing the representative items.
    # 
    # If None (the default), then Bokeh will automatically choose an index to
    # use. If the label does not refer to a data column name, this is
    # typically the first data point in the data source. Otherwise, if the
    # label does refer to a column name, the legend will have "groupby"
    # behavior, and will choose and display representative points from every
    # "group" in the column.
    # 
    # If set to a number, Bokeh will use that number as the index in all
    # cases.
    # > Int
    index = NULL,
    # A list of the glyph renderers to draw in the legend. If ``label`` is a
    # field, then all data_sources of renderers must be the same.
    # > List(Instance(GlyphRenderer))
    renderers = NULL
  )
)

# Single-line input widget.
TextInput <- R6::R6Class("TextInput",
  inherit = InputWidget,
  public = list(
    specified_args = NULL,
    initialize = function(
      title = "", min_width = NULL, max_width = NULL, align = "start",
      disabled = FALSE, value = "", callback = NULL, background = NULL,
      tags = list(), value_input = "", visible = TRUE, width_policy = "auto",
      height_policy = "auto", height = NULL, name = NULL, sizing_mode = NULL,
      default_size = 300L, max_height = NULL, placeholder = "",
      css_classes = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), orientation = "horizontal",
      js_event_callbacks = structure(list(), .Names = character(0)),
      min_height = NULL, subscribed_events = list(), width = NULL,
      aspect_ratio = NULL, margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(title = title, min_width = min_width,
        max_width = max_width, align = align, disabled = disabled,
        background = background, tags = tags, visible = visible,
        width_policy = width_policy, height_policy = height_policy,
        height = height, name = name, sizing_mode = sizing_mode,
        default_size = default_size, max_height = max_height,
        css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["TextInput"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Initial or entered text value.
    # > String
    value = NULL,
    # A callback to run in the browser whenever the user unfocuses the
    # ``TextInput`` widget by hitting Enter or clicking outside of the text
    # box area.
    # 
    # DEPRECATED: use .js_on_change or .on_change with "value" or
    # "value_input"
    # > Instance(Callback)
    callback = NULL,
    # Initial or entered text value that triggers a callback whenever the
    # value changes.
    # > String
    value_input = NULL,
    # Placeholder for empty input field.
    # > String
    placeholder = NULL
  )
)

# Render ovals.
# 
# This glyph renders ovals using Bezier curves, which are similar, but
# not identical to ellipses. In particular, widths equal to heights will
# not render circles. Use the ``Ellipse`` glyph for that.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/Oval.py
# :source-position: below
Oval <- R6::R6Class("Oval",
  inherit = XYGlyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      angle_units = "rad", x = NULL, tags = list(), height_units = "data",
      fill_alpha = 1, height = NULL, subscribed_events = list(),
      line_dash = list(), line_color = "black", name = NULL,
      fill_color = "gray", line_alpha = 1, y = NULL,
      js_property_callbacks = structure(list(), .Names = character(0)),
      line_dash_offset = 0L, angle = 0,
      js_event_callbacks = structure(list(), .Names = character(0)),
      line_join = "bevel", width_units = "data", width = NULL,
      line_cap = "butt", line_width = 1L, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Oval"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # 
    # > Enum('deg', 'rad')
    angle_units = NULL,
    # The x-coordinates of the centers of the ovals.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x = NULL,
    # 
    # > Enum('screen', 'data')
    height_units = NULL,
    # The fill alpha values for the ovals.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    fill_alpha = NULL,
    # The overall height of each oval.
    # > DistanceSpec(units_default='data')
    height = NULL,
    # The line dash values for the ovals.
    # > DashPattern
    line_dash = NULL,
    # The line color values for the ovals.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The fill color values for the ovals.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    fill_color = NULL,
    # The line alpha values for the ovals.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL,
    # The y-coordinates of the centers of the ovals.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y = NULL,
    # The line dash offset values for the ovals.
    # > Int
    line_dash_offset = NULL,
    # The angle the ovals are rotated from horizontal. [rad]
    # > AngleSpec(units_default='rad')
    angle = NULL,
    # The line join values for the ovals.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # 
    # > Enum('screen', 'data')
    width_units = NULL,
    # The overall widths of each oval.
    # > DistanceSpec(units_default='data')
    width = NULL,
    # The line cap values for the ovals.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line width values for the ovals.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL
  )
)

# A click button.
Button <- R6::R6Class("Button",
  inherit = AbstractButton,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", clicks = 0L,
      disabled = FALSE, callback = NULL, background = NULL,
      button_type = "default", icon = NULL, tags = list(), visible = TRUE,
      width_policy = "auto", height_policy = "auto", height = NULL,
      name = NULL, sizing_mode = NULL, default_size = 300L, max_height = NULL,
      label = "Button", css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      orientation = "horizontal", js_event_callbacks = structure(list(),
      .Names = character(0)), min_height = NULL,
      subscribed_events = list(), width = NULL, aspect_ratio = NULL,
      margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, callback = callback,
        background = background, button_type = button_type, icon = icon,
        tags = tags, visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, name = name,
        sizing_mode = sizing_mode, default_size = default_size,
        max_height = max_height, label = label, css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["Button"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A private property that used to trigger ``on_click`` event handler.
    # 
    # .. note: This property is deprecated and left for backwards
    # compatibility. Use ``button.on_click()`` or ``button.js_on_click()``
    # methods in new code.
    # > Int
    clicks = NULL
  )
)

# A base class for all interactive draw tool types.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
EditTool <- R6::R6Class("EditTool",
  inherit = Gesture,
  public = list(
    specified_args = NULL,
    initialize = function(
      custom_icon = NULL, js_property_callbacks = structure(list(), .Names
      = character(0)), tags = list(), renderers = list(), empty_value = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), name = NULL, custom_tooltip = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["EditTool"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # An icon to display in the toolbar.
    # 
    # The icon can provided as a string filename for an image, a PIL
    # ``Image`` object, or an RGB(A) NumPy array.
    # > Image
    custom_icon = NULL,
    # An explicit list of renderers corresponding to scatter glyphs that may
    # be edited.
    # > List(Instance(Renderer))
    renderers = NULL,
    # Defines the value to insert on non-coordinate columns when a new glyph
    # is inserted into the ``ColumnDataSource`` columns, e.g. when a circle
    # glyph defines 'x', 'y' and 'color' columns, adding a new point will add
    # the x and y-coordinates to 'x' and 'y' columns and the color column
    # will be filled with the defined empty value.
    # > Either(Bool, Int, Float, Date, Datetime, Color)
    empty_value = NULL,
    # A custom tooltip label to override the default name.
    # > String
    custom_tooltip = NULL
  )
)

# An abstract base class for data renderer types (e.g. ``GlyphRenderer``,
# ``TileRenderer``, ``GraphRenderer``).
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
DataRenderer <- R6::R6Class("DataRenderer",
  inherit = Renderer,
  public = list(
    specified_args = NULL,
    initialize = function(
      level = "glyph", js_property_callbacks = structure(list(), .Names =
      character(0)), x_range_name = "default", y_range_name = "default",
      tags = list(), visible = TRUE, js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(), name = NULL,
      id = NULL
    ) {
      super$initialize(level = level, tags = tags, visible = visible,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["DataRenderer"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A particular (named) x-range to use for computing screen locations when
    # rendering glyphs on the plot. If unset, use the default x-range.
    # > String
    x_range_name = NULL,
    # A particular (named) y-range to use for computing screen locations when
    # rendering glyphs on the plot. If unset, use the default y-range.
    # > String
    y_range_name = NULL
  )
)

# Render hexagon markers.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/Hex.py
# :source-position: below
Hex <- R6::R6Class("Hex",
  inherit = Marker,
  public = list(
    specified_args = NULL,
    initialize = function(
      y = NULL, size = 4L, line_join = "bevel",
      js_property_callbacks = structure(list(), .Names = character(0)),
      angle_units = "rad", name = NULL, x = NULL, fill_color = "gray",
      line_dash = list(), tags = list(), angle = 0, line_dash_offset = 0L,
      js_event_callbacks = structure(list(), .Names = character(0)),
      fill_alpha = 1, subscribed_events = list(), line_color = "black",
      line_width = 1L, line_cap = "butt", line_alpha = 1, id = NULL
    ) {
      super$initialize(y = y, size = size, line_join = line_join,
        js_property_callbacks = js_property_callbacks,
        angle_units = angle_units, name = name, x = x, fill_color = fill_color,
        line_dash = line_dash, tags = tags, angle = angle,
        line_dash_offset = line_dash_offset,
        js_event_callbacks = js_event_callbacks, fill_alpha = fill_alpha,
        subscribed_events = subscribed_events, line_color = line_color,
        line_width = line_width, line_cap = line_cap,
        line_alpha = line_alpha, id = id)
      types <- bk_prop_types[["Hex"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Render asterisk '*' markers.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/Asterisk.py
# :source-position: below
Asterisk <- R6::R6Class("Asterisk",
  inherit = Marker,
  public = list(
    specified_args = NULL,
    initialize = function(
      y = NULL, size = 4L, line_join = "bevel",
      js_property_callbacks = structure(list(), .Names = character(0)),
      angle_units = "rad", name = NULL, x = NULL, fill_color = "gray",
      line_dash = list(), tags = list(), angle = 0, line_dash_offset = 0L,
      js_event_callbacks = structure(list(), .Names = character(0)),
      fill_alpha = 1, subscribed_events = list(), line_color = "black",
      line_width = 1L, line_cap = "butt", line_alpha = 1, id = NULL
    ) {
      super$initialize(y = y, size = size, line_join = line_join,
        js_property_callbacks = js_property_callbacks,
        angle_units = angle_units, name = name, x = x, fill_color = fill_color,
        line_dash = line_dash, tags = tags, angle = angle,
        line_dash_offset = line_dash_offset,
        js_event_callbacks = js_event_callbacks, fill_alpha = fill_alpha,
        subscribed_events = subscribed_events, line_color = line_color,
        line_width = line_width, line_cap = line_cap,
        line_alpha = line_alpha, id = id)
      types <- bk_prop_types[["Asterisk"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# A ``LinearAxis`` that picks nice numbers for tick locations on a
# datetime scale. Configured with a ``DatetimeTickFormatter`` by default.
DatetimeAxis <- R6::R6Class("DatetimeAxis",
  inherit = LinearAxis,
  public = list(
    specified_args = NULL,
    initialize = function(
      major_label_text_font_size = list(value = "8pt"),
      major_label_text_font_style = "normal",
      axis_label_text_color = "#444444", fixed_location = NULL,
      major_label_text_align = "center", major_tick_line_color = "black",
      axis_label_text_line_height = 1.2, major_label_standoff = 5L,
      major_label_overrides = structure(list(), .Names = character(0)),
      tags = list(), minor_tick_in = 0L, formatter = NULL,
      axis_label_text_font_style = "italic",
      major_label_orientation = "horizontal",
      minor_tick_line_join = "bevel", major_tick_line_alpha = 1,
      axis_line_width = 1L, axis_label_text_font_size = list(value =
      "10pt"), major_tick_line_dash_offset = 0L,
      axis_label_text_baseline = "bottom", major_tick_line_width = 1L,
      major_label_text_font = "helvetica",
      axis_label_text_font = "helvetica", ticker = NULL,
      major_tick_line_cap = "butt", axis_label_text_alpha = 1,
      js_event_callbacks = structure(list(), .Names = character(0)),
      minor_tick_line_cap = "butt", subscribed_events = list(),
      major_tick_line_join = "bevel", axis_label_standoff = 5L,
      axis_line_alpha = 1, axis_line_cap = "butt", level = "overlay",
      major_tick_line_dash = list(), axis_label = "",
      major_label_text_color = "#444444",
      major_label_text_baseline = "alphabetic", major_tick_out = 6L,
      axis_line_color = "black", axis_line_join = "bevel",
      major_tick_in = 2L, visible = TRUE, minor_tick_out = 4L, name = NULL,
      minor_tick_line_dash = list(), major_label_text_line_height = 1.2,
      minor_tick_line_alpha = 1, bounds = "auto", axis_line_dash = list(),
      x_range_name = "default", minor_tick_line_color = "black",
      js_property_callbacks = structure(list(), .Names = character(0)),
      axis_label_text_align = "left", y_range_name = "default",
      major_label_text_alpha = 1, minor_tick_line_dash_offset = 0L,
      axis_line_dash_offset = 0L, minor_tick_line_width = 1L, id = NULL
    ) {
      super$initialize(major_label_text_font_size = major_label_text_font_size,
        major_label_text_font_style = major_label_text_font_style,
        axis_label_text_color = axis_label_text_color,
        fixed_location = fixed_location,
        major_label_text_align = major_label_text_align,
        major_tick_line_color = major_tick_line_color,
        axis_label_text_line_height = axis_label_text_line_height,
        major_label_standoff = major_label_standoff,
        major_label_overrides = major_label_overrides, tags = tags,
        minor_tick_in = minor_tick_in, formatter = formatter,
        axis_label_text_font_style = axis_label_text_font_style,
        major_label_orientation = major_label_orientation,
        minor_tick_line_join = minor_tick_line_join,
        major_tick_line_alpha = major_tick_line_alpha,
        axis_line_width = axis_line_width,
        axis_label_text_font_size = axis_label_text_font_size,
        major_tick_line_dash_offset = major_tick_line_dash_offset,
        axis_label_text_baseline = axis_label_text_baseline,
        major_tick_line_width = major_tick_line_width,
        major_label_text_font = major_label_text_font,
        axis_label_text_font = axis_label_text_font, ticker = ticker,
        major_tick_line_cap = major_tick_line_cap,
        axis_label_text_alpha = axis_label_text_alpha,
        js_event_callbacks = js_event_callbacks,
        minor_tick_line_cap = minor_tick_line_cap,
        subscribed_events = subscribed_events,
        major_tick_line_join = major_tick_line_join,
        axis_label_standoff = axis_label_standoff,
        axis_line_alpha = axis_line_alpha, axis_line_cap = axis_line_cap,
        level = level, major_tick_line_dash = major_tick_line_dash,
        axis_label = axis_label,
        major_label_text_color = major_label_text_color,
        major_label_text_baseline = major_label_text_baseline,
        major_tick_out = major_tick_out, axis_line_color = axis_line_color,
        axis_line_join = axis_line_join, major_tick_in = major_tick_in,
        visible = visible, minor_tick_out = minor_tick_out, name = name,
        minor_tick_line_dash = minor_tick_line_dash,
        major_label_text_line_height = major_label_text_line_height,
        minor_tick_line_alpha = minor_tick_line_alpha, bounds = bounds,
        axis_line_dash = axis_line_dash, x_range_name = x_range_name,
        minor_tick_line_color = minor_tick_line_color,
        js_property_callbacks = js_property_callbacks,
        axis_label_text_align = axis_label_text_align,
        y_range_name = y_range_name,
        major_label_text_alpha = major_label_text_alpha,
        minor_tick_line_dash_offset = minor_tick_line_dash_offset,
        axis_line_dash_offset = axis_line_dash_offset,
        minor_tick_line_width = minor_tick_line_width, id = id)
      types <- bk_prop_types[["DatetimeAxis"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# *toolbar icon*: |poly_draw_icon|
# 
# The PolyDrawTool allows drawing, selecting and deleting ``Patches`` and
# ``MultiLine`` glyphs on one or more renderers by editing the underlying
# ``ColumnDataSource`` data. Like other drawing tools, the renderers that
# are to be edited must be supplied explicitly.
# 
# The tool will modify the columns on the data source corresponding to
# the ``xs`` and ``ys`` values of the glyph. Any additional columns in
# the data source will be padded with the declared ``empty_value``, when
# adding a new point.
# 
# If a ``vertex_renderer`` with an point-like glyph is supplied then the
# ``PolyDrawTool`` will use it to display the vertices of the multi-lines
# or patches on all supplied renderers. This also enables the ability to
# snap to existing vertices while drawing.
# 
# The supported actions include:
# 
# * Add patch or multi-line: Double tap to add the first vertex, then use
# tap to add each subsequent vertex, to finalize the draw action double
# tap to insert the final vertex or press the <<esc> key.
# 
# * Move patch or ulti-line: Tap and drag an existing patch/multi-line,
# the point will be dropped once you let go of the mouse button.
# 
# * Delete patch or multi-line: Tap a patch/multi-line to select it then
# press <<backspace>> key while the mouse is within the plot area.
# 
# .. |poly_draw_icon| image:: /_images/icons/PolyDraw.png :height: 18pt
PolyDrawTool <- R6::R6Class("PolyDrawTool",
  inherit = EditTool,
  public = list(
    specified_args = NULL,
    initialize = function(
      custom_icon = NULL, drag = TRUE,
      js_property_callbacks = structure(list(), .Names = character(0)),
      tags = list(), renderers = list(), empty_value = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), vertex_renderer = NULL, num_objects = 0L,
      name = NULL, custom_tooltip = NULL, id = NULL
    ) {
      super$initialize(custom_icon = custom_icon,
        js_property_callbacks = js_property_callbacks, tags = tags,
        renderers = renderers, empty_value = empty_value,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name,
        custom_tooltip = custom_tooltip, id = id)
      types <- bk_prop_types[["PolyDrawTool"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Enables dragging of existing patches and multi-lines on pan events.
    # > Bool
    drag = NULL,
    # The renderer used to render the vertices of a selected line or polygon.
    # > Instance(GlyphRenderer)
    vertex_renderer = NULL,
    # Defines a limit on the number of patches or multi-lines that can be
    # drawn.  By default there is no limit on the number of objects, but if
    # enabled the oldest drawn patch or multi-line will be dropped to make
    # space for the new patch or multi-line.
    # > Int
    num_objects = NULL
  )
)

# A Range of values for a categorical dimension.
# 
# In addition to supplying ``factors`` as a keyword argument to the
# ``FactorRange`` initializer, you may also instantiate with a sequence
# of positional arguments:
# 
# .. code-block:: python
# 
# FactorRange("foo", "bar") # equivalent to FactorRange(factors=["foo",
# "bar"])
# 
# Users will normally supply categorical values directly:
# 
# .. code-block:: python
# 
# p.circle(x=["foo", "bar"], ...)
# 
# BokehJS will create a mapping from ``"foo"`` and ``"bar"`` to a
# numerical coordinate system called *synthetic coordinates*. In the
# simplest cases, factors are separated by a distance of 1.0 in synthetic
# coordinates, however the exact mapping from factors to synthetic
# coordinates is affected by he padding properties as well as whether the
# number of levels the factors have.
# 
# Users typically do not need to worry about the details of this mapping,
# however it can be useful to fine tune positions by adding offsets. When
# supplying factors as coordinates or values, it is possible to add an
# offset in the synthetic coordinate space by adding a final number value
# to a factor tuple. For example:
# 
# .. code-block:: python
# 
# p.circle(x=[("foo", 0.3), ...], ...)
# 
# will position the first circle at an ``x`` position that is offset by
# adding 0.3 to the synthetic coordinate for ``"foo"``.
FactorRange <- R6::R6Class("FactorRange",
  inherit = Range,
  public = list(
    specified_args = NULL,
    initialize = function(
      max_interval = NULL, factors = list(), end = NULL, factor_padding = 0,
      bounds = NULL, group_padding = 1.4, start = NULL,
      range_padding_units = "percent",
      js_property_callbacks = structure(list(), .Names = character(0)),
      callback = NULL, tags = list(), range_padding = 0L,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), name = NULL, min_interval = NULL,
      subgroup_padding = 0.8, id = NULL
    ) {
      super$initialize(tags = tags,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name,
        callback = callback, id = id)
      types <- bk_prop_types[["FactorRange"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The level that the range is allowed to zoom out, expressed as the
    # maximum visible interval in synthetic coordinates.. Note that
    # ``bounds`` can impose an implicit constraint on the maximum interval as
    # well.
    # 
    # The default "width" of a category is 1.0 in synthetic coordinates.
    # However, the distance between factors is affected by the various
    # padding properties and whether or not factors are grouped.
    # > Float
    max_interval = NULL,
    # A sequence of factors to define this categorical range.
    # 
    # Factors may have 1, 2, or 3 levels. For 1-level factors, each factor is
    # simply a string. For example:
    # 
    # .. code-block:: python
    # 
    # FactorRange(factors=["sales", "marketing", "engineering"])
    # 
    # defines a range with three simple factors that might represent
    # different units of a business.
    # 
    # For 2- and 3- level factors, each factor is a tuple of strings:
    # 
    # .. code-block:: python
    # 
    # FactorRange(factors=[ ["2016", "sales'], ["2016", "marketing'],
    # ["2016", "engineering"], ["2017", "sales'], ["2017", "marketing'],
    # ["2017", "engineering"], ])
    # 
    # defines a range with six 2-level factors that might represent the three
    # business units, grouped by year.
    # 
    # Note that factors and sub-factors *may only be strings*.
    # > Either(Seq(String), Seq(Tuple(String, String)), Seq(Tuple(String, String, String)))
    factors = NULL,
    # The end of the range, in synthetic coordinates.
    # 
    # .. note:: Synthetic coordinates are only computed in the browser, based
    # on the factors and various padding properties. The value of ``end``
    # will only be available in situations where bidirectional communication
    # is available (e.g. server, notebook).
    # > Float
    end = NULL,
    # How much padding to add in between all lowest-level factors. When
    # ``factor_padding`` is non-zero, every factor in every group will have
    # the padding value applied.
    # > Float
    factor_padding = NULL,
    # The bounds (in synthetic coordinates) that the range is allowed to go
    # to.  Typically used to prevent the user from panning/zooming/etc away
    # from the data.
    # 
    # .. note:: Synthetic coordinates are only computed in the browser, based
    # on the factors and various padding properties. Some experimentation may
    # be required to arrive at bounds suitable for specific situations.
    # 
    # By default, the bounds will be None, allowing your plot to pan/zoom as
    # far as you want. If bounds are 'auto' they will be computed to be the
    # same as the start and end of the ``FactorRange``.
    # > MinMaxBounds(Auto, Tuple(Float, Float), Tuple(TimeDelta, TimeDelta))
    bounds = NULL,
    # How much padding to add in between top-level groups of factors. This
    # property only applies when the overall range factors have either two or
    # three levels. For example, with:
    # 
    # .. code-block:: python
    # 
    # FactorRange(factors=[["foo", "1'], ["foo", "2'], ["bar", "1"]])
    # 
    # The top level groups correspond to ``"foo"` and ``"bar"``, and the
    # group padding will be applied between the factors ``["foo", "2']`` and
    # ``["bar", "1"]``
    # > Float
    group_padding = NULL,
    # The start of the range, in synthetic coordinates.
    # 
    # Synthetic coordinates are only computed in the browser, based on the
    # factors and various padding properties. The value of ``end`` will only
    # be available in situations where bidirectional communication is
    # available (e.g. server, notebook).
    # > Float
    start = NULL,
    # Whether the ``range_padding`` should be interpreted as a percentage, or
    # as an absolute quantity. (default: ``"percent"``)
    # > Enum('percent', 'absolute')
    range_padding_units = NULL,
    # How much padding to add around the outside of computed range bounds.
    # 
    # When ``range_padding_units`` is set to ``"percent"``, the span of the
    # range span is expanded to make the range ``range_padding`` percent
    # larger.
    # 
    # When ``range_padding_units`` is set to ``"absolute"``, the start and
    # end of the range span are extended by the amount ``range_padding``.
    # > Float
    range_padding = NULL,
    # The level that the range is allowed to zoom in, expressed as the
    # minimum visible interval in synthetic coordinates. If set to ``None``
    # (default), the minimum interval is not bounded.
    # 
    # The default "width" of a category is 1.0 in synthetic coordinates.
    # However, the distance between factors is affected by the various
    # padding properties and whether or not factors are grouped.
    # > Float
    min_interval = NULL,
    # How much padding to add in between mid-level groups of factors. This
    # property only applies when the overall factors have three levels. For
    # example with:
    # 
    # .. code-block:: python
    # 
    # FactorRange(factors=[ ['foo', 'A', '1'], ['foo', 'A', '2'], ['foo',
    # 'A', '3'], ['foo', 'B', '2'], ['bar', 'A', '1'], ['bar', 'A', '2'] ])
    # 
    # This property dictates how much padding to add between the three
    # factors in the `['foo', 'A']` group, and between the two factors in the
    # the [`bar`]
    # > Float
    subgroup_padding = NULL
  )
)

# 
ImageURLTexture <- R6::R6Class("ImageURLTexture",
  inherit = Texture,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      repetition = "repeat", url = NULL, name = NULL, id = NULL
    ) {
      super$initialize(tags = tags,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks,
        repetition = repetition, name = name, id = id)
      types <- bk_prop_types[["ImageURLTexture"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # 
    # > String
    url = NULL
  )
)

# Render rays.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/Ray.py
# :source-position: below
Ray <- R6::R6Class("Ray",
  inherit = XYGlyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      y = NULL, length = NULL, line_color = "black",
      js_property_callbacks = structure(list(), .Names = character(0)),
      angle_units = "rad", name = NULL, x = NULL, tags = list(), angle = NULL,
      line_dash_offset = 0L, length_units = "data", line_join = "bevel",
      line_alpha = 1, js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), line_dash = list(),
      line_cap = "butt", line_width = 1L, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Ray"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The y-coordinates to start the rays.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y = NULL,
    # The length to extend the ray. Note that this ``length`` defaults to
    # data units (measured in the x-direction).
    # > DistanceSpec(units_default='data')
    length = NULL,
    # The line color values for the rays.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # 
    # > Enum('deg', 'rad')
    angle_units = NULL,
    # The x-coordinates to start the rays.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x = NULL,
    # The angles in radians to extend the rays, as measured from the
    # horizontal.
    # > AngleSpec(units_default='rad')
    angle = NULL,
    # The line dash offset values for the rays.
    # > Int
    line_dash_offset = NULL,
    # 
    # > Enum('screen', 'data')
    length_units = NULL,
    # The line join values for the rays.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # The line alpha values for the rays.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL,
    # The line dash values for the rays.
    # > DashPattern
    line_dash = NULL,
    # The line cap values for the rays.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line width values for the rays.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL
  )
)

# Tick formatter based on a printf-style format string.
PrintfTickFormatter <- R6::R6Class("PrintfTickFormatter",
  inherit = TickFormatter,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      format = "%s", name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["PrintfTickFormatter"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The number format, as defined as follows: the placeholder in the format
    # string is marked by % and is followed by one or more of these elements,
    # in this order:
    # 
    # * An optional ``+`` sign Causes the result to be preceded with a plus
    # or minus sign on numeric values. By default, only the ``-`` sign is
    # used on negative numbers.
    # 
    # * An optional padding specifier Specifies what (if any) character to
    # use for padding. Possible values are 0 or any other character preceded
    # by a ``'`` (single quote). The default is to pad with spaces.
    # 
    # * An optional ``-`` sign Causes sprintf to left-align the result of
    # this placeholder. The default is to right-align the result.
    # 
    # * An optional number Specifies how many characters the result should
    # have. If the value to be returned is shorter than this number, the
    # result will be padded.
    # 
    # * An optional precision modifier Consists of a ``.`` (dot) followed by
    # a number, specifies how many digits should be displayed for floating
    # point numbers. When used on a string, it causes the result to be
    # truncated.
    # 
    # * A type specifier Can be any of:
    # 
    # - ``%`` --- yields a literal ``%`` character - ``b`` --- yields an
    # integer as a binary number - ``c`` --- yields an integer as the
    # character with that ASCII value - ``d`` or ``i`` --- yields an integer
    # as a signed decimal number - ``e`` --- yields a float using scientific
    # notation - ``u`` --- yields an integer as an unsigned decimal number -
    # ``f`` --- yields a float as is - ``o`` --- yields an integer as an
    # octal number - ``s`` --- yields a string as is - ``x`` --- yields an
    # integer as a hexadecimal number (lower-case) - ``X`` --- yields an
    # integer as a hexadecimal number (upper-case)
    # > String
    format = NULL
  )
)

# Render a square marker, optionally rotated.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/Square.py
# :source-position: below
Square <- R6::R6Class("Square",
  inherit = Marker,
  public = list(
    specified_args = NULL,
    initialize = function(
      y = NULL, size = 4L, line_join = "bevel",
      js_property_callbacks = structure(list(), .Names = character(0)),
      angle_units = "rad", name = NULL, x = NULL, fill_color = "gray",
      line_dash = list(), tags = list(), angle = 0, line_dash_offset = 0L,
      js_event_callbacks = structure(list(), .Names = character(0)),
      fill_alpha = 1, subscribed_events = list(), line_color = "black",
      line_width = 1L, line_cap = "butt", line_alpha = 1, id = NULL
    ) {
      super$initialize(y = y, size = size, line_join = line_join,
        js_property_callbacks = js_property_callbacks,
        angle_units = angle_units, name = name, x = x, fill_color = fill_color,
        line_dash = line_dash, tags = tags, angle = angle,
        line_dash_offset = line_dash_offset,
        js_event_callbacks = js_event_callbacks, fill_alpha = fill_alpha,
        subscribed_events = subscribed_events, line_color = line_color,
        line_width = line_width, line_cap = line_cap,
        line_alpha = line_alpha, id = id)
      types <- bk_prop_types[["Square"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Spinner-based integer cell editor.
IntEditor <- R6::R6Class("IntEditor",
  inherit = CellEditor,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), js_property_callbacks = structure(list(), .Names =
      character(0)), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), step = 1L, name = NULL,
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["IntEditor"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The major step value.
    # > Int
    step = NULL
  )
)

# Maps names of columns to sequences or arrays.
# 
# The ``ColumnDataSource`` is a fundamental data structure of Bokeh. Most
# plots, data tables, etc. will be driven by a ``ColumnDataSource``.
# 
# If the ``ColumnDataSource`` initializer is called with a single
# argument that can be any of the following:
# 
# * A Python ``dict`` that maps string names to sequences of values, e.g.
# lists, arrays, etc.
# 
# .. code-block:: python
# 
# data = {'x': [1,2,3,4], 'y': np.ndarray([10.0, 20.0, 30.0, 40.0])}
# 
# source = ColumnDataSource(data)
# 
# .. note:: ``ColumnDataSource`` only creates a shallow copy of ``data``.
# Use e.g.  ``ColumnDataSource(copy.deepcopy(data))`` if initializing
# from another ``ColumnDataSource.data`` object that you want to keep
# independent.
# 
# * A Pandas ``DataFrame`` object
# 
# .. code-block:: python
# 
# source = ColumnDataSource(df)
# 
# In this case the CDS will have columns corresponding to the columns of
# the ``DataFrame``. If the ``DataFrame`` columns have multiple levels,
# they will be flattened using an underscore (e.g.
# level_0_col_level_1_col).  The index of the ``DataFrame`` will be
# flattened to an ``Index`` of tuples if it's a ``MultiIndex``, and then
# reset using ``reset_index``. The result will be a column with the same
# name if the index was named, or level_0_name_level_1_name if it was a
# named ``MultiIndex``. If the ``Index`` did not have a name or the
# ``MultiIndex`` name could not be flattened/determined, the
# ``reset_index`` function will name the index column ``index``, or
# ``level_0`` if the name ``index`` is not available.
# 
# * A Pandas ``GroupBy`` object
# 
# .. code-block:: python
# 
# group = df.groupby(('colA', 'ColB'))
# 
# In this case the CDS will have columns corresponding to the result of
# calling ``group.describe()``. The ``describe`` method generates columns
# for statistical measures such as ``mean`` and ``count`` for all the
# non-grouped original columns. The CDS columns are formed by joining
# original column names with the computed measure. For example, if a
# ``DataFrame`` has columns ``'year'`` and ``'mpg'``. Then passing
# ``df.groupby('year')`` to a CDS will result in columns such as
# ``'mpg_mean'``
# 
# If the ``GroupBy.describe`` result has a named index column, then CDS
# will also have a column with this name. However, if the index name (or
# any subname of a ``MultiIndex``) is ``None``, then the CDS will have a
# column generically named ``index`` for the index.
# 
# Note this capability to adapt ``GroupBy`` objects may only work with
# Pandas ``>=0.20.0``.
# 
# .. note:: There is an implicit assumption that all the columns in a
# given ``ColumnDataSource`` all have the same length at all times. For
# this reason, it is usually preferable to update the ``.data`` property
# of a data source "all at once".
ColumnDataSource <- R6::R6Class("ColumnDataSource",
  inherit = ColumnarDataSource,
  public = list(
    specified_args = NULL,
    initialize = function(
      selected = NULL, js_property_callbacks = structure(list(), .Names =
      character(0)), data = structure(list(), .Names = character(0)),
      callback = NULL, tags = list(), selection_policy = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), name = NULL, id = NULL
    ) {
      super$initialize(selected = selected,
        js_property_callbacks = js_property_callbacks, callback = callback,
        tags = tags, selection_policy = selection_policy,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name, id = id)
      types <- bk_prop_types[["ColumnDataSource"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Mapping of column names to sequences of data. The columns can be, e.g,
    # Python lists or tuples, NumPy arrays, etc.
    # 
    # The .data attribute can also be set from Pandas DataFrames or GroupBy
    # objects. In these cases, the behaviour is identical to passing the
    # objects to the ``ColumnDataSource`` initializer.
    # > ColumnData(String, Seq(Any))
    data = NULL
  )
)

# Render diamond markers.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/Diamond.py
# :source-position: below
Diamond <- R6::R6Class("Diamond",
  inherit = Marker,
  public = list(
    specified_args = NULL,
    initialize = function(
      y = NULL, size = 4L, line_join = "bevel",
      js_property_callbacks = structure(list(), .Names = character(0)),
      angle_units = "rad", name = NULL, x = NULL, fill_color = "gray",
      line_dash = list(), tags = list(), angle = 0, line_dash_offset = 0L,
      js_event_callbacks = structure(list(), .Names = character(0)),
      fill_alpha = 1, subscribed_events = list(), line_color = "black",
      line_width = 1L, line_cap = "butt", line_alpha = 1, id = NULL
    ) {
      super$initialize(y = y, size = size, line_join = line_join,
        js_property_callbacks = js_property_callbacks,
        angle_units = angle_units, name = name, x = x, fill_color = fill_color,
        line_dash = line_dash, tags = tags, angle = angle,
        line_dash_offset = line_dash_offset,
        js_event_callbacks = js_event_callbacks, fill_alpha = fill_alpha,
        subscribed_events = subscribed_events, line_color = line_color,
        line_width = line_width, line_cap = line_cap,
        line_alpha = line_alpha, id = id)
      types <- bk_prop_types[["Diamond"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Render annuli.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/Annulus.py
# :source-position: below
Annulus <- R6::R6Class("Annulus",
  inherit = XYGlyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      y = NULL, inner_radius_units = "data", inner_radius = NULL,
      line_join = "bevel", js_property_callbacks = structure(list(), .Names
      = character(0)), name = NULL, x = NULL, fill_color = "gray",
      line_dash = list(), outer_radius_units = "data", line_dash_offset = 0L,
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), fill_alpha = 1, subscribed_events = list(),
      line_color = "black", outer_radius = NULL, line_width = 1L,
      line_cap = "butt", line_alpha = 1, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Annulus"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The y-coordinates of the center of the annuli.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y = NULL,
    # 
    # > Enum('screen', 'data')
    inner_radius_units = NULL,
    # The inner radii of the annuli.
    # > DistanceSpec(units_default='data')
    inner_radius = NULL,
    # The line join values for the annuli.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # The x-coordinates of the center of the annuli.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x = NULL,
    # The fill color values for the annuli.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    fill_color = NULL,
    # The line dash values for the annuli.
    # > DashPattern
    line_dash = NULL,
    # 
    # > Enum('screen', 'data')
    outer_radius_units = NULL,
    # The line dash offset values for the annuli.
    # > Int
    line_dash_offset = NULL,
    # The fill alpha values for the annuli.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    fill_alpha = NULL,
    # The line color values for the annuli.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The outer radii of the annuli.
    # > DistanceSpec(units_default='data')
    outer_radius = NULL,
    # The line width values for the annuli.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL,
    # The line cap values for the annuli.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line alpha values for the annuli.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL
  )
)

# A base class for tools that perform "inspections", e.g. ``HoverTool``.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
Inspection <- R6::R6Class("Inspection",
  inherit = Gesture,
  public = list(
    specified_args = NULL,
    initialize = function(
      toggleable = TRUE, tags = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Inspection"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Whether an on/off toggle button should appear in the toolbar for this
    # inspection tool. If ``False``, the viewers of a plot will not be able
    # to toggle the inspector on or off using the toolbar.
    # > Bool
    toggleable = NULL
  )
)

# Spinner widget for numerical inputs
Spinner <- R6::R6Class("Spinner",
  inherit = InputWidget,
  public = list(
    specified_args = NULL,
    initialize = function(
      title = "", min_width = NULL, max_width = NULL, align = "start",
      high = NULL, disabled = FALSE, value = 0L, callback = NULL,
      background = NULL, tags = list(), visible = TRUE, width_policy = "auto",
      height_policy = "auto", step = 1L, height = NULL, name = NULL,
      sizing_mode = NULL, default_size = 300L, max_height = NULL,
      css_classes = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), orientation = "horizontal", low = NULL,
      min_height = NULL, subscribed_events = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      width = NULL, aspect_ratio = NULL, margin = list(5L, 5L, 5L, 5L),
      id = NULL
    ) {
      super$initialize(title = title, min_width = min_width,
        max_width = max_width, align = align, disabled = disabled,
        background = background, tags = tags, visible = visible,
        width_policy = width_policy, height_policy = height_policy,
        height = height, name = name, sizing_mode = sizing_mode,
        default_size = default_size, max_height = max_height,
        css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["Spinner"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Optional highest allowable value.
    # > Float
    high = NULL,
    # The initial value of the spinner
    # > Float
    value = NULL,
    # A callback to run in the browser whenever the user unfocuses the
    # ``SpinBox`` widget by hitting Enter or clicking outside of the box
    # area.
    # > Instance(Callback)
    callback = NULL,
    # The step added or subtracted to the current value
    # > Float
    step = NULL,
    # Optional lowest allowable value.
    # > Float
    low = NULL
  )
)

# 
GridBox <- R6::R6Class("GridBox",
  inherit = LayoutDOM,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", disabled = FALSE,
      background = NULL, tags = list(), visible = TRUE, width_policy = "auto",
      height_policy = "auto", height = NULL, spacing = 0L, sizing_mode = NULL,
      name = NULL, cols = "auto", max_height = NULL, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      rows = "auto", children = list(), min_height = NULL,
      subscribed_events = list(), js_event_callbacks = structure(list(),
      .Names = character(0)), width = NULL, aspect_ratio = NULL,
      margin = list(0L, 0L, 0L, 0L), id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, background = background,
        tags = tags, visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, name = name,
        sizing_mode = sizing_mode, max_height = max_height,
        css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        js_event_callbacks = js_event_callbacks, min_height = min_height,
        subscribed_events = subscribed_events, width = width,
        aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["GridBox"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The gap between children (in pixels).
    # 
    # Either a number, if spacing is the same for both dimensions, or a pair
    # of numbers indicating spacing in the vertical and horizontal dimensions
    # respectively.
    # > Either(Int, Tuple(Int, Int))
    spacing = NULL,
    # Describes how the grid should maintain its columns' widths.
    # 
    # .. note:: This is an experimental feature and may change in future. Use
    # it at your own discretion.
    # > Either(Either(Enum('auto', 'min', 'fit', 'max'), Int), Dict(Either(Int, String), Either(Either(Enum('auto', 'min', 'fit', 'max'), Int), Struct(policy=Enum('auto', 'min'), align=Either(Auto, Enum('start', 'center', 'end'))), Struct(policy=Enum('fixed'), width=Int, align=Either(Auto, Enum('start', 'center', 'end'))), Struct(policy=Enum('fit', 'max'), align=Either(Auto, Enum('start', 'center', 'end')), flex=Float))))
    cols = NULL,
    # Describes how the grid should maintain its rows' heights.
    # 
    # .. note:: This is an experimental feature and may change in future. Use
    # it at your own discretion.
    # > Either(Either(Enum('auto', 'min', 'fit', 'max'), Int), Dict(Either(Int, String), Either(Either(Enum('auto', 'min', 'fit', 'max'), Int), Struct(policy=Enum('auto', 'min'), align=Either(Auto, Enum('start', 'center', 'end'))), Struct(policy=Enum('fixed'), height=Int, align=Either(Auto, Enum('start', 'center', 'end'))), Struct(policy=Enum('fit', 'max'), align=Either(Auto, Enum('start', 'center', 'end')), flex=Float))))
    rows = NULL,
    # A list of children with their associated position in the grid (row,
    # column).
    # > List(Either(Tuple(Instance(LayoutDOM), Int, Int), Tuple(Instance(LayoutDOM), Int, Int, Int, Int)))
    children = NULL
  )
)

# Abstract base class for groups with items rendered as check/radio
# boxes.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
Group <- R6::R6Class("Group",
  inherit = AbstractGroup,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", disabled = FALSE,
      callback = NULL, background = NULL, tags = list(), visible = TRUE,
      width_policy = "auto", height_policy = "auto", height = NULL,
      name = NULL, sizing_mode = NULL, labels = list(), default_size = 300L,
      max_height = NULL, inline = FALSE, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      orientation = "horizontal", js_event_callbacks = structure(list(),
      .Names = character(0)), min_height = NULL,
      subscribed_events = list(), width = NULL, aspect_ratio = NULL,
      margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, callback = callback,
        background = background, tags = tags, visible = visible,
        width_policy = width_policy, height_policy = height_policy,
        height = height, name = name, sizing_mode = sizing_mode,
        labels = labels, default_size = default_size,
        max_height = max_height, css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["Group"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Should items be arrange vertically (``False``) or horizontally in-line
    # (``True``).
    # > Bool
    inline = NULL
  )
)

# An axis that picks nice numbers for tick locations on a Mercator scale.
# Configured with a ``MercatorTickFormatter`` by default.
# 
# Args: dimension ('lat' or 'lon', optional) : Whether this axis will
# display latitude or longitude values.  (default: 'lat')
MercatorAxis <- R6::R6Class("MercatorAxis",
  inherit = LinearAxis,
  public = list(
    specified_args = NULL,
    initialize = function(
      major_label_text_font_size = list(value = "8pt"),
      major_label_text_font_style = "normal",
      axis_label_text_color = "#444444", fixed_location = NULL,
      major_label_text_align = "center", major_tick_line_color = "black",
      axis_label_text_line_height = 1.2, major_label_standoff = 5L,
      major_label_overrides = structure(list(), .Names = character(0)),
      tags = list(), minor_tick_in = 0L, formatter = NULL,
      axis_label_text_font_style = "italic",
      major_label_orientation = "horizontal",
      minor_tick_line_join = "bevel", major_tick_line_alpha = 1,
      axis_line_width = 1L, axis_label_text_font_size = list(value =
      "10pt"), major_tick_line_dash_offset = 0L,
      axis_label_text_baseline = "bottom", major_tick_line_width = 1L,
      major_label_text_font = "helvetica",
      axis_label_text_font = "helvetica", ticker = NULL,
      major_tick_line_cap = "butt", axis_label_text_alpha = 1,
      js_event_callbacks = structure(list(), .Names = character(0)),
      minor_tick_line_cap = "butt", subscribed_events = list(),
      major_tick_line_join = "bevel", axis_label_standoff = 5L,
      axis_line_alpha = 1, axis_line_cap = "butt", level = "overlay",
      major_tick_line_dash = list(), axis_label = "",
      major_label_text_color = "#444444",
      major_label_text_baseline = "alphabetic", major_tick_out = 6L,
      axis_line_color = "black", axis_line_join = "bevel",
      major_tick_in = 2L, visible = TRUE, minor_tick_out = 4L, name = NULL,
      minor_tick_line_dash = list(), major_label_text_line_height = 1.2,
      minor_tick_line_alpha = 1, bounds = "auto", axis_line_dash = list(),
      x_range_name = "default", minor_tick_line_color = "black",
      js_property_callbacks = structure(list(), .Names = character(0)),
      axis_label_text_align = "left", y_range_name = "default",
      major_label_text_alpha = 1, minor_tick_line_dash_offset = 0L,
      axis_line_dash_offset = 0L, minor_tick_line_width = 1L, id = NULL
    ) {
      super$initialize(major_label_text_font_size = major_label_text_font_size,
        major_label_text_font_style = major_label_text_font_style,
        axis_label_text_color = axis_label_text_color,
        fixed_location = fixed_location,
        major_label_text_align = major_label_text_align,
        major_tick_line_color = major_tick_line_color,
        axis_label_text_line_height = axis_label_text_line_height,
        major_label_standoff = major_label_standoff,
        major_label_overrides = major_label_overrides, tags = tags,
        minor_tick_in = minor_tick_in, formatter = formatter,
        axis_label_text_font_style = axis_label_text_font_style,
        major_label_orientation = major_label_orientation,
        minor_tick_line_join = minor_tick_line_join,
        major_tick_line_alpha = major_tick_line_alpha,
        axis_line_width = axis_line_width,
        axis_label_text_font_size = axis_label_text_font_size,
        major_tick_line_dash_offset = major_tick_line_dash_offset,
        axis_label_text_baseline = axis_label_text_baseline,
        major_tick_line_width = major_tick_line_width,
        major_label_text_font = major_label_text_font,
        axis_label_text_font = axis_label_text_font, ticker = ticker,
        major_tick_line_cap = major_tick_line_cap,
        axis_label_text_alpha = axis_label_text_alpha,
        js_event_callbacks = js_event_callbacks,
        minor_tick_line_cap = minor_tick_line_cap,
        subscribed_events = subscribed_events,
        major_tick_line_join = major_tick_line_join,
        axis_label_standoff = axis_label_standoff,
        axis_line_alpha = axis_line_alpha, axis_line_cap = axis_line_cap,
        level = level, major_tick_line_dash = major_tick_line_dash,
        axis_label = axis_label,
        major_label_text_color = major_label_text_color,
        major_label_text_baseline = major_label_text_baseline,
        major_tick_out = major_tick_out, axis_line_color = axis_line_color,
        axis_line_join = axis_line_join, major_tick_in = major_tick_in,
        visible = visible, minor_tick_out = minor_tick_out, name = name,
        minor_tick_line_dash = minor_tick_line_dash,
        major_label_text_line_height = major_label_text_line_height,
        minor_tick_line_alpha = minor_tick_line_alpha, bounds = bounds,
        axis_line_dash = axis_line_dash, x_range_name = x_range_name,
        minor_tick_line_color = minor_tick_line_color,
        js_property_callbacks = js_property_callbacks,
        axis_label_text_align = axis_label_text_align,
        y_range_name = y_range_name,
        major_label_text_alpha = major_label_text_alpha,
        minor_tick_line_dash_offset = minor_tick_line_dash_offset,
        axis_line_dash_offset = axis_line_dash_offset,
        minor_tick_line_width = minor_tick_line_width, id = id)
      types <- bk_prop_types[["MercatorAxis"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Table column widget.
TableColumn <- R6::R6Class("TableColumn",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      sortable = TRUE, editor = NULL, title = NULL,
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, tags = list(), field = NULL, formatter = NULL,
      subscribed_events = list(), js_event_callbacks = structure(list(),
      .Names = character(0)), width = 300L, default_sort = "ascending",
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["TableColumn"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Whether this column is sortable or not. Note that data table has to
    # have sorting enabled to allow sorting in general.
    # > Bool
    sortable = NULL,
    # The cell editor for this column. By default, a simple string editor is
    # used.
    # > Instance(CellEditor)
    editor = NULL,
    # The title of this column. If not set, column's data field is used
    # instead.
    # > String
    title = NULL,
    # The name of the field mapping to a column in the data source.
    # > String
    field = NULL,
    # The cell formatter for this column. By default, a simple string
    # formatter is used.
    # > Instance(CellFormatter)
    formatter = NULL,
    # The width or maximum width (depending on data table's configuration) in
    # pixels of this column.
    # > Int
    width = NULL,
    # The default sorting order. By default ``ascending`` order is used.
    # > Enum('ascending', 'descending')
    default_sort = NULL
  )
)

# Base class for Bokeh models that represent HTML markup elements.
# 
# Markups include e.g., ``<div>``, ``<p>``, and ``<pre>``.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
Markup <- R6::R6Class("Markup",
  inherit = Widget,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", disabled = FALSE,
      style = structure(list(), .Names = character(0)), background = NULL,
      text = "", tags = list(), visible = TRUE, width_policy = "auto",
      height_policy = "auto", height = NULL, name = NULL, sizing_mode = NULL,
      default_size = 300L, max_height = NULL, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      orientation = "horizontal", js_event_callbacks = structure(list(),
      .Names = character(0)), min_height = NULL,
      subscribed_events = list(), width = NULL, aspect_ratio = NULL,
      margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, background = background,
        tags = tags, visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, name = name,
        sizing_mode = sizing_mode, default_size = default_size,
        max_height = max_height, css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["Markup"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Raw CSS style declaration. Note this may be web browser dependent.
    # > Dict(String, Any)
    style = NULL,
    # The text or HTML contents of the widget.
    # 
    # .. note:: If the HTML content contains elements which size depends on
    # on external, asynchronously loaded resources, the size of the widget
    # may be computed incorrectly. This is in particular an issue with images
    # (``<img>``). To remedy this problem, one either has to set explicit
    # dimensions using CSS properties, HTML attributes or model's ``width``
    # and ``height`` properties, or inline images' contents using data URIs.
    # > String
    text = NULL
  )
)

# A base class for all range types.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
Range <- R6::R6Class("Range",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, callback = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Range"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A callback to run in the browser whenever the range is updated.
    # > Instance(Callback)
    callback = NULL
  )
)

# A base class for all interactive tool types.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
Tool <- R6::R6Class("Tool",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Tool"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Generate evenly spaced ticks at a fixed interval regardless of scale.
SingleIntervalTicker <- R6::R6Class("SingleIntervalTicker",
  inherit = ContinuousTicker,
  public = list(
    specified_args = NULL,
    initialize = function(
      desired_num_ticks = 6L, interval = NULL,
      js_property_callbacks = structure(list(), .Names = character(0)),
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), name = NULL,
      num_minor_ticks = 5L, id = NULL
    ) {
      super$initialize(tags = tags, desired_num_ticks = desired_num_ticks,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name,
        num_minor_ticks = num_minor_ticks, id = id)
      types <- bk_prop_types[["SingleIntervalTicker"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The interval between adjacent ticks.
    # > Float
    interval = NULL
  )
)

# A base class for all tile source types.
# 
# In general, tile sources are used as a required input for
# ``TileRenderer``.
TileSource <- R6::R6Class("TileSource",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      js_property_callbacks = structure(list(), .Names = character(0)),
      tile_size = 256L, extra_url_vars = structure(list(), .Names =
      character(0)), min_zoom = 0L, initial_resolution = NULL,
      x_origin_offset = NULL, attribution = "", y_origin_offset = NULL,
      max_zoom = 30L, tags = list(), js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(), name = NULL,
      url = "", id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["TileSource"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Tile size in pixels (e.g. 256)
    # > Int
    tile_size = NULL,
    # A dictionary that maps url variable template keys to values.
    # 
    # These variables are useful for parts of tile urls which do not change
    # from tile to tile (e.g. server host name, or layer name).
    # > Dict(String, Any)
    extra_url_vars = NULL,
    # A minimum zoom level for the tile layer. This is the most zoomed-out
    # level.
    # > Int
    min_zoom = NULL,
    # Resolution (plot_units / pixels) of minimum zoom level of tileset
    # projection. None to auto-compute.
    # > Float
    initial_resolution = NULL,
    # An x-offset in plot coordinates
    # > Float
    x_origin_offset = NULL,
    # Data provider attribution content. This can include HTML content.
    # > String
    attribution = NULL,
    # A y-offset in plot coordinates
    # > Float
    y_origin_offset = NULL,
    # A maximum zoom level for the tile layer. This is the most zoomed-in
    # level.
    # > Int
    max_zoom = NULL,
    # Tile service url e.g., http://c.tile.openstreetmap.org/{Z}/{X}/{Y}.png
    # > String
    url = NULL
  )
)

# Simple sum across multiple rows.
SumAggregator <- R6::R6Class("SumAggregator",
  inherit = RowAggregator,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), field_ = "", js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, id = NULL
    ) {
      super$initialize(tags = tags, field_ = field_,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["SumAggregator"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# *toolbar icon*: |zoom_out_icon|
# 
# The zoom-out tool allows users to click a button to zoom out by a fixed
# amount.
# 
# .. |zoom_out_icon| image:: /_images/icons/ZoomOut.png :height: 18pt
ZoomOutTool <- R6::R6Class("ZoomOutTool",
  inherit = Action,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), dimensions = "both",
      js_property_callbacks = structure(list(), .Names = character(0)),
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), factor = 0.1, name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["ZoomOutTool"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Which dimensions the zoom-out tool is constrained to act in. By default
    # the zoom-out tool will zoom in any dimension, but can be configured to
    # only zoom horizontally across the width of the plot, or vertically
    # across the height of the plot.
    # > Enum('width', 'height', 'both')
    dimensions = NULL,
    # Percentage to zoom for each click of the zoom-in tool.
    # > Percent
    factor = NULL
  )
)

# Base class of glyphs with `x` and `y` coordinate attributes.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
XYGlyph <- R6::R6Class("XYGlyph",
  inherit = Glyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["XYGlyph"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# An abstract base class for renderer types.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
Renderer <- R6::R6Class("Renderer",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      level = "image", tags = list(), visible = TRUE,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Renderer"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Specifies the level in which to paint this renderer.
    # > Enum('image', 'underlay', 'glyph', 'annotation', 'overlay')
    level = NULL,
    # Is the renderer visible.
    # > Bool
    visible = NULL
  )
)

# Render arbitrary markers according a specification.
# 
# The Scatter can draw any built-in marker type. It can be configured to
# draw the same marker for all values by specifying the name of a marker,
# e.g.
# 
# .. code-block:: python
# 
# glyph = Scatter(x="x", y="y", size="sizes", marker="square")
# plot.add_glyph(source, glyph)
# 
# will render only Square markers for all points. Alternatively, the
# Scatter marker can be configured to use marker types specified in a
# data source column:
# 
# .. code-block:: python
# 
# # source.data['markers'] = ["circle", "square", "circle", ... ]
# 
# glyph = Scatter(x="x", y="y", size="sizes", marker="markers")
# plot.add_glyph(source, glyph)
# 
# Note that circles drawn with `Scatter` conform to the standard Marker
# interface, and can only vary by size (in screen units) and *not* by
# radius (in data units). If you need to control circles by radius in
# data units, you should use the Circle glyph directly.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/Scatter.py
# :source-position: below
Scatter <- R6::R6Class("Scatter",
  inherit = Marker,
  public = list(
    specified_args = NULL,
    initialize = function(
      y = NULL, line_color = "black", size = 4L,
      js_property_callbacks = structure(list(), .Names = character(0)),
      fill_alpha = 1, angle_units = "rad", name = NULL, x = NULL, tags = list(),
      angle = 0, line_dash_offset = 0L, line_alpha = 1, line_join = "bevel",
      line_cap = "butt", js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), line_dash = list(),
      marker = "circle", fill_color = "gray", line_width = 1L, id = NULL
    ) {
      super$initialize(y = y, size = size, line_join = line_join,
        js_property_callbacks = js_property_callbacks,
        angle_units = angle_units, name = name, x = x, fill_color = fill_color,
        line_dash = line_dash, tags = tags, angle = angle,
        line_dash_offset = line_dash_offset,
        js_event_callbacks = js_event_callbacks, fill_alpha = fill_alpha,
        subscribed_events = subscribed_events, line_color = line_color,
        line_width = line_width, line_cap = line_cap,
        line_alpha = line_alpha, id = id)
      types <- bk_prop_types[["Scatter"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Which marker to render. This can be the name of any built in marker,
    # e.g. "circle", or a reference to a data column containing such names.
    # > MarkerSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), MarkerType('asterisk', 'circle', 'circle_cross', 'circle_x', 'cross', 'dash', 'diamond', 'diamond_cross', 'hex', 'inverted_triangle', 'square', 'square_cross', 'square_x', 'triangle', 'x'))), MarkerType('asterisk', 'circle', 'circle_cross', 'circle_x', 'cross', 'dash', 'diamond', 'diamond_cross', 'hex', 'inverted_triangle', 'square', 'square_cross', 'square_x', 'triangle', 'x'))
    marker = NULL
  )
)

# Map categorical factors to marker types.
# 
# Values that are passed to this mapper that are not in the factors list
# will be mapped to ``default_value``.
# 
# .. note:: This mappers is primarily only useful with the ``Scatter``
# marker glyph that be parameterized by marker type.
CategoricalMarkerMapper <- R6::R6Class("CategoricalMarkerMapper",
  inherit = CategoricalMapper,
  public = list(
    specified_args = NULL,
    initialize = function(
      factors = NULL, end = NULL, start = 0L,
      js_property_callbacks = structure(list(), .Names = character(0)),
      markers = NULL, tags = list(), js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(), name = NULL,
      default_value = "circle", id = NULL
    ) {
      super$initialize(factors = factors, end = end, start = start,
        js_property_callbacks = js_property_callbacks, tags = tags,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name, id = id)
      types <- bk_prop_types[["CategoricalMarkerMapper"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A sequence of marker types to use as the target for mapping.
    # > Seq(MarkerType('asterisk', 'circle', 'circle_cross', 'circle_x', 'cross', 'dash', 'diamond', 'diamond_cross', 'hex', 'inverted_triangle', 'square', 'square_cross', 'square_x', 'triangle', 'x'))
    markers = NULL,
    # A marker type to use in case an unrecognized factor is passed in to be
    # mapped.
    # > MarkerType('asterisk', 'circle', 'circle_cross', 'circle_x', 'cross', 'dash', 'diamond', 'diamond_cross', 'hex', 'inverted_triangle', 'square', 'square_cross', 'square_x', 'triangle', 'x')
    default_value = NULL
  )
)

# Display tick values from continuous ranges as powers of some base.
# 
# Most often useful in conjunction with a ``LogTicker``.
LogTickFormatter <- R6::R6Class("LogTickFormatter",
  inherit = TickFormatter,
  public = list(
    specified_args = NULL,
    initialize = function(
      ticker = NULL, tags = list(), js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["LogTickFormatter"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The corresponding ``LogTicker``, used to determine the correct base to
    # use. If unset, the formatter will use base 10 as a default.
    # > Instance(Ticker)
    ticker = NULL
  )
)

# A base class for tools that respond to tap/click events.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
Tap <- R6::R6Class("Tap",
  inherit = Gesture,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Tap"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Filter data sources with a custom defined JavaScript function.
# 
# .. warning:: The explicit purpose of this Bokeh Model is to embed *raw
# JavaScript code* for a browser to execute. If any part of the code is
# derived from untrusted user inputs, then you must take appropriate care
# to sanitize the user input prior to passing to Bokeh.
CustomJSFilter <- R6::R6Class("CustomJSFilter",
  inherit = Filter,
  public = list(
    specified_args = NULL,
    initialize = function(
      filter = NULL, js_property_callbacks = structure(list(), .Names =
      character(0)), code = "", tags = list(), use_strict = FALSE,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), name = NULL, args = structure(list(),
      .Names = character(0)), id = NULL
    ) {
      super$initialize(filter = filter, tags = tags,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["CustomJSFilter"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A snippet of JavaScript code to filter data contained in a columnar
    # data source.  The code is made into the body of a function, and all of
    # of the named objects in ``args`` are available as parameters that the
    # code can use. The variable ``source`` will contain the data source that
    # is associated with the ``CDSView`` this filter is added to.
    # 
    # The code should either return the indices of the subset or an array of
    # booleans to use to subset data source rows.
    # 
    # Example:
    # 
    # .. code-block:: javascript
    # 
    # code = ''' var indices = []; for (var i = 0; i <=
    # source.data['some_column'].length; i++){ if
    # (source.data['some_column'][i] == 'some_value') { indices.push(i) } }
    # return indices; '''
    # 
    # .. note:: Use ``CustomJS.from_coffeescript()`` for CoffeeScript source
    # code.
    # > String
    code = NULL,
    # Enables or disables automatic insertion of ``"use strict";`` into
    # ``code``.
    # > Bool
    use_strict = NULL,
    # A mapping of names to Python objects. In particular those can be
    # bokeh's models.  These objects are made available to the callback's
    # code snippet as the values of named parameters to the callback.
    # > Dict(String, AnyRef)
    args = NULL
  )
)

# A base class for tools that respond to drag events.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
Drag <- R6::R6Class("Drag",
  inherit = Gesture,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Drag"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Smallest value across multiple rows.
MinAggregator <- R6::R6Class("MinAggregator",
  inherit = RowAggregator,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), field_ = "", js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, id = NULL
    ) {
      super$initialize(tags = tags, field_ = field_,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["MinAggregator"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Render a tee-style arrow head.
TeeHead <- R6::R6Class("TeeHead",
  inherit = ArrowHead,
  public = list(
    specified_args = NULL,
    initialize = function(
      level = "annotation", size = 25L, line_join = "bevel",
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, line_dash = list(), tags = list(), line_dash_offset = 0L,
      visible = TRUE, js_event_callbacks = structure(list(), .Names =
      character(0)), line_width = 1L, subscribed_events = list(),
      line_color = "black", line_cap = "butt", line_alpha = 1, id = NULL
    ) {
      super$initialize(level = level, tags = tags, visible = visible,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["TeeHead"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The size, in pixels, of the arrow head.
    # > Float
    size = NULL,
    # The line join values for the arrow head outline.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # The line dash values for the arrow head outline.
    # > DashPattern
    line_dash = NULL,
    # The line dash offset values for the arrow head outline.
    # > Int
    line_dash_offset = NULL,
    # The line width values for the arrow head outline.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL,
    # The line color values for the arrow head outline.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The line cap values for the arrow head outline.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line alpha values for the arrow head outline.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL
  )
)

# *toolbar icon*: |lasso_select_icon|
# 
# The lasso selection tool allows users to make selections on a Plot by
# indicating a free-drawn "lasso" region by dragging the mouse or a
# finger over the plot region. The end of the drag event indicates the
# selection region is ready.
# 
# See :ref:`userguide_styling_selected_unselected_glyphs` for information
# on styling selected and unselected glyphs.
# 
# .. note:: Selections can be comprised of multiple regions, even those
# made by different selection tools. Hold down the <<shift>> key while
# making a selection to append the new selection to any previous
# selection that might exist.
# 
# .. |lasso_select_icon| image:: /_images/icons/LassoSelect.png :height:
# 18pt
LassoSelectTool <- R6::R6Class("LassoSelectTool",
  inherit = Drag,
  public = list(
    specified_args = NULL,
    initialize = function(
      js_property_callbacks = structure(list(), .Names = character(0)),
      callback = NULL, tags = list(), renderers = "auto", overlay = NULL,
      select_every_mousemove = TRUE, names = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["LassoSelectTool"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A callback to run in the browser on every selection of a lasso area.
    # The ``cb_data`` parameter that is available to the Callback code will
    # contain one ``LassoSelectTool``-specific field:
    # 
    # :geometry: object containing the coordinates of the lasso area
    # > Instance(Callback)
    callback = NULL,
    # An explicit list of renderers to hit test against. If unset, defaults
    # to all renderers on a plot.
    # > Either(Auto, List(Instance(Renderer)))
    renderers = NULL,
    # A shaded annotation drawn to indicate the selection region.
    # > Instance(PolyAnnotation)
    overlay = NULL,
    # Whether a selection computation should happen on every mouse event, or
    # only once, when the selection region is completed.
    # > Bool
    select_every_mousemove = NULL,
    # A list of names to query for. If set, only renderers that have a
    # matching value for their ``name`` attribute will be used.
    # > List(String)
    names = NULL
  )
)

# Render informational legends for a plot.
Legend <- R6::R6Class("Legend",
  inherit = Annotation,
  public = list(
    specified_args = NULL,
    initialize = function(
      border_line_color = "#e5e5e5", inactive_fill_alpha = 0.7,
      label_text_color = "#444444", location = "top_right",
      border_line_dash_offset = 0L, label_text_font_style = "normal",
      tags = list(), label_text_alpha = 1, click_policy = "none",
      border_line_dash = list(), title_standoff = 5L, border_line_width = 1L,
      title_text_font_style = "italic", title_text_font = "helvetica",
      label_text_line_height = 1.2, border_line_join = "bevel",
      border_line_cap = "butt", items = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      label_width = 20L, subscribed_events = list(), glyph_width = 20L,
      glyph_height = 20L, margin = 10L, label_height = 20L, padding = 10L,
      level = "annotation", title = NULL, title_text_line_height = 1.2,
      background_fill_color = "#ffffff", label_text_align = "left",
      visible = TRUE, label_text_font = "helvetica", spacing = 3L, name = NULL,
      inactive_fill_color = "white", title_text_baseline = "bottom",
      title_text_alpha = 1, title_text_font_size = list(value = "10pt"),
      js_property_callbacks = structure(list(), .Names = character(0)),
      title_text_align = "left", orientation = "vertical",
      title_text_color = "#444444", background_fill_alpha = 0.95,
      label_standoff = 5L, label_text_baseline = "middle",
      label_text_font_size = list(value = "10pt"), border_line_alpha = 0.5,
      id = NULL
    ) {
      super$initialize(level = level, tags = tags, visible = visible,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["Legend"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The line color for the legend border outline.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    border_line_color = NULL,
    # The fill alpha for the legend item style when inactive. These control
    # an overlay on the item that can be used to obscure it when the
    # corresponding glyph is inactive (e.g. by making it semi-transparent).
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    inactive_fill_alpha = NULL,
    # The text color for the legend labels.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    label_text_color = NULL,
    # The location where the legend should draw itself. It's either one of
    # ``bokeh.core.enums.LegendLocation``'s enumerated values, or a ``(x,
    # y)`` tuple indicating an absolute location absolute location in screen
    # coordinates (pixels from the bottom-left corner).
    # > Either(Enum('top_left', 'top_center', 'top_right', 'center_left', 'center', 'center_right', 'bottom_left', 'bottom_center', 'bottom_right'), Tuple(Float, Float))
    location = NULL,
    # The line dash offset for the legend border outline.
    # > Int
    border_line_dash_offset = NULL,
    # The text font style for the legend labels.
    # > Enum('normal', 'italic', 'bold', 'bold italic')
    label_text_font_style = NULL,
    # The text alpha for the legend labels.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    label_text_alpha = NULL,
    # Defines what happens when a lengend's item is clicked.
    # > Enum('none', 'hide', 'mute')
    click_policy = NULL,
    # The line dash for the legend border outline.
    # > DashPattern
    border_line_dash = NULL,
    # The distance (in pixels) to separate the title from the legend.
    # > Int
    title_standoff = NULL,
    # The line width for the legend border outline.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    border_line_width = NULL,
    # The text font style values for the title text.
    # > Enum('normal', 'italic', 'bold', 'bold italic')
    title_text_font_style = NULL,
    # The text font values for the title text.
    # > String
    title_text_font = NULL,
    # The text line height for the legend labels.
    # > Float
    label_text_line_height = NULL,
    # The line join for the legend border outline.
    # > Enum('miter', 'round', 'bevel')
    border_line_join = NULL,
    # The line cap for the legend border outline.
    # > Enum('butt', 'round', 'square')
    border_line_cap = NULL,
    # A list of :class:`~bokeh.model.annotations.LegendItem` instances to be
    # rendered in the legend.
    # 
    # This can be specified explicitly, for instance:
    # 
    # .. code-block:: python
    # 
    # legend = Legend(items=[ LegendItem(label="sin(x)" , renderers=[r0,
    # r1]), LegendItem(label="2*sin(x)" , renderers=[r2]),
    # LegendItem(label="3*sin(x)" , renderers=[r3, r4]) ])
    # 
    # But as a convenience, can also be given more compactly as a list of
    # tuples:
    # 
    # .. code-block:: python
    # 
    # legend = Legend(items=[ ("sin(x)" , [r0, r1]), ("2*sin(x)" , [r2]),
    # ("3*sin(x)" , [r3, r4]) ])
    # 
    # where each tuple is of the form: *(label, renderers)*.
    # > List(Instance(LegendItem))
    items = NULL,
    # The minimum width (in pixels) of the area that legend labels should
    # occupy.
    # > Int
    label_width = NULL,
    # The width (in pixels) that the rendered legend glyph should occupy.
    # > Int
    glyph_width = NULL,
    # The height (in pixels) that the rendered legend glyph should occupy.
    # > Int
    glyph_height = NULL,
    # Amount of margin around the legend.
    # > Int
    margin = NULL,
    # The minimum height (in pixels) of the area that legend labels should
    # occupy.
    # > Int
    label_height = NULL,
    # Amount of padding around the contents of the legend. Only applicable
    # when when border is visible, otherwise collapses to 0.
    # > Int
    padding = NULL,
    # The title text to render.
    # > String
    title = NULL,
    # The text line height values for the title text.
    # > Float
    title_text_line_height = NULL,
    # The fill color for the legend background style.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    background_fill_color = NULL,
    # The text align for the legend labels.
    # > Enum('left', 'right', 'center')
    label_text_align = NULL,
    # The text font for the legend labels.
    # > String
    label_text_font = NULL,
    # Amount of spacing (in pixels) between legend entries.
    # > Int
    spacing = NULL,
    # The fill color for the legend item style when inactive. These control
    # an overlay on the item that can be used to obscure it when the
    # corresponding glyph is inactive (e.g. by making it semi-transparent).
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    inactive_fill_color = NULL,
    # The text baseline values for the title text.
    # > Enum('top', 'middle', 'bottom', 'alphabetic', 'hanging', 'ideographic')
    title_text_baseline = NULL,
    # The text alpha values for the title text.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    title_text_alpha = NULL,
    # The text font size values for the title text.
    # > FontSizeSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), FontSize)), FontSize)
    title_text_font_size = NULL,
    # The text align values for the title text.
    # > Enum('left', 'right', 'center')
    title_text_align = NULL,
    # Whether the legend entries should be placed vertically or horizontally
    # when they are drawn.
    # > Enum('horizontal', 'vertical')
    orientation = NULL,
    # The text color values for the title text.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    title_text_color = NULL,
    # The fill alpha for the legend background style.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    background_fill_alpha = NULL,
    # The distance (in pixels) to separate the label from its associated
    # glyph.
    # > Int
    label_standoff = NULL,
    # The text baseline for the legend labels.
    # > Enum('top', 'middle', 'bottom', 'alphabetic', 'hanging', 'ideographic')
    label_text_baseline = NULL,
    # The text font size for the legend labels.
    # > FontSizeSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), FontSize)), FontSize)
    label_text_font_size = NULL,
    # The line alpha for the legend border outline.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    border_line_alpha = NULL
  )
)

# A button tool to provide a "help" link to users.
# 
# The hover text can be customized through the ``help_tooltip`` attribute
# and the redirect site overridden as well.
HelpTool <- R6::R6Class("HelpTool",
  inherit = Action,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), js_property_callbacks = structure(list(), .Names =
      character(0)), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), help_tooltip = "Click the
      question mark to learn more about Bokeh plot tools.", name = NULL,
      redirect = "https://bokeh.pydata.org/en/latest/docs/user_guide/tools.html#built-in-tools",
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["HelpTool"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Tooltip displayed when hovering over the help icon.
    # > String
    help_tooltip = NULL,
    # Site to be redirected through upon click.
    # > String
    redirect = NULL
  )
)

# Render a single title box as an annotation.
Title <- R6::R6Class("Title",
  inherit = TextAnnotation,
  public = list(
    specified_args = NULL,
    initialize = function(
      level = "annotation", align = "left", background_fill_color = NULL,
      border_line_dash_offset = 0L, text = NULL, tags = list(),
      text_color = "#444444", vertical_align = "bottom", offset = 0L,
      render_mode = "canvas", visible = TRUE, subscribed_events = list(),
      name = NULL, border_line_dash = list(), text_font_size = list(value =
      "10pt"), text_font_style = "bold", text_font = "helvetica",
      border_line_width = 1L, js_property_callbacks = structure(list(),
      .Names = character(0)), background_fill_alpha = 1,
      border_line_join = "bevel", border_line_cap = "butt",
      js_event_callbacks = structure(list(), .Names = character(0)),
      text_alpha = 1, border_line_color = NULL, border_line_alpha = 1,
      id = NULL
    ) {
      super$initialize(level = level,
        js_property_callbacks = js_property_callbacks, tags = tags,
        visible = visible, render_mode = render_mode,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name, id = id)
      types <- bk_prop_types[["Title"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Alignment of the text in its enclosing space, *along* the direction of
    # the text.
    # > Enum('left', 'right', 'center')
    align = NULL,
    # The fill color values for the text bounding box.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    background_fill_color = NULL,
    # The line dash offset values for the text bounding box.
    # > Int
    border_line_dash_offset = NULL,
    # The text value to render.
    # > String
    text = NULL,
    # A color to use to fill text with.
    # 
    # Acceptable values are:
    # 
    # - any of the 147 named `CSS colors`_, e.g ``'green'``, ``'indigo'`` -
    # an RGB(A) hex value, e.g., ``'#FF0000'``, ``'#44444444'`` - a 3-tuple
    # of integers (r,g,b) between 0 and 255 - a 4-tuple of (r,g,b,a) where
    # r,g,b are integers between 0..255 and a is between 0..1
    # 
    # .. _CSS colors: http://www.w3schools.com/cssref/css_colornames.asp
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    text_color = NULL,
    # Alignment of the text in its enclosing space, *across* the direction of
    # the text.
    # > Enum('top', 'middle', 'bottom')
    vertical_align = NULL,
    # Offset the text by a number of pixels (can be positive or negative).
    # Shifts the text in different directions based on the location of the
    # title:
    # 
    # * above: shifts title right * right: shifts title down * below: shifts
    # title right * left: shifts title up
    # > Float
    offset = NULL,
    # The line dash values for the text bounding box.
    # > DashPattern
    border_line_dash = NULL,
    # 
    # > FontSizeSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), FontSize)), FontSize)
    text_font_size = NULL,
    # A style to use for rendering text.
    # 
    # Acceptable values are:
    # 
    # - ``'normal'`` normal text - ``'italic'`` *italic text* - ``'bold'``
    # **bold text**
    # > Enum('normal', 'italic', 'bold', 'bold italic')
    text_font_style = NULL,
    # Name of a font to use for rendering text, e.g., ``'times'``,
    # ``'helvetica'``.
    # > String
    text_font = NULL,
    # The line width values for the text bounding box.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    border_line_width = NULL,
    # The fill alpha values for the text bounding box.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    background_fill_alpha = NULL,
    # The line join values for the text bounding box.
    # > Enum('miter', 'round', 'bevel')
    border_line_join = NULL,
    # The line cap values for the text bounding box.
    # > Enum('butt', 'round', 'square')
    border_line_cap = NULL,
    # An alpha value to use to fill text with.
    # 
    # Acceptable values are floating point numbers between 0 (transparent)
    # and 1 (opaque).
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    text_alpha = NULL,
    # The line color values for the text bounding box.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    border_line_color = NULL,
    # The line alpha values for the text bounding box.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    border_line_alpha = NULL
  )
)

# Has the same default tile origin as the ``WMTSTileSource`` but
# requested tiles use a ``{XMIN}``, ``{YMIN}``, ``{XMAX}``, ``{YMAX}``
# e.g.
# ``http://your.custom.tile.service?bbox={XMIN},{YMIN},{XMAX},{YMAX}``.
BBoxTileSource <- R6::R6Class("BBoxTileSource",
  inherit = MercatorTileSource,
  public = list(
    specified_args = NULL,
    initialize = function(
      js_property_callbacks = structure(list(), .Names = character(0)),
      tile_size = 256L, extra_url_vars = structure(list(), .Names =
      character(0)), snap_to_zoom = FALSE, url = "",
      initial_resolution = 156543.033928041, x_origin_offset = 20037508.34,
      attribution = "", y_origin_offset = 20037508.34, max_zoom = 30L,
      use_latlon = FALSE, tags = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), name = NULL, min_zoom = 0L,
      wrap_around = TRUE, id = NULL
    ) {
      super$initialize(js_property_callbacks = js_property_callbacks,
        tile_size = tile_size, extra_url_vars = extra_url_vars,
        snap_to_zoom = snap_to_zoom, url = url,
        initial_resolution = initial_resolution,
        x_origin_offset = x_origin_offset, attribution = attribution,
        y_origin_offset = y_origin_offset, max_zoom = max_zoom, tags = tags,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name,
        min_zoom = min_zoom, wrap_around = wrap_around, id = id)
      types <- bk_prop_types[["BBoxTileSource"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Flag which indicates option to output ``{XMIN}``, ``{YMIN}``,
    # ``{XMAX}``, ``{YMAX}`` in meters or latitude and longitude.
    # > Bool
    use_latlon = NULL
  )
)

# Map numbers in a range [*low*, *high*] into a sequence of colors (a
# palette) on a natural logarithm scale.
# 
# For example, if the range is [0, 25] and the palette is ``['red',
# 'green', 'blue']``, the values would be mapped as follows::
# 
# x < 0 : 'red' # values < low are clamped 0 >= x < 2.72 : 'red' # math.e
# ** 1 2.72 >= x < 7.39 : 'green' # math.e ** 2 7.39 >= x < 20.09 :
# 'blue' # math.e ** 3 20.09 >= x : 'blue' # values > high are clamped
# 
# .. warning:: The ``LogColorMapper`` only works for images with scalar
# values that are non-negative.
LogColorMapper <- R6::R6Class("LogColorMapper",
  inherit = ContinuousColorMapper,
  public = list(
    specified_args = NULL,
    initialize = function(
      high = NULL, js_property_callbacks = structure(list(), .Names =
      character(0)), palette = NULL, tags = list(), low = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), low_color = NULL, name = NULL,
      high_color = NULL, nan_color = "gray", id = NULL
    ) {
      super$initialize(high = high,
        js_property_callbacks = js_property_callbacks, palette = palette,
        tags = tags, low = low, js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, low_color = low_color,
        name = name, high_color = high_color, nan_color = nan_color, id = id)
      types <- bk_prop_types[["LogColorMapper"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Render arcs.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/Arc.py
# :source-position: below
Arc <- R6::R6Class("Arc",
  inherit = XYGlyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      start_angle_units = "rad", x = NULL, start_angle = NULL, tags = list(),
      radius_units = "data", line_dash = list(), line_color = "black",
      name = NULL, line_alpha = 1, y = NULL, line_join = "bevel",
      js_property_callbacks = structure(list(), .Names = character(0)),
      radius = NULL, end_angle_units = "rad", line_dash_offset = 0L,
      direction = "anticlock", line_width = 1L, subscribed_events = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      end_angle = NULL, line_cap = "butt", id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Arc"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # 
    # > Enum('deg', 'rad')
    start_angle_units = NULL,
    # The x-coordinates of the center of the arcs.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x = NULL,
    # The angles to start the arcs, as measured from the horizontal.
    # > AngleSpec(units_default='rad')
    start_angle = NULL,
    # 
    # > Enum('screen', 'data')
    radius_units = NULL,
    # The line dash values for the arcs.
    # > DashPattern
    line_dash = NULL,
    # The line color values for the arcs.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The line alpha values for the arcs.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL,
    # The y-coordinates of the center of the arcs.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y = NULL,
    # The line join values for the arcs.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # Radius of the arc.
    # > DistanceSpec(units_default='data')
    radius = NULL,
    # 
    # > Enum('deg', 'rad')
    end_angle_units = NULL,
    # The line dash offset values for the arcs.
    # > Int
    line_dash_offset = NULL,
    # Which direction to stroke between the start and end angles.
    # > Enum('clock', 'anticlock')
    direction = NULL,
    # The line width values for the arcs.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL,
    # The angles to end the arcs, as measured from the horizontal.
    # > AngleSpec(units_default='rad')
    end_angle = NULL,
    # The line cap values for the arcs.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL
  )
)

# Render a single patch.
# 
# The ``Patch`` glyph is different from most other glyphs in that the
# vector of values only produces one glyph on the Plot.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/Patch.py
# :source-position: below
Patch <- R6::R6Class("Patch",
  inherit = XYGlyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      hatch_extra = structure(list(), .Names = character(0)), x = NULL,
      hatch_weight = 1, tags = list(), hatch_scale = 12, fill_alpha = 1,
      hatch_pattern = NULL, line_color = "black", line_dash = list(),
      name = NULL, fill_color = "gray", line_alpha = 1, y = NULL,
      js_property_callbacks = structure(list(), .Names = character(0)),
      hatch_color = "black", hatch_alpha = 1, line_dash_offset = 0L,
      js_event_callbacks = structure(list(), .Names = character(0)),
      line_join = "bevel", subscribed_events = list(), line_cap = "butt",
      line_width = 1L, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Patch"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The hatch extra values for the patch.
    # > Dict(String, Instance(Texture))
    hatch_extra = NULL,
    # The x-coordinates for the points of the patch.
    # 
    # .. note:: A patch may comprise multiple polygons. In this case the
    # x-coordinates for each polygon should be separated by NaN values in the
    # sequence.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x = NULL,
    # The hatch weight values for the patch.
    # > Size
    hatch_weight = NULL,
    # The hatch scale values for the patch.
    # > Size
    hatch_scale = NULL,
    # The fill alpha values for the patch.
    # > Percent
    fill_alpha = NULL,
    # The hatch pattern values for the patch.
    # > String
    hatch_pattern = NULL,
    # The line color values for the patch.
    # > Color
    line_color = NULL,
    # The line dash values for the patch.
    # > DashPattern
    line_dash = NULL,
    # The fill color values for the patch.
    # > Color
    fill_color = NULL,
    # The line alpha values for the patch.
    # > Percent
    line_alpha = NULL,
    # The y-coordinates for the points of the patch.
    # 
    # .. note:: A patch may comprise multiple polygons. In this case the
    # y-coordinates for each polygon should be separated by NaN values in the
    # sequence.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y = NULL,
    # The hatch color values for the patch.
    # > Color
    hatch_color = NULL,
    # The hatch alpha values for the patch.
    # > Percent
    hatch_alpha = NULL,
    # The line dash offset values for the patch.
    # > Int
    line_dash_offset = NULL,
    # The line join values for the patch.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # The line cap values for the patch.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line width values for the patch.
    # > Float
    line_width = NULL
  )
)

# Number cell formatter.
NumberFormatter <- R6::R6Class("NumberFormatter",
  inherit = StringFormatter,
  public = list(
    specified_args = NULL,
    initialize = function(
      language = "en", font_style = "normal",
      js_property_callbacks = structure(list(), .Names = character(0)),
      format = "0,0", rounding = "round", text_align = "left", tags = list(),
      text_color = NULL, js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), name = NULL, id = NULL
    ) {
      super$initialize(font_style = font_style,
        js_property_callbacks = js_property_callbacks,
        text_align = text_align, tags = tags, text_color = text_color,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name, id = id)
      types <- bk_prop_types[["NumberFormatter"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The language to use for formatting language-specific features (e.g.
    # thousands separator).
    # > Enum('be-nl', 'chs', 'cs', 'da-dk', 'de-ch', 'de', 'en', 'en-gb', 'es-ES', 'es', 'et', 'fi', 'fr-CA', 'fr-ch', 'fr', 'hu', 'it', 'ja', 'nl-nl', 'pl', 'pt-br', 'pt-pt', 'ru', 'ru-UA', 'sk', 'th', 'tr', 'uk-UA')
    language = NULL,
    # The number format, as defined in the following tables:
    # 
    # **NUMBERS**:
    # 
    # ============ ============== =============== Number Format String
    # ============ ============== =============== 10000 '0,0.0000'
    # 10,000.0000 10000.23 '0,0' 10,000 10000.23 '+0,0' +10,000 -10000
    # '0,0.0' -10,000.0 10000.1234 '0.000' 10000.123 10000.1234 '0[.]00000'
    # 10000.12340 -10000 '(0,0.0000)' (10,000.0000) -0.23 '.00' -.23 -0.23
    # '(.00)' (.23) 0.23 '0.00000' 0.23000 0.23 '0.0[0000]' 0.23 1230974
    # '0.0a' 1.2m 1460 '0 a' 1 k -104000 '0a' -104k 1 '0o' 1st 52 '0o' 52nd
    # 23 '0o' 23rd 100 '0o' 100th ============ ============== ===============
    # 
    # **CURRENCY**:
    # 
    # =========== =============== ============= Number Format String
    # =========== =============== ============= 1000.234 '$0,0.00' $1,000.23
    # 1000.2 '0,0[.]00 $' 1,000.20 $ 1001 '$ 0,0[.]00' $ 1,001 -1000.234
    # '($0,0)' ($1,000) -1000.234 '$0.00' -$1000.23 1230974 '($ 0.00 a)' $
    # 1.23 m =========== =============== =============
    # 
    # **BYTES**:
    # 
    # =============== =========== ============ Number Format String
    # =============== =========== ============ 100 '0b' 100B 2048 '0 b' 2 KB
    # 7884486213 '0.0b' 7.3GB 3467479682787 '0.000 b' 3.154 TB
    # =============== =========== ============
    # 
    # **PERCENTAGES**:
    # 
    # ============= ============= =========== Number Format String
    # ============= ============= =========== 1 '0%' 100% 0.974878234
    # '0.000%' 97.488% -0.43 '0 %' -43 % 0.43 '(0.000 %)' 43.000 %
    # ============= ============= ===========
    # 
    # **TIME**:
    # 
    # ============ ============== ============ Number Format String
    # ============ ============== ============ 25 '00:00:00' 0:00:25 238
    # '00:00:00' 0:03:58 63846 '00:00:00' 17:44:06 ============
    # ============== ============
    # 
    # For the complete specification, see http://numbrojs.com/format.html
    # > String
    format = NULL,
    # Rounding functions (round, floor, ceil) and their synonyms (nearest,
    # rounddown, roundup).
    # > Enum('round', 'nearest', 'floor', 'rounddown', 'ceil', 'roundup')
    rounding = NULL
  )
)

# Map categorical factors to hatch fill patterns.
# 
# Values that are passed to this mapper that are not in the factors list
# will be mapped to ``default_value``.
# 
# Added in version 1.1.1
CategoricalPatternMapper <- R6::R6Class("CategoricalPatternMapper",
  inherit = CategoricalMapper,
  public = list(
    specified_args = NULL,
    initialize = function(
      factors = NULL, end = NULL, patterns = NULL, start = 0L,
      js_property_callbacks = structure(list(), .Names = character(0)),
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), name = NULL,
      default_value = " ", id = NULL
    ) {
      super$initialize(factors = factors, end = end, start = start,
        js_property_callbacks = js_property_callbacks, tags = tags,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name, id = id)
      types <- bk_prop_types[["CategoricalPatternMapper"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A sequence of marker types to use as the target for mapping.
    # > Seq(HatchPatternType)
    patterns = NULL,
    # A hatch pattern to use in case an unrecognized factor is passed in to
    # be mapped.
    # > HatchPatternType
    default_value = NULL
  )
)

# Render a vertically directed area between two equal length sequences of
# y-coordinates with the same x-coordinates.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/VArea.py
# :source-position: below
VArea <- R6::R6Class("VArea",
  inherit = Glyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      y2 = NULL, js_property_callbacks = structure(list(), .Names =
      character(0)), hatch_extra = structure(list(), .Names =
      character(0)), x = NULL, hatch_weight = 1, hatch_color = "black",
      hatch_alpha = 1, tags = list(), js_event_callbacks = structure(list(),
      .Names = character(0)), hatch_scale = 12, hatch_pattern = NULL,
      y1 = NULL, subscribed_events = list(), name = NULL, fill_alpha = 1,
      fill_color = "gray", id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["VArea"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The y-coordinates for the points of the other side of the area.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y2 = NULL,
    # The hatch extra values for the horizontal bars.
    # > Dict(String, Instance(Texture))
    hatch_extra = NULL,
    # The x-coordinates for the points of the area.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x = NULL,
    # The hatch weight values for the horizontal bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    hatch_weight = NULL,
    # The hatch color values for the horizontal bars.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    hatch_color = NULL,
    # The hatch alpha values for the horizontal bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    hatch_alpha = NULL,
    # The hatch scale values for the horizontal bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    hatch_scale = NULL,
    # The hatch pattern values for the horizontal bars.
    # > HatchPatternSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), HatchPatternType)), HatchPatternType)
    hatch_pattern = NULL,
    # The y-coordinates for the points of one side of the area.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y1 = NULL,
    # The fill alpha values for the patch.
    # > Percent
    fill_alpha = NULL,
    # The fill color values for the patch.
    # > Color
    fill_color = NULL
  )
)

# A group of radio boxes rendered as toggle buttons.
RadioButtonGroup <- R6::R6Class("RadioButtonGroup",
  inherit = ButtonGroup,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", disabled = FALSE,
      callback = NULL, background = NULL, button_type = "default",
      tags = list(), visible = TRUE, width_policy = "auto",
      height_policy = "auto", height = NULL, name = NULL, sizing_mode = NULL,
      labels = list(), default_size = 300L, max_height = NULL,
      css_classes = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), orientation = "horizontal", active = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      min_height = NULL, subscribed_events = list(), width = NULL,
      aspect_ratio = NULL, margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, callback = callback,
        background = background, button_type = button_type, tags = tags,
        visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, name = name,
        sizing_mode = sizing_mode, labels = labels,
        default_size = default_size, max_height = max_height,
        css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["RadioButtonGroup"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The index of the selected radio box, or ``None`` if nothing is
    # selected.
    # > Int
    active = NULL
  )
)

# Render diamond markers with a '+' cross through the center.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/DiamondCross.py
# :source-position: below
DiamondCross <- R6::R6Class("DiamondCross",
  inherit = Marker,
  public = list(
    specified_args = NULL,
    initialize = function(
      y = NULL, size = 4L, line_join = "bevel",
      js_property_callbacks = structure(list(), .Names = character(0)),
      angle_units = "rad", name = NULL, x = NULL, fill_color = "gray",
      line_dash = list(), tags = list(), angle = 0, line_dash_offset = 0L,
      js_event_callbacks = structure(list(), .Names = character(0)),
      fill_alpha = 1, subscribed_events = list(), line_color = "black",
      line_width = 1L, line_cap = "butt", line_alpha = 1, id = NULL
    ) {
      super$initialize(y = y, size = size, line_join = line_join,
        js_property_callbacks = js_property_callbacks,
        angle_units = angle_units, name = name, x = x, fill_color = fill_color,
        line_dash = line_dash, tags = tags, angle = angle,
        line_dash_offset = line_dash_offset,
        js_event_callbacks = js_event_callbacks, fill_alpha = fill_alpha,
        subscribed_events = subscribed_events, line_color = line_color,
        line_width = line_width, line_cap = line_cap,
        line_alpha = line_alpha, id = id)
      types <- bk_prop_types[["DiamondCross"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Multi-line input widget.
TextAreaInput <- R6::R6Class("TextAreaInput",
  inherit = TextInput,
  public = list(
    specified_args = NULL,
    initialize = function(
      title = "", min_width = NULL, max_width = NULL, align = "start",
      disabled = FALSE, value = "", callback = NULL, background = NULL,
      tags = list(), value_input = "", visible = TRUE, width_policy = "auto",
      height_policy = "auto", height = NULL, name = NULL, sizing_mode = NULL,
      max_length = 500L, default_size = 300L, cols = 20L, max_height = NULL,
      placeholder = "", css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      rows = 2L, orientation = "horizontal",
      js_event_callbacks = structure(list(), .Names = character(0)),
      min_height = NULL, subscribed_events = list(), width = NULL,
      aspect_ratio = NULL, margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(title = title, min_width = min_width,
        max_width = max_width, align = align, disabled = disabled,
        value = value, callback = callback, background = background,
        tags = tags, value_input = value_input, visible = visible,
        width_policy = width_policy, height_policy = height_policy,
        height = height, name = name, sizing_mode = sizing_mode,
        default_size = default_size, max_height = max_height,
        placeholder = placeholder, css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["TextAreaInput"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Max count of characters in field
    # > Int
    max_length = NULL,
    # Specifies the width of the text area (in average character width).
    # Default: 20
    # > Int
    cols = NULL,
    # Specifies the height of the text area (in lines). Default: 2
    # > Int
    rows = NULL
  )
)

# Color picker widget
# 
# .. warning:: This widget as a limited support on *Internet Explorer*
# (it will be displayed as a simple text input).
ColorPicker <- R6::R6Class("ColorPicker",
  inherit = InputWidget,
  public = list(
    specified_args = NULL,
    initialize = function(
      title = "", min_width = NULL, max_width = NULL, align = "start",
      disabled = FALSE, callback = NULL, background = NULL, tags = list(),
      visible = TRUE, width_policy = "auto", color = "#000000",
      height_policy = "auto", height = NULL, name = NULL, sizing_mode = NULL,
      default_size = 300L, max_height = NULL, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      orientation = "horizontal", js_event_callbacks = structure(list(),
      .Names = character(0)), min_height = NULL,
      subscribed_events = list(), width = NULL, aspect_ratio = NULL,
      margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(title = title, min_width = min_width,
        max_width = max_width, align = align, disabled = disabled,
        background = background, tags = tags, visible = visible,
        width_policy = width_policy, height_policy = height_policy,
        height = height, name = name, sizing_mode = sizing_mode,
        default_size = default_size, max_height = max_height,
        css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["ColorPicker"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A callback to run in the browser whenever the current date value
    # changes.
    # > Instance(Callback)
    callback = NULL,
    # The initial color of the picked color (named or hexadecimal)
    # > ColorHex
    color = NULL
  )
)

# Map categorical factors to colors.
# 
# Values that are passed to this mapper that are not in the factors list
# will be mapped to ``nan_color``.
CategoricalColorMapper <- R6::R6Class("CategoricalColorMapper",
  inherit = CategoricalMapper,
  public = list(
    specified_args = NULL,
    initialize = function(
      factors = NULL, end = NULL, start = 0L,
      js_property_callbacks = structure(list(), .Names = character(0)),
      palette = NULL, tags = list(), js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(), name = NULL,
      nan_color = "gray", id = NULL
    ) {
      super$initialize(factors = factors, end = end, start = start,
        js_property_callbacks = js_property_callbacks, tags = tags,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name, id = id)
      types <- bk_prop_types[["CategoricalColorMapper"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A sequence of colors to use as the target palette for mapping.
    # 
    # This property can also be set as a ``String``, to the name of any of
    # the palettes shown in :ref:`bokeh.palettes`.
    # > Seq(Color)
    palette = NULL,
    # Color to be used if data is NaN or otherwise not mappable. (Default:
    # 'gray')
    # > Color
    nan_color = NULL
  )
)

# Base class for continuous color mapper types.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
ContinuousColorMapper <- R6::R6Class("ContinuousColorMapper",
  inherit = ColorMapper,
  public = list(
    specified_args = NULL,
    initialize = function(
      high = NULL, js_property_callbacks = structure(list(), .Names =
      character(0)), palette = NULL, tags = list(), low = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), low_color = NULL, name = NULL,
      high_color = NULL, nan_color = "gray", id = NULL
    ) {
      super$initialize(tags = tags, nan_color = nan_color,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name,
        palette = palette, id = id)
      types <- bk_prop_types[["ContinuousColorMapper"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The maximum value of the range to map into the palette. Values above
    # this are clamped to ``high``.
    # > Float
    high = NULL,
    # The minimum value of the range to map into the palette. Values below
    # this are clamped to ``low``.
    # > Float
    low = NULL,
    # Color to be used if data is lower than ``low`` value. If None, values
    # lower than ``low`` are mapped to the first color in the palette.
    # > Color
    low_color = NULL,
    # Color to be used if data is higher than ``high`` value. If None, values
    # higher than ``high`` are mapped to the last color in the palette.
    # > Color
    high_color = NULL
  )
)

# Display horizontal or vertical grid lines at locations given by a
# supplied ``Ticker``.
Grid <- R6::R6Class("Grid",
  inherit = GuideRenderer,
  public = list(
    specified_args = NULL,
    initialize = function(
      level = "underlay", band_hatch_pattern = NULL, band_fill_color = NULL,
      band_fill_alpha = 0L, minor_grid_line_dash_offset = 0L,
      grid_line_join = "bevel", grid_line_color = "#e5e5e5",
      band_hatch_alpha = 1, band_hatch_weight = 1,
      minor_grid_line_dash = list(), visible = TRUE, tags = list(),
      minor_grid_line_join = "bevel", dimension = 0L, name = NULL,
      minor_grid_line_color = NULL, bounds = "auto",
      minor_grid_line_width = 1L, band_hatch_scale = 12,
      band_hatch_extra = structure(list(), .Names = character(0)),
      x_range_name = "default", y_range_name = "default",
      js_property_callbacks = structure(list(), .Names = character(0)),
      grid_line_dash = list(), grid_line_cap = "butt", grid_line_width = 1L,
      grid_line_dash_offset = 0L, ticker = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), minor_grid_line_alpha = 1,
      grid_line_alpha = 1, band_hatch_color = "black",
      minor_grid_line_cap = "butt", id = NULL
    ) {
      super$initialize(level = level, tags = tags, visible = visible,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["Grid"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The hatch pattern of alternating bands between Grid lines.
    # > String
    band_hatch_pattern = NULL,
    # The fill color of alternating bands between Grid lines.
    # > Color
    band_fill_color = NULL,
    # The fill alpha of alternating bands between Grid lines.
    # > Percent
    band_fill_alpha = NULL,
    # The line dash offset of the minor Grid lines.
    # > Int
    minor_grid_line_dash_offset = NULL,
    # The line join of the Grid lines.
    # > Enum('miter', 'round', 'bevel')
    grid_line_join = NULL,
    # The line color of the Grid lines.
    # > Color
    grid_line_color = NULL,
    # The hatch alpha of alternating bands between Grid lines.
    # > Percent
    band_hatch_alpha = NULL,
    # The hatch weight of alternating bands between Grid lines.
    # > Size
    band_hatch_weight = NULL,
    # The line dash of the minor Grid lines.
    # > DashPattern
    minor_grid_line_dash = NULL,
    # The line join of the minor Grid lines.
    # > Enum('miter', 'round', 'bevel')
    minor_grid_line_join = NULL,
    # Which dimension the Axis Grid lines will intersect. The x-axis is
    # dimension 0 (vertical Grid lines) and the y-axis is dimension 1
    # (horizontal Grid lines).
    # > Int
    dimension = NULL,
    # The line color of the minor Grid lines.
    # > Color
    minor_grid_line_color = NULL,
    # Bounds for the rendered grid lines. By default, a grid will look for a
    # corresponding axis to ask for bounds. If one cannot be found, the grid
    # will span the entire visible range.
    # > Either(Auto, Tuple(Float, Float))
    bounds = NULL,
    # The line width of the minor Grid lines.
    # > Float
    minor_grid_line_width = NULL,
    # The hatch scale of alternating bands between Grid lines.
    # > Size
    band_hatch_scale = NULL,
    # The hatch extra of alternating bands between Grid lines.
    # > Dict(String, Instance(Texture))
    band_hatch_extra = NULL,
    # A particular (named) x-range to use for computing screen locations when
    # rendering a grid on the plot. If unset, use the default x-range.
    # > String
    x_range_name = NULL,
    # A particular (named) y-range to use for computing screen locations when
    # rendering a grid on the plot. If unset, use the default y-range.
    # > String
    y_range_name = NULL,
    # The line dash of the Grid lines.
    # > DashPattern
    grid_line_dash = NULL,
    # The line cap of the Grid lines.
    # > Enum('butt', 'round', 'square')
    grid_line_cap = NULL,
    # The line width of the Grid lines.
    # > Float
    grid_line_width = NULL,
    # The line dash offset of the Grid lines.
    # > Int
    grid_line_dash_offset = NULL,
    # The Ticker to use for computing locations for the Grid lines.
    # > Instance(Ticker)
    ticker = NULL,
    # The line alpha of the minor Grid lines.
    # > Percent
    minor_grid_line_alpha = NULL,
    # The line alpha of the Grid lines.
    # > Percent
    grid_line_alpha = NULL,
    # The hatch color of alternating bands between Grid lines.
    # > Color
    band_hatch_color = NULL,
    # The line cap of the minor Grid lines.
    # > Enum('butt', 'round', 'square')
    minor_grid_line_cap = NULL
  )
)

# Render step lines.
# 
# Step levels can be draw before, after, or centered on each point,
# according to the value of the ``mode`` property.
# 
# The x-coordinates are assumed to be (and must be) sorted in ascending
# order for steps to be properly rendered.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/Step.py
# :source-position: below
Step <- R6::R6Class("Step",
  inherit = XYGlyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      y = NULL, line_join = "bevel",
      js_property_callbacks = structure(list(), .Names = character(0)),
      mode = "before", name = NULL, x = NULL, line_dash = list(), tags = list(),
      line_dash_offset = 0L, js_event_callbacks = structure(list(), .Names
      = character(0)), line_width = 1L, subscribed_events = list(),
      line_color = "black", line_cap = "butt", line_alpha = 1, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Step"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The y-coordinates for the steps.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y = NULL,
    # The line join values for the steps.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # Where the step "level" should be drawn in relation to the x and y
    # coordinates. The parameter can assume one of three values:
    # 
    # * ``before``: (default) Draw step levels before each x-coordinate (no
    # step before the first point) * ``after``: Draw step levels after each
    # x-coordinate (no step after the last point) * ``center``: Draw step
    # levels centered on each x-coordinate
    # > Enum('before', 'after', 'center')
    mode = NULL,
    # The x-coordinates for the steps.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x = NULL,
    # The line dash values for the steps.
    # > DashPattern
    line_dash = NULL,
    # The line dash offset values for the steps.
    # > Int
    line_dash_offset = NULL,
    # The line width values for the steps.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL,
    # The line color values for the steps.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The line cap values for the steps.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line alpha values for the steps.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL
  )
)

# A single-widget container with title bar and controls.
Panel <- R6::R6Class("Panel",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      title = "", js_property_callbacks = structure(list(), .Names =
      character(0)), closable = FALSE, tags = list(), child = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Panel"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The text title of the panel.
    # > String
    title = NULL,
    # Whether this panel is closable or not. If True, an "x" button will
    # appear.
    # 
    # Closing a panel is equivalent to removing it from its parent container
    # (e.g. tabs).
    # > Bool
    closable = NULL,
    # The child widget. If you need more children, use a layout widget, e.g.
    # a ``Column``.
    # > Instance(LayoutDOM)
    child = NULL
  )
)

# Base class for glyphs that are simple markers with line and fill
# properties, located at an (x, y) location with a specified size.
# 
# .. note:: For simplicity, all markers have both line and fill
# properties declared, however some markers (`Asterisk`, `Cross`, `X`)
# only draw lines. For these markers, the fill values are simply ignored.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
Marker <- R6::R6Class("Marker",
  inherit = XYGlyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      y = NULL, size = 4L, line_join = "bevel",
      js_property_callbacks = structure(list(), .Names = character(0)),
      angle_units = "rad", name = NULL, x = NULL, fill_color = "gray",
      line_dash = list(), tags = list(), angle = 0, line_dash_offset = 0L,
      js_event_callbacks = structure(list(), .Names = character(0)),
      fill_alpha = 1, subscribed_events = list(), line_color = "black",
      line_width = 1L, line_cap = "butt", line_alpha = 1, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Marker"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The y-axis coordinates for the center of the markers.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y = NULL,
    # The size (diameter) values for the markers in screen space units.
    # > ScreenDistanceSpec(units_default='screen')
    size = NULL,
    # The line join values for the markers.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # 
    # > Enum('deg', 'rad')
    angle_units = NULL,
    # The x-axis coordinates for the center of the markers.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x = NULL,
    # The fill color values for the markers.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    fill_color = NULL,
    # The line dash values for the markers.
    # > DashPattern
    line_dash = NULL,
    # The angles to rotate the markers.
    # > AngleSpec(units_default='rad')
    angle = NULL,
    # The line dash offset values for the markers.
    # > Int
    line_dash_offset = NULL,
    # The fill alpha values for the markers.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    fill_alpha = NULL,
    # The line color values for the markers.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The line width values for the markers.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL,
    # The line cap values for the markers.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line alpha values for the markers.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL
  )
)

# A ``GroupFilter`` represents the rows of a ``ColumnDataSource`` where
# the values of the categorical column column_name match the group
# variable.
GroupFilter <- R6::R6Class("GroupFilter",
  inherit = Filter,
  public = list(
    specified_args = NULL,
    initialize = function(
      filter = NULL, group = NULL, column_name = NULL,
      js_property_callbacks = structure(list(), .Names = character(0)),
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), name = NULL, id = NULL
    ) {
      super$initialize(filter = filter, tags = tags,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["GroupFilter"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The value of the column indicating the rows of data to keep.
    # > String
    group = NULL,
    # The name of the column to perform the group filtering operation on.
    # > String
    column_name = NULL
  )
)

# 
GlyphRenderer <- R6::R6Class("GlyphRenderer",
  inherit = DataRenderer,
  public = list(
    specified_args = NULL,
    initialize = function(
      data_source = NULL, muted = FALSE, level = "glyph", hover_glyph = NULL,
      js_property_callbacks = structure(list(), .Names = character(0)),
      x_range_name = "default", view = NULL, glyph = NULL,
      y_range_name = "default", name = NULL, tags = list(), visible = TRUE,
      muted_glyph = NULL, js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(),
      nonselection_glyph = "auto", selection_glyph = "auto", id = NULL
    ) {
      super$initialize(level = level,
        js_property_callbacks = js_property_callbacks,
        x_range_name = x_range_name, y_range_name = y_range_name,
        tags = tags, visible = visible,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name, id = id)
      types <- bk_prop_types[["GlyphRenderer"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Local data source to use when rendering glyphs on the plot.
    # > Instance(DataSource)
    data_source = NULL,
    # 
    # > Bool
    muted = NULL,
    # An optional glyph used for inspected points, e.g., those that are being
    # hovered over by a ``HoverTool``.
    # > Instance(Glyph)
    hover_glyph = NULL,
    # A view into the data source to use when rendering glyphs. A default
    # view of the entire data source is created when a view is not passed in
    # during initialization.
    # > Instance(CDSView)
    view = NULL,
    # The glyph to render, in conjunction with the supplied data source and
    # ranges.
    # > Instance(Glyph)
    glyph = NULL,
    # 
    # > Instance(Glyph)
    muted_glyph = NULL,
    # An optional glyph used for explicitly non-selected points (i.e.,
    # non-selected when there are other points that are selected, but not
    # when no points at all are selected.)
    # 
    # If set to "auto" then a glyph with a low alpha value (0.1) will be used
    # for non-selected points.
    # > Either(Auto, Instance(Glyph))
    nonselection_glyph = NULL,
    # An optional glyph used for selected points.
    # 
    # If set to "auto" then the standard glyph will be used for selected
    # points.
    # > Either(Auto, Instance(Glyph))
    selection_glyph = NULL
  )
)

# A view into a ``ColumnDataSource`` that represents a row-wise subset.
CDSView <- R6::R6Class("CDSView",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, source = NULL, filters = list(), id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["CDSView"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The ``ColumnDataSource`` associated with this view. Used to determine
    # the length of the columns.
    # > Instance(ColumnarDataSource)
    source = NULL,
    # List of filters that the view comprises.
    # > List(Instance(Filter))
    filters = NULL
  )
)

# *toolbar icon*: |tap_icon|
# 
# The tap selection tool allows the user to select at single points by
# left-clicking a mouse, or tapping with a finger.
# 
# See :ref:`userguide_styling_selected_unselected_glyphs` for information
# on styling selected and unselected glyphs.
# 
# .. |tap_icon| image:: /_images/icons/Tap.png :height: 18pt
# 
# .. note:: Selections can be comprised of multiple regions, even those
# made by different selection tools. Hold down the <<shift>> key while
# making a selection to append the new selection to any previous
# selection that might exist.
TapTool <- R6::R6Class("TapTool",
  inherit = Tap,
  public = list(
    specified_args = NULL,
    initialize = function(
      behavior = "select", js_property_callbacks = structure(list(), .Names
      = character(0)), callback = NULL, tags = list(), renderers = "auto",
      names = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["TapTool"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # This tool can be configured to either make selections or inspections on
    # associated data sources. The difference is that selection changes
    # propagate across bokeh and other components (e.g. selection glyph) will
    # be notified. Inspections don't act like this, so it's useful to
    # configure `callback` when setting `behavior='inspect'`.
    # > Enum('select', 'inspect')
    behavior = NULL,
    # A callback to execute *whenever a glyph is "hit"* by a mouse click or
    # tap.
    # 
    # This is often useful with the :class:`~bokeh.models.callbacks.OpenURL`
    # model to open URLs based on a user clicking or tapping a specific
    # glyph.
    # 
    # However, it may also be a :class:`~bokeh.models.callbacks.CustomJS`
    # which can execute arbitrary JavaScript code in response to clicking or
    # tapping glyphs. The callback will be executed for each individual glyph
    # that is it hit by a click or tap, and will receive the ``TapTool``
    # model as ``cb_obj``. The optional ``cb_data`` will have the data source
    # as its ``.source`` attribute and the selection geometry as its
    # ``.geometries`` attribute.
    # 
    # The ``.geometries`` attribute has 5 members.  ``.type`` is the geometry
    # type, which always a ``.point`` for a tap event.  ``.sx`` and ``.sy``
    # are the screen X and Y coordinates where the tap occurred.  ``.x`` and
    # ``.y`` are the converted data coordinates for the item that has been
    # selected. The ``.x`` and ``.y`` values are based on the axis assigned
    # to that glyph.
    # 
    # .. note:: This callback does *not* execute on every tap, only when a
    # glyph is "hit". If you would like to execute a callback on every mouse
    # tap, please see
    # :ref:`userguide_interaction_jscallbacks_customjs_interactions`.
    # > Instance(Callback)
    callback = NULL,
    # An explicit list of renderers to hit test against. If unset, defaults
    # to all renderers on a plot.
    # > Either(Auto, List(Instance(Renderer)))
    renderers = NULL,
    # A list of names to query for. If set, only renderers that have a
    # matching value for their ``name`` attribute will be used.
    # > List(String)
    names = NULL
  )
)

# Base class for all glyph models.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
Glyph <- R6::R6Class("Glyph",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Glyph"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Render a horizontal or vertical line span.
Span <- R6::R6Class("Span",
  inherit = Annotation,
  public = list(
    specified_args = NULL,
    initialize = function(
      level = "annotation", location = NULL, line_join = "bevel",
      x_range_name = "default", js_property_callbacks = structure(list(),
      .Names = character(0)), y_range_name = "default",
      location_units = "data", name = NULL, line_dash = list(), tags = list(),
      line_dash_offset = 0L, render_mode = "canvas", visible = TRUE,
      line_width = 1L, subscribed_events = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      dimension = "width", line_color = "black", line_cap = "butt",
      line_alpha = 1, id = NULL
    ) {
      super$initialize(level = level, tags = tags, visible = visible,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["Span"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The location of the span, along ``dimension``.
    # 
    # Datetime values are also accepted, but note that they are immediately
    # converted to milliseconds-since-epoch.
    # > Float
    location = NULL,
    # The line join values for the span.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # A particular (named) x-range to use for computing screen locations when
    # rendering annotations on the plot. If unset, use the default x-range.
    # > String
    x_range_name = NULL,
    # A particular (named) y-range to use for computing screen locations when
    # rendering annotations on the plot. If unset, use the default y-range.
    # > String
    y_range_name = NULL,
    # The unit type for the location attribute. Interpreted as "data space"
    # units by default.
    # > Enum('screen', 'data')
    location_units = NULL,
    # The line dash values for the span.
    # > DashPattern
    line_dash = NULL,
    # The line dash offset values for the span.
    # > Int
    line_dash_offset = NULL,
    # Specifies whether the span is rendered as a canvas element or as a CSS
    # element overlaid on the canvas. The default mode is "canvas".
    # 
    # .. warning:: The line_dash and line_dash_offset attributes aren't
    # supported if the render_mode is set to "css"
    # > Enum('canvas', 'css')
    render_mode = NULL,
    # The line width values for the span.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL,
    # The direction of the span can be specified by setting this property to
    # "height" (``y`` direction) or "width" (``x`` direction).
    # > Enum('width', 'height')
    dimension = NULL,
    # The line color values for the span.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The line cap values for the span.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line alpha values for the span.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL
  )
)

# Tick formatter based on a human-readable format string.
NumeralTickFormatter <- R6::R6Class("NumeralTickFormatter",
  inherit = TickFormatter,
  public = list(
    specified_args = NULL,
    initialize = function(
      language = "en", js_property_callbacks = structure(list(), .Names =
      character(0)), format = "0,0", rounding = "round", tags = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["NumeralTickFormatter"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The language to use for formatting language-specific features (e.g.
    # thousands separator).
    # > Enum('be-nl', 'chs', 'cs', 'da-dk', 'de-ch', 'de', 'en', 'en-gb', 'es-ES', 'es', 'et', 'fi', 'fr-CA', 'fr-ch', 'fr', 'hu', 'it', 'ja', 'nl-nl', 'pl', 'pt-br', 'pt-pt', 'ru', 'ru-UA', 'sk', 'th', 'tr', 'uk-UA')
    language = NULL,
    # The number format, as defined in the following tables:
    # 
    # **NUMBERS**:
    # 
    # ============ ============== =============== Number Format String
    # ============ ============== =============== 10000 '0,0.0000'
    # 10,000.0000 10000.23 '0,0' 10,000 10000.23 '+0,0' +10,000 -10000
    # '0,0.0' -10,000.0 10000.1234 '0.000' 10000.123 10000.1234 '0[.]00000'
    # 10000.12340 -10000 '(0,0.0000)' (10,000.0000) -0.23 '.00' -.23 -0.23
    # '(.00)' (.23) 0.23 '0.00000' 0.23000 0.23 '0.0[0000]' 0.23 1230974
    # '0.0a' 1.2m 1460 '0 a' 1 k -104000 '0a' -104k 1 '0o' 1st 52 '0o' 52nd
    # 23 '0o' 23rd 100 '0o' 100th ============ ============== ===============
    # 
    # **CURRENCY**:
    # 
    # =========== =============== ============= Number Format String
    # =========== =============== ============= 1000.234 '$0,0.00' $1,000.23
    # 1000.2 '0,0[.]00 $' 1,000.20 $ 1001 '$ 0,0[.]00' $ 1,001 -1000.234
    # '($0,0)' ($1,000) -1000.234 '$0.00' -$1000.23 1230974 '($ 0.00 a)' $
    # 1.23 m =========== =============== =============
    # 
    # **BYTES**:
    # 
    # =============== =========== ============ Number Format String
    # =============== =========== ============ 100 '0b' 100B 2048 '0 b' 2 KB
    # 7884486213 '0.0b' 7.3GB 3467479682787 '0.000 b' 3.154 TB
    # =============== =========== ============
    # 
    # **PERCENTAGES**:
    # 
    # ============= ============= =========== Number Format String
    # ============= ============= =========== 1 '0%' 100% 0.974878234
    # '0.000%' 97.488% -0.43 '0 %' -43 % 0.43 '(0.000 %)' 43.000 %
    # ============= ============= ===========
    # 
    # **TIME**:
    # 
    # ============ ============== ============ Number Format String
    # ============ ============== ============ 25 '00:00:00' 0:00:25 238
    # '00:00:00' 0:03:58 63846 '00:00:00' 17:44:06 ============
    # ============== ============
    # 
    # For the complete specification, see http://numbrojs.com/format.html
    # > String
    format = NULL,
    # Rounding functions (round, floor, ceil) and their synonyms (nearest,
    # rounddown, roundup).
    # > Enum('round', 'nearest', 'floor', 'rounddown', 'ceil', 'roundup')
    rounding = NULL
  )
)

# Compute a linear interpolation between the control points provided
# through the ``x``, ``y``, and ``data`` parameters.
LinearInterpolator <- R6::R6Class("LinearInterpolator",
  inherit = Interpolator,
  public = list(
    specified_args = NULL,
    initialize = function(
      y = NULL, js_property_callbacks = structure(list(), .Names =
      character(0)), data = NULL, x = NULL, clip = TRUE, tags = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), name = NULL, id = NULL
    ) {
      super$initialize(y = y,
        js_property_callbacks = js_property_callbacks, data = data, x = x,
        clip = clip, tags = tags, js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name, id = id)
      types <- bk_prop_types[["LinearInterpolator"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Define a custom formatter to apply to a hover tool field.
# 
# This model can be configured with JavaScript code to format hover
# tooltips.  The JavaScript code has access to the current value to
# format, some special variables, and any format configured on the
# tooltip. The variable ``value`` will contain the untransformed value.
# The variable ``special_vars`` will provide a dict with the following
# contents:
# 
# * ``x`` data-space x-coordinate of the mouse * ``y`` data-space
# y-coordinate of the mouse * ``sx`` screen-space x-coordinate of the
# mouse * ``sy`` screen-space y-coordinate of the mouse * ``data_x``
# data-space x-coordinate of the hovered glyph * ``data_y`` data-space
# y-coordinate of the hovered glyph * ``indices`` column indices of all
# currently hovered glyphs * ``name`` value of the ``name`` property of
# the hovered glyph renderer
# 
# If the hover is over a "multi" glyph such as ``Patches`` or
# ``MultiLine`` then a ``segment_index`` key will also be present.
# 
# Finally, the value of the format passed in the tooltip specification is
# available as the ``format`` variable.
# 
# Example:
# 
# As an example, the following code adds a custom formatter to format
# WebMercator northing coordinates (in meters) as a latitude:
# 
# .. code-block:: python
# 
# lat_custom = CustomJSHover(code=""" var projections =
# require("core/util/projections"); var x = special_vars.x var y =
# special_vars.y var coords = projections.wgs84_mercator.inverse([x, y])
# return "" + coords[1] """)
# 
# p.add_tools(HoverTool( tooltips=[( 'lat','@y{custom}' )],
# formatters=dict(y=lat_custom) ))
# 
# .. warning:: The explicit purpose of this Bokeh Model is to embed *raw
# JavaScript code* for a browser to execute. If any part of the code is
# derived from untrusted user inputs, then you must take appropriate care
# to sanitize the user input prior to passing to Bokeh.
CustomJSHover <- R6::R6Class("CustomJSHover",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, code = "", args = structure(list(), .Names =
      character(0)), id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["CustomJSHover"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A snippet of JavaScript code to transform a single value. The variable
    # ``value`` will contain the untransformed value and can be expected to
    # be present in the function namespace at render time. Additionally, the
    # variable ``special_vars`` will be available, and will provide a dict
    # with the following contents:
    # 
    # * ``x`` data-space x-coordinate of the mouse * ``y`` data-space
    # y-coordinate of the mouse * ``sx`` screen-space x-coordinate of the
    # mouse * ``sy`` screen-space y-coordinate of the mouse * ``data_x``
    # data-space x-coordinate of the hovered glyph * ``data_y`` data-space
    # y-coordinate of the hovered glyph * ``indices`` column indices of all
    # currently hovered glyphs
    # 
    # If the hover is over a "multi" glyph such as ``Patches`` or
    # ``MultiLine`` then a ``segment_index`` key will also be present.
    # 
    # Finally, the value of the format passed in the tooltip specification is
    # available as the ``format`` variable.
    # 
    # The snippet will be made into the body of a function and therefore
    # requires a return statement.
    # 
    # Example:
    # 
    # .. code-block:: javascript
    # 
    # code = ''' return value + " total" '''
    # > String
    code = NULL,
    # A mapping of names to Bokeh plot objects. These objects are made
    # available to the callback code snippet as the values of named
    # parameters to the callback.
    # > Dict(String, Instance(Model))
    args = NULL
  )
)

# Render '+' cross markers.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/Cross.py
# :source-position: below
Cross <- R6::R6Class("Cross",
  inherit = Marker,
  public = list(
    specified_args = NULL,
    initialize = function(
      y = NULL, size = 4L, line_join = "bevel",
      js_property_callbacks = structure(list(), .Names = character(0)),
      angle_units = "rad", name = NULL, x = NULL, fill_color = "gray",
      line_dash = list(), tags = list(), angle = 0, line_dash_offset = 0L,
      js_event_callbacks = structure(list(), .Names = character(0)),
      fill_alpha = 1, subscribed_events = list(), line_color = "black",
      line_width = 1L, line_cap = "butt", line_alpha = 1, id = NULL
    ) {
      super$initialize(y = y, size = size, line_join = line_join,
        js_property_callbacks = js_property_callbacks,
        angle_units = angle_units, name = name, x = x, fill_color = fill_color,
        line_dash = line_dash, tags = tags, angle = angle,
        line_dash_offset = line_dash_offset,
        js_event_callbacks = js_event_callbacks, fill_alpha = fill_alpha,
        subscribed_events = subscribed_events, line_color = line_color,
        line_width = line_width, line_cap = line_cap,
        line_alpha = line_alpha, id = id)
      types <- bk_prop_types[["Cross"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# *toolbar icon*: |save_icon|
# 
# The save tool is an action. When activated, the tool opens a download
# dialog which allows to save an image reproduction of the plot in PNG
# format. If automatic download is not support by a web browser, the tool
# falls back to opening the generated image in a new tab or window. User
# then can manually save it by right clicking on the image and choosing
# "Save As" (or similar) menu item.
# 
# .. |save_icon| image:: /_images/icons/Save.png :height: 18pt
SaveTool <- R6::R6Class("SaveTool",
  inherit = Action,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["SaveTool"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Render a single text label as an annotation.
# 
# ``Label`` will render a single text label at given ``x`` and ``y``
# coordinates, which can be in either screen (pixel) space, or data (axis
# range) space.
# 
# The label can also be configured with a screen space offset from ``x``
# and ``y``, by using the ``x_offset`` and ``y_offset`` properties.
# 
# Additionally, the label can be rotated with the ``angle`` property.
# 
# There are also standard text, fill, and line properties to control the
# appearance of the text, its background, as well as the rectangular
# bounding box border.
Label <- R6::R6Class("Label",
  inherit = TextAnnotation,
  public = list(
    specified_args = NULL,
    initialize = function(
      level = "annotation", background_fill_color = NULL,
      angle_units = "rad", border_line_dash_offset = 0L, x = NULL, text = NULL,
      tags = list(), text_line_height = 1.2, text_color = "#444444",
      render_mode = "canvas", visible = TRUE, y_units = "data",
      subscribed_events = list(), name = NULL, border_line_dash = list(),
      text_font_size = list(value = "12pt"), y = NULL,
      text_font_style = "normal", x_offset = 0L, text_font = "helvetica",
      text_baseline = "bottom", x_range_name = "default",
      border_line_width = 1L, js_property_callbacks = structure(list(),
      .Names = character(0)), y_range_name = "default",
      background_fill_alpha = 1, text_align = "left", x_units = "data",
      border_line_join = "bevel", border_line_cap = "butt", angle = 0L,
      js_event_callbacks = structure(list(), .Names = character(0)),
      text_alpha = 1, border_line_color = NULL, border_line_alpha = 1,
      y_offset = 0L, id = NULL
    ) {
      super$initialize(level = level,
        js_property_callbacks = js_property_callbacks, tags = tags,
        visible = visible, render_mode = render_mode,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name, id = id)
      types <- bk_prop_types[["Label"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The fill color values for the text bounding box.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    background_fill_color = NULL,
    # Acceptable values for units are ``"rad"`` and ``"deg"``
    # > Enum('deg', 'rad')
    angle_units = NULL,
    # The line dash offset values for the text bounding box.
    # > Int
    border_line_dash_offset = NULL,
    # The x-coordinate in screen coordinates to locate the text anchors.
    # 
    # Datetime values are also accepted, but note that they are immediately
    # converted to milliseconds-since-epoch.
    # > Float
    x = NULL,
    # The text value to render.
    # > String
    text = NULL,
    # The text line height values for the text.
    # > Float
    text_line_height = NULL,
    # The text color values for the text.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    text_color = NULL,
    # The unit type for the y attribute. Interpreted as "data space" units by
    # default.
    # > Enum('screen', 'data')
    y_units = NULL,
    # The line dash values for the text bounding box.
    # > DashPattern
    border_line_dash = NULL,
    # The text font size values for the text.
    # > FontSizeSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), FontSize)), FontSize)
    text_font_size = NULL,
    # The y-coordinate in screen coordinates to locate the text anchors.
    # 
    # Datetime values are also accepted, but note that they are immediately
    # converted to milliseconds-since-epoch.
    # > Float
    y = NULL,
    # The text font style values for the text.
    # > Enum('normal', 'italic', 'bold', 'bold italic')
    text_font_style = NULL,
    # Offset value to apply to the x-coordinate.
    # 
    # This is useful, for instance, if it is desired to "float" text a fixed
    # distance in screen units from a given data position.
    # > Float
    x_offset = NULL,
    # The text font values for the text.
    # > String
    text_font = NULL,
    # The text baseline values for the text.
    # > Enum('top', 'middle', 'bottom', 'alphabetic', 'hanging', 'ideographic')
    text_baseline = NULL,
    # A particular (named) x-range to use for computing screen location when
    # rendering an annotation on the plot. If unset, use the default x-range.
    # > String
    x_range_name = NULL,
    # The line width values for the text bounding box.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    border_line_width = NULL,
    # A particular (named) y-range to use for computing screen location when
    # rendering an annotation on the plot. If unset, use the default y-range.
    # > String
    y_range_name = NULL,
    # The fill alpha values for the text bounding box.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    background_fill_alpha = NULL,
    # The text align values for the text.
    # > Enum('left', 'right', 'center')
    text_align = NULL,
    # The unit type for the x attribute. Interpreted as "data space" units by
    # default.
    # > Enum('screen', 'data')
    x_units = NULL,
    # The line join values for the text bounding box.
    # > Enum('miter', 'round', 'bevel')
    border_line_join = NULL,
    # The line cap values for the text bounding box.
    # > Enum('butt', 'round', 'square')
    border_line_cap = NULL,
    # The angle to rotate the text, as measured from the horizontal.
    # 
    # .. warning:: The center of rotation for canvas and css render_modes is
    # different.  For `render_mode="canvas"` the label is rotated from the
    # top-left corner of the annotation, while for `render_mode="css"` the
    # annotation is rotated around it's center.
    # > Angle
    angle = NULL,
    # The text alpha values for the text.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    text_alpha = NULL,
    # The line color values for the text bounding box.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    border_line_color = NULL,
    # The line alpha values for the text bounding box.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    border_line_alpha = NULL,
    # Offset value to apply to the y-coordinate.
    # 
    # This is useful, for instance, if it is desired to "float" text a fixed
    # distance in screen units from a given data position.
    # > Float
    y_offset = NULL
  )
)

# 
TileRenderer <- R6::R6Class("TileRenderer",
  inherit = DataRenderer,
  public = list(
    specified_args = NULL,
    initialize = function(
      level = "glyph", render_parents = TRUE, alpha = 1, smoothing = TRUE,
      js_property_callbacks = structure(list(), .Names = character(0)),
      x_range_name = "default", y_range_name = "default", tags = list(),
      visible = TRUE, js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), name = NULL,
      tile_source = NULL, id = NULL
    ) {
      super$initialize(level = level,
        js_property_callbacks = js_property_callbacks,
        x_range_name = x_range_name, y_range_name = y_range_name,
        tags = tags, visible = visible,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name, id = id)
      types <- bk_prop_types[["TileRenderer"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Flag enable/disable drawing of parent tiles while waiting for new tiles
    # to arrive. Default value is True.
    # > Bool
    render_parents = NULL,
    # tile opacity 0.0 - 1.0
    # > Float
    alpha = NULL,
    # Enable image smoothing for the rendered tiles.
    # > Bool
    smoothing = NULL,
    # Local data source to use when rendering glyphs on the plot.
    # > Instance(TileSource)
    tile_source = NULL
  )
)

# *toolbar icon*: |redo_icon|
# 
# Redo tool reverses the last action performed by undo tool.
# 
# .. |redo_icon| image:: /_images/icons/Redo.png :height: 18pt
RedoTool <- R6::R6Class("RedoTool",
  inherit = Action,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["RedoTool"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# An axis that picks nice numbers for tick locations on a linear scale.
# Configured with a ``BasicTickFormatter`` by default.
LinearAxis <- R6::R6Class("LinearAxis",
  inherit = ContinuousAxis,
  public = list(
    specified_args = NULL,
    initialize = function(
      major_label_text_font_size = list(value = "8pt"),
      major_label_text_font_style = "normal",
      axis_label_text_color = "#444444", fixed_location = NULL,
      major_label_text_align = "center", major_tick_line_color = "black",
      axis_label_text_line_height = 1.2, major_label_standoff = 5L,
      major_label_overrides = structure(list(), .Names = character(0)),
      tags = list(), minor_tick_in = 0L, formatter = NULL,
      axis_label_text_font_style = "italic",
      major_label_orientation = "horizontal",
      minor_tick_line_join = "bevel", major_tick_line_alpha = 1,
      axis_line_width = 1L, axis_label_text_font_size = list(value =
      "10pt"), major_tick_line_dash_offset = 0L,
      axis_label_text_baseline = "bottom", major_tick_line_width = 1L,
      major_label_text_font = "helvetica",
      axis_label_text_font = "helvetica", ticker = NULL,
      major_tick_line_cap = "butt", axis_label_text_alpha = 1,
      js_event_callbacks = structure(list(), .Names = character(0)),
      minor_tick_line_cap = "butt", subscribed_events = list(),
      major_tick_line_join = "bevel", axis_label_standoff = 5L,
      axis_line_alpha = 1, axis_line_cap = "butt", level = "overlay",
      major_tick_line_dash = list(), axis_label = "",
      major_label_text_color = "#444444",
      major_label_text_baseline = "alphabetic", major_tick_out = 6L,
      axis_line_color = "black", axis_line_join = "bevel",
      major_tick_in = 2L, visible = TRUE, minor_tick_out = 4L, name = NULL,
      minor_tick_line_dash = list(), major_label_text_line_height = 1.2,
      minor_tick_line_alpha = 1, bounds = "auto", axis_line_dash = list(),
      x_range_name = "default", minor_tick_line_color = "black",
      js_property_callbacks = structure(list(), .Names = character(0)),
      axis_label_text_align = "left", y_range_name = "default",
      major_label_text_alpha = 1, minor_tick_line_dash_offset = 0L,
      axis_line_dash_offset = 0L, minor_tick_line_width = 1L, id = NULL
    ) {
      super$initialize(major_label_text_font_size = major_label_text_font_size,
        major_label_text_font_style = major_label_text_font_style,
        axis_label_text_color = axis_label_text_color,
        fixed_location = fixed_location,
        major_label_text_align = major_label_text_align,
        major_tick_line_color = major_tick_line_color,
        axis_label_text_line_height = axis_label_text_line_height,
        major_label_standoff = major_label_standoff,
        major_label_overrides = major_label_overrides, tags = tags,
        minor_tick_in = minor_tick_in, formatter = formatter,
        axis_label_text_font_style = axis_label_text_font_style,
        major_label_orientation = major_label_orientation,
        minor_tick_line_join = minor_tick_line_join,
        major_tick_line_alpha = major_tick_line_alpha,
        axis_line_width = axis_line_width,
        axis_label_text_font_size = axis_label_text_font_size,
        major_tick_line_dash_offset = major_tick_line_dash_offset,
        axis_label_text_baseline = axis_label_text_baseline,
        major_tick_line_width = major_tick_line_width,
        major_label_text_font = major_label_text_font,
        axis_label_text_font = axis_label_text_font, ticker = ticker,
        major_tick_line_cap = major_tick_line_cap,
        axis_label_text_alpha = axis_label_text_alpha,
        js_event_callbacks = js_event_callbacks,
        minor_tick_line_cap = minor_tick_line_cap,
        subscribed_events = subscribed_events,
        major_tick_line_join = major_tick_line_join,
        axis_label_standoff = axis_label_standoff,
        axis_line_alpha = axis_line_alpha, axis_line_cap = axis_line_cap,
        level = level, major_tick_line_dash = major_tick_line_dash,
        axis_label = axis_label,
        major_label_text_color = major_label_text_color,
        major_label_text_baseline = major_label_text_baseline,
        major_tick_out = major_tick_out, axis_line_color = axis_line_color,
        axis_line_join = axis_line_join, major_tick_in = major_tick_in,
        visible = visible, minor_tick_out = minor_tick_out, name = name,
        minor_tick_line_dash = minor_tick_line_dash,
        major_label_text_line_height = major_label_text_line_height,
        minor_tick_line_alpha = minor_tick_line_alpha, bounds = bounds,
        axis_line_dash = axis_line_dash, x_range_name = x_range_name,
        minor_tick_line_color = minor_tick_line_color,
        js_property_callbacks = js_property_callbacks,
        axis_label_text_align = axis_label_text_align,
        y_range_name = y_range_name,
        major_label_text_alpha = major_label_text_alpha,
        minor_tick_line_dash_offset = minor_tick_line_dash_offset,
        axis_line_dash_offset = axis_line_dash_offset,
        minor_tick_line_width = minor_tick_line_width, id = id)
      types <- bk_prop_types[["LinearAxis"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Render circle markers with a '+' cross through the center.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/CircleCross.py
# :source-position: below
CircleCross <- R6::R6Class("CircleCross",
  inherit = Marker,
  public = list(
    specified_args = NULL,
    initialize = function(
      y = NULL, size = 4L, line_join = "bevel",
      js_property_callbacks = structure(list(), .Names = character(0)),
      angle_units = "rad", name = NULL, x = NULL, fill_color = "gray",
      line_dash = list(), tags = list(), angle = 0, line_dash_offset = 0L,
      js_event_callbacks = structure(list(), .Names = character(0)),
      fill_alpha = 1, subscribed_events = list(), line_color = "black",
      line_width = 1L, line_cap = "butt", line_alpha = 1, id = NULL
    ) {
      super$initialize(y = y, size = size, line_join = line_join,
        js_property_callbacks = js_property_callbacks,
        angle_units = angle_units, name = name, x = x, fill_color = fill_color,
        line_dash = line_dash, tags = tags, angle = angle,
        line_dash_offset = line_dash_offset,
        js_event_callbacks = js_event_callbacks, fill_alpha = fill_alpha,
        subscribed_events = subscribed_events, line_color = line_color,
        line_width = line_width, line_cap = line_cap,
        line_alpha = line_alpha, id = id)
      types <- bk_prop_types[["CircleCross"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Has the same tile origin as the ``WMTSTileSource`` but requests tiles
# using a `quadkey` argument instead of X, Y, Z e.g.
# ``http://your.quadkey.tile.host/{Q}.png``
QUADKEYTileSource <- R6::R6Class("QUADKEYTileSource",
  inherit = MercatorTileSource,
  public = list(
    specified_args = NULL,
    initialize = function(
      js_property_callbacks = structure(list(), .Names = character(0)),
      tile_size = 256L, extra_url_vars = structure(list(), .Names =
      character(0)), snap_to_zoom = FALSE, url = "",
      initial_resolution = 156543.033928041, x_origin_offset = 20037508.34,
      attribution = "", y_origin_offset = 20037508.34, max_zoom = 30L,
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), name = NULL, min_zoom = 0L,
      wrap_around = TRUE, id = NULL
    ) {
      super$initialize(js_property_callbacks = js_property_callbacks,
        tile_size = tile_size, extra_url_vars = extra_url_vars,
        snap_to_zoom = snap_to_zoom, url = url,
        initial_resolution = initial_resolution,
        x_origin_offset = x_origin_offset, attribution = attribution,
        y_origin_offset = y_origin_offset, max_zoom = max_zoom, tags = tags,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name,
        min_zoom = min_zoom, wrap_around = wrap_around, id = id)
      types <- bk_prop_types[["QUADKEYTileSource"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Contains tile config info and provides urls for tiles based on a
# templated url e.g. ``http://your.tms.server.host/{Z}/{X}/{Y}.png``. The
# defining feature of TMS is the tile-origin in located at the
# bottom-left.
# 
# ``TMSTileSource`` can also be helpful in implementing tile renderers
# for custom tile sets, including non-spatial datasets.
TMSTileSource <- R6::R6Class("TMSTileSource",
  inherit = MercatorTileSource,
  public = list(
    specified_args = NULL,
    initialize = function(
      js_property_callbacks = structure(list(), .Names = character(0)),
      tile_size = 256L, extra_url_vars = structure(list(), .Names =
      character(0)), snap_to_zoom = FALSE, url = "",
      initial_resolution = 156543.033928041, x_origin_offset = 20037508.34,
      attribution = "", y_origin_offset = 20037508.34, max_zoom = 30L,
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), name = NULL, min_zoom = 0L,
      wrap_around = TRUE, id = NULL
    ) {
      super$initialize(js_property_callbacks = js_property_callbacks,
        tile_size = tile_size, extra_url_vars = extra_url_vars,
        snap_to_zoom = snap_to_zoom, url = url,
        initial_resolution = initial_resolution,
        x_origin_offset = x_origin_offset, attribution = attribution,
        y_origin_offset = y_origin_offset, max_zoom = max_zoom, tags = tags,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name,
        min_zoom = min_zoom, wrap_around = wrap_around, id = id)
      types <- bk_prop_types[["TMSTileSource"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# A fixed, closed range [start, end] in a continuous scalar dimension.
# 
# In addition to supplying ``start`` and ``end`` keyword arguments to the
# ``Range1d`` initializer, you can also instantiate with the convenience
# syntax::
# 
# Range(0, 10) # equivalent to Range(start=0, end=10)
Range1d <- R6::R6Class("Range1d",
  inherit = Range,
  public = list(
    specified_args = NULL,
    initialize = function(
      max_interval = NULL, end = 1L, bounds = NULL, start = 0L,
      reset_start = NULL, js_property_callbacks = structure(list(), .Names
      = character(0)), callback = NULL, reset_end = NULL, tags = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), name = NULL, min_interval = NULL, id = NULL
    ) {
      super$initialize(tags = tags,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name,
        callback = callback, id = id)
      types <- bk_prop_types[["Range1d"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The level that the range is allowed to zoom out, expressed as the
    # maximum visible interval. Can be a ``TimeDelta``. Note that ``bounds``
    # can impose an implicit constraint on the maximum interval as well.
    # > Either(Float, TimeDelta)
    max_interval = NULL,
    # The end of the range.
    # > Either(Float, Datetime, TimeDelta)
    end = NULL,
    # The bounds that the range is allowed to go to. Typically used to
    # prevent the user from panning/zooming/etc away from the data.
    # 
    # If set to ``'auto'``, the bounds will be computed to the start and end
    # of the Range.
    # 
    # Bounds are provided as a tuple of ``(min, max)`` so regardless of
    # whether your range is increasing or decreasing, the first item should
    # be the minimum value of the range and the second item should be the
    # maximum. Setting min > max will result in a ``ValueError``.
    # 
    # By default, bounds are ``None`` and your plot to pan/zoom as far as you
    # want. If you only want to constrain one end of the plot, you can set
    # min or max to None.
    # 
    # Examples:
    # 
    # .. code-block:: python
    # 
    # Range1d(0, 1, bounds='auto') # Auto-bounded to 0 and 1 (Default
    # behavior) Range1d(start=0, end=1, bounds=(0, None)) # Maximum is
    # unbounded, minimum bounded to 0
    # > MinMaxBounds(Auto, Tuple(Float, Float), Tuple(TimeDelta, TimeDelta), Tuple(Datetime, Datetime))
    bounds = NULL,
    # The start of the range.
    # > Either(Float, Datetime, TimeDelta)
    start = NULL,
    # The start of the range to apply after reset. If set to ``None``
    # defaults to the ``start`` value during initialization.
    # > Either(Float, Datetime, TimeDelta)
    reset_start = NULL,
    # The end of the range to apply when resetting. If set to ``None``
    # defaults to the ``end`` value during initialization.
    # > Either(Float, Datetime, TimeDelta)
    reset_end = NULL,
    # The level that the range is allowed to zoom in, expressed as the
    # minimum visible interval. If set to ``None`` (default), the minimum
    # interval is not bound. Can be a ``TimeDelta``.
    # > Either(Float, TimeDelta)
    min_interval = NULL
  )
)

# A toolbar that allow to merge and proxy tools of toolbars in multiple
# plots.
ProxyToolbar <- R6::R6Class("ProxyToolbar",
  inherit = ToolbarBase,
  public = list(
    specified_args = NULL,
    initialize = function(
      logo = "normal", js_property_callbacks = structure(list(), .Names =
      character(0)), tags = list(), autohide = FALSE,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), tools = list(), name = NULL, id = NULL
    ) {
      super$initialize(logo = logo,
        js_property_callbacks = js_property_callbacks, tags = tags,
        autohide = autohide, js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, tools = tools, name = name,
        id = id)
      types <- bk_prop_types[["ProxyToolbar"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Multi-line string cell editor.
TextEditor <- R6::R6Class("TextEditor",
  inherit = CellEditor,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["TextEditor"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# *toolbar icon*: |box_select_icon|
# 
# The box selection tool allows users to make selections on a Plot by
# showing a rectangular region by dragging the mouse or a finger over the
# plot area.  The end of the drag event indicates the selection region is
# ready.
# 
# See :ref:`userguide_styling_selected_unselected_glyphs` for information
# on styling selected and unselected glyphs.
# 
# .. |box_select_icon| image:: /_images/icons/BoxSelect.png :height: 18pt
BoxSelectTool <- R6::R6Class("BoxSelectTool",
  inherit = Drag,
  public = list(
    specified_args = NULL,
    initialize = function(
      dimensions = "both", js_property_callbacks = structure(list(), .Names
      = character(0)), callback = NULL, tags = list(), renderers = "auto",
      overlay = NULL, names = list(), select_every_mousemove = FALSE,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), name = NULL, origin = "corner", id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["BoxSelectTool"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Which dimensions the box selection is to be free in. By default, users
    # may freely draw selections boxes with any dimensions. If only "width"
    # is set, the box will be constrained to span the entire vertical space
    # of the plot, only the horizontal dimension can be controlled. If only
    # "height" is set, the box will be constrained to span the entire
    # horizontal space of the plot, and the vertical dimension can be
    # controlled.
    # > Enum('width', 'height', 'both')
    dimensions = NULL,
    # A callback to run in the browser on completion of drawing a selection
    # box.  The ``cb_data`` parameter that is available to the Callback code
    # will contain one ``BoxSelectTool``-specific field:
    # 
    # :geometry: object containing the coordinates of the selection box
    # > Instance(Callback)
    callback = NULL,
    # An explicit list of renderers to hit test against. If unset, defaults
    # to all renderers on a plot.
    # > Either(Auto, List(Instance(Renderer)))
    renderers = NULL,
    # A shaded annotation drawn to indicate the selection region.
    # > Instance(BoxAnnotation)
    overlay = NULL,
    # A list of names to query for. If set, only renderers that have a
    # matching value for their ``name`` attribute will be used.
    # > List(String)
    names = NULL,
    # Whether a selection computation should happen on every mouse event, or
    # only once, when the selection region is completed. Default: False
    # > Bool
    select_every_mousemove = NULL,
    # Indicates whether the rectangular selection area should originate from
    # a corner (top-left or bottom-right depending on direction) or the
    # center of the box.
    # > Enum('corner', 'center')
    origin = NULL
  )
)

# 
CanvasTexture <- R6::R6Class("CanvasTexture",
  inherit = Texture,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      repetition = "repeat", code = NULL, name = NULL, id = NULL
    ) {
      super$initialize(tags = tags,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks,
        repetition = repetition, name = name, id = id)
      types <- bk_prop_types[["CanvasTexture"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A snippet of JavaScript code to execute in the browser.
    # > String
    code = NULL
  )
)

# With the ``EdgesAndLinkedNodes`` policy, inspection or selection of
# graph edges will result in the inspection or selection of the edge and
# of the linked graph nodes. There is no direct selection or inspection
# of graph nodes.
EdgesAndLinkedNodes <- R6::R6Class("EdgesAndLinkedNodes",
  inherit = GraphHitTestPolicy,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["EdgesAndLinkedNodes"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Abstract base class for input widgets.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
InputWidget <- R6::R6Class("InputWidget",
  inherit = Widget,
  public = list(
    specified_args = NULL,
    initialize = function(
      title = "", min_width = NULL, max_width = NULL, align = "start",
      disabled = FALSE, background = NULL, tags = list(), visible = TRUE,
      width_policy = "auto", height_policy = "auto", height = NULL,
      name = NULL, sizing_mode = NULL, default_size = 300L, max_height = NULL,
      css_classes = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), orientation = "horizontal",
      js_event_callbacks = structure(list(), .Names = character(0)),
      min_height = NULL, subscribed_events = list(), width = NULL,
      aspect_ratio = NULL, margin = list(5L, 5L, 5L, 5L), id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, background = background,
        tags = tags, visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, name = name,
        sizing_mode = sizing_mode, default_size = default_size,
        max_height = max_height, css_classes = css_classes,
        js_property_callbacks = js_property_callbacks,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["InputWidget"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Widget's label.
    # > String
    title = NULL
  )
)

# Create a column of bokeh widgets with predefined styling.
WidgetBox <- R6::R6Class("WidgetBox",
  inherit = Column,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, max_width = NULL, align = "start", disabled = FALSE,
      background = NULL, tags = list(), visible = TRUE, width_policy = "auto",
      height_policy = "auto", height = NULL, spacing = 0L, sizing_mode = NULL,
      name = NULL, max_height = NULL, css_classes = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      rows = "auto", children = list(), min_height = NULL,
      subscribed_events = list(), js_event_callbacks = structure(list(),
      .Names = character(0)), width = NULL, aspect_ratio = NULL,
      margin = list(0L, 0L, 0L, 0L), id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, background = background,
        tags = tags, visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, spacing = spacing,
        sizing_mode = sizing_mode, name = name, max_height = max_height,
        css_classes = css_classes,
        js_property_callbacks = js_property_callbacks, rows = rows,
        children = children, min_height = min_height,
        subscribed_events = subscribed_events,
        js_event_callbacks = js_event_callbacks, width = width,
        aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["WidgetBox"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# A data source that can populate columns by making Ajax calls to REST
# endpoints.
# 
# The ``AjaxDataSource`` can be especially useful if you want to make a
# standalone document (i.e. not backed by the Bokeh server) that can
# still dynamically update using an existing REST API.
# 
# The response from the REST API should match the ``.data`` property of a
# standard ``ColumnDataSource``, i.e. a JSON dict that maps names to
# arrays of values:
# 
# .. code-block:: python
# 
# { 'x' : [1, 2, 3, ...], 'y' : [9, 3, 2, ...] }
# 
# Alternatively, if the REST API returns a different format, a
# ``CustomJS`` callback can be provided to convert the REST response into
# Bokeh format, via the ``adapter`` property of this data source.
# 
# A full example can be seen at
# :bokeh-tree:`examples/howto/ajax_source.py`
AjaxDataSource <- R6::R6Class("AjaxDataSource",
  inherit = RemoteSource,
  public = list(
    specified_args = NULL,
    initialize = function(
      selected = NULL, method = "POST",
      js_property_callbacks = structure(list(), .Names = character(0)),
      mode = "replace", data = structure(list(), .Names = character(0)),
      http_headers = structure(list(), .Names = character(0)),
      polling_interval = NULL, if_modified = FALSE, adapter = NULL,
      max_size = NULL, callback = NULL, selection_policy = NULL, tags = list(),
      name = NULL, content_type = "application/json",
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), data_url = NULL, id = NULL
    ) {
      super$initialize(selected = selected,
        js_property_callbacks = js_property_callbacks, mode = mode,
        data = data, callback = callback, max_size = max_size,
        polling_interval = polling_interval, adapter = adapter, name = name,
        tags = tags, selection_policy = selection_policy,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, data_url = data_url, id = id)
      types <- bk_prop_types[["AjaxDataSource"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Specify the HTTP method to use for the Ajax request (GET or POST)
    # > Enum('POST', 'GET')
    method = NULL,
    # Specify HTTP headers to set for the Ajax request.
    # 
    # Example:
    # 
    # .. code-block:: python
    # 
    # ajax_source.headers = { 'x-my-custom-header': 'some value' }
    # > Dict(String, String)
    http_headers = NULL,
    # Whether to include an ``If-Modified-Since`` header in Ajax requests to
    # the server. If this header is supported by the server, then only new
    # data since the last request will be returned.
    # > Bool
    if_modified = NULL,
    # Set the "contentType" parameter for the Ajax request.
    # > String
    content_type = NULL
  )
)

# When a data source is shared between multiple renderers, selecting a
# point on from any renderer will cause that row in the data source to be
# selected. The selection is made from the union of hit test results from
# all renderers.
UnionRenderers <- R6::R6Class("UnionRenderers",
  inherit = SelectionPolicy,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["UnionRenderers"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# *toolbar icon*: |crosshair_icon|
# 
# The crosshair tool is a passive inspector tool. It is generally on at
# all times, but can be configured in the inspector's menu associated
# with the *toolbar icon* shown above.
# 
# The crosshair tool draws a crosshair annotation over the plot, centered
# on the current mouse position. The crosshair tool may be configured to
# draw across only one dimension by setting the ``dimension`` property to
# only ``width`` or ``height``.
# 
# .. |crosshair_icon| image:: /_images/icons/Crosshair.png :height: 18pt
CrosshairTool <- R6::R6Class("CrosshairTool",
  inherit = Inspection,
  public = list(
    specified_args = NULL,
    initialize = function(
      toggleable = TRUE, dimensions = "both",
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, tags = list(), js_event_callbacks = structure(list(),
      .Names = character(0)), line_width = 1L, subscribed_events = list(),
      line_color = "black", line_alpha = 1, id = NULL
    ) {
      super$initialize(toggleable = toggleable, tags = tags,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["CrosshairTool"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Which dimensions the crosshair tool is to track. By default, both
    # vertical and horizontal lines will be drawn. If only "width" is
    # supplied, only a horizontal line will be drawn. If only "height" is
    # supplied, only a vertical line will be drawn.
    # > Enum('width', 'height', 'both')
    dimensions = NULL,
    # Stroke width in units of pixels.
    # > Float
    line_width = NULL,
    # A color to use to stroke paths with.
    # 
    # Acceptable values are:
    # 
    # - any of the 147 named `CSS colors`_, e.g ``'green'``, ``'indigo'`` -
    # an RGB(A) hex value, e.g., ``'#FF0000'``, ``'#44444444'`` - a 3-tuple
    # of integers (r,g,b) between 0 and 255 - a 4-tuple of (r,g,b,a) where
    # r,g,b are integers between 0..255 and a is between 0..1
    # 
    # .. _CSS colors: http://www.w3schools.com/cssref/css_colornames.asp
    # > Color
    line_color = NULL,
    # An alpha value to use to stroke paths with.
    # 
    # Acceptable values are floating point numbers between 0 (transparent)
    # and 1 (opaque).
    # > Float
    line_alpha = NULL
  )
)

# Execute a JavaScript function.
# 
# .. warning:: The explicit purpose of this Bokeh Model is to embed *raw
# JavaScript code* for a browser to execute. If any part of the code is
# derived from untrusted user inputs, then you must take appropriate care
# to sanitize the user input prior to passing to Bokeh.
CustomJS <- R6::R6Class("CustomJS",
  inherit = Callback,
  public = list(
    specified_args = NULL,
    initialize = function(
      js_property_callbacks = structure(list(), .Names = character(0)),
      code = "", tags = list(), use_strict = FALSE,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), name = NULL, args = structure(list(),
      .Names = character(0)), id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["CustomJS"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # A snippet of JavaScript code to execute in the browser. The code is
    # made into the body of a function, and all of of the named objects in
    # ``args`` are available as parameters that the code can use.
    # Additionally, a ``cb_obj`` parameter contains the object that triggered
    # the callback and an optional ``cb_data`` parameter that contains any
    # tool-specific data (i.e. mouse coordinates and hovered glyph indices
    # for the ``HoverTool``).
    # 
    # .. note:: Use ``CustomJS.from_coffeescript()`` for CoffeeScript source
    # code.
    # > String
    code = NULL,
    # Enables or disables automatic insertion of ``"use strict";`` into
    # ``code``.
    # > Bool
    use_strict = NULL,
    # A mapping of names to Python objects. In particular those can be
    # bokeh's models.  These objects are made available to the callback's
    # code snippet as the values of named parameters to the callback.
    # > Dict(String, AnyRef)
    args = NULL
  )
)

# Render a 'X' cross markers.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/X.py :source-position:
# below
X <- R6::R6Class("X",
  inherit = Marker,
  public = list(
    specified_args = NULL,
    initialize = function(
      y = NULL, size = 4L, line_join = "bevel",
      js_property_callbacks = structure(list(), .Names = character(0)),
      angle_units = "rad", name = NULL, x = NULL, fill_color = "gray",
      line_dash = list(), tags = list(), angle = 0, line_dash_offset = 0L,
      js_event_callbacks = structure(list(), .Names = character(0)),
      fill_alpha = 1, subscribed_events = list(), line_color = "black",
      line_width = 1L, line_cap = "butt", line_alpha = 1, id = NULL
    ) {
      super$initialize(y = y, size = size, line_join = line_join,
        js_property_callbacks = js_property_callbacks,
        angle_units = angle_units, name = name, x = x, fill_color = fill_color,
        line_dash = line_dash, tags = tags, angle = angle,
        line_dash_offset = line_dash_offset,
        js_event_callbacks = js_event_callbacks, fill_alpha = fill_alpha,
        subscribed_events = subscribed_events, line_color = line_color,
        line_width = line_width, line_cap = line_cap,
        line_alpha = line_alpha, id = id)
      types <- bk_prop_types[["X"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Render text.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/Text.py
# :source-position: below
Text <- R6::R6Class("Text",
  inherit = XYGlyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      text_font_style = "normal", text_font = "helvetica", x_offset = 0L,
      y = NULL, text_baseline = "bottom",
      js_property_callbacks = structure(list(), .Names = character(0)),
      angle_units = "rad", text_align = "left", x = NULL, text = "text",
      tags = list(), text_line_height = 1.2, text_color = "#444444",
      angle = 0L, js_event_callbacks = structure(list(), .Names =
      character(0)), text_alpha = 1, subscribed_events = list(), name = NULL,
      text_font_size = list(value = "12pt"), y_offset = 0L, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Text"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The text font style values for the text.
    # > Enum('normal', 'italic', 'bold', 'bold italic')
    text_font_style = NULL,
    # The text font values for the text.
    # > String
    text_font = NULL,
    # Offset values to apply to the x-coordinates.
    # 
    # This is useful, for instance, if it is desired to "float" text a fixed
    # distance in screen units from a given data position.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x_offset = NULL,
    # The y-coordinates to locate the text anchors.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y = NULL,
    # The text baseline values for the text.
    # > Enum('top', 'middle', 'bottom', 'alphabetic', 'hanging', 'ideographic')
    text_baseline = NULL,
    # 
    # > Enum('deg', 'rad')
    angle_units = NULL,
    # The text align values for the text.
    # > Enum('left', 'right', 'center')
    text_align = NULL,
    # The x-coordinates to locate the text anchors.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x = NULL,
    # The text values to render.
    # > StringSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), List(String))), List(String))
    text = NULL,
    # The text line height values for the text.
    # > Float
    text_line_height = NULL,
    # The text color values for the text.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    text_color = NULL,
    # The angles to rotate the text, as measured from the horizontal.
    # > AngleSpec(units_default='rad')
    angle = NULL,
    # The text alpha values for the text.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    text_alpha = NULL,
    # The text font size values for the text.
    # > FontSizeSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), FontSize)), FontSize)
    text_font_size = NULL,
    # Offset values to apply to the y-coordinates.
    # 
    # This is useful, for instance, if it is desired to "float" text a fixed
    # distance in screen units from a given data position.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y_offset = NULL
  )
)

# Spinner-based time cell editor.
TimeEditor <- R6::R6Class("TimeEditor",
  inherit = CellEditor,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["TimeEditor"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# Base class for interpolator transforms.
# 
# Interpolators return the value of a function which has been evaluated
# between specified (x, y) pairs of data.  As an example, if two control
# point pairs were provided to the interpolator, a linear interpolaction
# at a specific value of 'x' would result in the value of 'y' which
# existed on the line connecting the two control points.
# 
# The control point pairs for the interpolators can be specified through
# either
# 
# * A literal sequence of values:
# 
# .. code-block:: python
# 
# interp = Interpolator(x=[1, 2, 3, 4, 5], y=[2, 5, 10, 12, 16])
# 
# * or a pair of columns defined in a ``ColumnDataSource`` object:
# 
# .. code-block:: python
# 
# interp = Interpolator(x="year", y="earnings", data=jewlery_prices))
# 
# This is the base class and is not intended to end use.  Please see the
# documentation for the final derived classes (``Jitter``,
# ``LineraInterpolator``, ``StepInterpolator``) for more information on
# their specific methods of interpolation.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
Interpolator <- R6::R6Class("Interpolator",
  inherit = Transform,
  public = list(
    specified_args = NULL,
    initialize = function(
      y = NULL, js_property_callbacks = structure(list(), .Names =
      character(0)), data = NULL, x = NULL, clip = TRUE, tags = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Interpolator"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Dependant coordinate denoting the value of a point at a location.
    # > Either(String, Seq(Float))
    y = NULL,
    # Data which defines the source for the named columns if a string is
    # passed to either the ``x`` or ``y`` parameters.
    # > Instance(ColumnarDataSource)
    data = NULL,
    # Independent coordinate denoting the location of a point.
    # > Either(String, Seq(Float))
    x = NULL,
    # Determine if the interpolation should clip the result to include only
    # values inside its predefined range.  If this is set to False, it will
    # return the most value of the closest point.
    # > Bool
    clip = NULL
  )
)

# Two dimensional grid for visualisation and editing large amounts of
# data.
DataTable <- R6::R6Class("DataTable",
  inherit = TableWidget,
  public = list(
    specified_args = NULL,
    initialize = function(
      min_width = NULL, align = "start", selectable = TRUE, tags = list(),
      row_height = 25L, width_policy = "auto", reorderable = TRUE,
      height_policy = "auto", height = 400L, fit_columns = TRUE,
      sortable = TRUE, max_height = NULL, header_row = TRUE, columns = list(),
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), width = 600L, aspect_ratio = NULL,
      scroll_to_selection = TRUE, margin = list(5L, 5L, 5L, 5L),
      index_position = 0L, max_width = NULL, disabled = FALSE,
      background = NULL, visible = TRUE, name = NULL, sizing_mode = NULL,
      source = NULL, default_size = 300L, editable = FALSE, index_width = 40L,
      css_classes = list(), view = NULL, orientation = "horizontal",
      js_property_callbacks = structure(list(), .Names = character(0)),
      min_height = NULL, index_header = "#", id = NULL
    ) {
      super$initialize(min_width = min_width, max_width = max_width,
        align = align, disabled = disabled, background = background,
        tags = tags, visible = visible, width_policy = width_policy,
        height_policy = height_policy, height = height, name = name,
        sizing_mode = sizing_mode, source = source,
        default_size = default_size, max_height = max_height,
        css_classes = css_classes,
        js_property_callbacks = js_property_callbacks, view = view,
        orientation = orientation, js_event_callbacks = js_event_callbacks,
        min_height = min_height, subscribed_events = subscribed_events,
        width = width, aspect_ratio = aspect_ratio, margin = margin, id = id)
      types <- bk_prop_types[["DataTable"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Whether a table's rows can be selected or not. Using ``checkbox`` is
    # equivalent to ``True``, but makes selection visible through a checkbox
    # for each row, instead of highlighting rows. Multiple selection is
    # allowed and can be achieved by either clicking multiple checkboxes (if
    # enabled) or using Shift + click on rows.
    # > Either(Bool, Enum('checkbox'))
    selectable = NULL,
    # The height of each row in pixels.
    # > Int
    row_height = NULL,
    # Allows the reordering of a table's columns. To reorder a column, click
    # and drag a table's header to the desired location in the table.  The
    # columns on either side will remain in their previous order.
    # > Bool
    reorderable = NULL,
    # Whether columns should be fit to the available width. This results in
    # no horizontal scrollbar showing up, but data can get unreadable if
    # there is no enough space available. If set to ``True``, columns' width
    # is understood as maximum width.
    # > Bool
    fit_columns = NULL,
    # Allows to sort table's contents. By default natural order is preserved.
    # To sort a column, click on it's header. Clicking one more time changes
    # sort direction. Use Ctrl + click to return to natural order. Use Shift
    # + click to sort multiple columns simultaneously.
    # > Bool
    sortable = NULL,
    # Whether to show a header row with column names at the top of the table.
    # > Bool
    header_row = NULL,
    # The list of child column widgets.
    # > List(Instance(TableColumn))
    columns = NULL,
    # Whenever a selection is made on the data source, scroll the selected
    # rows into the table's viewport if none of the selected rows are already
    # in the viewport.
    # > Bool
    scroll_to_selection = NULL,
    # Where among the list of columns to insert a column displaying the row
    # index. Negative indices are supported, and specify an index position
    # from the end of the list of columns (i.e. standard Python behaviour).
    # 
    # To prevent the index column from being added, set to None.
    # 
    # If the absolute value of index_position is larger than the length of
    # the columns, then the index will appear at the beginning or end,
    # depending on the sign.
    # > Int
    index_position = NULL,
    # Allows to edit table's contents. Needs cell editors to be configured on
    # columns that are required to be editable.
    # > Bool
    editable = NULL,
    # The width of the index column, if present.
    # > Int
    index_width = NULL,
    # The column header to display for the index column, if it is present.
    # > String
    index_header = NULL
  )
)

# Basic string cell formatter.
StringFormatter <- R6::R6Class("StringFormatter",
  inherit = CellFormatter,
  public = list(
    specified_args = NULL,
    initialize = function(
      font_style = "normal", js_property_callbacks = structure(list(),
      .Names = character(0)), text_align = "left", tags = list(),
      text_color = NULL, js_event_callbacks = structure(list(), .Names =
      character(0)), subscribed_events = list(), name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["StringFormatter"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # An optional text font style, e.g. bold, italic.
    # > Enum('normal', 'italic', 'bold', 'bold italic')
    font_style = NULL,
    # An optional text align, i.e. left, center or right.
    # > Enum('left', 'right', 'center')
    text_align = NULL,
    # An optional text color. See :class:`bokeh.core.properties.Color` for
    # details.
    # > Color
    text_color = NULL
  )
)

# Base class for ``Expression`` models that represent a computation to be
# carried out on the client-side.
# 
# JavaScript implementations should implement the following methods:
# 
# .. code-block:: coffeescript
# 
# v_compute: (source) -> # compute an array of values
# 
# .. note:: If you wish for results to be cached per source and updated
# only if the source changes, implement ``_v_compute: (source)`` instead.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
Expression <- R6::R6Class("Expression",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Expression"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# A data source that can populate columns by receiving server sent events
# endpoints.
ServerSentDataSource <- R6::R6Class("ServerSentDataSource",
  inherit = WebSource,
  public = list(
    specified_args = NULL,
    initialize = function(
      selected = NULL, js_property_callbacks = structure(list(), .Names =
      character(0)), data = structure(list(), .Names = character(0)),
      mode = "replace", callback = NULL, max_size = NULL, name = NULL,
      adapter = NULL, tags = list(), selection_policy = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), data_url = NULL, id = NULL
    ) {
      super$initialize(selected = selected,
        js_property_callbacks = js_property_callbacks, data = data,
        mode = mode, callback = callback, max_size = max_size, name = name,
        adapter = adapter, tags = tags, selection_policy = selection_policy,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, data_url = data_url, id = id)
      types <- bk_prop_types[["ServerSentDataSource"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# A base class that defines common properties for all axis types.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
Axis <- R6::R6Class("Axis",
  inherit = GuideRenderer,
  public = list(
    specified_args = NULL,
    initialize = function(
      major_label_text_font_size = list(value = "8pt"),
      major_label_text_font_style = "normal",
      axis_label_text_color = "#444444", fixed_location = NULL,
      major_label_text_align = "center", major_tick_line_color = "black",
      axis_label_text_line_height = 1.2, major_label_standoff = 5L,
      major_label_overrides = structure(list(), .Names = character(0)),
      tags = list(), minor_tick_in = 0L, formatter = NULL,
      axis_label_text_font_style = "italic",
      major_label_orientation = "horizontal",
      minor_tick_line_join = "bevel", major_tick_line_alpha = 1,
      axis_line_width = 1L, axis_label_text_font_size = list(value =
      "10pt"), major_tick_line_dash_offset = 0L,
      axis_label_text_baseline = "bottom", major_tick_line_width = 1L,
      major_label_text_font = "helvetica",
      axis_label_text_font = "helvetica", ticker = NULL,
      major_tick_line_cap = "butt", axis_label_text_alpha = 1,
      js_event_callbacks = structure(list(), .Names = character(0)),
      minor_tick_line_cap = "butt", subscribed_events = list(),
      major_tick_line_join = "bevel", axis_label_standoff = 5L,
      axis_line_alpha = 1, axis_line_cap = "butt", level = "overlay",
      major_tick_line_dash = list(), axis_label = "",
      major_label_text_color = "#444444",
      major_label_text_baseline = "alphabetic", major_tick_out = 6L,
      axis_line_color = "black", axis_line_join = "bevel",
      major_tick_in = 2L, visible = TRUE, minor_tick_out = 4L, name = NULL,
      minor_tick_line_dash = list(), major_label_text_line_height = 1.2,
      minor_tick_line_alpha = 1, bounds = "auto", axis_line_dash = list(),
      x_range_name = "default", minor_tick_line_color = "black",
      js_property_callbacks = structure(list(), .Names = character(0)),
      axis_label_text_align = "left", y_range_name = "default",
      major_label_text_alpha = 1, minor_tick_line_dash_offset = 0L,
      axis_line_dash_offset = 0L, minor_tick_line_width = 1L, id = NULL
    ) {
      super$initialize(level = level, tags = tags, visible = visible,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["Axis"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The text font size of the major tick labels.
    # > FontSizeSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), FontSize)), FontSize)
    major_label_text_font_size = NULL,
    # The text font style of the major tick labels.
    # > Enum('normal', 'italic', 'bold', 'bold italic')
    major_label_text_font_style = NULL,
    # The text color of the axis label.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    axis_label_text_color = NULL,
    # Set to specify a fixed coordinate location to draw the axis. The
    # direction of ticks and major labels is determined by the side panel
    # that the axis belongs to.
    # 
    # .. note:: Axes labels are suppressed when axes are positioned at fixed
    # locations inside the central plot area.
    # > Either(Float, String, Tuple(String, String), Tuple(String, String, String))
    fixed_location = NULL,
    # The text align of the major tick labels.
    # > Enum('left', 'right', 'center')
    major_label_text_align = NULL,
    # The line color of the major ticks.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    major_tick_line_color = NULL,
    # The text line height of the axis label.
    # > Float
    axis_label_text_line_height = NULL,
    # The distance in pixels that the major tick labels should be offset from
    # the associated ticks.
    # > Int
    major_label_standoff = NULL,
    # Provide explicit tick label values for specific tick locations that
    # override normal formatting.
    # > Dict(Either(Float, String), String)
    major_label_overrides = NULL,
    # The distance in pixels that minor ticks should extend into the main
    # plot area.
    # > Int
    minor_tick_in = NULL,
    # A ``TickFormatter`` to use for formatting the visual appearance of
    # ticks.
    # > Instance(TickFormatter)
    formatter = NULL,
    # The text font style of the axis label.
    # > Enum('normal', 'italic', 'bold', 'bold italic')
    axis_label_text_font_style = NULL,
    # What direction the major label text should be oriented. If a number is
    # supplied, the angle of the text is measured from horizontal.
    # > Either(Enum('horizontal', 'vertical'), Float)
    major_label_orientation = NULL,
    # The line join of the minor ticks.
    # > Enum('miter', 'round', 'bevel')
    minor_tick_line_join = NULL,
    # The line alpha of the major ticks.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    major_tick_line_alpha = NULL,
    # The line width of the axis line.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    axis_line_width = NULL,
    # The text font size of the axis label.
    # > FontSizeSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), FontSize)), FontSize)
    axis_label_text_font_size = NULL,
    # The line dash offset of the major ticks.
    # > Int
    major_tick_line_dash_offset = NULL,
    # The text baseline of the axis label.
    # > Enum('top', 'middle', 'bottom', 'alphabetic', 'hanging', 'ideographic')
    axis_label_text_baseline = NULL,
    # The line width of the major ticks.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    major_tick_line_width = NULL,
    # The text font of the major tick labels.
    # > String
    major_label_text_font = NULL,
    # The text font of the axis label.
    # > String
    axis_label_text_font = NULL,
    # A Ticker to use for computing locations of axis components.
    # 
    # The property may also be passed a sequence of floating point numbers as
    # a shorthand for creating and configuring a ``FixedTicker``, e.g. the
    # following code
    # 
    # .. code-block:: python
    # 
    # from bokeh.plotting import figure
    # 
    # p = figure() p.xaxis.ticker = [10, 20, 37.4]
    # 
    # is equivalent to:
    # 
    # .. code-block:: python
    # 
    # from bokeh.plotting import figure from bokeh.models.tickers import
    # FixedTicker
    # 
    # p = figure() p.xaxis.ticker = FixedTicker(ticks=[10, 20, 37.4])
    # > Instance(Ticker)
    ticker = NULL,
    # The line cap of the major ticks.
    # > Enum('butt', 'round', 'square')
    major_tick_line_cap = NULL,
    # The text alpha of the axis label.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    axis_label_text_alpha = NULL,
    # The line cap of the minor ticks.
    # > Enum('butt', 'round', 'square')
    minor_tick_line_cap = NULL,
    # The line join of the major ticks.
    # > Enum('miter', 'round', 'bevel')
    major_tick_line_join = NULL,
    # The distance in pixels that the axis labels should be offset from the
    # tick labels.
    # > Int
    axis_label_standoff = NULL,
    # The line alpha of the axis line.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    axis_line_alpha = NULL,
    # The line cap of the axis line.
    # > Enum('butt', 'round', 'square')
    axis_line_cap = NULL,
    # The line dash of the major ticks.
    # > DashPattern
    major_tick_line_dash = NULL,
    # A text label for the axis, displayed parallel to the axis rule.
    # 
    # .. note:: LaTeX notation is not currently supported; please see
    # :bokeh-issue:`647` to track progress or contribute.
    # > String
    axis_label = NULL,
    # The text color of the major tick labels.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    major_label_text_color = NULL,
    # The text baseline of the major tick labels.
    # > Enum('top', 'middle', 'bottom', 'alphabetic', 'hanging', 'ideographic')
    major_label_text_baseline = NULL,
    # The distance in pixels that major ticks should extend out of the main
    # plot area.
    # > Int
    major_tick_out = NULL,
    # The line color of the axis line.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    axis_line_color = NULL,
    # The line join of the axis line.
    # > Enum('miter', 'round', 'bevel')
    axis_line_join = NULL,
    # The distance in pixels that major ticks should extend into the main
    # plot area.
    # > Int
    major_tick_in = NULL,
    # The distance in pixels that major ticks should extend out of the main
    # plot area.
    # > Int
    minor_tick_out = NULL,
    # The line dash of the minor ticks.
    # > DashPattern
    minor_tick_line_dash = NULL,
    # The text line height of the major tick labels.
    # > Float
    major_label_text_line_height = NULL,
    # The line alpha of the minor ticks.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    minor_tick_line_alpha = NULL,
    # Bounds for the rendered axis. If unset, the axis will span the entire
    # plot in the given dimension.
    # > Either(Auto, Tuple(Float, Float), Tuple(Datetime, Datetime))
    bounds = NULL,
    # The line dash of the axis line.
    # > DashPattern
    axis_line_dash = NULL,
    # A particular (named) x-range to use for computing screen locations when
    # rendering an axis on the plot. If unset, use the default x-range.
    # > String
    x_range_name = NULL,
    # The line color of the minor ticks.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    minor_tick_line_color = NULL,
    # The text align of the axis label.
    # > Enum('left', 'right', 'center')
    axis_label_text_align = NULL,
    # A particular (named) y-range to use for computing screen locations when
    # rendering an axis on the plot. If unset, use the default y-range.
    # > String
    y_range_name = NULL,
    # The text alpha of the major tick labels.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    major_label_text_alpha = NULL,
    # The line dash offset of the minor ticks.
    # > Int
    minor_tick_line_dash_offset = NULL,
    # The line dash offset of the axis line.
    # > Int
    axis_line_dash_offset = NULL,
    # The line width of the minor ticks.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    minor_tick_line_width = NULL
  )
)

# Render ellipses.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/Ellipse.py
# :source-position: below
Ellipse <- R6::R6Class("Ellipse",
  inherit = XYGlyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      angle_units = "rad", x = NULL, tags = list(), height_units = "data",
      fill_alpha = 1, height = NULL, subscribed_events = list(),
      line_dash = list(), line_color = "black", name = NULL,
      fill_color = "gray", line_alpha = 1, y = NULL,
      js_property_callbacks = structure(list(), .Names = character(0)),
      line_dash_offset = 0L, angle = 0,
      js_event_callbacks = structure(list(), .Names = character(0)),
      line_join = "bevel", width_units = "data", width = NULL,
      line_cap = "butt", line_width = 1L, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Ellipse"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # 
    # > Enum('deg', 'rad')
    angle_units = NULL,
    # The x-coordinates of the centers of the ellipses.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x = NULL,
    # 
    # > Enum('screen', 'data')
    height_units = NULL,
    # The fill alpha values for the ovals.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    fill_alpha = NULL,
    # The heights of each ellipse.
    # > DistanceSpec(units_default='data')
    height = NULL,
    # The line dash values for the ovals.
    # > DashPattern
    line_dash = NULL,
    # The line color values for the ovals.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The fill color values for the ovals.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    fill_color = NULL,
    # The line alpha values for the ovals.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL,
    # The y-coordinates of the centers of the ellipses.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y = NULL,
    # The line dash offset values for the ovals.
    # > Int
    line_dash_offset = NULL,
    # The angle the ellipses are rotated from horizontal. [rad]
    # > AngleSpec(units_default='rad')
    angle = NULL,
    # The line join values for the ovals.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # 
    # > Enum('screen', 'data')
    width_units = NULL,
    # The widths of each ellipse.
    # > DistanceSpec(units_default='data')
    width = NULL,
    # The line cap values for the ovals.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line width values for the ovals.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL
  )
)

# Render a vee-style arrow head.
VeeHead <- R6::R6Class("VeeHead",
  inherit = ArrowHead,
  public = list(
    specified_args = NULL,
    initialize = function(
      level = "annotation", size = 25L, line_join = "bevel",
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, fill_color = "black", line_dash = list(), tags = list(),
      line_dash_offset = 0L, line_alpha = 1, visible = TRUE, fill_alpha = 1,
      subscribed_events = list(), js_event_callbacks = structure(list(),
      .Names = character(0)), line_color = "black", line_cap = "butt",
      line_width = 1L, id = NULL
    ) {
      super$initialize(level = level, tags = tags, visible = visible,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, name = name, id = id)
      types <- bk_prop_types[["VeeHead"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The size, in pixels, of the arrow head.
    # > Float
    size = NULL,
    # The line join values for the arrow head outline.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # The fill color values for the arrow head interior.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    fill_color = NULL,
    # The line dash values for the arrow head outline.
    # > DashPattern
    line_dash = NULL,
    # The line dash offset values for the arrow head outline.
    # > Int
    line_dash_offset = NULL,
    # The line alpha values for the arrow head outline.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL,
    # The fill alpha values for the arrow head interior.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    fill_alpha = NULL,
    # The line color values for the arrow head outline.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The line cap values for the arrow head outline.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line width values for the arrow head outline.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL
  )
)

# Abstract base class for data cube's row formatters.
# 
# .. note:: This is an abstract base class used to help organize the
# hierarchy of Bokeh model types. **It is not useful to instantiate on
# its own.**
RowAggregator <- R6::R6Class("RowAggregator",
  inherit = Model,
  public = list(
    specified_args = NULL,
    initialize = function(
      tags = list(), field_ = "", js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(),
      js_property_callbacks = structure(list(), .Names = character(0)),
      name = NULL, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["RowAggregator"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Refers to the table column being aggregated
    # > String
    field_ = NULL
  )
)

# Render Bezier curves.
# 
# For more information consult the `Wikipedia article for Bezier curve`_.
# 
# .. _Wikipedia article for Bezier curve:
# http://en.wikipedia.org/wiki/Bezier_curve
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/Bezier.py
# :source-position: below
Bezier <- R6::R6Class("Bezier",
  inherit = Glyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      y0 = NULL, js_event_callbacks = structure(list(), .Names =
      character(0)), cy1 = NULL, js_property_callbacks = structure(list(),
      .Names = character(0)), x0 = NULL, name = NULL, cx1 = NULL, x1 = NULL,
      line_dash_offset = 0L, line_dash = list(), cy0 = NULL,
      line_join = "bevel", cx0 = NULL, y1 = NULL, subscribed_events = list(),
      line_color = "black", tags = list(), line_width = 1L, line_cap = "butt",
      line_alpha = 1, id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["Bezier"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # The y-coordinates of the starting points.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y0 = NULL,
    # The y-coordinates of second control points.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    cy1 = NULL,
    # The x-coordinates of the starting points.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x0 = NULL,
    # The x-coordinates of second control points.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    cx1 = NULL,
    # The x-coordinates of the ending points.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    x1 = NULL,
    # The line dash offset values for the Bezier curves.
    # > Int
    line_dash_offset = NULL,
    # The line dash values for the Bezier curves.
    # > DashPattern
    line_dash = NULL,
    # The y-coordinates of first control points.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    cy0 = NULL,
    # The line join values for the Bezier curves.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # The x-coordinates of first control points.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    cx0 = NULL,
    # The y-coordinates of the ending points.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    y1 = NULL,
    # The line color values for the Bezier curves.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The line width values for the Bezier curves.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL,
    # The line cap values for the Bezier curves.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line alpha values for the Bezier curves.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL
  )
)

# Render horizontal tiles on a regular hexagonal grid.
# 
# Example -------
# 
# .. bokeh-plot:: ../../examples/reference/models/HexTile.py
# :source-position: below
HexTile <- R6::R6Class("HexTile",
  inherit = Glyph,
  public = list(
    specified_args = NULL,
    initialize = function(
      aspect_scale = 1, size = 1, r = NULL, line_join = "bevel",
      js_property_callbacks = structure(list(), .Names = character(0)),
      orientation = "pointytop", name = NULL, scale = 1, q = NULL,
      fill_color = "gray", line_dash = list(), line_dash_offset = 0L,
      tags = list(), js_event_callbacks = structure(list(), .Names =
      character(0)), fill_alpha = 1, subscribed_events = list(),
      line_color = NULL, line_width = 1L, line_cap = "butt", line_alpha = 1,
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["HexTile"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # 
    # > Float
    aspect_scale = NULL,
    # The radius (in data space units) of the hex tiling.
    # 
    # The radius is always measured along the cartesian y-axis for
    # "pointy_top" orientation, and along the cartesian x-axis for "flat_top"
    # orientation. If the aspect ratio of the underlying cartesian system is
    # not 1-1, then the tiles may be "squished" in one direction. To ensure
    # that the tiles are always regular hexagons, consider setting the
    # ``match_aspect`` property of the plot to True.
    # > Float
    size = NULL,
    # The "row" axial coordinates of the tile centers.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    r = NULL,
    # The line join values for the horizontal bars.
    # > Enum('miter', 'round', 'bevel')
    line_join = NULL,
    # 
    # > String
    orientation = NULL,
    # A scale factor for individual tiles.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    scale = NULL,
    # The "column" axial coordinates of the tile centers.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    q = NULL,
    # The fill color values for the horizontal bars.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    fill_color = NULL,
    # The line dash values for the horizontal bars.
    # > DashPattern
    line_dash = NULL,
    # The line dash offset values for the horizontal bars.
    # > Int
    line_dash_offset = NULL,
    # The fill alpha values for the horizontal bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    fill_alpha = NULL,
    # The line color values for the horizontal bars.
    # > ColorSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Color)), Color)
    line_color = NULL,
    # The line width values for the horizontal bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_width = NULL,
    # The line cap values for the horizontal bars.
    # > Enum('butt', 'round', 'square')
    line_cap = NULL,
    # The line alpha values for the horizontal bars.
    # > NumberSpec(String, Dict(Enum('expr', 'field', 'value', 'transform'), Either(String, Instance(Transform), Instance(Expression), Float)), Float)
    line_alpha = NULL
  )
)

# *toolbar icon*: |point_draw_icon|
# 
# The PointDrawTool allows adding, dragging and deleting point-like
# glyphs (i.e subclasses of``XYGlyph``) on one or more renderers by
# editing the underlying ``ColumnDataSource`` data. Like other drawing
# tools, the renderers that are to be edited must be supplied explicitly
# as a list. Any newly added points will be inserted on the
# ``ColumnDataSource`` of the first supplied renderer.
# 
# The tool will modify the columns on the data source corresponding to
# the ``x`` and ``y`` values of the glyph. Any additional columns in the
# data source will be padded with the given ``empty_value`` when adding a
# new point.
# 
# .. note:: The data source updates will trigger data change events
# continuously throughout the edit operations on the BokehJS side. In
# Bokeh server apps, the data source will only be synced once, when the
# edit operation finishes.
# 
# The supported actions include:
# 
# * Add point: Tap anywhere on the plot
# 
# * Move point: Tap and drag an existing point, the point will be dropped
# once you let go of the mouse button.
# 
# * Delete point: Tap a point to select it then press <<backspace>> key
# while the mouse is within the plot area.
# 
# .. |point_draw_icon| image:: /_images/icons/PointDraw.png :height: 18pt
PointDrawTool <- R6::R6Class("PointDrawTool",
  inherit = EditTool,
  public = list(
    specified_args = NULL,
    initialize = function(
      add = TRUE, custom_icon = NULL, drag = TRUE,
      js_property_callbacks = structure(list(), .Names = character(0)),
      tags = list(), renderers = list(), empty_value = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      subscribed_events = list(), num_objects = 0L, name = NULL,
      custom_tooltip = NULL, id = NULL
    ) {
      super$initialize(custom_icon = custom_icon,
        js_property_callbacks = js_property_callbacks, tags = tags,
        renderers = renderers, empty_value = empty_value,
        js_event_callbacks = js_event_callbacks,
        subscribed_events = subscribed_events, name = name,
        custom_tooltip = custom_tooltip, id = id)
      types <- bk_prop_types[["PointDrawTool"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Enables adding of new points on tap events.
    # > Bool
    add = NULL,
    # Enables dragging of existing points on pan events.
    # > Bool
    drag = NULL,
    # Defines a limit on the number of points that can be drawn. By default
    # there is no limit on the number of objects, but if enabled the oldest
    # drawn point will be dropped to make space for the new point.
    # > Int
    num_objects = NULL
  )
)

# 
LogScale <- R6::R6Class("LogScale",
  inherit = Scale,
  public = list(
    specified_args = NULL,
    initialize = function(
      subscribed_events = list(), js_property_callbacks = structure(list(),
      .Names = character(0)), tags = list(), name = NULL,
      js_event_callbacks = structure(list(), .Names = character(0)),
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["LogScale"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(

  )
)

# A ``TickFormatter`` for displaying datetime values nicely across a
# range of scales.
# 
# ``DatetimeTickFormatter`` has the following properties (listed together
# with their default values) that can be used to control the formatting
# of axis ticks at different scales scales:
# 
# .. code-block:: python
# 
# microseconds = ['%fus']
# 
# milliseconds = ['%3Nms', '%S.%3Ns']
# 
# seconds = ['%Ss']
# 
# minsec = [':%M:%S']
# 
# minutes = [':%M', '%Mm']
# 
# hourmin = ['%H:%M']
# 
# hours = ['%Hh', '%H:%M']
# 
# days = ['%m/%d', '%a%d']
# 
# months = ['%m/%Y', '%b %Y']
# 
# years = ['%Y']
# 
# Each scale property can be set to format or list of formats to use for
# formatting datetime tick values that fall in in that "time scale".  By
# default, only the first format string passed for each time scale will
# be used. By default, all leading zeros are stripped away from the
# formatted labels.
# 
# This list of supported `strftime`_ formats is reproduced below.
# 
# %a The abbreviated name of the day of the week according to the current
# locale.
# 
# %A The full name of the day of the week according to the current
# locale.
# 
# %b The abbreviated month name according to the current locale.
# 
# %B The full month name according to the current locale.
# 
# %c The preferred date and time representation for the current locale.
# 
# %C The century number (year/100) as a 2-digit integer.
# 
# %d The day of the month as a decimal number (range 01 to 31).
# 
# %D Equivalent to %m/%d/%y.  (Americans should note that in many other
# countries %d/%m/%y is rather common. This means that in international
# context this format is ambiguous and should not be used.)
# 
# %e Like %d, the day of the month as a decimal number, but a leading
# zero is replaced by a space.
# 
# %f Microsecond as a decimal number, zero-padded on the left (range
# 000000-999999). This is an extension to the set of directives available
# to `timezone`_.
# 
# %F Equivalent to %Y-%m-%d (the ISO 8601 date format).
# 
# %G The ISO 8601 week-based year with century as a decimal number.  The
# 4-digit year corresponding to the ISO week number (see %V).  This has
# the same format and value as %Y, except that if the ISO week number
# belongs to the previous or next year, that year is used instead.
# 
# %g Like %G, but without century, that is, with a 2-digit year (00-99).
# 
# %h Equivalent to %b.
# 
# %H The hour as a decimal number using a 24-hour clock (range 00 to 23).
# 
# %I The hour as a decimal number using a 12-hour clock (range 01 to 12).
# 
# %j The day of the year as a decimal number (range 001 to 366).
# 
# %k The hour (24-hour clock) as a decimal number (range 0 to 23).
# Single digits are preceded by a blank.  (See also %H.)
# 
# %l The hour (12-hour clock) as a decimal number (range 1 to 12).
# Single digits are preceded by a blank.  (See also %I.)  (TZ)
# 
# %m The month as a decimal number (range 01 to 12).
# 
# %M The minute as a decimal number (range 00 to 59).
# 
# %n A newline character. Bokeh text does not currently support newline
# characters.
# 
# %N Nanosecond as a decimal number, zero-padded on the left (range
# 000000000-999999999). Supports a padding width specifier, i.e.  %3N
# displays 3 leftmost digits. However, this is only accurate to the
# millisecond level of precision due to limitations of `timezone`_.
# 
# %p Either "AM" or "PM" according to the given time value, or the
# corresponding strings for the current locale.  Noon is treated as "PM"
# and midnight as "AM".
# 
# %P Like %p but in lowercase: "am" or "pm" or a corresponding string for
# the current locale.
# 
# %r The time in a.m. or p.m. notation.  In the POSIX locale this is
# equivalent to %I:%M:%S %p.
# 
# %R The time in 24-hour notation (%H:%M). For a version including the
# seconds, see %T below.
# 
# %s The number of seconds since the Epoch, 1970-01-01 00:00:00 +0000
# (UTC).
# 
# %S The second as a decimal number (range 00 to 60).  (The range is up
# to 60 to allow for occasional leap seconds.)
# 
# %t A tab character. Bokeh text does not currently support tab
# characters.
# 
# %T The time in 24-hour notation (%H:%M:%S).
# 
# %u The day of the week as a decimal, range 1 to 7, Monday being 1.  See
# also %w.
# 
# %U The week number of the current year as a decimal number, range 00 to
# 53, starting with the first Sunday as the first day of week 01.  See
# also %V and %W.
# 
# %V The ISO 8601 week number (see NOTES) of the current year as a
# decimal number, range 01 to 53, where week 1 is the first week that has
# at least 4 days in the new year.  See also %U and %W.
# 
# %w The day of the week as a decimal, range 0 to 6, Sunday being 0.  See
# also %u.
# 
# %W The week number of the current year as a decimal number, range 00 to
# 53, starting with the first Monday as the first day of week 01.
# 
# %x The preferred date representation for the current locale without the
# time.
# 
# %X The preferred time representation for the current locale without the
# date.
# 
# %y The year as a decimal number without a century (range 00 to 99).
# 
# %Y The year as a decimal number including the century.
# 
# %z The +hhmm or -hhmm numeric timezone (that is, the hour and minute
# offset from UTC).
# 
# %Z The timezone name or abbreviation.
# 
# %% A literal '%' character.
# 
# .. warning:: The client library BokehJS uses the `timezone`_ library to
# format datetimes. The inclusion of the list below is based on the claim
# that `timezone`_ makes to support "the full compliment of GNU date
# format specifiers." However, this claim has not been tested
# exhaustively against this list. If you find formats that do not
# function as expected, please submit a `github issue`_, so that the
# documentation can be updated appropriately.
# 
# .. _strftime: http://man7.org/linux/man-pages/man3/strftime.3.html ..
# _timezone: http://bigeasy.github.io/timezone/ .. _github issue:
# https://github.com/bokeh/bokeh/issues
DatetimeTickFormatter <- R6::R6Class("DatetimeTickFormatter",
  inherit = TickFormatter,
  public = list(
    specified_args = NULL,
    initialize = function(
      minsec = list(":%M:%S"), minutes = list(":%M", "%Mm"),
      js_property_callbacks = structure(list(), .Names = character(0)),
      hours = list("%Hh", "%H:%M"), months = list("%m/%Y", "%b %Y"),
      milliseconds = list("%3Nms", "%S.%3Ns"), tags = list(),
      years = list("%Y"), days = list("%m/%d", "%a%d"),
      microseconds = list("%fus"), seconds = list("%Ss"),
      hourmin = list("%H:%M"), js_event_callbacks = structure(list(),
      .Names = character(0)), subscribed_events = list(), name = NULL,
      id = NULL
    ) {
      super$initialize(subscribed_events = subscribed_events,
        js_property_callbacks = js_property_callbacks, tags = tags,
        name = name, js_event_callbacks = js_event_callbacks, id = id)
      types <- bk_prop_types[["DatetimeTickFormatter"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # Formats for displaying datetime values in the ``minsec`` (for combined
    # minutes and seconds) range.
    # 
    # See the :class:`~bokeh.models.formatters.DatetimeTickFormatter` help
    # for a list of all supported formats.
    # > List(String)
    minsec = NULL,
    # Formats for displaying datetime values in the ``minutes`` range.
    # 
    # See the :class:`~bokeh.models.formatters.DatetimeTickFormatter` help
    # for a list of all supported formats.
    # > List(String)
    minutes = NULL,
    # Formats for displaying datetime values in the ``hours`` range.
    # 
    # See the :class:`~bokeh.models.formatters.DatetimeTickFormatter` help
    # for a list of all supported formats.
    # > List(String)
    hours = NULL,
    # Formats for displaying datetime values in the ``months`` range.
    # 
    # See the :class:`~bokeh.models.formatters.DatetimeTickFormatter` help
    # for a list of all supported formats.
    # > List(String)
    months = NULL,
    # Formats for displaying datetime values in the ``milliseconds`` range.
    # 
    # See the :class:`~bokeh.models.formatters.DatetimeTickFormatter` help
    # for a list of all supported formats.
    # > List(String)
    milliseconds = NULL,
    # Formats for displaying datetime values in the ``years`` range.
    # 
    # See the :class:`~bokeh.models.formatters.DatetimeTickFormatter` help
    # for a list of all supported formats.
    # > List(String)
    years = NULL,
    # Formats for displaying datetime values in the ``days`` range.
    # 
    # See the :class:`~bokeh.models.formatters.DatetimeTickFormatter` help
    # for a list of all supported formats.
    # > List(String)
    days = NULL,
    # Formats for displaying datetime values in the ``microseconds`` range.
    # 
    # See the :class:`~bokeh.models.formatters.DatetimeTickFormatter` help
    # for a list of all supported formats.
    # > List(String)
    microseconds = NULL,
    # Formats for displaying datetime values in the ``seconds`` range.
    # 
    # See the :class:`~bokeh.models.formatters.DatetimeTickFormatter` help
    # for a list of all supported formats.
    # > List(String)
    seconds = NULL,
    # Formats for displaying datetime values in the ``hourmin`` (for combined
    # hours and minutes) range.
    # 
    # See the :class:`~bokeh.models.formatters.DatetimeTickFormatter` help
    # for a list of all supported formats.
    # > List(String)
    hourmin = NULL
  )
)

# Base class
Base <- R6::R6Class("Base",
  public = list(
    specified_args = NULL,
    initialize = function(
      id = NULL
    ) {
      super$initialize()
      types <- bk_prop_types[["Base"]]
      for (nm in names(types)) {
        private[[nm]] <- validate(get(nm), types[[nm]]$type, nm)
      }
      self$specified_args <- get_specified_arg_names(match.call())
    }
  ),
  private = list(
    # id
    # > String
    id = NULL
  )
)

