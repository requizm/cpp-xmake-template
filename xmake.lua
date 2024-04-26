add_requires("fmt 9.1.0", "yaml_cpp_struct v1.0.2", "magic_enum v0.9.5")
add_rules("mode.debug", "mode.release")

set_version("0.1.0")

rule("last-build-info")
    after_build(function(target)
        local info = {
            version = "0.1.0",
            executable = target:name(),
            executable_with_ext = target:name() .. ".exe",
            release_path = target:targetdir(),
            included_files = {
            }
        }
        import("json")
        local info_json = json.stringify(info)
        local info_file = io.writefile(target:scriptdir() .. "/last_build.json", info_json)
    end)
    after_install(function(target)
        local info = {
            version = "0.1.0",
            executable = target:name(),
            executable_with_ext = target:name() .. ".exe",
            release_path = target:installdir() .. "/bin",
            included_files = {
            }
        }
        import("json")
        local info_json = json.stringify(info)
        local info_file = io.writefile(target:scriptdir() .. "/last_build.json", info_json)
    end)

target("template-name")
    set_kind("binary")
    add_syslinks("Ole32")
    add_languages("c++17")
    add_packages("fmt", "rapidjson", "yaml_cpp_struct", "magic_enum")
    add_files("src/*.cpp")
    add_includedirs("src")

    add_headerfiles("src/*.hpp", "resources/*.rh")
    add_files("resources/*.rc")
    add_rules("last-build-info")
