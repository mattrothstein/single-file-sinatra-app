###### SINATRA APP #######
require "sinatra"
require "json"
require "coderay"

f = File.open(__FILE__)

get "/code" do
  content_type :json
  { "code" => f.read.to_s }.to_json
end

get "/" do
  erb :html
end

get "/home" do
  erb :html
end

####### RUBY CODE TO SPLIT CODE FOR SYNTAX HIGHLIGHTING #######

$ruby_code = ""
ruby_array = File.open(__FILE__).readlines

ruby_array.each_with_index do |line, num|
  break if num == 41
  $ruby_code += line
end

$erb_code = ""
erb_array = File.open(__FILE__).readlines

erb_array.each_with_index do |line, num|
  if num >= 41
    $erb_code += line
  end
end

__END__

##### VIEWS ######

@@html
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>Sinatra App</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
</head>
<body>
  <br><br>
  <center><h3 style="text-transform:uppercase">This is the code for a single file sinatra app</h3><h5 style="text-transform:uppercase">the code snippets have been seperated to ensure proper syntax highlighting</h5></center>
  <div class="container">
    <div class="row">
      <div class="col-md-6">
        <center><h4>RUBY CODE</h4></center>
        <%= CodeRay.scan($ruby_code, :ruby).div %>
      </div>
      <div class="col-md-6">
        <center><h4>ERB CODE</h4></center>
        <%= CodeRay.scan($erb_code, :erb).div %>
      </div>
    </div>
  </div>
</body>
</html>
