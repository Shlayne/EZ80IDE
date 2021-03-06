project "CEmu"
	kind "StaticLib"
	language "C"
	cdialect "C17"
	staticruntime "On"

	targetdir ("%{wks.location}/bin/" .. OutputDir .. "/%{prj.name}")
	objdir ("%{wks.location}/bin-int/" .. OutputDir .. "/%{prj.name}")

	files {
		"CEmu/core/*.h",
		"CEmu/core/*.c",
		"CEmu/core/os/os.h",
		"CEmu/core/usb/*.h",
		"CEmu/core/usb/*.c"
	}

	defines {
		"MULTITHREAD"
	}

	includedirs {
		"CEmu"
	}

	filter "system:windows"
		systemversion "latest"

		files {
			"CEmu/core/os/os-win32.c"
		}

		defines {
			"_CRT_SECURE_NO_WARNINGS",
			-- Once again, Microsoft has done a fantastic job and implemented their macros
			-- with genuine undefined behavior, only when including <Windows.h> from c though...
			"MICROSOFT_WINDOWS_WINBASE_H_DEFINE_INTERLOCKED_CPLUSPLUS_OVERLOADS=0"
		}

	filter "configurations:Debug"
		runtime "Debug"
		optimize "Off"
		symbols "On"

		files {
			"CEmu/core/debug/**.h",
			"CEmu/core/debug/**.c"
		}

		defines {
			"DEBUG_SUPPORT"
		}

	filter "configurations:Release"
		runtime "Release"
		optimize "On"
		symbols "On"

	filter "configurations:Dist"
		runtime "Release"
		optimize "On"
		symbols "Off"
