require 'sinatra'
require "sinatra/reloader" if development?
require 'active_record'
require 'pry'
require 'zlib'

configure :development, :production do
    ActiveRecord::Base.establish_connection(
       :adapter => 'sqlite3',
       :database =>  'db/dev.sqlite3.db'
     )
end

# Quick and dirty form for testing application
#
# If building a real application you should probably
# use views: 
# http://www.sinatrarb.com/intro#Views%20/%20Templates
form = <<-eos
    <form id='myForm'>
        <input type='text' name="url">
        <input type="submit" value="Shorten"> 
    </form>
    <h2>Results:</h2>
    <h3 id="display"></h3>
    <script src="jquery.js"></script>

    <script type="text/javascript">
        $(function() {
            $('#myForm').submit(function() {
            $.post('/new', $("#myForm").serialize(), function(data){
                $('#display').html(data);
                });
            return false;
            });
    });
    </script>
eos

# Models to Access the database
# through ActiveRecord.  Define
# associations here if need be
#
# http://guides.rubyonrails.org/association_basics.html


class Link < ActiveRecord::Base
  self.table_name = "url_table"
end

get '/' do
    form
end

post '/new' do
    # PUT CODE HERE TO CREATE NEW SHORTENED LINKS
    # puts params[:url]
    # crc32 = Zlib::crc32(params[:url]).to_s
    # puts crc32
    # crc32
    #use url and crc32 in link funciton
    # @link = Link.create(hashURL: crc32, url: @params['url'])
    @link = Link.create(hashURL: 'hashURL', normalUrl: 'url')
    binding.pry
end

get '/jquery.js' do
    send_file 'jquery.js'
end

####################################################
####  Implement Routes to make the specs pass ######
####################################################``
