require "json"
require "erb"

module Chartx
  module Helper
    
    #pie_chart has different input data format LoL
    #TODO: fix the input data format
    def pie_chart(data_source, options = {})
      chartx "pie", data_source, options
    end
    
    def discrete_bar_chart(data_source, options = {})
      chartx "discrete_bar", data_source, options
    end
    
    def multi_bar_chart(data_source, options = {})
      chartx "multi_bar", data_source, options
    end
    
    def multi_bar_horizontal_chart(data_source, options = {})
      chartx "multi_bar_horizontal", data_source, options
    end
    
    def line_chart(data_source, options = {}) 
      chartx "line", data_source, options
    end
    
    def line_with_focus_chart(data_source, options = {})
      chartx "line_with_focus", data_source, options
    end
    
    def scatter_chart(data_source, options = {})
      chartx "scatter", data_source, options
    end
    
    def stacked_area_chart(data_source, options = {})
      chartx "stacked_area", data_source, options
    end
    
    def bullet_chart(data_source, options = {})
      chartx "bullet", data_source, options
    end
    
    def chartx(chart_type, data_source, options, &block)
      
      options = options.dup
      @chartx_id ||= 0
      
      height = options.delete(:height) || "600"
      width = options.delete(:width) || "600"
      elem_id = options.delete(:id) || "chart-#{@chartx_id += 1}"
      
      x_name = options.delete(:x_name) || "label"
      y_name = options.delete(:y_name) || "value"
      
      stagger_labels = options.delete(:stagger_labels) || true
      show_tooltips = options.delete(:show_tooltips) || false
      show_values = options.delete(:show_values) || false
      show_labels = options.delete(:show_labels) || true
      color = options.delete(:color) || "category10"
      show_controls = options.delete(:show_controls) || false
      
      show_dist_x = options.delete(:show_x_dist) || true
      show_dist_y = options.delete(:show_y_dist) || true
      
      x_axis_format = options.delete(:x_axis_format) || ',f'
      y_axis_format = options.delete(:y_axis_format) || ',.2f'
      y2_axis_format = options.delete(:y2_axis_format) || '.2f'
      
      clip_edge = options.delete(:clip_edge) || true
      
      case chart_type
        when "discrete_bar"
          chart_str = "var chart = nv.models.discreteBarChart()
            .x(function(d) { return d.#{x_name} })
            .y(function(d) { return d.#{y_name} })
            .staggerLabels(#{stagger_labels})
            .tooltips(#{show_tooltips})
            .showValues(#{show_values})
            .width(#{width})
            .height(#{height});"
          
        when "pie"      
          data_source = [data_source] # bug of nvd3
          chart_str = "var chart = nv.models.pieChart()
            .x(function(d) { return d.#{x_name} })
            .y(function(d) { return d.#{y_name} })
            .values(function(d) { return d })  
            .color(d3.scale.#{color}().range())
            .width(#{width})
            .height(#{height});"

        when "multi_bar", "line"      
          chart_str = "var chart = nv.models.multiBarChart()
            .width(#{width})
            .height(#{height});
            chart.xAxis.tickFormat(d3.format('#{x_axis_format}'));
            chart.yAxis.tickFormat(d3.format('#{y_axis_format}'));"      
      
        when "multi_bar_horizontal"      
          chart_str = "var chart = nv.models.multiBarHorizontalChart()
            .x(function(d) { return d.#{x_name} })
            .y(function(d) { return d.#{y_name} })
            .showValues(#{show_values})
            .tooltips(#{show_tooltips})
            .showControls(#{show_controls})
            .width(#{width})
            .height(#{height});
            chart.yAxis.tickFormat(d3.format('#{x_axis_format}'));"
      
        when  "line_with_focus"       
          chart_str = "var chart = nv.models.lineWithFocusChart()
            .width(#{width})
            .height(#{height});
            chart.xAxis.tickFormat(d3.format('#{x_axis_format}'));
            chart.yAxis.tickFormat(d3.format('#{y_axis_format}'));
            chart.y2Axis.tickFormat(d3.format('#{y2_axis_format}'));"   
            
        when "scatter"       
          chart_str = "chart = nv.models.scatterChart()
            .showDistX(#{show_dist_x})
            .showDistY(#{show_dist_y})
            .useVoronoi(true)
            .color(d3.scale.category10().range())
            .width(#{width})
            .height(#{height});
            chart.xAxis.tickFormat(d3.format('#{x_axis_format}'));
            chart.yAxis.tickFormat(d3.format('#{y_axis_format}'));"
            
        when "stacked_area"       
          chart_str = "var chart = nv.models.stackedAreaChart()
            .x(function(d) { return d.#{x_name} })
            .y(function(d) { return d.#{y_name} })
            .clipEdge(#{clip_edge})
            .width(#{width})
            .height(#{height});
            chart.xAxis.tickFormat(d3.format('#{x_axis_format}'));
            chart.yAxis.tickFormat(d3.format('#{y_axis_format}'));"
      
        when "bullet"
          chart_str = "var chart = nv.models.bulletChart();"
      end
      
      html = <<HTML
      <div id="#{ERB::Util.html_escape(elem_id)}" style="height: #{ERB::Util.html_escape(height)}px;">
      <svg></svg>
      </div>
HTML

      js = <<JS
      <script type="text/javascript">
        nv.addGraph(function() {
        #{chart_str}
        

        
        d3.select("##{elem_id} svg")
            .datum(#{data_source.to_json})
            .transition().duration(500)
            .call(chart);

        return chart;
      });
      </script>
JS

      if options[:content_for]
        content_for(options[:content_for]) { js.respond_to?(:html_safe) ? js.html_safe : js }
      else
        html += js
      end

      html.respond_to?(:html_safe) ? html.html_safe : html
      
    end
    
  end
end
