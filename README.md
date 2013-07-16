# Chartx

Create beautiful d3/nvd3 javascript charts using Ruby.

## Installation

Add this line to your application's Gemfile:

    gem 'chartx'

And then execute:

    $ bundle install


## Usage

Pie chart

```erb

@pie_data = [{:label=>"Group1", :value=>14}, 
			 {:label=>"Group2", :value=>10}, 
			 {:label=>"Group3", :value=>11}, 
			 {:label=>"Group4", :value=>0}, 
			 {:label=>"Group5", :value=>4}]

<%= pie_chart @pie_data %>
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
