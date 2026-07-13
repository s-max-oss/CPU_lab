# Trace 测试框架说明

## 实验环境
- 推荐：WSL2虚拟机（实验室台式机已预装）
- 备选：远程实验平台（非上课时间使用）
- 自行部署：安装WSL2，详见附录

## 获取测试框架
```bash
cd ~ && git clone https://gitee.com/hitsz-cslab/cdp-tests.git
# miniLA: git clone -b miniLA https://gitee.com/hitsz-cslab/cdp-tests.git
```

## 目录结构
```
cdp-tests/
├── bin/              # 指令测试用例 (.bin)
├── asm/              # 反汇编文件 (.dump)
├── csrc/             # 测试驱动框架 + 比对逻辑
├── golden_model/     # C语言CPU行为模型（标准答案）
├── waveform/         # 运行测试生成的.vcd波形文件
├── mySoC/            # ★ 你的Verilog代码放这里
├── vsrc/             # 仿真用主存模块 (ram.v / bram_axi.v)
├── run_all_tests.py  # 批量测试脚本
└── Makefile
```

## 差分测试原理
比对标准模型(C语言CPU)和待测模型(你的Verilog CPU)执行同一指令的结果。

## 添加待测试代码注意事项
1. 只拷贝 `src/rtl` 下的源文件，**不拷贝ip文件夹**
2. 架构要求：`miniRV_SoC → cpu_top → cpu_core`（模块名/实例名/接口信号不要改）
3. **不要修改** `RUN_TRACE` 宏和 `/* verilator public */` 注释
4. SoC顶层复位信号 `fpga_rst` 是高电平复位
5. 系统复位后首条指令地址 = `0x00000000`
6. Basic Trace只测CPU内核，AXI Trace测CPU+ICache+DCache+总线

## Trace信号（在cpu_core.v末尾）
```verilog
// 第一组：写回寄存器信息
wire [31:0] debug_wb_pc;     // WB阶段PC
wire        debug_wb_rf_we;  // 寄存器写使能
wire [4:0]  debug_wb_rf_wR;  // 目标寄存器号
wire [31:0] debug_wb_rf_wD;  // 写入值

// 第二组：写访存信息
wire [31:0] debug_mem_pc;    // MEM阶段PC
wire [3:0]  debug_mem_we;    // 写使能
wire [31:0] debug_mem_waddr; // 写地址
wire [31:0] debug_mem_wdata; // 写数据
```
**每组信号只能有效一个时钟周期！**（流水线CPU连接对应阶段的信号即可）

## 运行测试
```bash
cd cdp-tests
make                          # 编译
make run TEST=sltu            # 运行单个测试
python3 run_all_tests.py      # 批量测试
```
