Pod::Spec.new do |s|


  s.name         = "NSUserDefaults-Convenience"
  s.version      = "0.0.1"
  s.summary      = "NSUserDefaults-Convenience is a category on NSUserDefaults"

  s.description  = <<-DESC
                   The NSUserDefaults class provides a programmatic interface for interacting with the defaults system.

                   This category adds a series of miscellaneous improvements for increase speed of implementation and bolster the overall capability of the NSUserDefaults class.

                   These improvements include convenient macros for accessing the standard user defaults database, methods for determining if a defaults database has a given key, and synchronizing defaults with iCloud.

                   The category is also designed to be extensible, where applicable. For example, more options for synchronization can be added without interfering with running synchronization options.
                   DESC

  s.homepage     = "https://github.com/pcperini/NSUserDefaults-Convenience"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "pcperini" => "pcperini@gmail.com" }

  s.platform     = :ios
  s.platform     = :ios, "6.0"

  s.source       = { :git => "https://github.com/andriitishchenko/NSUserDefaults-Convenience", :tag => "v#{s.version.to_s}" }

  s.source_files  = "src/*.{h,m}"
  s.exclude_files = "extendedDemo/*.*"
  s.requires_arc = true

end