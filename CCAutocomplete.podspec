Pod::Spec.new do |s|
  s.name         	= "CCAutocomplete"
  s.version      	= "1.0.1"
  s.summary      	= "Autocomplete for UITextField"
  s.ios.deployment_target = 9.0
  s.homepage     	= "https://github.com/juanbus/CCAutocomplete"
  s.license      	= "MIT"
  s.author			= { "Amir Rezvani" => "iosmate-misc@yahoo.com" }
  s.description 	= 'Autocomplete is a lightweight component that gives you the ability to extend UITextField and add autocomplete functionality to it'
  s.source      	= { :git => "https://github.com/juanbus/CCAutocomplete.git", :branch => "master",:tag => s.version }
  s.source_files 	= "Autocomplete/AutoComplete/*.swift"
  s.resource 		= 'Autocomplete/AutoComplete/*.{png,xib,storyboard,lproj}'
end
