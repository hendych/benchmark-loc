require 'xcodeproj'

# Sort build phase so stripping build phase always happen
# after Pods Embed Frameworks and Pods Copy Resources phase.
def sort_project_build_phase
  puts "Reordering build phase..."

  project = Xcodeproj::Project.open("Traveloka.xcodeproj")

  project.native_targets.each { |target|

    if target.name == "Traveloka" || target.name == "Traveloka Staging"
      # Take the native embed frameworks phase and pods build phases.
      native_embed_phase = target.build_phases.select { | build_phase |
        build_phase.to_s == "Embed Frameworks"
      }.first
      pods_embed_phase = target.build_phases.select { | build_phase |
        build_phase.to_s == "[CP] Embed Pods Frameworks"
      }.first
      pods_copy_phase = target.build_phases.select { | build_phase |
        build_phase.to_s == "[CP] Copy Pods Resources"
      }.first

      index_native_embed_phase = target.build_phases.index(native_embed_phase)

      # Shift the phase to below embed frameworks phase in native build phase.
      if index_native_embed_phase < target.build_phases.length && (pods_embed_phase != nil && pods_copy_phase != nil)
        target.build_phases.delete(pods_embed_phase)
        target.build_phases.delete(pods_copy_phase)
        target.build_phases.insert(index_native_embed_phase + 1, pods_copy_phase)
        target.build_phases.insert(index_native_embed_phase + 1, pods_embed_phase)
      end
    end
  }

  project.save

  puts "\e[32m√ Build phase reorder complete!\e[0m"
end

sort_project_build_phase()
