# This file is generated by Edalize.
# Microsemi Tcl Script
# Libero

puts "----------------- Creating project libero-test-all ------------------------------"
# Create a new project with device parameters
new_project \
    -location {./prj} \
    -name libero-test-all \
    -project_description {} \
    -hdl {VHDL} \
    -family {PolarFire} \
    -die {MPF300TS_ES} \
    -package {FCG1152} \
    -speed {-1}  \
    -die_voltage {1.0}  \
    -part_range {EXT}  \
    -adv_options {IO_DEFT_STD:LVCMOS 1.8V} \

# Set up the include directories
set_global_include_path_order -paths " . "
build_design_hierarchy

# Link HDL sources and constraints
create_links \
    -sdc {sdc_file} \
    -hdl_source {sv_file.sv} \
    -hdl_source {vlog_file.v} \
    -hdl_source {vlog05_file.v} \
    -hdl_source {vhdl_file.vhd} \
    -hdl_source {vhdl2008_file} \
    -hdl_source {another_sv_file.sv} \
    -io_pdc {pdc_constraint_file.pdc} \
    -fp_pdc {pdc_floorplan_constraint_file.pdc} \

# Import HDL sources on libraries (logical_names)
create_links \
        -library {libx} \
        -hdl_source {vhdl_lfile} \


# Source user defined TCL scripts
puts "---------- Executing User TCL script: tcl_file.tcl ----------"
source tcl_file.tcl

# Build design hierarchy and set the top module
build_design_hierarchy
puts "Setting top level module to: {top_module::work}"
set_root -module {top_module::work}



# Configure Synthesize tool to use the generated Synplify TCL script
configure_tool -name {SYNTHESIZE} \
        -params [join [list "SYNPLIFY_TCL_FILE" [file join [file dirname [info script]] ../libero-test-all-syn-user.tcl]] ":"]

puts "Configured Synthesize tool to use script: libero-test-all-syn-user.tcl"
puts "Configured Synthesize tool to include dirs:"
puts "- ../../."

puts "----------------------- Synthesize Constraints ---------------------------"
puts "File: sdc_file"
# Configure Synthesize tool to use the project constraints
organize_tool_files -tool {SYNTHESIZE} \
        -file {sdc_file} \
        -module {top_module::work} -input_type {constraint}

# Configure Place and Route tool to use the project constraints
puts "----------------------- Place and Route Constraints ----------------------"
puts "File: sdc_file"
puts "File: pdc_constraint_file.pdc"
puts "File: pdc_floorplan_constraint_file.pdc"

organize_tool_files -tool {PLACEROUTE} \
        -file {sdc_file} \
        -file {pdc_constraint_file.pdc} \
        -file {pdc_floorplan_constraint_file.pdc} \
        -module {top_module::work} -input_type {constraint}

# Configure Verify Timing tool to use the project constraints
puts "----------------------- Verify Timings Constraints -----------------------"
puts "File: sdc_file"
organize_tool_files -tool {VERIFYTIMING} \
        -file {sdc_file} \
        -module {top_module::work} -input_type {constraint}

save_project

puts "If desired, execute the libero-test-all-run.tcl script to run the generation flow."
puts "----------------- Finished Importing project -----------------------------"
