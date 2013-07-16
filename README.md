# Chartx

Create beautiful d3/nvd3 javascript charts using Ruby.

## Installation

Add this line to your application's Gemfile:

    gem 'chartx'

And then execute:

    $ bundle install


## Usage

Pie Chart

```erb
<%= pie_chart @pie_data %>
```

Line Chart

```erb
<%= line_chart @pie_data %>
```

Discrete Bar Chart

```erb
<%= discrete_bar_chart @pie_data %>
```

Line Chart with Focus (View Finder)

```erb
<%= line_with_focus_chart @pie_data %>
```

Scatter Chart

```erb
<%= scatter_chart @pie_data %>
```

Bullet Chart

```erb
<%= bullet_chart @pie_data %>
```

Multi Bar Chart

```erb
<%= multi_bar_chart @pie_data %>
```

Multi Horizontal Bar Chart

```erb
<%= multi_bar_horizontal_chart @pie_data %>
```

## Input Data

For pie Chart

```js
@pie_data = [
	{:label=>"Group1", :value=>14}, 
	{:label=>"Group2", :value=>10}, 
	{:label=>"Group3", :value=>11}, 
	{:label=>"Group4", :value=>0}, 
	{:label=>"Group5", :value=>4}
]
```

For pie Chart

```js
@pie_data = [
	{:label=>"Group1", :value=>14}, 
	{:label=>"Group2", :value=>10}, 
	{:label=>"Group3", :value=>11}, 
	{:label=>"Group4", :value=>0}, 
	{:label=>"Group5", :value=>4}
]
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
