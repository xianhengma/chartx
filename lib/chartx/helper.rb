require "json"
require "erb"

module Chartx
  module Helper
    
    #pie_chart has different input data format LoL
    #Todo: fix the input data format
    def pie_chart(data_source, options = {})
      options = options.dup
      @chartx_id ||= 0
      height = options.delete(:height) || "600"
      width = options.delete(:width) || "500"
      elem_id = options.delete(:id) || "chart-#{@chartx_id += 1}"
      
      html = <<HTML
      <div id="#{ERB::Util.html_escape(elem_id)}" style="height: #{ERB::Util.html_escape(height)}px;">
      <svg></svg>
      </div>
HTML
 
      js = <<JS
      
      <script type="text/javascript">
      
      var pie_input_data = #{data_source.to_json}; 
       nv.addGraph(function() {
           var chart = nv.models.pieChart()
               .x(function(d) { return d.label })
               .y(function(d) { return d.value })
               //.showLabels(true)
               .values(function(d) { return d })  
               .color(d3.scale.category10().range())
               .width(#{width})
               .height(#{height});

             d3.select("##{elem_id} svg")
                 .datum([pie_input_data])
               .transition().duration(500)
                 .attr('width', #{width})
                 .attr('height', #{height})
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
    
    def bar_chart(data_source, options ={})
      options = options.dup
      @chartx_id ||= 0
      height = options.delete(:height) || "600"
      width = options.delete(:width) || "500"
      elem_id = options.delete(:id) || "chart-#{@chartx_id += 1}"
      
      html = <<HTML
      <div id="#{ERB::Util.html_escape(elem_id)}" style="height: #{ERB::Util.html_escape(height)}px;">
      <svg></svg>
      </div>
HTML

      js = <<JS
      
      <script type="text/javascript">
      
      var bar_input_data = #{data_source.to_json}; 
      
      nv.addGraph(function() {  
        var chart = nv.models.discreteBarChart()
            .x(function(d) { return d.label })
            .y(function(d) { return d.value })
            .staggerLabels(true)
            //.staggerLabels(historicalBarChart[0].values.length > 8)
            .tooltips(false)
            .showValues(true)
            .width(#{width})
            .height(#{height});

        d3.select("##{elem_id} svg")
            .datum(bar_input_data)
            .transition().duration(500)
            .attr('width', #{width})
            .attr('height', #{height})
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
    
    def line_chart(data_source, options ={}) 
    
      options = options.dup
      @chartx_id ||= 0
      height = options.delete(:height) || "600"
      width = options.delete(:width) || "500"
      elem_id = options.delete(:id) || "chart-#{@chartx_id += 1}"
      
      x_axis_label = options.delete(:x_axis_label) || "X(Unit)"
      
      html = <<HTML
      <div id="#{ERB::Util.html_escape(elem_id)}" style="height: #{ERB::Util.html_escape(height)}px;">
      <svg></svg>
      </div>
HTML

      js = <<JS
      
      <script type="text/javascript">
      
      var line_data = #{data_source.to_json}; 
      var chart;

      nv.addGraph(function() {
        var chart = nv.models.lineChart();

        chart.xAxis
            //.axisLabel("#{x_axis_label}")
            .tickFormat(d3.format(',r'));

        chart.yAxis
            //.axisLabel('Voltage (v)')
            .tickFormat(d3.format('.02f'));

        chart.width(#{width})
            .height(#{height});
        d3.select("##{elem_id} svg")
            .datum(line_data)
          .transition().duration(500)
          .attr('width', #{width})
          .attr('height', #{height})
            .call(chart);

        nv.utils.windowResize(chart.update);

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
