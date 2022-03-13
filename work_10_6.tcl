set device          xcku040
set package         ffva1156
set speed           -2-i
set part            $device$package$speed
set prjName         an9767_system
set prjDir          ./$an9767_system
set srcDir          ./Source

# 创建工程
create_project      $prjName $prjDir -part $part

# 添加RTL设计文件
add_files           [glob $srcDir/hdl/*.v]
add_files           [glob $srcDir/hdl/*.vh]
add_files           [glob $srcDir/hdl/*.xcix]
update_compile_order    -filset sources_1

# 添加XDC约束文件
add_files               -fileset constrs_1 [glob $srcDir/xdc/*.xdc]

# 添加仿真测试文件
add_files               -fileset sim_1 [glob $srcDir/sim/**_tb.v]
update_compile_order    -fileset sim_1

# 设置编译优化策略
set_property            strategy    Flow_AreaOptimized_high [get_runs synth_1]
set_property            strategy    Performance_Explore [get_runs impl_1]

# 运行编译流程
launch_runs synth_1
wait_on_run synth_1
launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1

# 编译完成后，启动GUI界面
start_gui