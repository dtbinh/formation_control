# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/kadir/matlab_work/FormationControl/gazebo_components/plugins

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/kadir/matlab_work/FormationControl/gazebo_components/plugins/build

# Include any dependencies generated for this target.
include CMakeFiles/world_publisher.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/world_publisher.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/world_publisher.dir/flags.make

CMakeFiles/world_publisher.dir/world_publisher.cc.o: CMakeFiles/world_publisher.dir/flags.make
CMakeFiles/world_publisher.dir/world_publisher.cc.o: ../world_publisher.cc
	$(CMAKE_COMMAND) -E cmake_progress_report /home/kadir/matlab_work/FormationControl/gazebo_components/plugins/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object CMakeFiles/world_publisher.dir/world_publisher.cc.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/world_publisher.dir/world_publisher.cc.o -c /home/kadir/matlab_work/FormationControl/gazebo_components/plugins/world_publisher.cc

CMakeFiles/world_publisher.dir/world_publisher.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/world_publisher.dir/world_publisher.cc.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/kadir/matlab_work/FormationControl/gazebo_components/plugins/world_publisher.cc > CMakeFiles/world_publisher.dir/world_publisher.cc.i

CMakeFiles/world_publisher.dir/world_publisher.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/world_publisher.dir/world_publisher.cc.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/kadir/matlab_work/FormationControl/gazebo_components/plugins/world_publisher.cc -o CMakeFiles/world_publisher.dir/world_publisher.cc.s

CMakeFiles/world_publisher.dir/world_publisher.cc.o.requires:
.PHONY : CMakeFiles/world_publisher.dir/world_publisher.cc.o.requires

CMakeFiles/world_publisher.dir/world_publisher.cc.o.provides: CMakeFiles/world_publisher.dir/world_publisher.cc.o.requires
	$(MAKE) -f CMakeFiles/world_publisher.dir/build.make CMakeFiles/world_publisher.dir/world_publisher.cc.o.provides.build
.PHONY : CMakeFiles/world_publisher.dir/world_publisher.cc.o.provides

CMakeFiles/world_publisher.dir/world_publisher.cc.o.provides.build: CMakeFiles/world_publisher.dir/world_publisher.cc.o

# Object files for target world_publisher
world_publisher_OBJECTS = \
"CMakeFiles/world_publisher.dir/world_publisher.cc.o"

# External object files for target world_publisher
world_publisher_EXTERNAL_OBJECTS =

libworld_publisher.so: CMakeFiles/world_publisher.dir/world_publisher.cc.o
libworld_publisher.so: CMakeFiles/world_publisher.dir/build.make
libworld_publisher.so: /usr/lib/x86_64-linux-gnu/libboost_system.so
libworld_publisher.so: CMakeFiles/world_publisher.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX shared library libworld_publisher.so"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/world_publisher.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/world_publisher.dir/build: libworld_publisher.so
.PHONY : CMakeFiles/world_publisher.dir/build

CMakeFiles/world_publisher.dir/requires: CMakeFiles/world_publisher.dir/world_publisher.cc.o.requires
.PHONY : CMakeFiles/world_publisher.dir/requires

CMakeFiles/world_publisher.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/world_publisher.dir/cmake_clean.cmake
.PHONY : CMakeFiles/world_publisher.dir/clean

CMakeFiles/world_publisher.dir/depend:
	cd /home/kadir/matlab_work/FormationControl/gazebo_components/plugins/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/kadir/matlab_work/FormationControl/gazebo_components/plugins /home/kadir/matlab_work/FormationControl/gazebo_components/plugins /home/kadir/matlab_work/FormationControl/gazebo_components/plugins/build /home/kadir/matlab_work/FormationControl/gazebo_components/plugins/build /home/kadir/matlab_work/FormationControl/gazebo_components/plugins/build/CMakeFiles/world_publisher.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/world_publisher.dir/depend

