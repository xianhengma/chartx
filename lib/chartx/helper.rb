require "json"
require "erb"

module Chartx
  module Helper
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
      
      var data = #{data_source.to_json}; 
       nv.addGraph(function() {
           var chart = nv.models.pieChart()
               .x(function(d) { return d.key })
               .y(function(d) { return d.y })
               //.showLabels(true)
               .values(function(d) { return d })
               .color(d3.scale.category10().range())
               .width(#{width})
               .height(#{height});

             d3.select("##{elem_id} svg")
                 .datum([data])
               .transition().duration(1200)
                 .attr('width', #{width})
                 .attr('height', #{height})
                 .call(chart);

           //chart.dispatch.on('stateChange', function(e) { nv.log('New State:', JSON.stringify(e)); });
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
