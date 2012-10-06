# The Cleveland  Professional 20/30 Club
-

### About the club:
The Cleveland Professional 20/30 Club a group of young professionals who are working to create a thriving community for young professionals in Northeast Ohio. The Club provides a place where we socialize, network, discover and volunteer; it's an organization where you can enjoy life.

### About the software:
The Cleveland Professional 20/30 Club moved to Ruby on Rails in September 2010.  The development of the site has been almost entirely driven by volunteers in the community.  If you would like to contribute, or learn how to get involved, please contact the Technology Director technology@cleveland2030.org

### Getting started:
Though it is not enforced, we highly recommend using RVM to manage Ruby versions and gemsets.

//Note: If you are using OSX, you will need to install the Command Line Tools before you can continue.  https://developer.apple.com/downloads/index.action 

To install RVM, follow the instructions listed on their site: https://rvm.io/rvm/install/

You will need to install Ruby 1.9.3:

command: rvm install 1.9.3

Next you will need to install Bundler.

command: rvm use 1.9.3@global

command: gem install bundler
  
//Note: This will add bundler to your global gemset for the current version of ruby (1.9.3).

Clone the repository and cd to the project.

Once in the project's root directory copy the .rvmrc.sample file to .rvmrc

command: cp .rvmrc.sample .rvmrc

command: source .rvmrc

By sourcing the .rvmrc file, you should now have a new gemset @2030, and you should have been automatically switched into that gemset.  To verify you are in the correct gemset

command: rvm current

You should see output similar to ruby-1.9.3-p194@2030

Install all the gems for the project.

command: bundle install

You should be ready to go!

### License:

Copyright &copy; 2012 Cleveland Professional 20/30 Club

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



