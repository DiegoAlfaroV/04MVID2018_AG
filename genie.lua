local project_list = {
	"AG01",
	"AG02",
	"AG03",
	"AG04",
	"AG05_01",
	"AG05_02",
	"AG06",
	"AG07_01",
	"AG07_02",
	"AG08_01",
	"AG08_02",
	"AG08_03",
	"AG08_04",
	"AG08_05",
	"AG09_01",
	"AG10_01",
	"AG10_02",
	"AG10_03",
	"AG11",
	"AG12",
	"AG13"
}

local function new_project(name)
	project(name)
		kind("ConsoleApp")
		includedirs{"include", "src/deps/glfw", "src/deps/glad", "src/deps/stb"}
		files{"tests/"..name.."/*.cpp",
			  "tests/"..name.."/*.h",
			  "src/*.cpp",
			  "include/**.h",
			  "src/deps/glfw/context.c",
			  "src/deps/glfw/init.c",
			  "src/deps/glfw/input.c",
			  "src/deps/glfw/monitor.c",
			  "src/deps/glfw/window.c",
			  "src/deps/glfw/vulkan.c",
			  "src/deps/glad/glad.c",
			  "src/deps/stb/*"}
		defines {"_GLFW_USE_OPENGL=1"}
		vpaths {["Headers"] = "include/*.h",
				["Source"] = {"src/*.cpp"},
				["Deps Headers"] = {"include/GLFW/*",
						    "include/glad/**",
						    "include/KHR/**",
					   	    "include/glm/**"},
				["Deps Sources"] = "src/deps/**",
				["Tests"] = {"tests/"..name.."/*.cpp",
					     "tests/"..name.."/*.h"}}
		configuration{"debug"}
			flags{"Symbols"}
			targetsuffix("_d")
			libdirs{"libs/Debug"}
		configuration{"release"}
			flags("Optimize")
			targetsuffix("_r")
			libdirs{"libs/Release"}
		configuration{"windows"}
			files{"src/deps/glfw/egl_context.c",
				  "src/deps/glfw/win32*",
				  "src/deps/glfw/wgl_*",
				  "src/deps/glfw/winm_*"}
			links{"OpenGL32", "assimp-vc140-mt"}
			defines{"_GLFW_WIN32", "_GLFW_WGL"}
			flags{"NoEditAndcontinue"}
			windowstargetplatformversion "10.0.15063.0"
end

solution "OpenGL_Project"
	configurations { "debug", "release" }
	language ("c++")
	platforms ("x64")
	location ("build")
	debugdir ("build")
	targetdir ("bin")
	flags {"ExtraWarnings"}

for k,v in pairs(project_list) do
	new_project(v)
end
