# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/ru.auroraaihub.aurora-ai-hub_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/ru.auroraaihub.aurora-ai-hub_autogen.dir/ParseCache.txt"
  "ru.auroraaihub.aurora-ai-hub_autogen"
  )
endif()
