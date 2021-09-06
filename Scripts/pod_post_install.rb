

# Overwriting Header Search Paths
# Last update: CocoaPods v1.9.3
#
# Discussion:
# BUCK by default doesn't support #import "" (import quote) on frameworks or libraries.
# Infra team want to enforce full import using #import <Framework/Framework.h> or @import Framework;
# So that imports works on both Xcodebuild and BUCK.
#
# Somehow, CocoaPods adding header search to the .framework/Headers. While,
# if we add frameworks manually, it won't also add search path to the .framework/Headers.
# We believe this is something that CocoaPods done in order to simplify imports, by doing any means
# so that it work as intended to do by ignoring some of best practices.
#
# In this script, we want to exclude some of those header search path added by CocoaPods.
def overwrite_header_search_path(installer, target_name)
  puts "Configuring header search paths..."

  installer.generated_aggregate_targets&.each do |target|
    if target.name == target_name

      target.xcconfigs.each do |config_name, config_file|
        # Throw away $(inherited) in HEADER_SEARCH_PATHS
        config_file.attributes["HEADER_SEARCH_PATHS"] = config_file.attributes["HEADER_SEARCH_PATHS"].gsub(/\$\(inherited\) /, "")

        # Throw away .framework/Headers in HEADER_SEARCH_PATHS
        config_file.attributes["HEADER_SEARCH_PATHS"] = config_file.attributes["HEADER_SEARCH_PATHS"].gsub(/"\$\{PODS_CONFIGURATION_BUILD_DIR\}\/.*Headers" /, "")

        # Throw away $(inherited) in OTHER_CFLAGS
        config_file.attributes["OTHER_CFLAGS"] = config_file.attributes["OTHER_CFLAGS"].gsub(/\$\(inherited\) /, "")

        # Throw away -iSystem .framework/Headers in OTHER_CFLAGS
        config_file.attributes["OTHER_CFLAGS"] = config_file.attributes["OTHER_CFLAGS"].gsub(/-isystem "\${PODS_CONFIGURATION_BUILD_DIR}.*Headers" /, "")

        xcconfig_path = target.xcconfig_path(config_name)
        config_file.save_as(xcconfig_path)
      end
    end
  end

  puts "\e[32m√ Header search path configured!\e[0m"
end


# Auto Generated Umbrella Header for Internal Modules
# Last update: CocoaPods v1.9.3
#
# Discussion:
# CocoaPods by default create umbrella header for modules with format <module_name>-umbrella.h.
# When you used BUCK, it will use non generated umbrella header on CocoaPods.
#
# In this particular scripting, we will generate umbrella header, copy any imports from generated umbrella header
# by CocoaPods to the real umbrella header.
def auto_generate_umbrella_header_modules(installer)
  puts "Generating umbrella header..."

  installer.development_pod_targets.each do |target|
    root_path = `pwd`.split("/ios/").first.chomp + "/ios/Traveloka"
    module_umbrella_header_path = "#{root_path}/Modules/#{target.name}/#{target.name}/#{target.name}.h"
    module_umbrella_impl = "#{root_path}/Modules/#{target.name}/#{target.name}/#{target.name}.m"
    cocoapods_umbrella_header_path = "./Pods/Target Support Files/#{target.name}/#{target.name}-umbrella.h"

    # If a module has module_umbrella_impl, then it might not have umbrella header inside.
    if File.file?(module_umbrella_header_path) && File.file?(cocoapods_umbrella_header_path) && !File.file?(module_umbrella_impl)

      public_headers = []

      # Read from CocoaPods generated header
      File.open(cocoapods_umbrella_header_path, 'r') { |f|
        f.each { |line|
          if !(line.include? "#import \"#{target.name}.h\"")
            public_headers << line
          end
        }
        f.close
      }

      # Write to real umbrella header
      File.open(module_umbrella_header_path, 'w') { |f|
        f.write "// Generated with ruby script\n"
        f.write "\n\n"

        public_headers.each { |header|
          f.write "#{header}"
        }

        f.write "\n\n"

        f.close
      }
    end
  end

  puts "\e[32m√ Umbrella header generated!\e[0m"
end


def setup_pod_projects_build_configs(installer)
  swift_version = "5.0"
  os_version = "12.0"

  installer.generated_projects&.each do |project|
    project.targets&.each do |target|
      if target.name == "RNSVG"
        target.build_configurations.each do |config|
          config.build_settings['GCC_NO_COMMON_BLOCKS'] = 'NO'
        end
      elsif target.name == "Appboy-iOS-SDK"
        target.build_configurations.each do |config|
          config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'ABK_ENABLE_IDFA_COLLECTION']
        end
      end
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = "#{swift_version}"
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = "#{os_version}"
      end
    end
  end
end
