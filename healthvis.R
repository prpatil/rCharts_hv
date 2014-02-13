hvPlot <- function(...){
  myChart <- hv$new()
  myChart$getChartParams(...)
  return(myChart$copy())
}

hv <- setRefClass('hv', contains = 'rCharts', methods = list(
  initialize = function(){
    callSuper(); 
    params <<- c(params, list(controls = list(),
      chart = list(),
      filters = list()
    ))
  },
  chart = function(..., replace = F){
    params$chart <<- setSpec(params$chart, ..., replace = replace)
  },
  addControls = function(nm, value, values, label = paste("Select ", nm, ":")){
    .self$setTemplate(
      page = 'rChartControls2.html',
      script = 'icon_array.html'
    )
    #.self$set(width = 700)
    control = list(name = nm, value = value, values = values, label = label)
    params$controls[[nm]] <<- control
  },
  getChartParams = function(...){
    params <<- modifyList(params, getLayer(...))
  },
  getPayload = function(chartId){
    chart = toChain(params$chart, 'chart')
    controls_json = toJSON2(params$controls)
    filters_json = toJSON2(params$filters)
    controls = setNames(params$controls, NULL)
    opts = toJSON2(params[!(names(params) %in% c('data', 'chart', 'xAxis', 'x2Axis', 'yAxis', 'controls', 'filters'))])
    list(opts = opts, chartParams=toJSON2(params),
         chart = chart, chartId = chartId, controls = controls, 
         controls_json = controls_json, CODE = srccode, 
         filters_json = filters_json, hasFilter = (length(params$filters) > 0)
    )
  }
))